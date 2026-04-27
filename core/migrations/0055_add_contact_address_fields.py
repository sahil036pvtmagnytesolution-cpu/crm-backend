"""Placeholder migration to satisfy Django's migration loader.

The earlier migration ``0055_add_contact_address_fields_sql`` implements the
actual schema changes using raw SQL with ``IF NOT EXISTS``. This placeholder
ensures that ``core.0055_add_contact_address_fields`` exists as a valid
migration module so Django does not raise ``BadMigrationError`` when loading the
migration graph.

No operations are performed because the schema changes are handled in the
subsequent ``0056_add_contact_address_fields_sql`` migration.
"""

from django.db import migrations


class Migration(migrations.Migration):
    """Empty migration – marks the migration name as existing.

    It intentionally contains no operations. The real address‑field addition is
    performed in ``0056_add_contact_address_fields_sql``.
    """

    dependencies = [
        ("core", "0054_add_missing_address_fields"),
    ]

    operations = []
