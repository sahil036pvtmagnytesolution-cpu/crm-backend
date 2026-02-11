# core/middleware.py

import threading
from django.conf import settings

_thread_locals = threading.local()


# ==================================================
# DB CONTEXT HELPERS (USED BY ROUTER / ADMIN / SEEDERS)
# ==================================================

def set_current_db(db_alias: str):
    """
    Set current database alias (default / tenant)
    """
    _thread_locals.db = db_alias


def get_current_db():
    """
    Get current database alias
    """
    return getattr(_thread_locals, "db", "default")


def clear_current_db():
    """
    Clear DB context after request / task
    """
    if hasattr(_thread_locals, "db"):
        del _thread_locals.db


# ==================================================
# TENANT MIDDLEWARE
# ==================================================

class TenantMiddleware:
    """
    Dynamically inject tenant DB config based on request header.
    Uses a SINGLE alias: 'tenant'
    """

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):

        # ------------------------------
        # ALWAYS START WITH DEFAULT
        # ------------------------------
        set_current_db("default")

        # ------------------------------
        # READ TENANT HEADER
        # ------------------------------
        raw_tenant = request.headers.get("X-TENANT-DB")

        if raw_tenant:
            # Normalize DB NAME (real DB name)
            db_name = (
                raw_tenant
                if raw_tenant.startswith("ms_crm_")
                else f"ms_crm_{raw_tenant}"
            )

            default_db = settings.DATABASES["default"]

            # Ensure single alias only: "tenant"
            settings.DATABASES["tenant"] = {
                "ENGINE": default_db["ENGINE"],
                "NAME": db_name,
                "USER": default_db["USER"],
                "PASSWORD": default_db["PASSWORD"],
                "HOST": default_db.get("HOST", "localhost"),
                "PORT": default_db.get("PORT", "3306"),
                "OPTIONS": default_db.get("OPTIONS", {}),
                "CONN_MAX_AGE": default_db.get("CONN_MAX_AGE", 0),
            }

            # Switch ORM routing to tenant
            set_current_db("tenant")

        # ------------------------------
        # PROCESS REQUEST
        # ------------------------------
        try:
            response = self.get_response(request)
        finally:
            # ------------------------------
            # CLEANUP (CRITICAL)
            # ------------------------------
            clear_current_db()

        return response
