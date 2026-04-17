# core/middleware.py

from collections import defaultdict
import re
import threading
from typing import Dict, List, Optional, Tuple

from django.contrib.auth import get_user_model
from django.conf import settings
from django.db import connections
from django.http import JsonResponse
from django.utils.text import slugify
from rest_framework_simplejwt.authentication import JWTAuthentication

from .models import Permission, Role, RoleAuditLog, RolePermission, SetupModule, UserRole

_thread_locals = threading.local()
_rbac_schema_lock = threading.Lock()
_rbac_schema_ready = set()

RBAC_ACTIONS = (
    Permission.ACTION_VIEW,
    Permission.ACTION_CREATE,
    Permission.ACTION_EDIT,
    Permission.ACTION_DELETE,
)

MODULE_CANONICAL_MAP = {
    "staff": "Staff",
    "customer": "Customer",
    "customers": "Customer",
    "client": "Customer",
    "clients": "Customer",
    "leads": "Leads",
    "support": "Support",
    "finance": "Finance",
    "contracts": "Contracts",
    "emailtemplate": "EmailTemplate",
    "email-template": "EmailTemplate",
    "customfields": "CustomFields",
    "custom-fields": "CustomFields",
    "settings": "Settings",
}

# Keep middleware enforcement limited to roles APIs so legacy modules continue
# with their original behavior.
ROUTE_MODULE_RULES = [
    ("api/roles", "Settings"),
]

ROUTE_PERMISSION_OVERRIDES = [
    ("api/roles/my-permissions", None, None),
    ("api/roles/assign-to-user", "Settings", Permission.ACTION_EDIT),
    ("api/roles/create", "Settings", Permission.ACTION_CREATE),
    ("api/roles/permissions", "Settings", Permission.ACTION_VIEW),
]


def _active_db_alias() -> str:
    try:
        return get_current_db()
    except Exception:
        return "default"


def _rbac_schema_cache_key(db_alias: str) -> str:
    try:
        db_name = connections[db_alias].settings_dict.get("NAME") or db_alias
    except Exception:
        db_name = db_alias
    return f"{db_alias}:{db_name}"


def _table_columns(conn, table_name: str) -> set:
    with conn.cursor() as cursor:
        description = conn.introspection.get_table_description(cursor, table_name)
    columns = set()
    for col in description:
        columns.add(getattr(col, "name", col[0]))
    return columns


def _ensure_model_fields(conn, schema_editor, model, field_names: List[str]):
    table_name = model._meta.db_table
    existing_columns = _table_columns(conn, table_name)
    for field_name in field_names:
        field = model._meta.get_field(field_name)
        if field.column in existing_columns:
            continue
        schema_editor.add_field(model, field)
        existing_columns.add(field.column)


def ensure_rbac_schema():
    db_alias = _active_db_alias()
    cache_key = _rbac_schema_cache_key(db_alias)
    if cache_key in _rbac_schema_ready:
        return

    with _rbac_schema_lock:
        if cache_key in _rbac_schema_ready:
            return

        conn = connections[db_alias]
        existing_tables = set(conn.introspection.table_names())

        try:
            with conn.schema_editor() as schema_editor:
                for model in (Role, Permission, RolePermission, UserRole, RoleAuditLog):
                    table_name = model._meta.db_table
                    if table_name in existing_tables:
                        continue
                    schema_editor.create_model(model)
                    existing_tables.add(table_name)

                # Backfill columns for partially-created schemas.
                _ensure_model_fields(
                    conn,
                    schema_editor,
                    Role,
                    ["description", "is_active", "is_super_admin", "level", "updated_at"],
                )
                _ensure_model_fields(conn, schema_editor, RolePermission, ["role", "permission"])
                _ensure_model_fields(conn, schema_editor, UserRole, ["user", "role", "assigned_by"])
                _ensure_model_fields(
                    conn,
                    schema_editor,
                    RoleAuditLog,
                    ["role", "actor", "target_user"],
                )
        except Exception:
            # Legacy CRM should remain usable even if schema auto-repair fails.
            return

        _rbac_schema_ready.add(cache_key)


def _to_pascal_case(raw: str) -> str:
    normalized = re.sub(r"[^a-zA-Z0-9]+", " ", str(raw or "")).strip()
    if not normalized:
        return ""
    parts = [part for part in normalized.split(" ") if part]
    if not parts:
        return ""

    canonical_parts = []
    for part in parts:
        canonical_parts.append(part[:1].upper() + part[1:].lower())
    return "".join(canonical_parts)


def canonicalize_module(module_name: str) -> str:
    raw = str(module_name or "").strip()
    if not raw:
        return ""
    normalized = raw.replace("_", "-").replace(" ", "-").lower()
    mapped = MODULE_CANONICAL_MAP.get(normalized)
    if mapped:
        return mapped

    if re.search(r"[A-Z]", raw[1:]) and not re.search(r"[_\-\s]", raw):
        return raw
    return _to_pascal_case(raw)


def infer_action_from_method(method: str) -> Optional[str]:
    upper = str(method or "").upper()
    if upper in {"GET", "HEAD", "OPTIONS"}:
        return Permission.ACTION_VIEW
    if upper == "POST":
        return Permission.ACTION_CREATE
    if upper in {"PUT", "PATCH"}:
        return Permission.ACTION_EDIT
    if upper == "DELETE":
        return Permission.ACTION_DELETE
    return None


def infer_module_from_path(path: str) -> Optional[str]:
    normalized = str(path or "").lower().strip("/")
    if not normalized:
        return None
    if "api/roles/my-permissions" in normalized:
        return None
    for pattern, module in ROUTE_MODULE_RULES:
        if pattern in normalized:
            return module
    return None


def resolve_permission_for_request(request) -> Tuple[Optional[str], Optional[str]]:
    normalized_path = str(getattr(request, "path", "")).lower().strip("/")
    for pattern, module, forced_action in ROUTE_PERMISSION_OVERRIDES:
        if pattern in normalized_path:
            return module, forced_action

    action = infer_action_from_method(getattr(request, "method", None))
    module = infer_module_from_path(normalized_path)
    if not module or not action:
        return None, None
    return module, action


def get_target_modules() -> List[str]:
    permission_modules = set()
    for module in Permission.objects.values_list("module", flat=True):
        canonical = canonicalize_module(module)
        if canonical:
            permission_modules.add(canonical)

    if permission_modules:
        return sorted(permission_modules)

    db_modules = set()
    for raw_name, raw_slug in SetupModule.objects.values_list("name", "slug"):
        if raw_slug:
            db_modules.add(canonicalize_module(raw_slug))
        if raw_name:
            db_modules.add(canonicalize_module(raw_name))
    return sorted(module for module in db_modules if module)


def _permission_code(module: str, action: str) -> str:
    module_slug = slugify(module).replace("-", "_")
    action_slug = slugify(action).replace("-", "_")
    return f"{module_slug}.{action_slug}"


def sync_default_permissions() -> List[Permission]:
    ensure_rbac_schema()
    modules = get_target_modules()
    if not modules:
        return []

    existing = {
        (row["module"], row["action"]): row["id"]
        for row in Permission.objects.values("id", "module", "action")
    }
    to_create = []
    for module in modules:
        for action in RBAC_ACTIONS:
            key = (module, action)
            if key in existing:
                continue
            to_create.append(
                Permission(
                    module=module,
                    action=action,
                    code=_permission_code(module, action),
                    is_active=True,
                )
            )
    if to_create:
        Permission.objects.bulk_create(to_create, ignore_conflicts=True)

    return list(Permission.objects.filter(module__in=modules).order_by("module", "action"))


def ensure_permission(module: str, action: str) -> Permission:
    canonical_module = canonicalize_module(module)
    canonical_action = str(action or "").strip().lower()
    if canonical_action not in RBAC_ACTIONS:
        raise ValueError("Invalid action for permission.")
    permission, _ = Permission.objects.get_or_create(
        module=canonical_module,
        action=canonical_action,
        defaults={
            "code": _permission_code(canonical_module, canonical_action),
            "is_active": True,
        },
    )
    return permission


def is_super_admin(user) -> bool:
    if not user or not getattr(user, "is_authenticated", False):
        return False
    if getattr(user, "is_superuser", False):
        return True
    try:
        ensure_rbac_schema()
        return UserRole.objects.filter(
            user=user,
            is_active=True,
            role__is_active=True,
            role__is_super_admin=True,
        ).exists()
    except Exception:
        return False


def _get_active_role_ids(user) -> List[int]:
    if not user or not getattr(user, "is_authenticated", False):
        return []
    try:
        ensure_rbac_schema()
        return list(
            UserRole.objects.filter(
                user=user,
                is_active=True,
                role__is_active=True,
            ).values_list("role_id", flat=True)
        )
    except Exception:
        return []


def _has_any_role_permission_mapping(role_ids: List[int]) -> bool:
    if not role_ids:
        return False
    try:
        ensure_rbac_schema()
        return RolePermission.objects.filter(
            role_id__in=role_ids,
            is_allowed=True,
            permission__is_active=True,
        ).exists()
    except Exception:
        return False


def user_has_permission(user, module: str, action: str) -> bool:
    if not user or not getattr(user, "is_authenticated", False):
        return False
    if is_super_admin(user):
        return True

    active_role_ids = _get_active_role_ids(user)
    if not active_role_ids:
        return True
    if not _has_any_role_permission_mapping(active_role_ids):
        return True

    canonical_module = canonicalize_module(module)
    canonical_action = str(action or "").strip().lower()
    if not canonical_module or canonical_action not in RBAC_ACTIONS:
        return False

    return RolePermission.objects.filter(
        role__user_roles__user=user,
        role__user_roles__is_active=True,
        role__is_active=True,
        is_allowed=True,
        permission__is_active=True,
        permission__module=canonical_module,
        permission__action=canonical_action,
    ).exists()


def get_user_permission_matrix(user) -> Dict[str, List[str]]:
    matrix = defaultdict(set)
    if not user or not getattr(user, "is_authenticated", False):
        return {}

    if is_super_admin(user):
        for module in get_target_modules():
            matrix[module] = set(RBAC_ACTIONS)
        return {module: sorted(list(actions)) for module, actions in matrix.items()}

    active_role_ids = _get_active_role_ids(user)
    if not active_role_ids:
        for module in get_target_modules():
            matrix[module] = set(RBAC_ACTIONS)
        return {module: sorted(list(actions)) for module, actions in matrix.items()}

    if not _has_any_role_permission_mapping(active_role_ids):
        for module in get_target_modules():
            matrix[module] = set(RBAC_ACTIONS)
        return {module: sorted(list(actions)) for module, actions in matrix.items()}

    permission_pairs = RolePermission.objects.filter(
        role__user_roles__user=user,
        role__user_roles__is_active=True,
        role__is_active=True,
        is_allowed=True,
        permission__is_active=True,
    ).values_list("permission__module", "permission__action")

    for module, action in permission_pairs:
        matrix[module].add(action)
    return {module: sorted(list(actions)) for module, actions in matrix.items()}


def get_user_roles_payload(user):
    if not user or not getattr(user, "is_authenticated", False):
        return []

    try:
        ensure_rbac_schema()
        rows = (
            UserRole.objects.select_related("role")
            .filter(user=user, is_active=True, role__is_active=True)
            .order_by("-role__is_super_admin", "-role__level", "role__name")
        )
    except Exception:
        return []
    return [
        {
            "id": row.role.id,
            "name": row.role.name,
            "description": row.role.description or "",
            "is_super_admin": bool(row.role.is_super_admin),
            "level": row.role.level,
        }
        for row in rows
    ]


def build_user_access_payload(user):
    return {
        "is_super_admin": is_super_admin(user),
        "roles": get_user_roles_payload(user),
        "permissions": get_user_permission_matrix(user),
    }


def apply_user_permission_method():
    UserModel = get_user_model()
    if hasattr(UserModel, "has_permission"):
        return

    def _has_permission(self, module_name, action_name=Permission.ACTION_VIEW):
        return user_has_permission(self, module_name, action_name)

    setattr(UserModel, "has_permission", _has_permission)


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

            default_db = settings.DATABASES["default"].copy()
            default_db["NAME"] = db_name

            # Ensure single alias only: "tenant"
            settings.DATABASES["tenant"] = default_db

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


class RBACMiddleware:
    """
    Enforce module/action RBAC before protected APIs execute.
    Works with JWT Bearer auth used by DRF.
    """

    EXEMPT_PREFIXES = (
        "/admin/",
        "/api/token/",
        "/api/token/refresh/",
        "/core_api/login/",
        "/core_api/forgot-password/",
        "/core_api/reset-password/",
        "/core_api/register-business/",
        "/api/manage_data/login/",
        "/api/manage_data/register-business/",
        "/api/app/login/",
    )

    def __init__(self, get_response):
        self.get_response = get_response
        self.jwt_auth = JWTAuthentication()

    def _is_exempt(self, path: str) -> bool:
        lowered = str(path or "").lower()
        return any(lowered.startswith(prefix.lower()) for prefix in self.EXEMPT_PREFIXES)

    def _resolve_user(self, request):
        user = getattr(request, "user", None)
        if user is not None and getattr(user, "is_authenticated", False):
            return user
        try:
            auth = self.jwt_auth.authenticate(request)
        except Exception:
            auth = None
        if not auth:
            return None
        user, _token = auth
        request.user = user
        return user

    def __call__(self, request):
        path = getattr(request, "path", "")
        if request.method == "OPTIONS" or self._is_exempt(path):
            return self.get_response(request)

        module, action = resolve_permission_for_request(request)
        if not module or not action:
            return self.get_response(request)

        try:
            sync_default_permissions()
        except Exception:
            pass

        user = self._resolve_user(request)
        if not user or not getattr(user, "is_authenticated", False):
            return JsonResponse(
                {"detail": "Authentication credentials were not provided."},
                status=401,
            )

        if user_has_permission(user, module, action):
            request.rbac_required = {"module": module, "action": action}
            return self.get_response(request)

        return JsonResponse(
            {
                "detail": "Permission denied.",
                "required": {"module": module, "action": action},
            },
            status=403,
        )
