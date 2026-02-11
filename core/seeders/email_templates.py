from django.db import transaction
from core.models import EmailTemplate
from core.middleware import get_current_db


EMAIL_TEMPLATES = [
    {
        "module": "client",
        "slug": "new-client-created",
        "language": "english",
        "subject": "Welcome Client",
        "body": "New client created successfully"
    },
    {
        "module": "ticket",
        "slug": "ticket-reply",
        "language": "english",
        "subject": "Ticket Reply",
        "body": "You have a new ticket reply"
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
