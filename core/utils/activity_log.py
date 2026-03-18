from django.contrib.auth import get_user_model
from django.utils import timezone

from core.models import ActivityLog


def _normalize_user(user):
    if user is None:
        return None
    try:
        UserModel = get_user_model()
        if isinstance(user, UserModel):
            return user
    except Exception:
        return None
    return None


def _staff_name(user):
    if not user:
        return "-"
    full_name = ""
    try:
        full_name = user.get_full_name()
    except Exception:
        full_name = ""
    full_name = (full_name or "").strip()
    if full_name:
        return full_name
    return (
        getattr(user, "username", None)
        or getattr(user, "email", None)
        or "-"
    )


def log_activity(description, user=None):
    description = (description or "").strip()
    if not description:
        return
    try:
        ActivityLog.objects.create(
            description=description,
            user=_normalize_user(user),
        )
    except Exception as exc:
        print("ActivityLog create failed:", exc)


def serialize_activity_log(log):
    staff = _staff_name(getattr(log, "user", None))
    created_at = getattr(log, "created_at", None)
    if created_at:
        try:
            created_at = timezone.localtime(created_at)
        except Exception:
            pass
        date_value = created_at.strftime("%Y-%m-%d %H:%M:%S")
    else:
        date_value = "-"

    return {
        "id": getattr(log, "id", None),
        "description": getattr(log, "description", "") or "",
        "staff": staff,
        "staff_name": staff,
        "date": date_value,
    }
