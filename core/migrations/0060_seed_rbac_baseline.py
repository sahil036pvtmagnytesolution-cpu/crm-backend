from django.db import migrations


DEFAULT_MODULES = [
    "Staff",
    "Customer",
    "Leads",
    "Support",
    "Finance",
    "Contracts",
    "EmailTemplate",
    "CustomFields",
    "GDPR",
    "Settings",
]

DEFAULT_ACTIONS = ["view", "create", "edit", "delete"]


def seed_rbac_baseline(apps, schema_editor):
    Role = apps.get_model("core", "Role")
    Permission = apps.get_model("core", "Permission")
    RolePermission = apps.get_model("core", "RolePermission")
    UserRole = apps.get_model("core", "UserRole")
    User = apps.get_model("auth", "User")

    permission_index = {}
    for module in DEFAULT_MODULES:
        for action in DEFAULT_ACTIONS:
            code = f"{module.lower()}.{action}".replace(" ", "").replace("-", "")
            permission, _ = Permission.objects.get_or_create(
                module=module,
                action=action,
                defaults={
                    "code": code,
                    "is_active": True,
                },
            )
            permission_index[(module, action)] = permission

    super_admin_role, _ = Role.objects.get_or_create(
        name="Super Admin",
        defaults={
            "description": "System super administrator with full CRM access.",
            "is_active": True,
            "is_super_admin": True,
            "level": 100,
            "permissions": "[]",
            "is_approved": True,
        },
    )

    if not super_admin_role.is_super_admin:
        super_admin_role.is_super_admin = True
        super_admin_role.is_active = True
        super_admin_role.level = max(super_admin_role.level or 1, 100)
        super_admin_role.save(update_fields=["is_super_admin", "is_active", "level", "updated_at"])

    for permission in permission_index.values():
        RolePermission.objects.get_or_create(
            role=super_admin_role,
            permission=permission,
            defaults={"is_allowed": True},
        )

    for user in User.objects.filter(is_superuser=True):
        UserRole.objects.get_or_create(
            user=user,
            role=super_admin_role,
            defaults={"is_active": True},
        )


def noop_reverse(apps, schema_editor):
    pass


class Migration(migrations.Migration):
    dependencies = [
        ("core", "0059_permission_roleauditlog_rolepermission_userrole_and_more"),
    ]

    operations = [
        migrations.RunPython(seed_rbac_baseline, noop_reverse),
    ]

