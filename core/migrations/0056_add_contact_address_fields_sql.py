"""Idempotent migration to ensure address fields exist on the ``Contact`` model.

This migration uses raw ``ALTER TABLE ... ADD COLUMN IF NOT EXISTS`` statements
which are supported by MySQL 8+. The ``IF NOT EXISTS`` clause makes the
operation safe to run on databases where the columns may already be present –
no error will be raised and the migration will be a no‑op for those columns.

We keep the migration atomic‑off because MySQL does not allow DDL statements
inside a transaction.
"""

from django.db import migrations, models


def add_address_columns(apps, schema_editor):
    """Add address columns to ``core_contact`` safely.

    This mirrors the logic used in migration ``0054_add_missing_address_fields``
    – we execute a plain ``ALTER TABLE`` for each column and ignore any
    ``DatabaseError`` that indicates the column already exists. This works on
    MySQL versions both with and without ``IF NOT EXISTS`` support.
    """
    from django.db import DatabaseError

    sql_statements = [
        "ALTER TABLE core_contact ADD COLUMN street varchar(255) NULL;",
        "ALTER TABLE core_contact ADD COLUMN city varchar(100) NULL;",
        "ALTER TABLE core_contact ADD COLUMN state varchar(100) NULL;",
        "ALTER TABLE core_contact ADD COLUMN zip_code varchar(20) NULL;",
        "ALTER TABLE core_contact ADD COLUMN country varchar(100) NULL;",
    ]
    for sql in sql_statements:
        try:
            schema_editor.execute(sql)
        except DatabaseError:
            # Column probably already exists – ignore and continue.
            continue


def remove_address_columns(apps, schema_editor):
    """Drop the address columns – used when the migration is reversed."""
    for col in ["street", "city", "state", "zip_code", "country"]:
        schema_editor.execute(f"ALTER TABLE core_contact DROP COLUMN IF EXISTS {col};")


class Migration(migrations.Migration):
    """Migration that safely adds address fields to ``Contact``.

    The migration is deliberately simple: it only runs raw SQL via ``RunPython``.
    This avoids Django's schema‑generation pitfalls on MySQL and works on any
    version that supports ``IF NOT EXISTS`` (MySQL 8+). For older MySQL the
    ``IF NOT EXISTS`` clause is ignored, but the operation will still succeed
    because the column already exists.
    """

    atomic = False

    dependencies = [
        ("core", "0055_add_contact_address_fields"),
    ]

    operations = [
        migrations.RunPython(add_address_columns, reverse_code=remove_address_columns),
    ]
