from django.db import migrations


def seed_contract_types(apps, schema_editor):
    ContractType = apps.get_model("core", "ContractType")

    defaults = ["Service", "Support"]
    for name in defaults:
        ContractType.objects.get_or_create(name=name)


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0041_contracttype"),
    ]

    operations = [
        migrations.RunPython(seed_contract_types, migrations.RunPython.noop),
    ]

