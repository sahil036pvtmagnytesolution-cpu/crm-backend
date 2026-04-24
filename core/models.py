from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from django.utils.text import slugify
from datetime import date
# The following imports created circular dependencies between the core and ms_crm_app
# apps (LegacyStaff, LegacyKnowledgeBase, LegacyKnowledgeBaseGroups). They are not
# required for the GDPR module and caused migration failures. They have been
# removed to break the circular reference.
# from ms_crm_app.models import (
#     Staff as LegacyStaff,
#     KnowledgeBase as LegacyKnowledgeBase,
#     KnowledgeBaseGroups as LegacyKnowledgeBaseGroups,
# )


class LegacyBusiness(models.Model):
    """
    EXISTING TABLE ONLY
    NO MIGRATION
    NO DATA LOSS
    """

    name = models.CharField(max_length=255)
    email = models.EmailField()
    owner_name = models.CharField(max_length=255)
    is_approved = models.BooleanField()
    created_at = models.DateTimeField()

    class Meta:
        db_table = "ms_business"
        managed = False

    def __str__(self):
        return self.name


class EmailTemplate(models.Model):
    name = models.CharField(max_length=191, blank=True, default="")
    module = models.CharField(max_length=50)
    slug = models.CharField(max_length=100)
    language = models.CharField(max_length=20, default="english")
    subject = models.CharField(max_length=255)
    body = models.TextField()
    variables = models.JSONField(default=list, blank=True)

    class Meta:
        unique_together = ("module", "slug", "language")
        indexes = [
            models.Index(fields=["module", "slug"]),
        ]

    def __str__(self):
        return self.name or f"{self.module} - {self.slug}"


class Ticket(models.Model):
    STATUS_OPEN = "open"
    STATUS_IN_PROGRESS = "in_progress"
    STATUS_CLOSED = "closed"
    STATUS_CHOICES = [
        (STATUS_OPEN, "Open"),
        (STATUS_IN_PROGRESS, "In Progress"),
        (STATUS_CLOSED, "Closed"),
    ]

    PRIORITY_LOW = "low"
    PRIORITY_MEDIUM = "medium"
    PRIORITY_HIGH = "high"
    PRIORITY_URGENT = "urgent"
    PRIORITY_CHOICES = [
        (PRIORITY_LOW, "Low"),
        (PRIORITY_MEDIUM, "Medium"),
        (PRIORITY_HIGH, "High"),
        (PRIORITY_URGENT, "Urgent"),
    ]

    ticket_id = models.AutoField(primary_key=True)
    customer_name = models.CharField(max_length=191)
    email = models.EmailField()
    subject = models.CharField(max_length=255)
    description = models.TextField()
    status = models.CharField(max_length=30, choices=STATUS_CHOICES, default=STATUS_OPEN, db_index=True)
    priority = models.CharField(max_length=30, choices=PRIORITY_CHOICES, default=PRIORITY_MEDIUM, db_index=True)
    assigned_to = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_ticket"
        ordering = ["-created_at", "-ticket_id"]

    def __str__(self):
        return f"#{self.ticket_id} {self.subject}"


class SetupModule(models.Model):
    name = models.CharField(max_length=100)
    slug = models.SlugField(max_length=120, unique=True, db_index=True)
    description = models.TextField(blank=True, null=True)
    route = models.CharField(max_length=255, blank=True, null=True)
    icon = models.CharField(max_length=80, blank=True, null=True)
    is_enabled = models.BooleanField(default=True, db_index=True)
    is_deleted = models.BooleanField(default=False, db_index=True)
    deleted_at = models.DateTimeField(blank=True, null=True)
    sort_order = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_module"
        ordering = ["sort_order", "name", "id"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name or "")
        if not self.name:
            self.name = (self.slug or "").replace("-", " ").title()
        route_value = str(self.route or "").strip()
        if route_value:
            route_value = f"/{route_value.lstrip('/')}"
            if route_value != "/":
                route_value = route_value.rstrip("/")
            self.route = route_value
        else:
            self.route = ""
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class SetupCustomField(models.Model):
    FIELD_TYPE_CHOICES = [
        ("text", "Text"),
        ("textarea", "Textarea"),
        ("number", "Number"),
        ("email", "Email"),
        ("date", "Date"),
        ("select", "Select"),
        ("checkbox", "Checkbox"),
    ]

    module_slug = models.SlugField(max_length=120, db_index=True)
    label = models.CharField(max_length=191)
    field_key = models.SlugField(max_length=191)
    field_type = models.CharField(max_length=50, choices=FIELD_TYPE_CHOICES, default="text")
    options = models.JSONField(default=list, blank=True)
    default_value = models.CharField(max_length=255, blank=True, null=True)
    is_required = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True, db_index=True)
    sort_order = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_custom_field"
        unique_together = ("module_slug", "field_key")
        ordering = ["module_slug", "sort_order", "id"]

    def save(self, *args, **kwargs):
        if not self.field_key:
            self.field_key = slugify(self.label or "")
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.module_slug} - {self.label}"


class CustomField(SetupCustomField):
    """Compatibility alias for admin-defined dynamic field definitions."""

    class Meta:
        proxy = True
        verbose_name = "Custom Field"
        verbose_name_plural = "Custom Fields"


# ---------------------------------------------------------------------------
# Custom Field Value Model
# ---------------------------------------------------------------------------
# This model stores the value of a custom field for any target object in the
# system (e.g., Lead, Client, Project, etc.). It uses Django's generic
# foreign key mechanism to link to any model instance.
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey


class CustomFieldValue(models.Model):
    """A value assigned to a :class:`SetupCustomField` for a specific object.

    The generic relation allows this model to be attached to any other model
    without creating a dedicated foreign key for each possible target.
    """

    custom_field = models.ForeignKey(
        SetupCustomField,
        on_delete=models.CASCADE,
        related_name="values",
    )
    # Generic relation to the target object (e.g., Lead, Client, Project)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')

    # Store the actual value. JSONField gives flexibility for different types.
    value = models.JSONField(blank=True, null=True)

    # Auditing fields
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_custom_field_value"
        unique_together = ("custom_field", "content_type", "object_id")
        ordering = ["custom_field", "content_type", "object_id"]

    def __str__(self):
        return f"{self.custom_field.field_key}={self.value} for {self.content_object}"


class SetupGDPRRequest(models.Model):
    REQUEST_TYPE_CHOICES = [
        ("export", "Data Export"),
        ("delete", "Data Deletion"),
        ("rectify", "Data Rectification"),
        ("consent", "Consent Update"),
    ]

    STATUS_CHOICES = [
        ("pending", "Pending"),
        ("in_progress", "In Progress"),
        ("completed", "Completed"),
        ("rejected", "Rejected"),
    ]

    customer_name = models.CharField(max_length=191)
    email = models.EmailField()
    module_slug = models.SlugField(max_length=120, blank=True, null=True)
    request_type = models.CharField(max_length=30, choices=REQUEST_TYPE_CHOICES, default="export")
    status = models.CharField(max_length=30, choices=STATUS_CHOICES, default="pending", db_index=True)
    details = models.TextField(blank=True, null=True)
    resolution_notes = models.TextField(blank=True, null=True)
    resolved_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_gdpr_request"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"{self.customer_name} ({self.request_type})"


class SetupSetting(models.Model):
    INPUT_TYPE_CHOICES = [
        ("text", "Text"),
        ("textarea", "Textarea"),
        ("number", "Number"),
        ("email", "Email"),
        ("url", "URL"),
        ("boolean", "Boolean"),
        ("json", "JSON"),
    ]

    category = models.CharField(max_length=100, db_index=True)
    key = models.CharField(max_length=120)
    display_name = models.CharField(max_length=191)
    value = models.TextField(blank=True, null=True)
    input_type = models.CharField(max_length=30, choices=INPUT_TYPE_CHOICES, default="text")
    description = models.TextField(blank=True, null=True)
    is_public = models.BooleanField(default=False)
    is_editable = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_setting"
        unique_together = ("category", "key")
        ordering = ["category", "display_name", "id"]

    def __str__(self):
        return f"{self.category} / {self.key}"


class SetupHelpArticle(models.Model):
    title = models.CharField(max_length=191)
    slug = models.SlugField(max_length=191, unique=True, db_index=True)
    module_slug = models.SlugField(max_length=120, blank=True, null=True, db_index=True)
    summary = models.CharField(max_length=255, blank=True, null=True)
    content = models.TextField()
    inquiry_email_to = models.TextField(blank=True, null=True)
    inquiry_email_cc = models.TextField(blank=True, null=True)
    inquiry_email_subject = models.CharField(max_length=255, blank=True, null=True)
    is_published = models.BooleanField(default=True, db_index=True)
    sort_order = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_help_article"
        ordering = ["module_slug", "sort_order", "title", "id"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title or "")
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title

# ------------------------------------------------------------
# Company Information Model
# ------------------------------------------------------------
class CompanyInfo(models.Model):
    """Store basic company information used in the Setup/Setting module.

    The model is deliberately simple – only the company name and an optional
    logo image.  Additional fields (address, phone, etc.) can be added later if
    required.
    """

    name = models.CharField(max_length=255, unique=True, db_index=True)
    # Use FileField instead of ImageField to avoid Pillow dependency.
    # The frontend can still treat this as an image upload; validation can be
    # performed at the API level if needed.
    logo = models.FileField(upload_to="company_logos/", blank=True, null=True)
    # Timestamps for audit purposes
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_company_info"
        ordering = ["-created_at"]

    def __str__(self):
        return self.name

# ------------------------------------------------------------
# SMS Task Model – represents an outbound SMS that can be
# scheduled, sent, and tracked.  Simple fields are provided; the
# implementation can be expanded later (e.g., integration with an
# external SMS gateway).
# ------------------------------------------------------------
class SMSTask(models.Model):
    recipient = models.CharField(max_length=20, help_text="Phone number in international format")
    message = models.TextField()
    # Status tracking – pending, sent, failed
    STATUS_CHOICES = [
        ("pending", "Pending"),
        ("sent", "Sent"),
        ("failed", "Failed"),
    ]
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default="pending")
    scheduled_at = models.DateTimeField(blank=True, null=True)
    sent_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_sms_task"
        ordering = ["-created_at"]

    def __str__(self):
        return f"SMS to {self.recipient} ({self.status})"

# ------------------------------------------------------------
# Generic Setup Task Model – used for tasks within the Setup/Setting
# module (e.g., reminders for updating contacts, addresses, etc.)
# ------------------------------------------------------------
class SetupTask(models.Model):
    title = models.CharField(max_length=191)
    description = models.TextField(blank=True, null=True)
    is_completed = models.BooleanField(default=False)
    due_date = models.DateField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_task"
        ordering = ["-created_at"]

    def __str__(self):
        return self.title


class SetupCustomerGroup(models.Model):
    name = models.CharField(max_length=191, unique=True, db_index=True)
    description = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_customer_group"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupCustomerGroupAssignment(models.Model):
    customer = models.ForeignKey(
        "Client",
        on_delete=models.CASCADE,
        related_name="setup_group_assignments",
    )
    group = models.ForeignKey(
        SetupCustomerGroup,
        on_delete=models.CASCADE,
        related_name="customer_assignments",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_customer_group_assignment"
        unique_together = ("customer",)
        ordering = ["-updated_at", "-id"]

    def __str__(self):
        return f"{self.customer_id} -> {self.group_id}"


# ⚠️ renamed (duplicate model avoid)
class SetupThemeStyle(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    # Original theming fields retained for backward compatibility.
    # Base palette colors
    primary_color = models.CharField(max_length=7, default="#0d6efd")
    secondary_color = models.CharField(max_length=7, default="#6c757d")
    accent_color = models.CharField(max_length=7, default="#198754")
    # Dynamic theming extensions
    theme_mode = models.CharField(max_length=5, choices=[("light", "Light"), ("dark", "Dark")], default="light")
    sidebar_bg = models.CharField(max_length=7, default="#011e34")
    sidebar_text = models.CharField(max_length=7, default="#ffffff")
    navbar_bg = models.CharField(max_length=7, default="#011e34")
    navbar_text = models.CharField(max_length=7, default="#ffffff")
    # Status badge colors
    status_success = models.CharField(max_length=7, default="#28a745")
    status_warning = models.CharField(max_length=7, default="#ffc107")
    status_error = models.CharField(max_length=7, default="#dc3545")
    status_info = models.CharField(max_length=7, default="#17a2b8")
    # JSON container for additional status colors (optional)
    status_colors = models.JSONField(default=dict, blank=True)
    # UI settings JSON – kept as a flexible configuration object.
    ui_settings = models.JSONField(default=dict, blank=True)
    is_default = models.BooleanField(default=False, db_index=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_theme_style"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupTax(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    rate = models.DecimalField(max_digits=7, decimal_places=4, default=0)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_tax"
        ordering = ["name", "id"]

    def __str__(self):
        return f"{self.name} ({self.rate}%)"


class SetupCurrency(models.Model):
    code = models.CharField(max_length=10, unique=True, db_index=True)
    symbol = models.CharField(max_length=8, blank=True, null=True)
    name = models.CharField(max_length=80)
    is_default = models.BooleanField(default=False, db_index=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_currency"
        ordering = ["code", "id"]

    def save(self, *args, **kwargs):
        if self.code:
            self.code = self.code.upper()
        super().save(*args, **kwargs)

    def __str__(self):
        return self.code


class SetupPaymentMode(models.Model):
    name = models.CharField(max_length=100, unique=True, db_index=True)
    description = models.CharField(max_length=255, blank=True, null=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_payment_mode"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupExpenseCategory(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    description = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_expense_category"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupSupportDepartment(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    email = models.EmailField(blank=True, null=True)
    imap_host = models.CharField(max_length=255, blank=True, default="")
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_support_department"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupTicketPriority(models.Model):
    name = models.CharField(max_length=80, unique=True, db_index=True)
    level = models.PositiveSmallIntegerField(default=1)
    description = models.TextField(blank=True, default="")
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_ticket_priority"
        ordering = ["level", "name", "id"]

    def __str__(self):
        return self.name


class SetupTicketStatus(models.Model):
    name = models.CharField(max_length=80, unique=True, db_index=True)
    color = models.CharField(max_length=7, default="#0d6efd")
    is_closed = models.BooleanField(default=False, db_index=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_ticket_status"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupPredefinedReply(models.Model):
    title = models.CharField(max_length=191, db_index=True)
    body = models.TextField()
    department = models.ForeignKey(
        SetupSupportDepartment,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="predefined_replies",
    )
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_predefined_reply"
        ordering = ["title", "id"]

    def __str__(self):
        return self.title


class SetupLeadSource(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_lead_source"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class SetupLeadStatus(models.Model):
    name = models.CharField(max_length=120, unique=True, db_index=True)
    sequence = models.PositiveSmallIntegerField(default=1)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_lead_status"
        ordering = ["sequence", "name", "id"]

    def __str__(self):
        return self.name


class SetupContractTemplate(models.Model):
    name = models.CharField(max_length=191, unique=True, db_index=True)
    slug = models.SlugField(max_length=191, unique=True, db_index=True)
    content = models.TextField()
    variable_keys = models.JSONField(default=list, blank=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_contract_template"
        ordering = ["name", "id"]

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name or "")
        super().save(*args, **kwargs)

    def __str__(self):
        return self.name


class SetupRolePermission(models.Model):
    role = models.ForeignKey(
        "Role",
        on_delete=models.CASCADE,
        related_name="setup_permissions",
    )
    module_slug = models.SlugField(max_length=120, db_index=True)
    can_view = models.BooleanField(default=False)
    can_create = models.BooleanField(default=False)
    can_edit = models.BooleanField(default=False)
    can_delete = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_setup_role_permission"
        unique_together = ("role", "module_slug")
        ordering = ["role_id", "module_slug", "id"]

    def __str__(self):
        return f"{self.role_id}:{self.module_slug}"


class Business(models.Model):
    name = models.CharField(max_length=100, unique=True, db_index=True)
    email = models.EmailField(unique=True, db_index=True)
    owner_name = models.CharField(max_length=100)
    is_approved = models.BooleanField(default=False, db_index=True)
    db_name = models.CharField(max_length=100, blank=True, null=True, unique=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "core_business"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["email", "is_approved"]),
        ]

    def __str__(self):
        return self.name


class Role(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True, db_index=True)
    is_super_admin = models.BooleanField(default=False, db_index=True)
    level = models.PositiveIntegerField(default=1)
    permissions = models.TextField(default="Basic")
    is_approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_roles"
        ordering = ["-id"]

    def __str__(self):
        return self.name


class Permission(models.Model):
    ACTION_VIEW = "view"
    ACTION_CREATE = "create"
    ACTION_EDIT = "edit"
    ACTION_DELETE = "delete"

    ACTION_CHOICES = [
        (ACTION_VIEW, "View"),
        (ACTION_CREATE, "Create"),
        (ACTION_EDIT, "Edit"),
        (ACTION_DELETE, "Delete"),
    ]

    module = models.CharField(max_length=100, db_index=True)
    action = models.CharField(max_length=20, choices=ACTION_CHOICES, db_index=True)
    code = models.CharField(max_length=191, unique=True, db_index=True)
    description = models.TextField(blank=True, null=True)
    is_active = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_permissions"
        unique_together = ("module", "action")
        ordering = ["module", "action", "id"]

    def __str__(self):
        return f"{self.module}:{self.action}"


class RolePermission(models.Model):
    role = models.ForeignKey(
        Role,
        on_delete=models.CASCADE,
        related_name="role_permissions",
    )
    permission = models.ForeignKey(
        Permission,
        on_delete=models.CASCADE,
        related_name="role_permissions",
    )
    is_allowed = models.BooleanField(default=True, db_index=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_role_permissions"
        unique_together = ("role", "permission")
        ordering = ["role_id", "permission__module", "permission__action", "id"]

    def __str__(self):
        return f"{self.role_id}:{self.permission.code}"


class UserRole(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="user_roles",
    )
    role = models.ForeignKey(
        Role,
        on_delete=models.CASCADE,
        related_name="user_roles",
    )
    assigned_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_user_roles",
    )
    is_active = models.BooleanField(default=True, db_index=True)
    assigned_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "core_user_roles"
        unique_together = ("user", "role")
        ordering = ["-assigned_at", "-id"]

    def __str__(self):
        return f"{self.user_id}:{self.role_id}"


class RoleAuditLog(models.Model):
    EVENT_CREATE = "create"
    EVENT_UPDATE = "update"
    EVENT_DELETE = "delete"
    EVENT_ASSIGN = "assign"
    EVENT_UNASSIGN = "unassign"

    EVENT_CHOICES = [
        (EVENT_CREATE, "Create"),
        (EVENT_UPDATE, "Update"),
        (EVENT_DELETE, "Delete"),
        (EVENT_ASSIGN, "Assign"),
        (EVENT_UNASSIGN, "Unassign"),
    ]

    role = models.ForeignKey(
        Role,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="audit_logs",
    )
    actor = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="role_audit_actor_logs",
    )
    target_user = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="role_audit_target_logs",
    )
    event_type = models.CharField(max_length=20, choices=EVENT_CHOICES, db_index=True)
    changes = models.JSONField(default=dict, blank=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "core_role_audit_logs"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"{self.event_type}:{self.role_id or '-'}"


class StaffProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    manager = models.ForeignKey(
        User,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="team_members"
    )

    def __str__(self):
        return self.user.username


class ActivityLog(models.Model):
    description = models.TextField()
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "core_activity_log"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return self.description[:50]


class Proposal(models.Model):

    STATUS_CHOICES = [
        ("1", "Draft"),
        ("2", "Pending"),
        ("3", "Approved"),
    ]

    subject = models.CharField(max_length=255)

    created_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="created_proposals"
    )

    assigned_to = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_proposals"
    )

    items = models.JSONField(default=list, blank=True)

    proposal_to = models.CharField(max_length=191, blank=True, null=True)
    address = models.CharField(max_length=200, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    country = models.CharField(max_length=100, blank=True, null=True)
    zip = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=150, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    comments = models.JSONField(default=list, blank=True, null=True)
    reminders = models.JSONField(default=list, blank=True, null=True)
    tasks = models.JSONField(default=list, blank=True, null=True)
    notes = models.JSONField(default=list, blank=True, null=True)

    discount_total = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    adjustment = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    total = models.DecimalField(max_digits=12, decimal_places=2, default=0)

    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="1")

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject


class Expense(models.Model):
    CATEGORY_CHOICES = [
        ("Travel", "Travel"),
        ("Food", "Food"),
        ("Office", "Office"),
    ]

    name = models.CharField(max_length=255)
    note = models.TextField(blank=True, null=True)
    category = models.CharField(max_length=100, choices=CATEGORY_CHOICES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    date = models.DateField()
    customer = models.CharField(max_length=255, blank=True, null=True)

    currency = models.CharField(max_length=20, default="INR ₹")
    tax1 = models.CharField(max_length=50, blank=True, null=True)
    tax2 = models.CharField(max_length=50, blank=True, null=True)
    payment_mode = models.CharField(max_length=100, blank=True, null=True)
    customer_ref = models.ForeignKey(
        "Client",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="expenses",
    )
    invoice_ref = models.ForeignKey(
        "Invoice",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="expenses",
    )
    reference = models.CharField(max_length=255, blank=True, null=True)
    repeat_every = models.CharField(max_length=50, blank=True, null=True)

    status = models.CharField(max_length=50, default="Not Invoiced")

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Lead(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    source = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(max_length=50, default="New")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Client(models.Model):
    company = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    vat_number = models.CharField(max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=20, blank=True, null=True)
    country = models.CharField(max_length=100, blank=True, null=True)
    currency = models.CharField(max_length=10, blank=True, null=True)
    default_language = models.CharField(max_length=50, blank=True, null=True)

    billing_address = models.TextField(blank=True, null=True)
    shipping_address = models.TextField(blank=True, null=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.company

class Estimate(models.Model):

    estimate_number = models.CharField(max_length=100)

    # ✅ FIX: CharField से ForeignKey
    customer = models.ForeignKey(
        Client,
        on_delete=models.CASCADE,
        related_name="estimates"
    )

    amount = models.DecimalField(max_digits=10, decimal_places=2)

    total_tax = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0
    )

    date = models.DateField()
    expiry_date = models.DateField()

    status = models.CharField(
        max_length=100,
        default="Draft"
    )

    items = models.JSONField(default=list, blank=True)

    def __str__(self):
        return self.estimate_number

class CalendarEvent(models.Model):
    REMINDER_TYPE_DAYS = "days"
    REMINDER_TYPE_HOURS = "hours"
    REMINDER_TYPE_CUSTOM = "custom_datetime"
    REMINDER_TYPE_CHOICES = [
        (REMINDER_TYPE_DAYS, "Days Before"),
        (REMINDER_TYPE_HOURS, "Hours Before"),
        (REMINDER_TYPE_CUSTOM, "Custom Date Time"),
    ]

    MODULE_TYPE_REMINDER = "reminder"
    MODULE_TYPE_ANNOUNCEMENT = "announcement"
    MODULE_TYPE_TASK = "task"
    MODULE_TYPE_TICKET = "ticket"
    MODULE_TYPE_CHOICES = [
        (MODULE_TYPE_REMINDER, "Reminder"),
        (MODULE_TYPE_ANNOUNCEMENT, "Announcement"),
        (MODULE_TYPE_TASK, "Task"),
        (MODULE_TYPE_TICKET, "Ticket"),
    ]

    title = models.CharField(max_length=255)
    date = models.DateField()
    color = models.CharField(max_length=20, default="#2196f3")
    reminder_type = models.CharField(
        max_length=32,
        choices=REMINDER_TYPE_CHOICES,
        blank=True,
        null=True,
    )
    reminder_value = models.IntegerField(blank=True, null=True)
    reminder_datetime = models.DateTimeField(blank=True, null=True)
    module_type = models.CharField(
        max_length=32,
        choices=MODULE_TYPE_CHOICES,
        default=MODULE_TYPE_REMINDER,
    )
    reference_id = models.IntegerField(blank=True, null=True)
    is_reminder_sent = models.BooleanField(default=False)

    def __str__(self):
        return self.title

class EmailCampaign(models.Model):
    subject = models.CharField(max_length=255)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject

class EmailRecipient(models.Model):
    campaign = models.ForeignKey(EmailCampaign, on_delete=models.CASCADE, related_name="recipients")
    email = models.EmailField()
    is_sent = models.BooleanField(default=False)
    sent_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.email

class Invoice(models.Model):

    PAYMENT_CHOICES = [
        ("Null", "Null"),
        ("Bank", "Bank"),
        ("Cash", "Cash"),
        ("UPI", "UPI"),
    ]

    invoice_number = models.CharField(max_length=50)

    # ✅ NEW FIELD (Estimate link)
    reference_estimate = models.ForeignKey(
        'Estimate',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="invoices"
    )

    customer = models.ForeignKey(Client, on_delete=models.CASCADE)

    invoice_date = models.DateField(default=date.today)
    due_date = models.DateField(default=date.today)

    payment_mode = models.CharField(
        max_length=20,
        choices=PAYMENT_CHOICES,
        default="Bank"
    )

    subtotal = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    tax_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    items = models.JSONField(default=list, blank=True)

    status = models.CharField(
        max_length=20,
        choices=[
            ("Draft","Draft"),
            ("Unpaid","Unpaid"),
            ("Paid","Paid"),
            ("Overdue","Overdue"),
        ],
        default="Draft"
    )

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.invoice_number

class InvoiceReminder(models.Model):
    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="reminders")
    description = models.TextField()
    date = models.DateTimeField()
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Reminder for {self.invoice.invoice_number}"

class InvoiceTask(models.Model):
    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="tasks")
    description = models.TextField()
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Task for {self.invoice.invoice_number}"


class InvoiceEmailLog(models.Model):
    invoice = models.ForeignKey(
        Invoice,
        on_delete=models.CASCADE,
        related_name="email_logs"
    )

    email = models.EmailField()
    message = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.email


class InvoicePayment(models.Model):

    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="Payments")
    payment_mode = models.CharField(max_length=20)
    transaction_id = models.CharField(max_length=50)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_date = models.DateField(auto_now_add=True)
    def __str__(self):
        return f"{self.invoice.invoice_number} - {self.amount}"


class CreditNote(models.Model):
    client = models.ForeignKey(
        Client,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="credit_notes",
    )
    deleted_customer_name = models.CharField(max_length=255, blank=True, null=True)
    number = models.PositiveIntegerField(default=1)
    prefix = models.CharField(max_length=20, default="CN-")
    number_format = models.CharField(max_length=30, blank=True, null=True)
    datecreated = models.DateTimeField(auto_now_add=True)
    date = models.DateField(default=date.today)
    duedate = models.DateField(blank=True, null=True)
    project_id = models.IntegerField(blank=True, null=True)
    reference_no = models.CharField(max_length=100, blank=True, null=True)
    subtotal = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total_tax = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    adjustment = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    addedfrom = models.IntegerField(blank=True, null=True, default=0)
    status = models.IntegerField(default=1)
    clientnote = models.TextField(blank=True, null=True)
    adminnote = models.TextField(blank=True, null=True)
    terms = models.TextField(blank=True, null=True)
    currency = models.CharField(max_length=20, blank=True, null=True, default="INR")
    discount_percent = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount_total = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount_type = models.CharField(max_length=30, blank=True, null=True, default="none")
    billing_street = models.CharField(max_length=255, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=30, blank=True, null=True)
    billing_country = models.CharField(max_length=100, blank=True, null=True)
    shipping_street = models.CharField(max_length=255, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=30, blank=True, null=True)
    shipping_country = models.CharField(max_length=100, blank=True, null=True)
    include_shipping = models.BooleanField(default=False)
    show_shipping_on_credit_note = models.BooleanField(default=False)
    show_quantity_as = models.CharField(max_length=30, blank=True, null=True, default="Qty")
    email_signature = models.TextField(blank=True, null=True)
    items = models.JSONField(default=list, blank=True)

    class Meta:
        db_table = "core_creditnote"
        ordering = ["-datecreated", "-id"]

    def __str__(self):
        return f"{self.prefix}{self.number}"


class CreditNoteReminder(models.Model):
    credit_note = models.ForeignKey(
        CreditNote,
        on_delete=models.CASCADE,
        related_name="reminders",
    )
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True, default="Pending")
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_creditnote_reminder"
        ordering = ["-created_at", "-id"]


class CreditNoteTask(models.Model):
    credit_note = models.ForeignKey(
        CreditNote,
        on_delete=models.CASCADE,
        related_name="tasks",
    )
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True, default="Open")
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_creditnote_task"
        ordering = ["-created_at", "-id"]


class ItemGroup(models.Model):
    name = models.CharField(max_length=191, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_item_group"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class Contract(models.Model):
    STATUS_CHOICES = [
        ("Draft", "Draft"),
        ("Active", "Active"),
        ("Expired", "Expired"),
    ]

    customer_ref = models.ForeignKey(
        "Client",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="contracts",
    )

    customer = models.CharField(max_length=255, blank=True, null=True)
    subject = models.CharField(max_length=255)
    contract_type = models.CharField(max_length=100, blank=True, null=True)
    contract_value = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    start_date = models.DateField(null=True, blank=True)
    end_date = models.DateField(null=True, blank=True)
    signature = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    content = models.TextField(blank=True, null=True)

    hide_from_customer = models.BooleanField(default=False)
    is_trashed = models.BooleanField(default=False)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="Draft")

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject


class SalesProposal(Proposal):
    class Meta:
        proxy = True
        verbose_name = "Sales"
        verbose_name_plural = "Sales"


class ContractType(models.Model):
    name = models.CharField(max_length=191, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_type"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class ContractAttachment(models.Model):
    contract = models.ForeignKey(
        Contract,
        on_delete=models.CASCADE,
        related_name="attachments",
    )
    file = models.FileField(upload_to="contracts/attachments/%Y/%m/")
    filename = models.CharField(max_length=255, blank=True, null=True)
    uploaded_by = models.CharField(max_length=191, blank=True, null=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_attachment"
        ordering = ["-uploaded_at", "-id"]

    def save(self, *args, **kwargs):
        if not self.filename and getattr(self, "file", None):
            try:
                self.filename = self.file.name.split("/")[-1]
            except Exception:
                self.filename = self.filename or ""
        super().save(*args, **kwargs)

    def __str__(self):
        return self.filename or f"Attachment #{self.id}"


class ContractComment(models.Model):
    contract = models.ForeignKey(
        Contract,
        on_delete=models.CASCADE,
        related_name="comments",
    )
    comment = models.TextField()
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_comment"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"Comment #{self.id}"


class ContractRenewal(models.Model):
    contract = models.ForeignKey(
        Contract,
        on_delete=models.CASCADE,
        related_name="renewals",
    )
    old_start_date = models.DateField(blank=True, null=True)
    new_start_date = models.DateField(blank=True, null=True)
    old_end_date = models.DateField(blank=True, null=True)
    new_end_date = models.DateField(blank=True, null=True)
    old_value = models.DecimalField(
        max_digits=12, decimal_places=2, blank=True, null=True
    )
    new_value = models.DecimalField(
        max_digits=12, decimal_places=2, blank=True, null=True
    )
    notes = models.TextField(blank=True, null=True)
    renewed_by = models.CharField(max_length=191, blank=True, null=True)
    renewed_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_renewal"
        ordering = ["-renewed_at", "-id"]

    def __str__(self):
        return f"Renewal #{self.id}"


class ContractTask(models.Model):
    PRIORITY_CHOICES = [
        ("Low", "Low"),
        ("Medium", "Medium"),
        ("High", "High"),
    ]

    contract = models.ForeignKey(
        Contract,
        on_delete=models.CASCADE,
        related_name="tasks",
    )
    subject = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    due_date = models.DateField(blank=True, null=True)
    priority = models.CharField(
        max_length=20, choices=PRIORITY_CHOICES, default="Medium"
    )
    is_public = models.BooleanField(default=False)
    is_billable = models.BooleanField(default=True)
    tags = models.CharField(max_length=255, blank=True, null=True)
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_task"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return self.subject


class ContractNote(models.Model):
    contract = models.ForeignKey(
        Contract,
        on_delete=models.CASCADE,
        related_name="notes",
    )
    note = models.TextField()
    created_by = models.CharField(max_length=191, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contract_note"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"Note #{self.id}"


class Item(models.Model):
    item_name = models.CharField(max_length=255, blank=True, db_index=True)
    item_code = models.CharField(max_length=100, blank=True, null=True, db_index=True)
    description = models.CharField(max_length=255)
    long_description = models.TextField(blank=True, null=True)
    rate = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    tax = models.CharField(max_length=50, blank=True, null=True, default="No Tax")
    tax2 = models.CharField(max_length=50, blank=True, null=True, default="No Tax")
    unit = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(max_length=20, default="active", db_index=True)
    group = models.ForeignKey(
        ItemGroup,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="items",
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_item"
        ordering = ["-created_at", "-id"]

    def save(self, *args, **kwargs):
        if not self.item_name:
            self.item_name = (self.description or self.item_code or "Unnamed Item").strip()
        if not self.description:
            self.description = self.item_name
        if self.status not in {"active", "inactive"}:
            self.status = "active"
        super().save(*args, **kwargs)

    def __str__(self):
        return self.item_name or self.description


class Customer(models.Model):
    company = models.CharField(max_length=255)
    primary_contact = models.CharField(max_length=255, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    phone = models.CharField(max_length=20, null=True, blank=True)

    is_active = models.BooleanField(default=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.company


class Contact(models.Model):
    firstname = models.CharField(max_length=191)
    lastname = models.CharField(max_length=191)
    email = models.EmailField()
    company = models.CharField(max_length=255, blank=True, null=True)
    phonenumber = models.CharField(max_length=100, blank=True, null=True)
    title = models.CharField(max_length=100, blank=True, null=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    is_primary = models.BooleanField(default=False)
    active = models.BooleanField(default=True)
    direction = models.CharField(max_length=10, blank=True, null=True)
    invoice_emails = models.BooleanField(default=False)
    estimate_emails = models.BooleanField(default=False)
    credit_note_emails = models.BooleanField(default=False)
    contract_emails = models.BooleanField(default=False)
    task_emails = models.BooleanField(default=False)
    project_emails = models.BooleanField(default=False)
    ticket_emails = models.BooleanField(default=False)
    last_login = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    # ------------------------------------------------------------
    # Additional address fields – allow storing a full address for a
    # contact record. These are optional and align with the UI request
    # to manage contact addresses.
    # ------------------------------------------------------------
    street = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=20, blank=True, null=True)
    country = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        db_table = "core_contact"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"{self.firstname} {self.lastname}".strip()


class AdminClient(Client):
    class Meta:
        proxy = True
        app_label = "core"
        verbose_name = "Client"
        verbose_name_plural = "Clients"


class AdminContact(Contact):
    class Meta:
        proxy = True
        app_label = "core"
        verbose_name = "Contact"
        verbose_name_plural = "Contacts"


class Project(models.Model):
    STATUS_CHOICES = [
        ("Draft", "Draft"),
        ("Sent", "Sent"),
        ("Expired", "Expired"),
        ("Declined", "Declined"),
        ("Accepted", "Accepted"),
        ("In Progress", "In Progress"),
        ("Completed", "Completed"),
        ("On Hold", "On Hold"),
    ]

    BILLING_TYPE_CHOICES = [
        ("Fixed Rate", "Fixed Rate"),
        ("Hourly", "Hourly"),
    ]

    name = models.CharField(max_length=255, db_index=True)
    client = models.ForeignKey(
        Client,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="projects",
        db_index=True,
    )

    progress = models.PositiveSmallIntegerField(default=0)
    status = models.CharField(
        max_length=32,
        choices=STATUS_CHOICES,
        default="Draft",
        db_index=True,
    )

    billing_type = models.CharField(
        max_length=32,
        choices=BILLING_TYPE_CHOICES,
        default="Fixed Rate",
    )
    total_rate = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    estimated_hours = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    start_date = models.DateField(blank=True, null=True)
    deadline = models.DateField(blank=True, null=True)

    tags = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)

    members = models.ManyToManyField(
        User,
        blank=True,
        related_name="project_memberships",
    )

    mentor = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="mentored_projects",
    )

    send_email = models.BooleanField(default=False)
    visible_tabs = models.JSONField(default=list, blank=True)
    settings = models.JSONField(default=list, blank=True)

    created_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="created_projects",
    )
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)
    updated_at = models.DateTimeField(auto_now=True, db_index=True)

    class Meta:
        db_table = "core_project"
        ordering = ["-created_at", "-id"]
        indexes = [
            models.Index(fields=["client", "status"]),
        ]

    def __str__(self):
        return self.name


# Proxy models for legacy tables have been removed to avoid circular dependencies.
