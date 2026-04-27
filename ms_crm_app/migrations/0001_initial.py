"""Initial migration for ``ms_crm_app``.

Creates the ``ActivityLog`` model which is required by subsequent migrations.
All other models are marked ``managed = False`` in the codebase and are
considered to already exist in the legacy database, so they are not created
here.
"""

from django.db import migrations, models


class Migration(migrations.Migration):
    # This is the first migration for the app.
    # Depend on core app migrations to resolve proxy base classes.
    dependencies = [
        ("core", "0029_auto_20260310_1237"),
    ]
    operations = [
        migrations.CreateModel(
            name="ActivityLog",
            fields=[
                ("id", models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("description", models.TextField()),
                ("date", models.DateTimeField()),
                # Initial column is ``staffid``; later migrations rename it to ``staff_name``.
                ("staffid", models.CharField(blank=True, max_length=100, null=True)),
            ],
            options={
                "db_table": "ms_activity_log",
                "managed": False,
            },
        ),
        # Stub model for UserProfile – required by later migrations that alter its fields.
        migrations.CreateModel(
            name="UserProfile",
            fields=[
                ("id", models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("user_id", models.IntegerField(blank=True, null=True, default=0)),
                ("user_name", models.CharField(max_length=100)),
                ("user_type", models.IntegerField(blank=True, null=True)),
                ("business_name", models.CharField(max_length=100)),
                ("user_email", models.EmailField(unique=True, max_length=254)),
                ("contact_number", models.CharField(max_length=20)),
                ("password", models.CharField(max_length=255)),
                ("address", models.TextField(max_length=100)),
                ("city", models.CharField(blank=True, max_length=100, null=True)),
                ("created_by", models.IntegerField(blank=True, null=True)),
                ("updated_by", models.IntegerField(blank=True, null=True)),
                ("created_datetime", models.DateTimeField(blank=True, null=True)),
                ("updated_datetime", models.DateTimeField(blank=True, null=True)),
            ],
            options={
                "db_table": "ms_user_profiles",
                "managed": False,
            },
        ),
        # Stub model for Staff – referenced by GDPR request FK.
        migrations.CreateModel(
            name="Staff",
            fields=[
                ("staffid", models.AutoField(primary_key=True, serialize=False)),
                ("email", models.CharField(max_length=100)),
                ("firstname", models.CharField(max_length=50)),
                ("lastname", models.CharField(max_length=50)),
                ("password", models.CharField(max_length=250)),
                ("datecreated", models.DateTimeField()),
            ],
            options={
                "db_table": "ms_staff",
                "managed": False,
            },
        ),
        # Stub model for Roles – required by later migrations that alter its options.
        migrations.CreateModel(
            name="Roles",
            fields=[
                ("roleid", models.AutoField(primary_key=True, serialize=False)),
                ("name", models.CharField(max_length=100)),
                ("permissions", models.TextField(blank=True, null=True)),
            ],
            options={
                "db_table": "ms_roles",
                "managed": False,
            },
        ),
    ]