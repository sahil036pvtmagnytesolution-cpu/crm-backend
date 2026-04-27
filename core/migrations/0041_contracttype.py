from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0040_contract"),
    ]

    operations = [
        migrations.CreateModel(
            name="ContractType",
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
                ("name", models.CharField(max_length=191, unique=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
            ],
            options={
                "db_table": "core_contract_type",
                "ordering": ["name", "id"],
            },
        ),
    ]
