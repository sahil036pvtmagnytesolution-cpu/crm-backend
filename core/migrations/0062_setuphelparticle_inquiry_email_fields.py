from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0061_setupmodule_soft_delete"),
    ]

    operations = [
        migrations.AddField(
            model_name="setuphelparticle",
            name="inquiry_email_cc",
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name="setuphelparticle",
            name="inquiry_email_subject",
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
        migrations.AddField(
            model_name="setuphelparticle",
            name="inquiry_email_to",
            field=models.TextField(blank=True, null=True),
        ),
    ]

