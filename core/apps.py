from django.apps import AppConfig


class CoreConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'core'

    def ready(self):
        try:
            from .middleware import apply_user_permission_method
            apply_user_permission_method()
        except Exception:
            # RBAC helper binding should not block app boot.
            pass
