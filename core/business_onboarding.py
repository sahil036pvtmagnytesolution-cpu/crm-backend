import re
from typing import Optional

import MySQLdb
from django.conf import settings
from django.contrib.auth.models import User
from django.utils.text import slugify
from django.utils import timezone

from .email_branding import build_module_email_html, send_branded_email
from .models import Business


DB_PREFIX = "ms_crm_"
MAX_DB_NAME_LENGTH = 64
VALID_DB_NAME_RE = re.compile(r"^[A-Za-z0-9_]+$")
TENANT_SCHEMA_CHECK_TABLES = ("core_roles", "ms_staff", "ms_activity_log")
TENANT_BUSINESS_DATA_CHECK_TABLES = (
    "core_client",
    "core_contact",
    "core_lead",
    "core_proposal",
    "core_project",
    "core_invoice",
    "core_estimate",
    "core_customer",
    "ms_staff",
)
LEGACY_FULL_DATA_COPY_EXCLUDED_TABLES = {
    "auth_group",
    "auth_group_permissions",
    "auth_permission",
    "auth_user",
    "auth_user_groups",
    "auth_user_user_permissions",
    "authtoken_token",
    "core_activity_log",
    "core_business",
    "core_emailtemplate",
    "django_admin_log",
    "django_content_type",
    "django_migrations",
    "django_session",
}
REFERENCE_DATA_TABLES = (
    "ms_countries",
    "ms_currencies",
    "ms_taxes",
)


def _is_valid_db_name(value: str) -> bool:
    return bool(value and VALID_DB_NAME_RE.fullmatch(value.strip()))


def _quote_identifier(identifier: str) -> str:
    return f"`{(identifier or '').replace('`', '``')}`"


def _build_db_name_base(business_name: str) -> str:
    normalized = (slugify(business_name or "").replace("-", "_")).strip("_")
    if not normalized:
        normalized = "business"

    max_base_length = MAX_DB_NAME_LENGTH - len(DB_PREFIX)
    return normalized[:max_base_length].rstrip("_") or "business"


def generate_unique_business_db_name(business_name: str, exclude_pk=None) -> str:
    base = _build_db_name_base(business_name)
    max_base_length = MAX_DB_NAME_LENGTH - len(DB_PREFIX)
    candidate = f"{DB_PREFIX}{base}"

    query = Business.objects.all()
    if exclude_pk:
        query = query.exclude(pk=exclude_pk)

    if not query.filter(db_name__iexact=candidate).exists():
        return candidate

    counter = 2
    while True:
        suffix = f"_{counter}"
        trimmed_base = base[: max_base_length - len(suffix)].rstrip("_") or "business"
        candidate = f"{DB_PREFIX}{trimmed_base}{suffix}"
        if not query.filter(db_name__iexact=candidate).exists():
            return candidate
        counter += 1


def ensure_tenant_database(db_name: str) -> str:
    db_name = (db_name or "").strip()
    if not db_name:
        raise ValueError("db_name is required")

    db_conf = settings.DATABASES["default"]
    root_conn = MySQLdb.connect(
        host=db_conf.get("HOST") or "localhost",
        user=db_conf.get("USER") or "",
        passwd=db_conf.get("PASSWORD") or "",
        port=int(db_conf.get("PORT") or 3306),
        charset="utf8mb4",
        autocommit=True,
    )

    try:
        with root_conn.cursor() as cursor:
            cursor.execute(
                f"CREATE DATABASE IF NOT EXISTS {_quote_identifier(db_name)} "
                "CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
            )
    finally:
        root_conn.close()

    return db_name


def _connect_mysql_root():
    db_conf = settings.DATABASES["default"]
    return MySQLdb.connect(
        host=db_conf.get("HOST") or "localhost",
        user=db_conf.get("USER") or "",
        passwd=db_conf.get("PASSWORD") or "",
        port=int(db_conf.get("PORT") or 3306),
        charset="utf8mb4",
        autocommit=True,
    )


def _database_exists(db_name: str) -> bool:
    db_name = (db_name or "").strip()
    if not db_name:
        return False

    conn = _connect_mysql_root()
    try:
        with conn.cursor() as cursor:
            cursor.execute(
                "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = %s",
                [db_name],
            )
            return cursor.fetchone() is not None
    finally:
        conn.close()


def is_tenant_schema_ready(db_name: str) -> bool:
    db_name = (db_name or "").strip()
    if not db_name:
        return False

    conn = _connect_mysql_root()
    try:
        with conn.cursor() as cursor:
            for table_name in TENANT_SCHEMA_CHECK_TABLES:
                cursor.execute(
                    f"SHOW TABLES FROM {_quote_identifier(db_name)} LIKE %s",
                    [table_name],
                )
                if cursor.fetchone() is None:
                    return False
    except MySQLdb.OperationalError as exc:
        # MySQL error 1049 = unknown database.
        # Treat as "not ready" so caller can bootstrap/create tenant DB.
        if exc.args and int(exc.args[0]) == 1049:
            return False
        raise
    finally:
        conn.close()
    return True


def bootstrap_tenant_schema(db_name: str):
    """
    Clone schema from default DB to tenant DB so all CRM pages/modules
    can work for newly approved businesses.
    """
    db_name = ensure_tenant_database(db_name)
    source_db = settings.DATABASES["default"]["NAME"]

    if not _is_valid_db_name(source_db):
        raise ValueError("Invalid default database name")

    conn = _connect_mysql_root()
    try:
        with conn.cursor() as cursor:
            cursor.execute(
                f"SHOW FULL TABLES FROM {_quote_identifier(source_db)} "
                "WHERE Table_type = 'BASE TABLE'"
            )
            table_rows = cursor.fetchall() or []
            table_names = [row[0] for row in table_rows]

            for table_name in table_names:
                cursor.execute(
                    f"CREATE TABLE IF NOT EXISTS {_quote_identifier(db_name)}.{_quote_identifier(table_name)} "
                    f"LIKE {_quote_identifier(source_db)}.{_quote_identifier(table_name)}"
                )

            # Copy only static master/reference data to keep tenant usable.
            for table_name in REFERENCE_DATA_TABLES:
                if table_name not in table_names:
                    continue
                cursor.execute(
                    f"SELECT COUNT(*) FROM {_quote_identifier(db_name)}.{_quote_identifier(table_name)}"
                )
                dest_count = cursor.fetchone()[0]
                if dest_count == 0:
                    cursor.execute(
                        f"INSERT INTO {_quote_identifier(db_name)}.{_quote_identifier(table_name)} "
                        f"SELECT * FROM {_quote_identifier(source_db)}.{_quote_identifier(table_name)}"
                    )
    finally:
        conn.close()


def has_tenant_business_data(db_name: str) -> bool:
    db_name = (db_name or "").strip()
    if not db_name:
        return False

    conn = _connect_mysql_root()
    try:
        with conn.cursor() as cursor:
            for table_name in TENANT_BUSINESS_DATA_CHECK_TABLES:
                try:
                    cursor.execute(
                        f"SELECT COUNT(*) FROM {_quote_identifier(db_name)}.{_quote_identifier(table_name)}"
                    )
                except MySQLdb.OperationalError:
                    continue
                if cursor.fetchone()[0] > 0:
                    return True
    finally:
        conn.close()
    return False


def _has_legacy_user_owned_data_in_default(user_email: str) -> bool:
    user_email = (user_email or "").strip().lower()
    if not user_email:
        return False

    source_db = settings.DATABASES["default"]["NAME"]
    conn = _connect_mysql_root()
    try:
        with conn.cursor() as cursor:
            cursor.execute(
                f"SELECT id FROM {_quote_identifier(source_db)}.auth_user "
                "WHERE LOWER(username)=LOWER(%s) OR LOWER(email)=LOWER(%s) "
                "ORDER BY id DESC LIMIT 1",
                [user_email, user_email],
            )
            row = cursor.fetchone()
            if not row:
                return False

            user_id = row[0]
            ownership_checks = (
                (
                    "core_proposal",
                    "created_by_id = %s OR assigned_to_id = %s",
                    [user_id, user_id],
                ),
                (
                    "core_project",
                    "created_by_id = %s OR mentor_id = %s",
                    [user_id, user_id],
                ),
                ("core_project_members", "user_id = %s", [user_id]),
            )

            for table_name, where_clause, params in ownership_checks:
                try:
                    cursor.execute(
                        f"SELECT COUNT(*) FROM {_quote_identifier(source_db)}.{_quote_identifier(table_name)} "
                        f"WHERE {where_clause}",
                        params,
                    )
                except MySQLdb.OperationalError:
                    continue
                if cursor.fetchone()[0] > 0:
                    return True
    finally:
        conn.close()
    return False


def _copy_legacy_data_from_default_to_tenant(db_name: str) -> bool:
    """
    One-time legacy migration:
    copy historical business tables from default DB into an empty tenant DB.
    """
    db_name = (db_name or "").strip()
    if not db_name:
        return False

    source_db = settings.DATABASES["default"]["NAME"]
    if db_name == source_db:
        return False

    conn = _connect_mysql_root()
    copied_any = False
    try:
        with conn.cursor() as cursor:
            cursor.execute(
                f"SHOW FULL TABLES FROM {_quote_identifier(source_db)} "
                "WHERE Table_type = 'BASE TABLE'"
            )
            table_rows = cursor.fetchall() or []
            table_names = [row[0] for row in table_rows]

            candidate_tables = []
            for table_name in table_names:
                if table_name in LEGACY_FULL_DATA_COPY_EXCLUDED_TABLES:
                    continue
                if table_name.startswith("core_") or table_name.startswith("ms_"):
                    candidate_tables.append(table_name)

            cursor.execute("SET FOREIGN_KEY_CHECKS=0")
            try:
                for table_name in candidate_tables:
                    cursor.execute(
                        f"SELECT COUNT(*) FROM {_quote_identifier(db_name)}.{_quote_identifier(table_name)}"
                    )
                    dest_count = cursor.fetchone()[0]
                    if dest_count > 0:
                        continue

                    cursor.execute(
                        f"INSERT INTO {_quote_identifier(db_name)}.{_quote_identifier(table_name)} "
                        f"SELECT * FROM {_quote_identifier(source_db)}.{_quote_identifier(table_name)}"
                    )
                    if cursor.rowcount > 0:
                        copied_any = True
            finally:
                cursor.execute("SET FOREIGN_KEY_CHECKS=1")
    finally:
        conn.close()

    return copied_any


def _frontend_login_url() -> str:
    return getattr(settings, "FRONTEND_LOGIN_URL", "http://localhost:3000/login")


def _send_email(subject: str, message: str, to_email: str, html_message: Optional[str] = None):
    try:
        sent_count = send_branded_email(
            subject=subject,
            message=message,
            to_emails=[to_email],
            html_message=html_message,
            fail_silently=False,
        )
        return sent_count > 0, None
    except Exception as exc:
        print(f"Email send failed to {to_email}: {exc}")
        return False, str(exc)


def send_signup_received_email(business: Business):
    subject = f"Business Signup Received - {business.name}"
    message = (
        f"Hello {business.owner_name},\n\n"
        f"We received your business signup request for '{business.name}'.\n"
        "Your account is currently pending super admin approval.\n\n"
        "You will receive another email once your business is approved.\n\n"
        "Regards,\n"
        "CRM Team"
    )
    html_message = build_module_email_html(
        title="Business Signup Request Received",
        greeting=business.owner_name,
        intro=(
            f"We received your business signup request for '{business.name}'. "
            "Your account is currently pending super admin approval."
        ),
        details=[
            ("Business Name", business.name),
            ("Owner Name", business.owner_name),
            ("Email", business.email),
            ("Approval Status", "Pending"),
        ],
        body_html="<p>You will receive another email once your business is approved.</p>",
        closing="Regards,<br/><strong>CRM Team</strong>",
    )
    return _send_email(subject, message, business.email, html_message=html_message)


def send_business_approved_email(business: Business):
    subject = f"Business Approved - {business.name}"
    login_url = _frontend_login_url()
    message = (
        f"Hello {business.owner_name},\n\n"
        f"Your business '{business.name}' is now approved.\n"
        "You can login to CRM now.\n\n"
        f"Business DB Name: {business.db_name}\n"
        f"Login URL: {login_url}\n\n"
        "Regards,\n"
        "CRM Team"
    )
    html_message = build_module_email_html(
        title="Business Approved",
        greeting=business.owner_name,
        intro=f"Your business '{business.name}' is now approved. You can login to CRM now.",
        details=[
            ("Business Name", business.name),
            ("Business DB Name", business.db_name or "-"),
            ("Approval Status", "Approved"),
        ],
        cta_label="Login to CRM",
        cta_url=login_url,
        closing="Regards,<br/><strong>CRM Team</strong>",
    )
    return _send_email(subject, message, business.email, html_message=html_message)


def send_login_success_email(business: Business):
    subject = f"Login Successful - {business.name}"
    login_time = timezone.now().strftime("%Y-%m-%d %H:%M:%S %Z")
    message = (
        f"Hello {business.owner_name},\n\n"
        "Your login to CRM was successful.\n"
        f"Business: {business.name}\n\n"
        f"Login Time: {login_time}\n\n"
        "If this wasn't you, contact support immediately.\n\n"
        "Regards,\n"
        "CRM Team"
    )
    html_message = build_module_email_html(
        title="Login Successful",
        greeting=business.owner_name,
        intro="Your login to CRM was successful.",
        details=[
            ("Business", business.name),
            ("Email", business.email),
            ("Login Time", login_time),
        ],
        body_html="<p>If this wasn't you, contact support immediately.</p>",
        cta_label="Open CRM",
        cta_url=_frontend_login_url(),
        closing="Regards,<br/><strong>CRM Team</strong>",
    )
    return _send_email(subject, message, business.email, html_message=html_message)


def approve_business_and_activate_user(business: Business):
    if not _is_valid_db_name(business.db_name):
        business.db_name = generate_unique_business_db_name(
            business.name,
            exclude_pk=business.pk,
        )

    bootstrap_tenant_schema(business.db_name)

    update_fields = ["db_name"]
    if not business.is_approved:
        business.is_approved = True
        update_fields.append("is_approved")
    business.save(update_fields=update_fields)

    User.objects.filter(username__iexact=business.email).update(
        is_active=True,
        email=business.email,
    )

    email_sent, email_error = send_business_approved_email(business)
    return {
        "db_name": business.db_name,
        "email_sent": email_sent,
        "email_error": email_error,
    }


def ensure_business_runtime_ready(business: Business):
    """
    For old approved businesses created before schema bootstrap changes.
    """
    current_db_name = (business.db_name or "").strip()
    has_legacy_existing_db = bool(current_db_name and _database_exists(current_db_name))

    if not _is_valid_db_name(current_db_name) and not has_legacy_existing_db:
        business.db_name = generate_unique_business_db_name(
            business.name,
            exclude_pk=business.pk,
        )
        business.save(update_fields=["db_name"])
    elif current_db_name and business.db_name != current_db_name:
        business.db_name = current_db_name
        business.save(update_fields=["db_name"])

    if not is_tenant_schema_ready(business.db_name):
        bootstrap_tenant_schema(business.db_name)

    # Legacy backfill:
    # If tenant has no business data but this user had historical records in
    # default DB, perform a one-time copy so old login keeps seeing old data.
    if not has_tenant_business_data(business.db_name):
        try:
            if _has_legacy_user_owned_data_in_default(business.email):
                _copy_legacy_data_from_default_to_tenant(business.db_name)
        except Exception as exc:
            print(f"Legacy data copy skipped for '{business.email}': {exc}")
