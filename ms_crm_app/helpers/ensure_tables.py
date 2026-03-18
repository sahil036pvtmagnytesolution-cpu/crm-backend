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
                    status VARCHAR(100) NOT NULL
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
            """)
