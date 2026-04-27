from django.db import migrations


def _ensure_created_by_column(apps, schema_editor, model_name):
    model = apps.get_model("core", model_name)
    table_name = model._meta.db_table
    field = model._meta.get_field("created_by")

    with schema_editor.connection.cursor() as cursor:
        existing_columns = {
            column.name
            for column in schema_editor.connection.introspection.get_table_description(
                cursor,
                table_name,
            )
        }

    if field.column not in existing_columns:
        schema_editor.add_field(model, field)


def forwards(apps, schema_editor):
    for model_name in (
        "InvoiceReminder",
        "InvoiceTask",
        "CreditNoteReminder",
        "CreditNoteTask",
    ):
        _ensure_created_by_column(apps, schema_editor, model_name)


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0063_customfield_creditnotereminder_created_by_and_more"),
    ]

    operations = [
        migrations.RunPython(forwards, migrations.RunPython.noop),
    ]
