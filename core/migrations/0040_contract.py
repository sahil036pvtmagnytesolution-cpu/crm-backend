from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0039_expense_customer_invoice_refs"),
    ]

    operations = [
        migrations.CreateModel(
            name="Contract",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("customer", models.CharField(blank=True, max_length=255, null=True)),
                ("subject", models.CharField(max_length=255)),
                ("contract_type", models.CharField(blank=True, max_length=100, null=True)),
                ("contract_value", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("start_date", models.DateField(blank=True, null=True)),
                ("end_date", models.DateField(blank=True, null=True)),
                ("signature", models.CharField(blank=True, max_length=255, null=True)),
                ("description", models.TextField(blank=True, null=True)),
                ("hide_from_customer", models.BooleanField(default=False)),
                ("is_trashed", models.BooleanField(default=False)),
                ("status", models.CharField(choices=[("Draft", "Draft"), ("Active", "Active"), ("Expired", "Expired")], default="Draft", max_length=20)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                (
                    "customer_ref",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="contracts",
                        to="core.client",
                    ),
                ),
            ],
        ),
    ]

