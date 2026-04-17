import json

from django.db import IntegrityError, transaction
from core.models import EmailTemplate
from core.middleware import get_current_db


EMAIL_TEMPLATES = [
    {
        # "name": "New Client Created",
        "module": "client",
        "slug": "new-client-created",
        "language": "english",
        "subject": "Welcome Client",
        "body": "New client created successfully",
        "variables": [],
    },
    {
        "name": "Ticket Reply",
        "module": "support",
        "slug": "ticket-reply",
        "language": "english",
        "subject": "Ticket Reply",
        "body": "You have a new ticket reply",
        "variables": [],
    },
    {
        "name": "Ticket Created",
        "module": "ticket",
        "slug": "ticket_created",
        "language": "english",
        "subject": "Ticket #{{ticket_id}} created",
        "body": (
            "Hi {{customer_name}},<br/><br/>"
            "Your ticket <strong>#{{ticket_id}}</strong> has been created with status "
            "<strong>{{status}}</strong> and priority <strong>{{priority}}</strong>."
        ),
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
    {
        "name": "Ticket Assigned",
        "module": "ticket",
        "slug": "ticket_assigned",
        "language": "english",
        "subject": "Ticket #{{ticket_id}} assigned",
        "body": (
            "Ticket <strong>#{{ticket_id}}</strong> is now assigned to "
            "<strong>{{assigned_to}}</strong>."
        ),
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
    {
        "name": "Ticket Updated",
        "module": "ticket",
        "slug": "ticket_updated",
        "language": "english",
        "subject": "Ticket #{{ticket_id}} updated",
        "body": "Your ticket #{{ticket_id}} has been updated. Current status: {{status}}.",
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
    {
        "name": "Ticket Closed",
        "module": "ticket",
        "slug": "ticket_closed",
        "language": "english",
        "subject": "Ticket #{{ticket_id}} closed",
        "body": "Your ticket #{{ticket_id}} has been marked as closed.",
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
    {
        "name": "Ticket Reopened",
        "module": "ticket",
        "slug": "ticket_reopened",
        "language": "english",
        "subject": "Ticket #{{ticket_id}} reopened",
        "body": "Your ticket #{{ticket_id}} has been reopened and moved to {{status}}.",
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
    {
        "name": "Thank You",
        "module": "ticket",
        "slug": "thank_you",
        "language": "english",
        "subject": "Thank you for contacting support",
        "body": "Thank you {{customer_name}}. Ticket #{{ticket_id}} is now {{status}}.",
        "variables": [
            "{{ticket_id}}",
            "{{customer_name}}",
            "{{email}}",
            "{{subject}}",
            "{{description}}",
            "{{status}}",
            "{{priority}}",
            "{{assigned_to}}",
            "{{created_at}}",
        ],
    },
]

# ============================
# OLD FUNCTION (DO NOT TOUCH)
# ============================
def seed_email_templates():
    """Legacy entry point kept for backward compatibility.

    The implementation delegates to ``seed_email_templates_optimized`` which
    performs schema-aware raw inserts so it works across both legacy and newer
    EmailTemplate table shapes.
    """
    # Call the optimized implementation which safely inserts only the known
    # columns. This ensures both legacy callers and newer code behave correctly.
    return seed_email_templates_optimized()


# ======================================
# ✅ NEW OPTIMIZED FUNCTION (USE THIS)
# ======================================
def seed_email_templates_optimized():
    """
    🔥 Optimized version:
    - Single SELECT
    - Single bulk_create
    - DB-aware
    - Safe for parallel signup
    """

    db = get_current_db() or "default"

    # All operations are performed within a single atomic transaction to ensure
    # consistency. We capture existing unique keys first, then insert only
    # missing templates.
    with transaction.atomic(using=db):
        existing_keys = set(
            EmailTemplate.objects
            .using(db)
            .values_list("module", "slug", "language")
        )

        # Build candidate objects once, then insert with schema-aware SQL so we
        # can support both:
        # 1) legacy schemas where ``name`` column does not exist
        # 2) newer schemas where ``name`` exists (and may be required)
        new_objects = []
        for t in EMAIL_TEMPLATES:
            if (t["module"], t["slug"], t["language"]) in existing_keys:
                continue
            new_obj = EmailTemplate(
                name=t.get("name") or t.get("subject") or t["slug"],
                module=t["module"],
                slug=t["slug"],
                language=t["language"],
                subject=t["subject"],
                body=t["body"],
                variables=t.get("variables", []),
            )
            new_objects.append(new_obj)

        if new_objects:
            # Django's ``bulk_create`` includes *all* model fields, which would try to
            # write to the ``name`` column that may be missing in older databases.
            # To avoid this, we use a raw INSERT that explicitly lists only the known
            # safe columns and writes JSON text for the ``variables`` column.
            from django.db import connections

            batch = []
            connection = connections[db]
            table_name = EmailTemplate._meta.db_table

            with connection.cursor() as cursor:
                table_columns = {
                    col.name for col in connection.introspection.get_table_description(cursor, table_name)
                }

                insert_columns = ["module", "slug", "language", "subject", "body", "variables"]
                if "name" in table_columns:
                    insert_columns.insert(0, "name")

                placeholders = ", ".join(["%s"] * len(insert_columns))
                sql = (
                    "INSERT INTO {table} ({columns}) VALUES ({placeholders})"
                ).format(
                    table=table_name,
                    columns=", ".join(insert_columns),
                    placeholders=placeholders,
                )

                def flush_batch():
                    if not batch:
                        return
                    try:
                        cursor.executemany(sql, batch)
                    except IntegrityError:
                        # Concurrent requests can race on the unique
                        # (module, slug, language) constraint. Retry row-wise
                        # and ignore duplicates so seeding stays idempotent.
                        for row in batch:
                            try:
                                cursor.execute(sql, row)
                            except IntegrityError:
                                continue
                    batch.clear()

                for obj in new_objects:
                    row = [
                        obj.module,
                        obj.slug,
                        obj.language,
                        obj.subject,
                        obj.body,
                        json.dumps(obj.variables or []),
                    ]
                    if "name" in table_columns:
                        row.insert(0, obj.name or "")

                    batch.append(tuple(row))
                    # Insert in batches to avoid huge parameter lists.
                    if len(batch) >= 100:
                        flush_batch()

                flush_batch()
