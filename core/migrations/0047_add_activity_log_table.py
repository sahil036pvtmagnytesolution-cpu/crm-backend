"""Stub migration for the removed proxy models.

The original ``0047_add_activity_log_table.py`` defined proxy models for
``StaffProxy``, ``KnowledgeBaseProxy`` and ``KnowledgeBaseGroupProxy``. Those
models were removed to resolve circular import issues, but Django still expects a
migration file with a ``Migration`` class. This stub provides an empty migration
that depends on the previous activity‑log migration (``0046_activitylog``) so the
migration graph remains valid.
"""

from django.db import migrations


class Migration(migrations.Migration):
    """Empty migration – retained for migration graph compatibility.

    No database operations are required because the proxy models have been
    eliminated. Keeping this file prevents ``BadMigrationError`` during
    ``manage.py migrate``.
    """

    dependencies = [
        ("core", "0046_activitylog"),
    ]

    operations = []
