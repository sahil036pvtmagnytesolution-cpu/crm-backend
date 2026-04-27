from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0060_add_theme_style_fields"),
    ]

    operations = [
        migrations.RunPython(migrations.RunPython.noop, migrations.RunPython.noop),
    ]
