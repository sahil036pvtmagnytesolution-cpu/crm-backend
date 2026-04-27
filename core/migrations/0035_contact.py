from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0034_alter_client_city_alter_client_country_and_more"),
    ]

    operations = [
        migrations.CreateModel(
            name="Contact",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("firstname", models.CharField(max_length=191)),
                ("lastname", models.CharField(max_length=191)),
                ("email", models.EmailField(max_length=254)),
                ("company", models.CharField(blank=True, max_length=255, null=True)),
                ("phonenumber", models.CharField(blank=True, max_length=100, null=True)),
                ("title", models.CharField(blank=True, max_length=100, null=True)),
                ("password", models.CharField(blank=True, max_length=255, null=True)),
                ("is_primary", models.BooleanField(default=False)),
                ("active", models.BooleanField(default=True)),
                ("direction", models.CharField(blank=True, max_length=10, null=True)),
                ("invoice_emails", models.BooleanField(default=False)),
                ("estimate_emails", models.BooleanField(default=False)),
                ("credit_note_emails", models.BooleanField(default=False)),
                ("contract_emails", models.BooleanField(default=False)),
                ("task_emails", models.BooleanField(default=False)),
                ("project_emails", models.BooleanField(default=False)),
                ("ticket_emails", models.BooleanField(default=False)),
                ("last_login", models.DateTimeField(blank=True, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
            ],
            options={
                "db_table": "core_contact",
                "ordering": ["-created_at", "-id"],
            },
        ),
    ]
