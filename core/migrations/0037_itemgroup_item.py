from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0036_creditnote_creditnotereminder_creditnotetask"),
    ]

    operations = [
        migrations.CreateModel(
            name="ItemGroup",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("name", models.CharField(max_length=191, unique=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
            ],
            options={
                "db_table": "core_item_group",
                "ordering": ["name", "id"],
            },
        ),
        migrations.CreateModel(
            name="Item",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("description", models.CharField(max_length=255)),
                ("long_description", models.TextField(blank=True, null=True)),
                ("rate", models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ("tax", models.CharField(blank=True, default="No Tax", max_length=50, null=True)),
                ("tax2", models.CharField(blank=True, default="No Tax", max_length=50, null=True)),
                ("unit", models.CharField(blank=True, max_length=100, null=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("group", models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name="items", to="core.itemgroup")),
            ],
            options={
                "db_table": "core_item",
                "ordering": ["-created_at", "-id"],
            },
        ),
    ]
