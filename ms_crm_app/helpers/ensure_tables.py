from django.db import connection

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
