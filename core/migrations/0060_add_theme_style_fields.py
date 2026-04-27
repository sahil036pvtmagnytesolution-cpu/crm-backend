from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0059_permission_roleauditlog_rolepermission_userrole_and_more"),
    ]

    operations = [
        migrations.RunPython(migrations.RunPython.noop, migrations.RunPython.noop),
    ]
