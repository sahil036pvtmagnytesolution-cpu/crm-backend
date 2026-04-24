import os
import importlib
from types import SimpleNamespace

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "ms_crm_proj.settings")

CeleryClass = None
try:
    CeleryClass = getattr(importlib.import_module("celery"), "Celery")
except Exception:
    CeleryClass = None


class _FallbackCelery:
    """No-op Celery fallback when celery isn't installed in local dev."""

    def __init__(self):
        self.conf = SimpleNamespace()

    def config_from_object(self, *args, **kwargs):
        return None

    def autodiscover_tasks(self, *args, **kwargs):
        return []

    def task(self, *d_args, **d_kwargs):
        def decorator(func):
            return func
        return decorator


if CeleryClass is None:
    app = _FallbackCelery()
else:
    app = CeleryClass("ms_crm_proj")
    app.config_from_object("django.conf:settings", namespace="CELERY")
    app.autodiscover_tasks()
