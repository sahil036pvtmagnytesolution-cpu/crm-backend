from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0043_contract_extras"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Project",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(db_index=True, max_length=255)),
                ("progress", models.PositiveSmallIntegerField(default=0)),
                (
                    "status",
                    models.CharField(
                        choices=[
                            ("Draft", "Draft"),
                            ("Sent", "Sent"),
                            ("Expired", "Expired"),
                            ("Declined", "Declined"),
                            ("Accepted", "Accepted"),
                            ("In Progress", "In Progress"),
                            ("Completed", "Completed"),
                            ("On Hold", "On Hold"),
                        ],
                        db_index=True,
                        default="Draft",
                        max_length=32,
                    ),
                ),
                (
                    "billing_type",
                    models.CharField(
                        choices=[("Fixed Rate", "Fixed Rate"), ("Hourly", "Hourly")],
                        default="Fixed Rate",
                        max_length=32,
                    ),
                ),
                ("total_rate", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                (
                    "estimated_hours",
                    models.DecimalField(decimal_places=2, default=0, max_digits=10),
                ),
                ("start_date", models.DateField(blank=True, null=True)),
                ("deadline", models.DateField(blank=True, null=True)),
                ("tags", models.CharField(blank=True, max_length=255, null=True)),
                ("description", models.TextField(blank=True, null=True)),
                ("send_email", models.BooleanField(default=False)),
                ("visible_tabs", models.JSONField(blank=True, default=list)),
                ("settings", models.JSONField(blank=True, default=list)),
                ("created_at", models.DateTimeField(auto_now_add=True, db_index=True)),
                ("updated_at", models.DateTimeField(auto_now=True, db_index=True)),
                (
                    "client",
                    models.ForeignKey(
                        blank=True,
                        db_index=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="projects",
                        to="core.client",
                    ),
                ),
                (
                    "created_by",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="created_projects",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
                (
                    "members",
                    models.ManyToManyField(
                        blank=True,
                        related_name="project_memberships",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
            options={
                "db_table": "core_project",
                "ordering": ["-created_at", "-id"],
            },
        ),
        migrations.AddIndex(
            model_name="project",
            index=models.Index(fields=["client", "status"], name="core_project_client__e37d5a_idx"),
        ),
    ]

