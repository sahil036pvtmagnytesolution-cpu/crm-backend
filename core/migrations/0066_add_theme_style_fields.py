from django.db import migrations, models


def ensure_theme_style_fields(apps, schema_editor):
    connection = schema_editor.connection
    table_name = "core_setup_theme_style"

    if table_name not in connection.introspection.table_names():
        return

    with connection.cursor() as cursor:
        existing_columns = {
            column.name
            for column in connection.introspection.get_table_description(cursor, table_name)
        }

    table_sql = schema_editor.quote_name(table_name)
    accent_sql = schema_editor.quote_name("accent_color")
    secondary_sql = schema_editor.quote_name("secondary_color")
    theme_mode_sql = schema_editor.quote_name("theme_mode")

    if "accent_color" not in existing_columns:
        schema_editor.execute(
            f"ALTER TABLE {table_sql} ADD COLUMN {accent_sql} varchar(7) NOT NULL DEFAULT '#198754'"
        )

    if "secondary_color" not in existing_columns:
        schema_editor.execute(
            f"ALTER TABLE {table_sql} ADD COLUMN {secondary_sql} varchar(7) NOT NULL DEFAULT '#6c757d'"
        )

    if "theme_mode" not in existing_columns:
        schema_editor.execute(
            f"ALTER TABLE {table_sql} ADD COLUMN {theme_mode_sql} varchar(5) NOT NULL DEFAULT 'light'"
        )
        return

    if connection.vendor == "mysql":
        schema_editor.execute(
            f"ALTER TABLE {table_sql} MODIFY COLUMN {theme_mode_sql} varchar(5) NOT NULL DEFAULT 'light'"
        )


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0065_remove_setupthemestyle_accent_color_and_more"),
    ]

    operations = [
        migrations.SeparateDatabaseAndState(
            database_operations=[
                migrations.RunPython(ensure_theme_style_fields, migrations.RunPython.noop),
            ],
            state_operations=[
                migrations.AddField(
                    model_name="setupthemestyle",
                    name="accent_color",
                    field=models.CharField(default="#198754", max_length=7),
                ),
                migrations.AddField(
                    model_name="setupthemestyle",
                    name="secondary_color",
                    field=models.CharField(default="#6c757d", max_length=7),
                ),
                migrations.AlterField(
                    model_name="setupthemestyle",
                    name="theme_mode",
                    field=models.CharField(
                        choices=[("light", "Light"), ("dark", "Dark")],
                        default="light",
                        max_length=5,
                    ),
                ),
            ],
        ),
    ]
