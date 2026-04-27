"""Migration to create the gdpr_requests table.
This migration is added after the existing migration chain (ending at 0008_delete_business)
to avoid conflicts with the previously removed 0001_create_gdpr_requests migration.
"""

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    # This migration should run after the placeholder migration that ensures a
    # linear migration chain.
    dependencies = [
        ("ms_crm_app", "0001_create_gdpr_requests"),
    ]

    operations = [
        migrations.CreateModel(
            name="GdprRequest",
            fields=[
                ("id", models.AutoField(primary_key=True, serialize=False)),
                ("customer_name", models.CharField(max_length=191)),
                ("email", models.EmailField(max_length=254)),
                ("user_type", models.CharField(max_length=20, choices=[
                    ("customer", "Customer"),
                    ("lead", "Lead"),
                    ("staff", "Staff"),
                ])),
                ("request_type", models.CharField(max_length=20, choices=[
                    ("access", "Data Access"),
                    ("export", "Data Export"),
                    ("deletion", "Data Deletion"),
                ])),
                ("status", models.CharField(max_length=20, default="pending", choices=[
                    ("pending", "Pending"),
                    ("in_progress", "In Progress"),
                    ("completed", "Completed"),
                    ("rejected", "Rejected"),
                ])),
                ("details", models.TextField(blank=True, null=True)),
                ("request_id", models.CharField(max_length=64, unique=True, editable=False)),
                ("requested_at", models.DateTimeField(default=django.utils.timezone.now, editable=False)),
                ("processed_by", models.ForeignKey(null=True, blank=True, to="ms_crm_app.Staff", on_delete=models.SET_NULL)),
                ("completed_at", models.DateTimeField(null=True, blank=True)),
                ("verification_status", models.CharField(max_length=20, default="pending")),
                ("data_format", models.CharField(max_length=10, default="json", choices=[
                    ("csv", "CSV"),
                    ("json", "JSON"),
                    ("pdf", "PDF"),
                ])),
            ],
            options={"db_table": "gdpr_requests"},
        ),
    ]
