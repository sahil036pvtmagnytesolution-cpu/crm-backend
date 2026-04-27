from django.db import migrations, models
import django.db.models.deletion
from datetime import date


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0035_contact"),
    ]

    operations = [
        migrations.CreateModel(
            name="CreditNote",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("deleted_customer_name", models.CharField(blank=True, max_length=255, null=True)),
                ("number", models.PositiveIntegerField(default=1)),
                ("prefix", models.CharField(default="CN-", max_length=20)),
                ("number_format", models.CharField(blank=True, max_length=30, null=True)),
                ("datecreated", models.DateTimeField(auto_now_add=True)),
                ("date", models.DateField(default=date.today)),
                ("duedate", models.DateField(blank=True, null=True)),
                ("project_id", models.IntegerField(blank=True, null=True)),
                ("reference_no", models.CharField(blank=True, max_length=100, null=True)),
                ("subtotal", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("total_tax", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("total", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("adjustment", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("addedfrom", models.IntegerField(blank=True, default=0, null=True)),
                ("status", models.IntegerField(default=1)),
                ("clientnote", models.TextField(blank=True, null=True)),
                ("adminnote", models.TextField(blank=True, null=True)),
                ("terms", models.TextField(blank=True, null=True)),
                ("currency", models.CharField(blank=True, default="INR", max_length=20, null=True)),
                ("discount_percent", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("discount_total", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("discount_type", models.CharField(blank=True, default="none", max_length=30, null=True)),
                ("billing_street", models.CharField(blank=True, max_length=255, null=True)),
                ("billing_city", models.CharField(blank=True, max_length=100, null=True)),
                ("billing_state", models.CharField(blank=True, max_length=100, null=True)),
                ("billing_zip", models.CharField(blank=True, max_length=30, null=True)),
                ("billing_country", models.CharField(blank=True, max_length=100, null=True)),
                ("shipping_street", models.CharField(blank=True, max_length=255, null=True)),
                ("shipping_city", models.CharField(blank=True, max_length=100, null=True)),
                ("shipping_state", models.CharField(blank=True, max_length=100, null=True)),
                ("shipping_zip", models.CharField(blank=True, max_length=30, null=True)),
                ("shipping_country", models.CharField(blank=True, max_length=100, null=True)),
                ("include_shipping", models.BooleanField(default=False)),
                ("show_shipping_on_credit_note", models.BooleanField(default=False)),
                ("show_quantity_as", models.CharField(blank=True, default="Qty", max_length=30, null=True)),
                ("email_signature", models.TextField(blank=True, null=True)),
                ("items", models.JSONField(blank=True, default=list)),
                ("client", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="credit_notes", to="core.client")),
            ],
            options={
                "db_table": "core_creditnote",
                "ordering": ["-datecreated", "-id"],
            },
        ),
        migrations.CreateModel(
            name="CreditNoteReminder",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("description", models.TextField(blank=True, null=True)),
                ("date", models.DateTimeField(blank=True, null=True)),
                ("status", models.CharField(blank=True, default="Pending", max_length=50, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("credit_note", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="reminders", to="core.creditnote")),
            ],
            options={
                "db_table": "core_creditnote_reminder",
                "ordering": ["-created_at", "-id"],
            },
        ),
        migrations.CreateModel(
            name="CreditNoteTask",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("description", models.TextField(blank=True, null=True)),
                ("date", models.DateTimeField(blank=True, null=True)),
                ("status", models.CharField(blank=True, default="Open", max_length=50, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("credit_note", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="tasks", to="core.creditnote")),
            ],
            options={
                "db_table": "core_creditnote_task",
                "ordering": ["-created_at", "-id"],
            },
        ),
    ]
