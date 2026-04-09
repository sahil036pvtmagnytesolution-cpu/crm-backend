from django.db import transaction
from core.models import EmailTemplate
from core.middleware import get_current_db


EMAIL_TEMPLATES = [
    {
        "name": "New Client Created",
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
    objs = []
    for t in EMAIL_TEMPLATES:
        objs.append(EmailTemplate(**t))

    EmailTemplate.objects.bulk_create(
        objs,
        ignore_conflicts=True
    )

    db = get_current_db() or "default"

    with transaction.atomic(using=db):
        existing_slugs = set(
            EmailTemplate.objects
            .using(db)
            .values_list("slug", flat=True)
        )

        new_templates = [
            EmailTemplate(**data)
            for data in EMAIL_TEMPLATES
            if data["slug"] not in existing_slugs
        ]

        if new_templates:
            EmailTemplate.objects.using(db).bulk_create(
                new_templates,
                batch_size=500,
                ignore_conflicts=True,
            )


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

    with transaction.atomic(using=db):

        existing_keys = set(
            EmailTemplate.objects
            .using(db)
            .values_list("module", "slug", "language")
        )

        new_objects = [
            EmailTemplate(**t)
            for t in EMAIL_TEMPLATES
            if (t["module"], t["slug"], t["language"]) not in existing_keys
        ]

        if new_objects:
            EmailTemplate.objects.using(db).bulk_create(
                new_objects,
                batch_size=100,
                ignore_conflicts=True
            )
