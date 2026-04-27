"""Placeholder migration for GDPR requests.
This migration provides a linear chain for Django migrations.
It has no database operations and depends on the previous migration
(`0008_delete_business`). The actual GDPR model is created in
`0009_gdpr_requests.py` which depends on this placeholder.
"""

from django.db import migrations


class Migration(migrations.Migration):
    # No dependencies; this placeholder sits at the start of the migration chain.
    dependencies = []
    operations = []