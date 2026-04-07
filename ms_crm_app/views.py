from django.shortcuts import get_object_or_404
from django.conf import settings
from django.utils import timezone
from django.db import ProgrammingError, OperationalError, connections
from .models import ActivityLog
from django.apps import apps
import csv
import io
import json
import logging
from urllib import parse as urllib_parse
from urllib import request as urllib_request
from urllib.error import URLError

from rest_framework import filters, mixins, status, viewsets
from rest_framework.decorators import action, api_view, permission_classes
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.models import User

from .models import (
    CustomerStatus,
    EmailIntegration,
    Lead,
    LeadCaptureConfiguration,
    LeadSource,
    Product,
    ProductStatus,
    Roles,
    UserToken,
    WebFormField,
)
from .serializers import UserProfileSerializers
from .serializers import (
    CustomerStatusSerializer,
    CompanyInfoSerializer,
    EmailIntegrationSerializer,
    LeadSerializer,
    LeadCaptureConfigurationSerializer,
    LeadSourceSerializer,
    ProductSerializer,
    ProductStatusSerializer,
    SMSTaskSerializer,
    SetupTaskSerializer,
    WebFormFieldSerializer,
    WebToLeadSerializer,
)
from .helpers.utility import (
    app_name,
    get_serializer_class,
    get_filtered_queryset,
    CustomPageNumberPagination
)
from .constants import UserType
from core.models import Business
from core.middleware import get_current_db
from core.email_branding import build_module_email_html, send_branded_email

# ✅ SAFE TABLE ENSURE
from ms_crm_app.helpers.ensure_tables import (
    ensure_leads_setup_tables,
    ensure_roles_table,
    ensure_gdpr_requests_table,
    ensure_setup_management_tables,
)


def _create_legacy_activity_log(description, request=None):
    """Write to legacy ms_activity_log without breaking API flow on schema drift."""
    staff_identifier = None
    user = getattr(request, "user", None)
    if user is not None and getattr(user, "is_authenticated", False):
        staff_identifier = getattr(user, "id", None)

    try:
        ActivityLog.objects.create(
            description=description,
            date=timezone.now(),
            staff_name=staff_identifier,
        )
    except Exception as exc:
        print("ActivityLog create failed:", exc)


_GDPR_EXPORT_TABLES = {
    "customer": "ms_contacts",
    "lead": "ms_leads",
    "staff": "ms_staff",
}

_GDPR_EXPORT_FIELDS = {
    "customer": [
        "userid",
        "firstname",
        "lastname",
        "email",
        "phonenumber",
        "title",
        "datecreated",
        "last_login",
        "active",
    ],
    "lead": [
        "name",
        "title",
        "company",
        "email",
        "phonenumber",
        "website",
        "address",
        "city",
        "state",
        "zip",
        "dateadded",
        "lastcontact",
        "status",
        "source",
    ],
    "staff": [
        "staffid",
        "firstname",
        "lastname",
        "email",
        "phonenumber",
        "facebook",
        "linkedin",
        "skype",
        "datecreated",
        "last_login",
        "active",
        "default_language",
    ],
}


def _safe_export_value(value):
    if value is None:
        return ""
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return value


def _fetch_gdpr_export_rows(user_type, email):
    normalized_type = str(user_type or "").strip().lower()
    table_name = _GDPR_EXPORT_TABLES.get(normalized_type)
    expected_fields = _GDPR_EXPORT_FIELDS.get(normalized_type, [])
    normalized_email = str(email or "").strip()

    if not table_name or not expected_fields or not normalized_email:
        return []

    db_alias = get_current_db()
    connection = connections[db_alias]

    with connection.cursor() as cursor:
        cursor.execute(f"SHOW COLUMNS FROM `{table_name}`")
        available_columns = {row[0] for row in cursor.fetchall()}
        selected_fields = [field for field in expected_fields if field in available_columns]
        if "email" not in available_columns or not selected_fields:
            return []

        select_clause = ", ".join(f"`{field}`" for field in selected_fields)
        cursor.execute(
            f"SELECT {select_clause} FROM `{table_name}` WHERE LOWER(`email`) = LOWER(%s)",
            [normalized_email],
        )
        rows = cursor.fetchall()

    result = []
    for row in rows:
        item = {}
        for idx, field_name in enumerate(selected_fields):
            item[field_name] = _safe_export_value(row[idx])
        result.append(item)

    return result


def _build_simple_pdf(lines):
    safe_lines = [str(line).replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)") for line in lines]
    content_lines = ["BT", "/F1 10 Tf", "45 790 Td", "14 TL"]

    first = True
    for line in safe_lines:
        if first:
            content_lines.append(f"({line}) Tj")
            first = False
        else:
            content_lines.append("T*")
            content_lines.append(f"({line}) Tj")

    content_lines.append("ET")
    stream_bytes = "\n".join(content_lines).encode("latin-1", errors="replace")

    objects = [
        b"1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n",
        b"2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n",
        b"3 0 obj\n<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << /Font << /F1 5 0 R >> >> /Contents 4 0 R >>\nendobj\n",
        (
            f"4 0 obj\n<< /Length {len(stream_bytes)} >>\nstream\n".encode("ascii")
            + stream_bytes
            + b"\nendstream\nendobj\n"
        ),
        b"5 0 obj\n<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>\nendobj\n",
    ]

    output = b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n"
    offsets = [0]
    for obj in objects:
        offsets.append(len(output))
        output += obj

    xref_pos = len(output)
    output += f"xref\n0 {len(offsets)}\n".encode("ascii")
    output += b"0000000000 65535 f \n"
    for offset in offsets[1:]:
        output += f"{offset:010d} 00000 n \n".encode("ascii")

    output += (
        f"trailer\n<< /Size {len(offsets)} /Root 1 0 R >>\nstartxref\n{xref_pos}\n%%EOF".encode("ascii")
    )
    return output


def _build_gdpr_attachment(gdpr_request, export_rows):
    export_format = str(getattr(gdpr_request, "data_format", "json") or "json").strip().lower()
    if export_format not in {"json", "csv", "pdf"}:
        export_format = "json"

    request_summary = {
        "request_id": gdpr_request.request_id,
        "customer_name": gdpr_request.customer_name,
        "email": gdpr_request.email,
        "user_type": gdpr_request.user_type,
        "request_type": gdpr_request.request_type,
        "status": gdpr_request.status,
        "data_format": export_format,
        "details": gdpr_request.details or "",
        "requested_at": _safe_export_value(gdpr_request.requested_at),
    }

    limited_rows = export_rows[:25]

    if export_format == "csv":
        merged_rows = []
        if limited_rows:
            for row in limited_rows:
                merged = {**request_summary, **row}
                merged_rows.append({k: _safe_export_value(v) for k, v in merged.items()})
        else:
            merged_rows.append({**request_summary, "record_status": "No matching records found"})

        field_names = list(merged_rows[0].keys())
        buffer = io.StringIO()
        writer = csv.DictWriter(buffer, fieldnames=field_names)
        writer.writeheader()
        writer.writerows(merged_rows)
        content = buffer.getvalue().encode("utf-8")
        return (
            f"gdpr_export_{gdpr_request.request_id}.csv",
            content,
            "text/csv",
        )

    if export_format == "pdf":
        lines = [
            "GDPR Request Export",
            "",
            f"Request ID: {gdpr_request.request_id}",
            f"Customer Name: {gdpr_request.customer_name}",
            f"Email: {gdpr_request.email}",
            f"User Type: {gdpr_request.user_type}",
            f"Request Type: {gdpr_request.request_type}",
            f"Requested Format: {export_format.upper()}",
            f"Status: {gdpr_request.status}",
            f"Details: {gdpr_request.details or 'N/A'}",
            "",
            f"Matching Records: {len(export_rows)}",
            "",
        ]

        if limited_rows:
            for index, row in enumerate(limited_rows, start=1):
                lines.append(f"Record {index}:")
                for key, value in row.items():
                    lines.append(f"  {key}: {_safe_export_value(value)}")
                lines.append("")
        else:
            lines.append("No matching records found for the submitted email.")

        content = _build_simple_pdf(lines[:180])
        return (
            f"gdpr_export_{gdpr_request.request_id}.pdf",
            content,
            "application/pdf",
        )

    payload = {
        "request_summary": request_summary,
        "record_count": len(export_rows),
        "records": limited_rows,
    }
    content = json.dumps(payload, indent=2, default=str).encode("utf-8")
    return (
        f"gdpr_export_{gdpr_request.request_id}.json",
        content,
        "application/json",
    )


def _send_gdpr_submission_email(gdpr_request):
    request_type_label = dict(gdpr_request.REQUEST_TYPE_CHOICES).get(
        gdpr_request.request_type,
        gdpr_request.request_type,
    )

    export_rows = []
    attachment = None
    attachment_note = ""

    try:
        export_rows = _fetch_gdpr_export_rows(gdpr_request.user_type, gdpr_request.email)
        attachment = _build_gdpr_attachment(gdpr_request, export_rows)
    except Exception as exc:
        print("GDPR export generation failed:", exc)
        attachment_note = "Export attachment could not be generated at submission time."

    body_lines = [
        "Your GDPR request has been received.",
        "",
        f"Request ID: {gdpr_request.request_id}",
        f"Request Type: {request_type_label}",
        f"Requested Export Format: {str(gdpr_request.data_format).upper()}",
        f"Current Status: {gdpr_request.status}",
        f"Requested By: {gdpr_request.customer_name} ({gdpr_request.email})",
        f"Details: {gdpr_request.details or 'N/A'}",
        f"Exported Records Found: {len(export_rows)}",
    ]

    if attachment:
        body_lines.append("An export file is attached based on the selected format.")
    if attachment_note:
        body_lines.append(attachment_note)

    html_message = build_module_email_html(
        title="GDPR Request Submitted",
        greeting=gdpr_request.customer_name or gdpr_request.email,
        intro="Your GDPR request has been received and logged by the CRM system.",
        details=[
            ("Request ID", gdpr_request.request_id),
            ("Request Type", request_type_label),
            ("Requested Export Format", str(gdpr_request.data_format).upper()),
            ("Current Status", gdpr_request.status),
            ("Requested By", f"{gdpr_request.customer_name} ({gdpr_request.email})"),
            ("Details", gdpr_request.details or "N/A"),
            ("Exported Records Found", len(export_rows)),
        ],
        closing="Regards,<br/><strong>CRM Team</strong>",
    )

    send_branded_email(
        subject=f"GDPR Request Submitted - {gdpr_request.request_id}",
        message="\n".join(body_lines),
        to_emails=[gdpr_request.email],
        html_message=html_message,
        attachments=[attachment] if attachment else None,
        from_email=getattr(settings, "DEFAULT_FROM_EMAIL", None),
        fail_silently=True,
    )


# ======================================================
# GENERIC CRUD API
# ======================================================
@api_view(['GET', 'POST', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def manage_data(request, model_name, item_id=None, field=None, value=None):

    try:
        serializer_class = get_serializer_class(model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    try:
        # Prefer the serializer's model so legacy endpoints keep working
        # even when the model lives outside `ms_crm_app` (e.g. in `core`).
        serializer_meta = getattr(serializer_class, "Meta", None)
        model = getattr(serializer_meta, "model", None) or apps.get_model(app_name, model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    table_name = getattr(getattr(model, "_meta", None), "db_table", "")
    if table_name in {"core_company_info", "core_sms_task", "core_setup_task"}:
        try:
            ensure_setup_management_tables()
        except Exception as exc:
            print("Setup management table ensure failed:", exc)

    try:
        if request.method == 'GET':
            queryset = get_filtered_queryset(
                model,
                field,
                value,
                request.query_params
            )
            if not field and not value and not request.query_params:
                queryset = model.objects.all()
            # Order by the model's primary key field instead of assuming 'id'
            pk_name = getattr(model._meta, 'pk', None)
            if pk_name is not None:
                pk_field = pk_name.name
                queryset = queryset.order_by(pk_field)
            else:
                # Fallback: no explicit PK, use default ordering if any
                queryset = queryset

            paginator = CustomPageNumberPagination()
            page = paginator.paginate_queryset(queryset, request)
            if page is not None:
                serializer = serializer_class(page, many=True)
                return paginator.get_paginated_response(serializer.data)
            serializer = serializer_class(queryset, many=True)
            return Response({"status": True, "data": serializer.data}, status=status.HTTP_200_OK)

        if request.method == 'POST':
            # Generic create using the appropriate serializer for the model
            serializer = serializer_class(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        if request.method == 'PUT':
            if not item_id:
                return Response(
                    {"message": "item_id is required for update"},
                    status=status.HTTP_400_BAD_REQUEST
                )

            instance = get_object_or_404(model, pk=item_id)
            serializer = serializer_class(instance, data=request.data, partial=True)

            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        if request.method == 'DELETE':
            if not item_id:
                return Response(
                    {"message": "item_id is required for delete"},
                    status=status.HTTP_400_BAD_REQUEST
                )

            instance = get_object_or_404(model, pk=item_id)
            instance.delete()
            return Response(
                {"message": "Deleted successfully"},
                status=status.HTTP_204_NO_CONTENT
            )
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            if request.method == "GET":
                return Response({"status": True, "data": []}, status=status.HTTP_200_OK)
            return Response(
                {"detail": "Table not found for this tenant. Bootstrap setup tables or run migrations."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise

# ======================================================
# GDPR Specific API
# ======================================================
@api_view(['GET', 'POST'])
@permission_classes([AllowAny])
def gdpr_requests(request):
    """List all GDPR requests or create a new one."""
    from .models import GdprRequest
    from .serializers import GdprRequestSerializer

    try:
        ensure_gdpr_requests_table()
    except Exception as exc:
        print("GDPR requests table ensure failed:", exc)

    if request.method == 'GET':
        try:
            queryset = GdprRequest.objects.all().order_by('-requested_at')
            serializer = GdprRequestSerializer(queryset, many=True)
            return Response(serializer.data)
        except (ProgrammingError, OperationalError) as exc:
            msg = str(exc).lower()
            if "doesn't exist" in msg or "1146" in msg:
                return Response([])
            raise

    # POST - create
    try:
        serializer = GdprRequestSerializer(data=request.data)
        if serializer.is_valid():
            import uuid
            instance = serializer.save(request_id=str(uuid.uuid4()))
            user_id = getattr(getattr(request, "user", None), "id", None)
            actor_label = f"user {user_id}" if user_id else "anonymous"
            _create_legacy_activity_log(
                description=f"GDPR request {instance.request_id} created via API by {actor_label}",
                request=request,
            )
            # Send submit acknowledgement with request details and export attachment.
            try:
                _send_gdpr_submission_email(instance)
            except Exception:
                pass
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            return Response(
                {"detail": "GDPR requests table not found. Run migrations or setup table bootstrap."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise


@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes([AllowAny])
def gdpr_request_detail(request, pk):
    """Retrieve, update or delete a specific GDPR request."""
    from .models import GdprRequest
    from .serializers import GdprRequestSerializer

    try:
        ensure_gdpr_requests_table()
    except Exception as exc:
        print("GDPR requests table ensure failed:", exc)

    try:
        instance = get_object_or_404(GdprRequest, pk=pk)
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            return Response(
                {"detail": "GDPR requests table not found. Run migrations or setup table bootstrap."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise

    if request.method == 'GET':
        serializer = GdprRequestSerializer(instance)
        return Response(serializer.data)

    if request.method == 'PUT':
        serializer = GdprRequestSerializer(instance, data=request.data, partial=True)
        if serializer.is_valid():
            updated = serializer.save()
            user_id = getattr(getattr(request, "user", None), "id", None)
            actor_label = f"user {user_id}" if user_id else "anonymous"
            _create_legacy_activity_log(
                description=f"GDPR request {updated.request_id} updated by {actor_label}",
                request=request,
            )
            # Notify on completion
            if updated.status == 'completed':
                try:
                    completion_message = f"Your GDPR request (ID: {updated.request_id}) has been completed."
                    completion_html = build_module_email_html(
                        title="GDPR Request Completed",
                        greeting=updated.customer_name or updated.email,
                        intro=completion_message,
                        details=[
                            ("Request ID", updated.request_id),
                            ("Status", updated.status),
                            ("Requested Email", updated.email),
                        ],
                        closing="Regards,<br/><strong>CRM Team</strong>",
                    )
                    send_branded_email(
                        subject='GDPR Request Completed',
                        message=completion_message,
                        to_emails=[updated.email],
                        html_message=completion_html,
                        fail_silently=True,
                    )
                except Exception:
                    pass
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'DELETE':
        instance.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


# ======================================================
# AUTH
# ======================================================
@api_view(["POST"])
@permission_classes([AllowAny])
def login(request):

    email = request.data.get("email")
    password = request.data.get("password")

    if not email or not password:
        return Response(
            {"message": "Email and password required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # ✅ AUTH USER (PERMANENT)
    try:
        user = User.objects.get(username=email)
    except User.DoesNotExist:
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    if not user.check_password(password):
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    # ✅ BUSINESS APPROVAL (REAL TABLE)
    business = Business.objects.filter(
        email__iexact=user.email,
        is_approved=1
    ).first()

    if not business:
        return Response(
            {"message": "Business not approved yet by admin"},
            status=status.HTTP_403_FORBIDDEN
        )

    refresh = RefreshToken.for_user(user)

    return Response({
        "message": "Login successful",
        "access_token": str(refresh.access_token),
        "refresh_token": str(refresh),
        "business": {
            "name": business.name
        }
    }, status=status.HTTP_200_OK)


@api_view(['POST'])
def signup(request):
    data = request.data.copy()

    email = data.get("user_email")
    password = data.get("password")

    if not email or not password:
        return Response(
            {"message": "Email and password required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    if User.objects.filter(username=email).exists():
        return Response(
            {"message": "User already exists"},
            status=status.HTTP_400_BAD_REQUEST
        )

    auth_user = User.objects.create_user(
        username=email,
        email=email,
        password=password
    )

    data["password"] = make_password(password)
    data["user_type"] = UserType.ADMIN

    serializer = UserProfileSerializers(data=data)
    if serializer.is_valid():
        serializer.save(user_id=auth_user.id)
        return Response(
            {"message": "Signup successful"},
            status=status.HTTP_201_CREATED
        )

    auth_user.delete()
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def logout(request):
    access_token = request.data.get("accessToken")
    UserToken.objects.filter(access_token=access_token).delete()

    return Response(
        {"message": "Logout successful"},
        status=status.HTTP_200_OK
    )


# ======================================================
# ROLES API (SAFE + TENANT READY)
# ======================================================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def roles_list_create(request):

    # 🔐 TENANT HEADER REQUIRED
    if not request.headers.get("X-TENANT-DB"):
        return Response(
            {"message": "Business context missing"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # ✅ ENSURE TABLE (NO SIDE EFFECT)
    ensure_roles_table()

    if request.method == "GET":
        roles = Roles.objects.all().values(
            "roleid", "name", "permissions"
        )
        return Response(list(roles))

    if request.method == "POST":
        role = Roles.objects.create(
            name=request.data.get("name"),
            permissions=request.data.get("permissions")
        )
        return Response({
            "roleid": role.roleid,
            "name": role.name,
            "permissions": role.permissions
        }, status=status.HTTP_201_CREATED)


logger = logging.getLogger(__name__)


def _to_bool(value, default=False):
    if value is None:
        return default
    if isinstance(value, bool):
        return value
    normalized = str(value).strip().lower()
    if normalized in {"1", "true", "yes", "on"}:
        return True
    if normalized in {"0", "false", "no", "off"}:
        return False
    return default


def _token_from_request(request):
    return (
        request.headers.get("X-Lead-Token")
        or request.headers.get("X-API-Key")
        or request.data.get("api_key")
        or request.query_params.get("api_key")
        or ""
    )


def _get_lead_capture_config():
    config, _ = LeadCaptureConfiguration.objects.get_or_create(name="default")
    return config


def _verify_recaptcha_token(config, request):
    if not getattr(config, "recaptcha_enabled", False):
        return True, ""

    recaptcha_token = (
        request.data.get("recaptcha_token")
        or request.headers.get("X-Recaptcha-Token")
        or ""
    )
    if not recaptcha_token:
        return False, "reCAPTCHA token is required."
    if not config.recaptcha_secret_key:
        return False, "reCAPTCHA secret key is not configured."

    payload = urllib_parse.urlencode(
        {"secret": config.recaptcha_secret_key, "response": recaptcha_token}
    ).encode("utf-8")

    try:
        req = urllib_request.Request(
            "https://www.google.com/recaptcha/api/siteverify",
            data=payload,
            method="POST",
        )
        with urllib_request.urlopen(req, timeout=8) as response:
            parsed = json.loads(response.read().decode("utf-8"))
        if parsed.get("success"):
            return True, ""
        return False, "reCAPTCHA validation failed."
    except (URLError, ValueError):
        return False, "Unable to verify reCAPTCHA token."


def _send_web_to_lead_emails(config, lead):
    if not config:
        return

    try:
        if config.send_notification_email and config.notification_email:
            summary = f"Lead received from website: {lead.email}"
            html = build_module_email_html(
                title="New Web Lead",
                greeting="Team",
                intro="A new lead was captured from the web form.",
                details=[
                    ("Name", f"{lead.first_name} {lead.last_name}".strip() or "-"),
                    ("Email", lead.email),
                    ("Phone", lead.phone or "-"),
                    ("Company", lead.company or "-"),
                    ("Priority", lead.priority or "-"),
                    ("Source", getattr(lead.source, "name", "-")),
                ],
                closing="Regards,<br/><strong>CRM Lead Automation</strong>",
            )
            send_branded_email(
                subject="New Web To Lead Submission",
                message=summary,
                to_emails=[config.notification_email],
                html_message=html,
                fail_silently=True,
            )
    except Exception:
        logger.exception("Web lead notification email failed.")

    try:
        if config.send_auto_response and lead.email:
            subject = config.auto_response_subject or "We received your request"
            body = config.auto_response_message or (
                "Thank you for contacting us. Our team will reach out shortly."
            )
            html = build_module_email_html(
                title=subject,
                greeting=lead.first_name or lead.email,
                intro=body,
                details=[("Reference", f"Lead #{lead.id}")],
                closing="Regards,<br/><strong>CRM Team</strong>",
            )
            send_branded_email(
                subject=subject,
                message=body,
                to_emails=[lead.email],
                html_message=html,
                fail_silently=True,
            )
    except Exception:
        logger.exception("Web lead auto-response email failed.")


class LeadSetupEnsureMixin:
    """
    Shared safety layer for Leads setup APIs.
    - Bootstraps required tables/columns.
    - Avoids crashing endpoints on schema drift.
    """

    @staticmethod
    def _is_missing_table_error(exc):
        msg = str(exc or "").lower()
        return "doesn't exist" in msg or "1146" in msg or "no such table" in msg

    def _handle_db_error(self, exc, *, empty_ok):
        if self._is_missing_table_error(exc):
            if empty_ok:
                return Response([])
            return Response(
                {
                    "detail": "Leads setup table not found. Run setup table bootstrap/migrations.",
                },
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        return None

    def initial(self, request, *args, **kwargs):
        try:
            ensure_leads_setup_tables()
        except Exception as exc:
            # Keep auth/permission flow intact; action handlers below guard DB errors.
            logger.exception("Leads setup table ensure failed: %s", exc)
        return super().initial(request, *args, **kwargs)

    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=True)
            if handled is not None:
                return handled
            raise

    def retrieve(self, request, *args, **kwargs):
        try:
            return super().retrieve(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def create(self, request, *args, **kwargs):
        try:
            return super().create(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def update(self, request, *args, **kwargs):
        try:
            return super().update(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def partial_update(self, request, *args, **kwargs):
        try:
            return super().partial_update(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def destroy(self, request, *args, **kwargs):
        try:
            return super().destroy(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_db_error(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise


class LeadEmailIntakeService:
    """
    Placeholder email intake service.
    The current implementation intentionally simulates IMAP polling and
    converts email payloads into Lead records.
    """

    def __init__(self, integration):
        self.integration = integration

    def fetch_emails(self):
        if not self.integration.is_connected:
            return []

        return [
            {
                "from_name": "Website Contact",
                "from_email": "sample.prospect@example.com",
                "phone": "",
                "subject": "Interested in your CRM offering",
                "body": "Please contact me for a demo.",
            }
        ]

    def convert_email_to_lead(self, email_payload):
        email = str(email_payload.get("from_email", "")).strip().lower()
        if not email:
            raise ValueError("from_email is required to create a lead.")

        config = _get_lead_capture_config()
        existing = Lead.objects.filter(email__iexact=email).first()
        if existing:
            if config.prevent_duplicates:
                return existing, False

            existing.message = str(email_payload.get("body", "")).strip()
            existing.priority = config.default_priority or existing.priority or "medium"
            if not existing.phone:
                existing.phone = str(email_payload.get("phone", "")).strip()
            if not existing.assigned_to_user:
                existing.assigned_to_user = self._parse_int(config.auto_assign_user)
            if not existing.assigned_to_team:
                existing.assigned_to_team = config.auto_assign_team or ""
            existing.save()
            return existing, False

        source = LeadSource.objects.filter(name__iexact="Email").first()
        if source is None:
            source, _ = LeadSource.objects.get_or_create(name="Email", defaults={"is_active": True})

        customer_status = CustomerStatus.objects.filter(name__iexact=config.default_status).first()
        if customer_status is None:
            customer_status, _ = CustomerStatus.objects.get_or_create(
                name="New",
                defaults={"is_active": True},
            )

        first_name, last_name = self._split_name(email_payload.get("from_name", ""))

        lead = Lead.objects.create(
            first_name=first_name,
            last_name=last_name,
            email=email,
            phone=str(email_payload.get("phone", "")).strip(),
            product=self._get_default_product(),
            product_status=self._get_default_product_status(),
            customer_status=customer_status,
            source=source,
            message=str(email_payload.get("body", "")).strip(),
            priority=config.default_priority or "medium",
            assigned_to_user=self._parse_int(config.auto_assign_user),
            assigned_to_team=config.auto_assign_team or "",
        )
        return lead, True

    @staticmethod
    def _split_name(full_name):
        raw_name = str(full_name or "").strip()
        if not raw_name:
            return "", ""
        parts = raw_name.split()
        if len(parts) == 1:
            return parts[0], ""
        return parts[0], " ".join(parts[1:])

    @staticmethod
    def _get_default_product():
        config = _get_lead_capture_config()
        if config.default_product:
            mapped = Product.objects.filter(name__iexact=config.default_product).first()
            if mapped is not None:
                return mapped
        return Product.objects.filter(is_active=True).order_by("id").first()

    @staticmethod
    def _get_default_product_status():
        config = _get_lead_capture_config()
        if config.default_product_status:
            mapped = ProductStatus.objects.filter(name__iexact=config.default_product_status).first()
            if mapped is not None:
                return mapped
        return ProductStatus.objects.filter(is_active=True).order_by("id").first()

    @staticmethod
    def _parse_int(value):
        try:
            return int(str(value).strip())
        except (TypeError, ValueError):
            return None


class LeadsPagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = "page_size"
    max_page_size = 100


class LeadViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = Lead.objects.select_related(
        "product",
        "product_status",
        "customer_status",
        "source",
    )
    serializer_class = LeadSerializer
    permission_classes = [IsAuthenticated]
    pagination_class = LeadsPagination
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ["first_name", "last_name", "email"]
    ordering_fields = ["created_at", "updated_at"]
    ordering = ["-created_at"]

    def get_permissions(self):
        if self.action in {"web_to_lead", "validate_token"}:
            return [AllowAny()]
        return super().get_permissions()

    def get_queryset(self):
        queryset = super().get_queryset()
        params = self.request.query_params

        product = params.get("product")
        product_status = params.get("product_status")
        customer_status = params.get("customer_status")
        source = params.get("source")

        if product:
            queryset = queryset.filter(product_id=product)
        if product_status:
            queryset = queryset.filter(product_status_id=product_status)
        if customer_status:
            queryset = queryset.filter(customer_status_id=customer_status)
        if source:
            queryset = queryset.filter(source_id=source)

        return queryset

    @action(detail=False, methods=["post"], url_path="web-to-lead")
    def web_to_lead(self, request):
        config = _get_lead_capture_config()

        if not config.is_web_to_lead_enabled:
            return Response(
                {"detail": "Web To Lead capture is disabled."},
                status=status.HTTP_403_FORBIDDEN,
            )

        if config.require_api_key:
            request_token = str(_token_from_request(request) or "").strip()
            expected_token = str(config.api_key_token or "").strip()
            if not expected_token or request_token != expected_token:
                return Response(
                    {"detail": "Invalid API key/token."},
                    status=status.HTTP_401_UNAUTHORIZED,
                )

        recaptcha_ok, recaptcha_message = _verify_recaptcha_token(config, request)
        if not recaptcha_ok:
            return Response(
                {"detail": recaptcha_message},
                status=status.HTTP_400_BAD_REQUEST,
            )

        serializer = WebToLeadSerializer(
            data=request.data,
            context={"lead_capture_config": config},
        )
        serializer.is_valid(raise_exception=True)
        lead = serializer.save()
        _send_web_to_lead_emails(config, lead)
        return Response(LeadSerializer(lead).data, status=status.HTTP_201_CREATED)

    @action(detail=False, methods=["get", "patch", "put"], url_path="configuration")
    def configuration(self, request):
        config = _get_lead_capture_config()
        if request.method == "GET":
            return Response(LeadCaptureConfigurationSerializer(config).data, status=status.HTTP_200_OK)

        partial = request.method == "PATCH"
        serializer = LeadCaptureConfigurationSerializer(config, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=False, methods=["post"], url_path="validate-token")
    def validate_token(self, request):
        config = _get_lead_capture_config()
        if not config.require_api_key:
            return Response({"valid": True, "required": False}, status=status.HTTP_200_OK)

        provided = str(_token_from_request(request) or "").strip()
        expected = str(config.api_key_token or "").strip()
        is_valid = bool(expected) and provided == expected
        return Response(
            {"valid": is_valid, "required": True},
            status=status.HTTP_200_OK if is_valid else status.HTTP_401_UNAUTHORIZED,
        )


class ProductViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = Product.objects.all().order_by("name")
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = super().get_queryset()
        # Detail actions must be able to target inactive records as well.
        if getattr(self, "action", "") in {"retrieve", "update", "partial_update", "destroy"}:
            return queryset
        include_inactive = _to_bool(self.request.query_params.get("include_inactive"), default=False)
        if include_inactive:
            return queryset
        return queryset.filter(is_active=True)


class ProductStatusViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = ProductStatus.objects.all().order_by("name")
    serializer_class = ProductStatusSerializer
    permission_classes = [IsAuthenticated]


class CustomerStatusViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = CustomerStatus.objects.all().order_by("name")
    serializer_class = CustomerStatusSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = super().get_queryset()
        # Keep detail actions consistent with Products (inactive rows are manageable).
        if getattr(self, "action", "") in {"retrieve", "update", "partial_update", "destroy"}:
            return queryset
        include_inactive = _to_bool(self.request.query_params.get("include_inactive"), default=False)
        if include_inactive:
            return queryset
        return queryset.filter(is_active=True)


class LeadSourceViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = LeadSource.objects.all().order_by("name")
    serializer_class = LeadSourceSerializer
    permission_classes = [IsAuthenticated]


class WebFormFieldViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = WebFormField.objects.all().order_by("sort_order", "id")
    serializer_class = WebFormFieldSerializer
    permission_classes = [IsAuthenticated]


class EmailIntegrationViewSet(LeadSetupEnsureMixin, viewsets.ModelViewSet):
    queryset = EmailIntegration.objects.all().order_by("id")
    serializer_class = EmailIntegrationSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        instance = serializer.save()
        if not instance.email_address and instance.username:
            instance.email_address = instance.username
        if not instance.imap_host and instance.email_host:
            instance.imap_host = instance.email_host
        if not instance.smtp_host and instance.email_host:
            instance.smtp_host = instance.email_host
        if not instance.imap_port and instance.email_port:
            instance.imap_port = instance.email_port
        if not instance.smtp_port and instance.email_port:
            instance.smtp_port = instance.email_port
        instance.save()

    def _sync_integration(self, integration):
        service = LeadEmailIntakeService(integration)
        created_count = 0
        skipped_count = 0
        errors = []

        for payload in service.fetch_emails():
            try:
                _, created = service.convert_email_to_lead(payload)
                if created:
                    created_count += 1
                else:
                    skipped_count += 1
            except Exception as exc:
                logger.exception("Email-to-lead conversion failed: %s", exc)
                errors.append(str(exc))

        integration.last_sync_at = timezone.now()
        integration.save(update_fields=["last_sync_at"])

        return {
            "status": "completed",
            "created": created_count,
            "skipped": skipped_count,
            "errors": errors,
        }

    @action(detail=True, methods=["post"], url_path="connect")
    def connect(self, request, pk=None):
        integration = self.get_object()
        integration.is_connected = True
        integration.save(update_fields=["is_connected"])
        return Response({"status": "connected"}, status=status.HTTP_200_OK)

    @action(detail=True, methods=["post"], url_path="disconnect")
    def disconnect(self, request, pk=None):
        integration = self.get_object()
        integration.is_connected = False
        integration.save(update_fields=["is_connected"])
        return Response({"status": "disconnected"}, status=status.HTTP_200_OK)

    @action(detail=True, methods=["post"], url_path="sync")
    def sync(self, request, pk=None):
        integration = self.get_object()
        if not integration.is_connected:
            return Response(
                {"detail": "Integration is not connected."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        result = self._sync_integration(integration)
        return Response(result, status=status.HTTP_200_OK)
