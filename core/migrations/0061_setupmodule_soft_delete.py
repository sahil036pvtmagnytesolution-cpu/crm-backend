from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0060_seed_rbac_baseline"),
    ]

    operations = [
        migrations.AddField(
            model_name="setupmodule",
            name="deleted_at",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="setupmodule",
            name="is_deleted",
            field=models.BooleanField(db_index=True, default=False),
        ),
    ]
