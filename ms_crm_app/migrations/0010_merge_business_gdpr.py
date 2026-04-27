"""Merge migration for ms_crm_app.

Resolves the conflict between leaf migrations ``0008_delete_business`` and
``0009_gdpr_requests`` by depending on both. No database operations are
required – this migration simply merges the migration graph.
"""

from django.db import migrations


class Migration(migrations.Migration):
    # Depend on both leaf migrations so they are considered applied together.
    dependencies = [
        ("ms_crm_app", "0008_delete_business"),
        ("ms_crm_app", "0009_gdpr_requests"),
    ]

    # No operations – merge point only.
    operations = []
