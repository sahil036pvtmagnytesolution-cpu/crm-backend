from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0042_seed_contract_types"),
    ]

    operations = [
        migrations.AddField(
            model_name="contract",
            name="content",
            field=models.TextField(blank=True, null=True),
        ),
        migrations.CreateModel(
            name="ContractAttachment",
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
                ("file", models.FileField(upload_to="contracts/attachments/%Y/%m/")),
                ("filename", models.CharField(blank=True, max_length=255, null=True)),
                ("uploaded_by", models.CharField(blank=True, max_length=191, null=True)),
                ("uploaded_at", models.DateTimeField(auto_now_add=True)),
                (
                    "contract",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="attachments",
                        to="core.contract",
                    ),
                ),
            ],
            options={
                "db_table": "core_contract_attachment",
                "ordering": ["-uploaded_at", "-id"],
            },
        ),
        migrations.CreateModel(
            name="ContractComment",
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
                ("comment", models.TextField()),
                ("created_by", models.CharField(blank=True, max_length=191, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                (
                    "contract",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="comments",
                        to="core.contract",
                    ),
                ),
            ],
            options={
                "db_table": "core_contract_comment",
                "ordering": ["-created_at", "-id"],
            },
        ),
        migrations.CreateModel(
            name="ContractNote",
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
                ("note", models.TextField()),
                ("created_by", models.CharField(blank=True, max_length=191, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                (
                    "contract",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="notes",
                        to="core.contract",
                    ),
                ),
            ],
            options={
                "db_table": "core_contract_note",
                "ordering": ["-created_at", "-id"],
            },
        ),
        migrations.CreateModel(
            name="ContractRenewal",
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
                ("old_start_date", models.DateField(blank=True, null=True)),
                ("new_start_date", models.DateField(blank=True, null=True)),
                ("old_end_date", models.DateField(blank=True, null=True)),
                ("new_end_date", models.DateField(blank=True, null=True)),
                (
                    "old_value",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=12, null=True
                    ),
                ),
                (
                    "new_value",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=12, null=True
                    ),
                ),
                ("notes", models.TextField(blank=True, null=True)),
                ("renewed_by", models.CharField(blank=True, max_length=191, null=True)),
                ("renewed_at", models.DateTimeField(auto_now_add=True)),
                (
                    "contract",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="renewals",
                        to="core.contract",
                    ),
                ),
            ],
            options={
                "db_table": "core_contract_renewal",
                "ordering": ["-renewed_at", "-id"],
            },
        ),
        migrations.CreateModel(
            name="ContractTask",
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
                ("subject", models.CharField(max_length=255)),
                ("description", models.TextField(blank=True, null=True)),
                ("start_date", models.DateField(blank=True, null=True)),
                ("due_date", models.DateField(blank=True, null=True)),
                (
                    "priority",
                    models.CharField(
                        choices=[("Low", "Low"), ("Medium", "Medium"), ("High", "High")],
                        default="Medium",
                        max_length=20,
                    ),
                ),
                ("is_public", models.BooleanField(default=False)),
                ("is_billable", models.BooleanField(default=True)),
                ("tags", models.CharField(blank=True, max_length=255, null=True)),
                ("created_by", models.CharField(blank=True, max_length=191, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                (
                    "contract",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="tasks",
                        to="core.contract",
                    ),
                ),
            ],
            options={
                "db_table": "core_contract_task",
                "ordering": ["-created_at", "-id"],
            },
        ),
    ]

