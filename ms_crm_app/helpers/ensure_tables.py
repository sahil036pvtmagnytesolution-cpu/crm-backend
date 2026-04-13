from django.db import connection
from core.middleware import get_current_db

def ensure_roles_table():
    table_name = "ms_roles"

    with connection.cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE %s", [table_name])
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_roles (
                    roleid INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100),
                    permissions TEXT
                )
            """)


def ensure_staff_table():
    """Ensure ms_staff table exists - create if not"""
    from django.db import connections
    from core.middleware import get_current_db
    
    # Get the current database based on tenant
    db_name = get_current_db()
    
    # Use the correct database connection
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_staff'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_staff (
                    staffid INT AUTO_INCREMENT PRIMARY KEY,
                    email VARCHAR(100) NOT NULL,
                    firstname VARCHAR(50) NOT NULL,
                    lastname VARCHAR(50) NOT NULL,
                    facebook MEDIUMTEXT DEFAULT NULL,
                    linkedin MEDIUMTEXT DEFAULT NULL,
                    phonenumber VARCHAR(30) DEFAULT NULL,
                    skype VARCHAR(50) DEFAULT NULL,
                    password VARCHAR(250) NOT NULL,
                    datecreated DATETIME NOT NULL,
                    profile_image VARCHAR(191) DEFAULT NULL,
                    last_ip VARCHAR(40) DEFAULT NULL,
                    last_login DATETIME DEFAULT NULL,
                    last_activity DATETIME DEFAULT NULL,
                    last_password_change DATETIME DEFAULT NULL,
                    new_pass_key VARCHAR(32) DEFAULT NULL,
                    new_pass_key_requested DATETIME DEFAULT NULL,
                    admin INT(11) NOT NULL DEFAULT 0,
                    role INT(11) DEFAULT NULL,
                    active INT(11) NOT NULL DEFAULT 1,
                    default_language VARCHAR(40) DEFAULT NULL,
                    direction VARCHAR(3) DEFAULT NULL,
                    media_path_slug VARCHAR(191) DEFAULT NULL,
                    is_not_staff INT(11) NOT NULL DEFAULT 0,
                    hourly_rate DECIMAL(15,2) NOT NULL DEFAULT 0.00,
                    two_factor_auth_enabled TINYINT(1) DEFAULT 0,
                    two_factor_auth_code VARCHAR(100) DEFAULT NULL,
                    two_factor_auth_code_requested DATETIME DEFAULT NULL,
                    email_signature TEXT DEFAULT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)
            # Insert default admin user
            cursor.execute("""
                INSERT INTO ms_staff (email, firstname, lastname, password, datecreated, admin, active, hourly_rate)
                VALUES ('admin@example.com', 'Admin', 'User', '', NOW(), 1, 1, 0)
            """)

        cursor.execute("SHOW TABLES LIKE 'ms_staff_permissions'")
        permissions_exists = cursor.fetchone()
        if not permissions_exists:
            cursor.execute("""
                CREATE TABLE ms_staff_permissions (
                    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    staff_id INT NOT NULL,
                    feature VARCHAR(40) NOT NULL,
                    capability VARCHAR(100) NOT NULL,
                    KEY idx_ms_staff_permissions_staff (staff_id),
                    UNIQUE KEY uq_ms_staff_permissions_staff_feature_capability (staff_id, feature, capability)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)


def ensure_project_tables():
    """Ensure core_project (and its M2M table) exist for the current DB."""
    from django.apps import apps
    from django.db import connections
    from core.middleware import get_current_db

    db_alias = get_current_db()
    connection = connections[db_alias]

    # Introspection to avoid recreating existing tables
    existing_tables = set(connection.introspection.table_names())

    Project = apps.get_model("core", "Project")
    project_table = Project._meta.db_table

    if project_table not in existing_tables:
        with connection.schema_editor() as schema_editor:
            schema_editor.create_model(Project)
        existing_tables = set(connection.introspection.table_names())

    # Ensure auto-created M2M table for members exists
    for m2m in Project._meta.local_many_to_many:
        through = m2m.remote_field.through
        if through._meta.auto_created:
            m2m_table = through._meta.db_table
            if m2m_table not in existing_tables:
                with connection.schema_editor() as schema_editor:
                    schema_editor.create_model(through)
                existing_tables.add(m2m_table)


def ensure_knowledge_base_tables():
    """Ensure ms_knowledge_base and ms_knowledge_base_groups tables exist."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_knowledge_base_groups'")
        has_groups = cursor.fetchone() is not None

        if not has_groups:
            cursor.execute("""
                CREATE TABLE ms_knowledge_base_groups (
                    groupid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(191) NOT NULL,
                    group_slug TEXT DEFAULT NULL,
                    description MEDIUMTEXT DEFAULT NULL,
                    active TINYINT(4) NOT NULL,
                    color VARCHAR(10) DEFAULT '#28B8DA',
                    group_order INT DEFAULT 0
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)

        cursor.execute("SHOW TABLES LIKE 'ms_knowledge_base'")
        has_articles = cursor.fetchone() is not None

        if not has_articles:
            cursor.execute("""
                CREATE TABLE ms_knowledge_base (
                    articleid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    articlegroup INT NOT NULL,
                    subject MEDIUMTEXT NOT NULL,
                    description TEXT NOT NULL,
                    slug MEDIUMTEXT NOT NULL,
                    active TINYINT(4) NOT NULL,
                    datecreated DATETIME NOT NULL,
                    article_order INT NOT NULL DEFAULT 0,
                    staff_article INT NOT NULL DEFAULT 0
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)

        # Seed a default group/article if empty to show module data
        cursor.execute("SELECT COUNT(*) FROM ms_knowledge_base_groups")
        group_count = cursor.fetchone()[0]
        if group_count == 0:
            cursor.execute("""
                INSERT INTO ms_knowledge_base_groups
                (name, group_slug, description, active, color, group_order)
                VALUES ('General', 'general', 'General knowledge base articles', 1, '#28B8DA', 0)
            """)
            default_group_id = cursor.lastrowid
        else:
            cursor.execute("SELECT groupid FROM ms_knowledge_base_groups ORDER BY group_order, groupid LIMIT 1")
            row = cursor.fetchone()
            default_group_id = row[0] if row else 1

        cursor.execute("SELECT COUNT(*) FROM ms_knowledge_base")
        article_count = cursor.fetchone()[0]
        if article_count == 0 and default_group_id:
            cursor.execute("""
                INSERT INTO ms_knowledge_base
                (articlegroup, subject, description, slug, active, datecreated, article_order, staff_article)
                VALUES (%s, %s, %s, %s, 1, NOW(), 0, 0)
            """, [
                default_group_id,
                "Getting Started",
                "Welcome to the Knowledge Base. Add your first article to help your team.",
                "getting-started",
            ])


def ensure_announcements_table():
    """Ensure ms_announcements table exists for the current DB."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_announcements'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_announcements (
                    announcementid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(191) NOT NULL,
                    message TEXT DEFAULT NULL,
                    showtousers INT NOT NULL DEFAULT 0,
                    showtostaff INT NOT NULL DEFAULT 0,
                    showname INT NOT NULL DEFAULT 1,
                    dateadded DATETIME NOT NULL,
                    userid VARCHAR(100) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)


def ensure_goals_table():
    """Ensure ms_goals table exists for the current DB."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_goals'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_goals (
                    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    subject VARCHAR(191) NOT NULL,
                    description TEXT NOT NULL,
                    start_date DATE NOT NULL,
                    end_date DATE NOT NULL,
                    goal_type INT NOT NULL DEFAULT 0,
                    contract_type INT NOT NULL DEFAULT 0,
                    achievement INT NOT NULL DEFAULT 0,
                    notify_when_fail INT NOT NULL DEFAULT 0,
                    notify_when_achieve INT NOT NULL DEFAULT 0,
                    notified INT NOT NULL DEFAULT 0,
                    staff_id INT NOT NULL DEFAULT 0
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)


def ensure_surveys_table():
    """Ensure ms_surveys table exists for the current DB."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_surveys'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_surveys (
                    surveyid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    subject MEDIUMTEXT NOT NULL,
                    slug MEDIUMTEXT NOT NULL,
                    description TEXT NOT NULL,
                    viewdescription TEXT DEFAULT NULL,
                    datecreated DATETIME NOT NULL,
                    redirect_url VARCHAR(100) DEFAULT NULL,
                    send TINYINT(1) NOT NULL DEFAULT 0,
                    onlyforloggedin INT(11) DEFAULT 0,
                    fromname VARCHAR(100) DEFAULT NULL,
                    iprestrict TINYINT(1) NOT NULL,
                    active TINYINT(1) NOT NULL DEFAULT 1,
                    hash VARCHAR(32) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)


def ensure_activity_log_table():
    """Ensure ms_activity_log table exists for the current DB."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_activity_log'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_activity_log (
                    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    description MEDIUMTEXT NOT NULL,
                    date DATETIME NOT NULL,
                    staffid VARCHAR(100) DEFAULT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)


def ensure_tickets_pipe_log_table():
    """Ensure ms_tickets_pipe_log table exists for the current DB."""
    from django.db import connections
    from core.middleware import get_current_db

    db_name = get_current_db()
    with connections[db_name].cursor() as cursor:
        cursor.execute("SHOW TABLES LIKE 'ms_tickets_pipe_log'")
        exists = cursor.fetchone()

        if not exists:
            cursor.execute("""
                CREATE TABLE ms_tickets_pipe_log (
                    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                    date DATETIME NOT NULL,
                    email_to VARCHAR(100) NOT NULL,
                    name VARCHAR(191) NOT NULL,
                    subject VARCHAR(191) NOT NULL,
                    message MEDIUMTEXT NOT NULL,
                    email VARCHAR(100) NOT NULL,
                    status VARCHAR(100) NOT NULL,
                    group_name VARCHAR(100) DEFAULT NULL,
                    log_filter VARCHAR(100) DEFAULT NULL,
                    cc_emails MEDIUMTEXT DEFAULT NULL,
                    mention_emails MEDIUMTEXT DEFAULT NULL,
                    role_name VARCHAR(100) DEFAULT NULL,
                    tag VARCHAR(100) DEFAULT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)
            return

        # Backward compatibility for existing DBs that already have the table.
        cursor.execute("SHOW COLUMNS FROM ms_tickets_pipe_log")
        existing_columns = {row[0] for row in cursor.fetchall()}

        alter_statements = []
        if "group_name" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN group_name VARCHAR(100) DEFAULT NULL"
            )
        if "log_filter" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN log_filter VARCHAR(100) DEFAULT NULL"
            )
        if "cc_emails" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN cc_emails MEDIUMTEXT DEFAULT NULL"
            )
        if "mention_emails" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN mention_emails MEDIUMTEXT DEFAULT NULL"
            )
        if "role_name" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN role_name VARCHAR(100) DEFAULT NULL"
            )
        if "tag" not in existing_columns:
            alter_statements.append(
                "ALTER TABLE ms_tickets_pipe_log ADD COLUMN tag VARCHAR(100) DEFAULT NULL"
            )

        for sql in alter_statements:
            cursor.execute(sql)


def ensure_gdpr_requests_table():
    """Ensure gdpr_requests table exists for the current DB."""
    from django.apps import apps
    from django.db import connections
    from core.middleware import get_current_db

    db_alias = get_current_db()
    db_connection = connections[db_alias]
    gdpr_model = apps.get_model("ms_crm_app", "GdprRequest")
    table_name = gdpr_model._meta.db_table
    existing_tables = set(db_connection.introspection.table_names())

    if table_name in existing_tables:
        return

    # Foreign key target for processed_by; make sure legacy staff table exists first.
    try:
        ensure_staff_table()
    except Exception:
        pass

    with db_connection.schema_editor() as schema_editor:
        schema_editor.create_model(gdpr_model)


def ensure_setup_tables():
    """
    Ensure Setup module tables exist for the current DB.
    Uses schema_editor to create Django-managed tables without requiring migrations.
    """
    from django.apps import apps
    from django.db import connections
    from core.middleware import get_current_db

    db_alias = get_current_db()
    connection = connections[db_alias]
    existing_tables = set(connection.introspection.table_names())

    model_names = [
        "SetupModule",
        "SetupCustomField",
        "CustomFieldValue",
        "SetupGDPRRequest",
        "SetupSetting",
        "SetupHelpArticle",
        "SetupCustomerGroup",
        "SetupCustomerGroupAssignment",
        "SetupThemeStyle",
        "SetupTax",
        "SetupCurrency",
        "SetupPaymentMode",
        "SetupExpenseCategory",
        "SetupSupportDepartment",
        "SetupTicketPriority",
        "SetupTicketStatus",
        "SetupPredefinedReply",
        "SetupLeadSource",
        "SetupLeadStatus",
        "SetupContractTemplate",
        "SetupRolePermission",
        "Ticket",
    ]

    for model_name in model_names:
        model = apps.get_model("core", model_name)
        table_name = model._meta.db_table
        if table_name in existing_tables:
            continue

        with connection.schema_editor() as schema_editor:
            schema_editor.create_model(model)

        existing_tables.add(table_name)

    # Backward-compatible schema patch:
    # If setup module table already exists, ensure soft-delete columns are present.
    setup_module_model = apps.get_model("core", "SetupModule")
    setup_module_table = setup_module_model._meta.db_table
    if setup_module_table in existing_tables:
        with connection.cursor() as cursor:
            existing_columns = {
                column.name
                for column in connection.introspection.get_table_description(cursor, setup_module_table)
            }

        for field_name in ("is_deleted", "deleted_at"):
            if field_name in existing_columns:
                continue
            field = setup_module_model._meta.get_field(field_name)
            with connection.schema_editor() as schema_editor:
                schema_editor.add_field(setup_module_model, field)
            existing_columns.add(field_name)

    # Backward-compatible schema patch:
    # If help article table already exists, ensure inquiry email columns are present.
    help_article_model = apps.get_model("core", "SetupHelpArticle")
    help_article_table = help_article_model._meta.db_table
    if help_article_table in existing_tables:
        with connection.cursor() as cursor:
            help_columns = {
                column.name
                for column in connection.introspection.get_table_description(cursor, help_article_table)
            }

        for field_name in ("inquiry_email_to", "inquiry_email_cc", "inquiry_email_subject"):
            if field_name in help_columns:
                continue
            field = help_article_model._meta.get_field(field_name)
            with connection.schema_editor() as schema_editor:
                schema_editor.add_field(help_article_model, field)
            help_columns.add(field_name)

    # Backward-compatible schema patch:
    # If theme style table already exists, ensure all expected theming columns are present.
    theme_style_model = apps.get_model("core", "SetupThemeStyle")
    theme_style_table = theme_style_model._meta.db_table
    if theme_style_table in existing_tables:
        with connection.cursor() as cursor:
            theme_columns = {
                column.name
                for column in connection.introspection.get_table_description(cursor, theme_style_table)
            }

        theme_fields = (
            "primary_color",
            "secondary_color",
            "accent_color",
            "theme_mode",
            "sidebar_bg",
            "sidebar_text",
            "navbar_bg",
            "navbar_text",
            "status_success",
            "status_warning",
            "status_error",
            "status_info",
            "status_colors",
            "ui_settings",
        )
        for field_name in theme_fields:
            if field_name in theme_columns:
                continue
            field = theme_style_model._meta.get_field(field_name)
            with connection.schema_editor() as schema_editor:
                schema_editor.add_field(theme_style_model, field)
            theme_columns.add(field_name)

    # Backward-compatible schema patch:
    # Ensure support department and ticket priority enhancement columns exist.
    setup_field_patch_map = {
        "SetupSupportDepartment": ("imap_host",),
        "SetupTicketPriority": ("description",),
    }
    for model_name, field_names in setup_field_patch_map.items():
        model = apps.get_model("core", model_name)
        table_name = model._meta.db_table
        if table_name not in existing_tables:
            continue

        with connection.cursor() as cursor:
            existing_columns = {
                column.name
                for column in connection.introspection.get_table_description(cursor, table_name)
            }

        for field_name in field_names:
            if field_name in existing_columns:
                continue
            field = model._meta.get_field(field_name)
            with connection.schema_editor() as schema_editor:
                schema_editor.add_field(model, field)
            existing_columns.add(field_name)

    # Email templates are global (default DB in router), ensure table there as well.
    default_connection = connections["default"]
    default_existing = set(default_connection.introspection.table_names())
    email_template_model = apps.get_model("core", "EmailTemplate")
    email_table = email_template_model._meta.db_table
    if email_table not in default_existing:
        with default_connection.schema_editor() as schema_editor:
            schema_editor.create_model(email_template_model)
        default_existing.add(email_table)

    if email_table in default_existing:
        with default_connection.cursor() as cursor:
            email_columns = {
                column.name
                for column in default_connection.introspection.get_table_description(cursor, email_table)
            }

        for field_name in ("name", "variables"):
            if field_name in email_columns:
                continue
            field = email_template_model._meta.get_field(field_name)
            with default_connection.schema_editor() as schema_editor:
                schema_editor.add_field(email_template_model, field)
            email_columns.add(field_name)


def ensure_setup_management_tables():
    """
    Ensure lightweight setup management tables exist for the current DB.
    """
    from django.apps import apps
    from django.db import connections
    from core.middleware import get_current_db

    db_alias = get_current_db()
    db_connection = connections[db_alias]
    existing_tables = set(db_connection.introspection.table_names())

    model_names = [
        "CompanyInfo",
        "SMSTask",
        "SetupTask",
    ]

    for model_name in model_names:
        model = apps.get_model("core", model_name)
        table_name = model._meta.db_table
        if table_name in existing_tables:
            continue

        with db_connection.schema_editor() as schema_editor:
            schema_editor.create_model(model)
        existing_tables.add(table_name)


def ensure_finance_created_by_columns():
    """
    Ensure tenant DBs contain created_by columns used by invoice/credit-note
    reminder and task models.
    """
    from django.apps import apps
    from django.db import connections
    from core.middleware import get_current_db

    db_alias = get_current_db()
    db_connection = connections[db_alias]
    existing_tables = set(db_connection.introspection.table_names())

    model_names = [
        "InvoiceReminder",
        "InvoiceTask",
        "CreditNoteReminder",
        "CreditNoteTask",
    ]

    for model_name in model_names:
        model = apps.get_model("core", model_name)
        table_name = model._meta.db_table
        if table_name not in existing_tables:
            continue

        with db_connection.cursor() as cursor:
            existing_columns = {
                column.name
                for column in db_connection.introspection.get_table_description(cursor, table_name)
            }

        if "created_by" in existing_columns:
            continue

        field = model._meta.get_field("created_by")
        with db_connection.schema_editor() as schema_editor:
            schema_editor.add_field(model, field)


def ensure_leads_setup_tables():
    """
    Ensure managed leads setup tables and newly introduced columns exist for
    tenant databases without relying on migration files.
    """
    from django.apps import apps
    from django.db import connections

    db_alias = get_current_db()
    db_connection = connections[db_alias]
    existing_tables = set(db_connection.introspection.table_names())

    model_names = [
        "Product",
        "ProductStatus",
        "CustomerStatus",
        "LeadSource",
        "Lead",
        "WebFormField",
        "EmailIntegration",
        "LeadCaptureConfiguration",
    ]

    for model_name in model_names:
        model = apps.get_model("ms_crm_app", model_name)
        table_name = model._meta.db_table
        if table_name in existing_tables:
            continue

        with db_connection.schema_editor() as schema_editor:
            schema_editor.create_model(model)
        existing_tables.add(table_name)

    field_patch_map = {
        "ProductStatus": ["is_active"],
        "LeadSource": ["is_active"],
        "Lead": [
            "company",
            "message",
            "priority",
            "assigned_to_user",
            "assigned_to_team",
            "dynamic_data",
        ],
        "WebFormField": [
            "label",
            "mapped_field",
            "placeholder",
            "is_active",
            "sort_order",
            "field_options",
        ],
        "EmailIntegration": [
            "smtp_host",
            "smtp_port",
            "imap_host",
            "imap_port",
            "email_address",
            "use_ssl",
            "auto_create_leads",
            "is_active",
            "last_sync_at",
        ],
    }

    for model_name, field_names in field_patch_map.items():
        model = apps.get_model("ms_crm_app", model_name)
        table_name = model._meta.db_table
        if table_name not in existing_tables:
            continue

        with db_connection.cursor() as cursor:
            existing_columns = {
                column.name
                for column in db_connection.introspection.get_table_description(cursor, table_name)
            }

        for field_name in field_names:
            if field_name in existing_columns:
                continue
            field = model._meta.get_field(field_name)
            with db_connection.schema_editor() as schema_editor:
                schema_editor.add_field(model, field)
            existing_columns.add(field_name)

    web_form_field_model = apps.get_model("ms_crm_app", "WebFormField")
    default_fields = [
        {
            "field_name": "name",
            "label": "Name",
            "field_type": "text",
            "mapped_field": "first_name",
            "placeholder": "Enter name",
            "is_required": True,
            "is_active": True,
            "sort_order": 1,
        },
        {
            "field_name": "email",
            "label": "Email",
            "field_type": "email",
            "mapped_field": "email",
            "placeholder": "Enter email",
            "is_required": True,
            "is_active": True,
            "sort_order": 2,
        },
        {
            "field_name": "phone",
            "label": "Phone",
            "field_type": "phone",
            "mapped_field": "phone",
            "placeholder": "Enter phone",
            "is_required": False,
            "is_active": True,
            "sort_order": 3,
        },
        {
            "field_name": "company",
            "label": "Company",
            "field_type": "text",
            "mapped_field": "company",
            "placeholder": "Enter company",
            "is_required": False,
            "is_active": True,
            "sort_order": 4,
        },
        {
            "field_name": "message",
            "label": "Message",
            "field_type": "textarea",
            "mapped_field": "message",
            "placeholder": "Enter message",
            "is_required": False,
            "is_active": True,
            "sort_order": 5,
        },
    ]

    for item in default_fields:
        obj, created = web_form_field_model.objects.get_or_create(
            field_name=item["field_name"],
            defaults=item,
        )
        if created:
            continue
        updated_fields = []
        for key, value in item.items():
            if key == "field_name":
                continue
            current_value = getattr(obj, key, None)
            if current_value == value:
                continue
            if key in {"is_required", "sort_order"}:
                continue
            setattr(obj, key, value)
            updated_fields.append(key)
        if updated_fields:
            obj.save(update_fields=updated_fields)

    config_model = apps.get_model("ms_crm_app", "LeadCaptureConfiguration")
    config_model.objects.get_or_create(name="default")
