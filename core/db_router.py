from core.middleware import get_current_db


GLOBAL_APP_LABELS = {
    "auth",
    "admin",
    "contenttypes",
    "sessions",
    "authtoken",
}

GLOBAL_MODELS = {
    ("core", "business"),
    ("core", "legacybusiness"),
    ("core", "emailtemplate"),
    ("core", "activitylog"),
}


def _use_default_db(model):
    app_label = model._meta.app_label
    model_name = model._meta.model_name
    return app_label in GLOBAL_APP_LABELS or (app_label, model_name) in GLOBAL_MODELS


class TenantRouter:
    def db_for_read(self, model, **hints):
        if _use_default_db(model):
            return "default"
        return get_current_db()

    def db_for_write(self, model, **hints):
        if _use_default_db(model):
            return "default"
        return get_current_db()

    def allow_relation(self, obj1, obj2, **hints):
        if _use_default_db(obj1.__class__) or _use_default_db(obj2.__class__):
            return True
        db = get_current_db()
        return obj1._state.db == db and obj2._state.db == db

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        if app_label in GLOBAL_APP_LABELS:
            return db == "default"
        if (app_label, model_name or "") in GLOBAL_MODELS:
            return db == "default"
        return db == "default"
