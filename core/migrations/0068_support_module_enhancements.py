from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0067_merge_20260407_1718"),
    ]

    operations = [
        migrations.AddField(
            model_name="setupsupportdepartment",
            name="imap_host",
            field=models.CharField(blank=True, default="", max_length=255),
        ),
        migrations.AddField(
            model_name="setupticketpriority",
            name="description",
            field=models.TextField(blank=True, default=""),
        ),
    ]

