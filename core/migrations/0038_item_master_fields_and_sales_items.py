from django.db import migrations, models


def backfill_item_master_fields(apps, schema_editor):
    Item = apps.get_model("core", "Item")

    for item in Item.objects.all():
        item.item_name = (item.item_name or item.description or "").strip()
        if not item.status:
            item.status = "active"
        item.save(update_fields=["item_name", "status"])


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0037_itemgroup_item"),
    ]

    operations = [
        migrations.AddField(
            model_name="estimate",
            name="items",
            field=models.JSONField(blank=True, default=list),
        ),
        migrations.AddField(
            model_name="invoice",
            name="items",
            field=models.JSONField(blank=True, default=list),
        ),
        migrations.AddField(
            model_name="item",
            name="item_code",
            field=models.CharField(blank=True, db_index=True, max_length=100, null=True),
        ),
        migrations.AddField(
            model_name="item",
            name="item_name",
            field=models.CharField(blank=True, db_index=True, max_length=255),
        ),
        migrations.AddField(
            model_name="item",
            name="status",
            field=models.CharField(db_index=True, default="active", max_length=20),
        ),
        migrations.RunPython(backfill_item_master_fields, migrations.RunPython.noop),
    ]
