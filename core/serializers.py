import json
from decimal import Decimal, InvalidOperation

from django.core.exceptions import ValidationError as DjangoValidationError
from django.core.validators import validate_email
from django.utils import timezone
from django.utils.dateparse import parse_date
from django.utils.text import slugify
from django.db import transaction
from rest_framework import serializers
from .models import Business, Contact, CreditNote, CreditNoteReminder, CreditNoteTask, Customer, Item, ItemGroup, Role, Proposal, CustomFieldValue
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User
from django.contrib.auth import get_user_model
from core.models import Proposal
from .models import Proposal
from .models import Expense
from .models import Lead
from .models import Client
from .models import Estimate
from .models import CalendarEvent
from .models import EmailCampaign, EmailRecipient
from .models import Invoice
from .models import InvoiceReminder
from .models import InvoiceTask
from rest_framework import serializers
from .models import Invoice, InvoiceReminder, InvoiceTask, InvoiceEmailLog, InvoicePayment
from .models import Contract
from .models import ContractType
from .models import ContractAttachment, ContractComment, ContractRenewal, ContractTask, ContractNote
from .models import (
    EmailTemplate,
    Permission,
    RolePermission,
    SetupModule,
    SetupCustomField,
    SetupGDPRRequest,
    SetupSetting,
    SetupHelpArticle,
    SetupCustomerGroup,
    SetupCustomerGroupAssignment,
    SetupThemeStyle,
    SetupTax,
    SetupCurrency,
    SetupPaymentMode,
    SetupExpenseCategory,
    SetupSupportDepartment,
    SetupTicketPriority,
    SetupTicketStatus,
    SetupPredefinedReply,
    SetupLeadSource,
    SetupLeadStatus,
    SetupContractTemplate,
    SetupRolePermission,
    UserRole,
)
from .item_master import sync_items_to_master
from .models import Project
from ms_crm_app.models import Staff
from .middleware import (
    RBAC_ACTIONS,
    canonicalize_module,
    ensure_permission,
    is_super_admin,
    sync_default_permissions,
)


def _normalize_items_payload(items):
    """
    Normalize line items across Proposal/Estimate/Invoice/Credit Note.

    Frontend screens send mixed keys like `longDescription` vs `long_description`.
    We persist and return a canonical shape so UIs can reliably render
    `description` + `long_description` from backend data.
    """
    if not isinstance(items, list):
        return []

    normalized = []
    for raw in items:
        if not isinstance(raw, dict):
            continue

        item = dict(raw)

        # Canonical long description
        if not item.get("long_description"):
            item["long_description"] = (
                item.get("longDescription")
                or item.get("longdescription")
                or item.get("details")
                or ""
            )

        # Back-compat field used by some forms
        if not item.get("longDescription"):
            item["longDescription"] = item.get("long_description") or ""

        # Canonical description
        if not item.get("description"):
            item["description"] = (
                item.get("item_name")
                or item.get("name")
                or item.get("label")
                or ""
            )

        normalized.append(item)

    return normalized
# ======================= Customer ==========================
class CustomerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Customer
        fields = "__all__"
# ======================= Payment Invoice ===================
class InvoicePaymentSerializer(serializers.ModelSerializer):

    customer = serializers.SerializerMethodField()

    class Meta:
        model = InvoicePayment
        fields = "__all__"

    def get_customer(self, obj):
        if obj.invoice and obj.invoice.customer:
            return obj.invoice.customer.company
        return "-"

# ======================= InvoiceEmail ======================
class InvoiceEmailLogSerializer(serializers.ModelSerializer):

    class Meta:
        model = InvoiceEmailLog
        fields = "__all__"

# ======================= Invoice Reminders =================
class InvoiceSerializer(serializers.ModelSerializer):
    payments = InvoicePaymentSerializer(many=True, read_only=True)
    class Meta:
        model = Invoice
        fields = "__all__"

    def create(self, validated_data):
        validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        invoice = super().create(validated_data)
        sync_items_to_master(invoice.items)
        return invoice

    def update(self, instance, validated_data):
        if "items" in validated_data:
            validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        invoice = super().update(instance, validated_data)
        sync_items_to_master(invoice.items)
        return invoice

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data["items"] = _normalize_items_payload(data.get("items"))
        return data

class InvoiceReminderSerializer(serializers.ModelSerializer):
    class Meta:
        model = InvoiceReminder
        fields = "__all__"


class InvoiceTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = InvoiceTask
        fields = "__all__"


class CreditNoteSerializer(serializers.ModelSerializer):
    clientid = serializers.IntegerField(source="client_id", required=False, allow_null=True)

    class Meta:
        model = CreditNote
        fields = "__all__"

    def create(self, validated_data):
        validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        credit_note = super().create(validated_data)
        sync_items_to_master(credit_note.items)
        return credit_note

    def update(self, instance, validated_data):
        if "items" in validated_data:
            validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        credit_note = super().update(instance, validated_data)
        sync_items_to_master(credit_note.items)
        return credit_note

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data["items"] = _normalize_items_payload(data.get("items"))
        return data


class CreditNoteReminderSerializer(serializers.ModelSerializer):
    class Meta:
        model = CreditNoteReminder
        fields = "__all__"


class CreditNoteTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = CreditNoteTask
        fields = "__all__"


class ItemGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemGroup
        fields = "__all__"


class ItemSerializer(serializers.ModelSerializer):
    unit_price = serializers.DecimalField(
        source="rate",
        max_digits=12,
        decimal_places=2,
        required=False,
    )
    group_id = ItemGroupSerializer(source="group", read_only=True)
    group_name = serializers.CharField(source="group.name", read_only=True)
    group = serializers.PrimaryKeyRelatedField(
        queryset=ItemGroup.objects.all(),
        required=False,
        allow_null=True,
    )

    class Meta:
        model = Item
        fields = [
            "id",
            "item_name",
            "item_code",
            "description",
            "long_description",
            "rate",
            "unit_price",
            "tax",
            "tax2",
            "unit",
            "status",
            "group",
            "group_id",
            "group_name",
            "created_at",
        ]
          
#================== CalenderEvent ============
class CalendarEventSerializer(serializers.ModelSerializer):
    class Meta:
        model = CalendarEvent
        fields = "__all__"

# ================= Customer =================
class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = "__all__"


class ProjectSerializer(serializers.ModelSerializer):
    clientid = serializers.IntegerField(
        source="client_id",
        required=False,
        allow_null=True,
    )
    customer_name = serializers.CharField(source="client.company", read_only=True)
    members = serializers.PrimaryKeyRelatedField(
        many=True,
        queryset=User.objects.filter(is_active=True),
        required=False,
    )
    mentor = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.filter(is_active=True),
        required=False,
        allow_null=True,
    )
    mentor_display = serializers.SerializerMethodField()
    members_display = serializers.SerializerMethodField()
    total_logged_hours = serializers.SerializerMethodField()
    productivity = serializers.SerializerMethodField()

    class Meta:
        model = Project
        fields = [
            "id",
            "name",
            "client",
            "clientid",
            "customer_name",
            "progress",
            "status",
            "billing_type",
            "total_rate",
            "estimated_hours",
            "start_date",
            "deadline",
            "tags",
            "description",
            "members",
            "members_display",
            "mentor",
            "mentor_display",
            "send_email",
            "visible_tabs",
            "settings",
            "created_by",
            "created_at",
            "updated_at",
            "total_logged_hours",
            "productivity",
        ]
        read_only_fields = [
            "created_by",
            "created_at",
            "updated_at",
            "members_display",
            "mentor_display",
            "customer_name",
            "total_logged_hours",
            "productivity",
        ]

    def validate_progress(self, value):
        if value < 0 or value > 100:
            raise serializers.ValidationError("Progress must be between 0 and 100.")
        return value

    def validate_visible_tabs(self, value):
        if value is None:
            return []
        if not isinstance(value, list) or not all(isinstance(x, str) for x in value):
            raise serializers.ValidationError("visible_tabs must be a list of strings.")
        return value

    def validate_settings(self, value):
        if value is None:
            return []
        if not isinstance(value, list) or not all(isinstance(x, str) for x in value):
            raise serializers.ValidationError("settings must be a list of strings.")
        return value

    def get_members_display(self, obj):
        return [
            (m.first_name or m.username or str(m.id))
            for m in obj.members.all()
        ]

    def get_mentor_display(self, obj):
        mentor = getattr(obj, "mentor", None)
        if not mentor:
            return None
        return mentor.first_name or mentor.username or mentor.email or str(mentor.id)

    def get_total_logged_hours(self, obj):
        return 0

    def get_productivity(self, obj):
        return 0


class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = Contact
        fields = [
            "id",
            "is_primary",
            "firstname",
            "lastname",
            "email",
            "company",
            "phonenumber",
            "title",
            "password",
            "last_login",
            "active",
            "direction",
            # ------------------------------------------------------------
            # Address fields (added to Contact model)
            # ------------------------------------------------------------
            "street",
            "city",
            "state",
            "zip_code",
            "country",
            "invoice_emails",
            "estimate_emails",
            "credit_note_emails",
            "contract_emails",
            "task_emails",
            "project_emails",
            "ticket_emails",
            "created_at",
        ]
        extra_kwargs = {
            "is_primary": {"required": False},
            "company": {"required": False, "allow_blank": True, "allow_null": True},
            "phonenumber": {"required": False, "allow_blank": True},
            "title": {"required": False, "allow_blank": True, "allow_null": True},
            "password": {"required": False, "allow_blank": True, "allow_null": True},
            "last_login": {"required": False, "allow_null": True},
            "active": {"required": False},
            "direction": {"required": False, "allow_blank": True, "allow_null": True},
            "invoice_emails": {"required": False},
            "estimate_emails": {"required": False},
            "credit_note_emails": {"required": False},
            "contract_emails": {"required": False},
            "task_emails": {"required": False},
            "project_emails": {"required": False},
            "ticket_emails": {"required": False},
        }

# ================= Estimate =================
class EstimateSerializer(serializers.ModelSerializer):
    invoice = InvoiceSerializer(many=True, read_only=True)
    class Meta:
        model = Estimate
        fields = "__all__"

    def create(self, validated_data):
        validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        estimate = super().create(validated_data)
        sync_items_to_master(estimate.items)
        return estimate

    def update(self, instance, validated_data):
        if "items" in validated_data:
            validated_data["items"] = _normalize_items_payload(validated_data.get("items"))
        estimate = super().update(instance, validated_data)
        sync_items_to_master(estimate.items)
        return estimate

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data["items"] = _normalize_items_payload(data.get("items"))
        return data
#==================Leads===================
class LeadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Lead
        fields = "__all__"

# ================= BUSINESS =================
class BusinessSerializer(serializers.ModelSerializer):
    class Meta:
        model = Business
        fields = "__all__"
        read_only_fields = ["is_approved", "db_name", "created_at"]


# ================= ROLE =================
class RoleSerializer(serializers.ModelSerializer):
    status = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = Role
        fields = [
            "id",
            "name",
            "permissions",
            "is_approved",
            "status",
            "created_at",
        ]
        read_only_fields = ["is_approved", "created_at"]

    def get_status(self, obj):
        return "Approved" if obj.is_approved else "Pending"

    def validate_permissions(self, value):
        if not value or not value.strip():
            return "Basic"
        return value


# ================= PROPOSAL (FIXED) =================
class ProposalSerializer(serializers.ModelSerializer):

    assigned_to_name = serializers.CharField(
        source="assigned_to.username",
        read_only=True
    )

    assigned_to = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(),
        required=False,
        allow_null=True
    )

    class Meta:
        model = Proposal
        fields = "__all__"
        read_only_fields = ["id", "created_by", "created_at"]

    # ✅ CREATE METHOD
    def create(self, validated_data):
        items = _normalize_items_payload(validated_data.pop("items", []))
        proposal = Proposal.objects.create(**validated_data)

        proposal.items = items
        proposal.total = self.calculate_total(
            items,
            proposal.discount_total,
            proposal.adjustment
        )
        proposal.save()
        sync_items_to_master(items)
        return proposal

    # ✅ UPDATE METHOD
    def update(self, instance, validated_data):
        items = _normalize_items_payload(validated_data.pop("items", instance.items))

        for attr, value in validated_data.items():
            setattr(instance, attr, value)

        instance.items = items
        instance.total = self.calculate_total(
            items,
            instance.discount_total,
            instance.adjustment
        )
        instance.save()
        sync_items_to_master(items)
        return instance

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data["items"] = _normalize_items_payload(data.get("items"))
        return data

    # ✅ TOTAL CALCULATION
    def calculate_total(self, items, discount, adjustment):
        subtotal = 0

        for item in items or []:
            qty = float(item.get("qty", 0))
            rate = float(item.get("rate", 0))
            subtotal += qty * rate

        return subtotal - float(discount or 0) + float(adjustment or 0)
# ================= USER =================
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["id", "username"]


# ================= JWT =================
class EmailTokenObtainPairSerializer(TokenObtainPairSerializer):
    username_field = "email"

    def validate(self, attrs):
        email = attrs.get("email")
        password = attrs.get("password")

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            raise serializers.ValidationError("Invalid credentials")

        if not user.check_password(password):
            raise serializers.ValidationError("Invalid credentials")

        data = super().validate({
            "username": user.username,
            "password": password,
        })
        return data


class ExpenseSerializer(serializers.ModelSerializer):
    customer_display = serializers.SerializerMethodField()
    invoice_number = serializers.SerializerMethodField()
    payment_mode_display = serializers.SerializerMethodField()

    class Meta:
        model = Expense
        fields = "__all__"

    def get_customer_display(self, obj):
        if getattr(obj, "customer_ref", None):
            return obj.customer_ref.company

        if getattr(obj, "customer", None):
            return obj.customer

        if getattr(obj, "invoice_ref", None) and getattr(obj.invoice_ref, "customer", None):
            return obj.invoice_ref.customer.company

        return "-"

    def get_invoice_number(self, obj):
        if getattr(obj, "invoice_ref", None):
            return obj.invoice_ref.invoice_number
        return None

    def get_payment_mode_display(self, obj):
        if getattr(obj, "payment_mode", None):
            return obj.payment_mode
        if getattr(obj, "invoice_ref", None):
            return obj.invoice_ref.payment_mode
        return "Null"

    def validate(self, attrs):
        raw_customer = self.initial_data.get("customer")
        raw_reference = self.initial_data.get("reference")
        raw_invoice = (
            self.initial_data.get("invoice_ref")
            or self.initial_data.get("invoice")
            or self.initial_data.get("invoiceId")
        )

        if not attrs.get("customer_ref") and raw_customer:
            try:
                customer_id = int(raw_customer)
            except (TypeError, ValueError):
                customer_id = None

            if customer_id is not None:
                customer = Client.objects.filter(pk=customer_id).first()
                if customer:
                    attrs["customer_ref"] = customer
                    if str(raw_customer).strip().isdigit():
                        attrs["customer"] = customer.company

        if not attrs.get("invoice_ref"):
            key = raw_invoice or raw_reference
            if key:
                invoice = None
                try:
                    invoice_id = int(key)
                except (TypeError, ValueError):
                    invoice_id = None

                if invoice_id is not None:
                    invoice = Invoice.objects.filter(pk=invoice_id).first()

                if not invoice:
                    invoice = Invoice.objects.filter(
                        invoice_number__iexact=str(key).strip()
                    ).first()

                if invoice:
                    attrs["invoice_ref"] = invoice

                    if not attrs.get("customer_ref") and getattr(invoice, "customer", None):
                        attrs["customer_ref"] = invoice.customer

                    if not attrs.get("payment_mode") and getattr(invoice, "payment_mode", None):
                        attrs["payment_mode"] = invoice.payment_mode

                    if not attrs.get("customer") and getattr(invoice, "customer", None):
                        attrs["customer"] = invoice.customer.company

        return attrs


class ContractSerializer(serializers.ModelSerializer):
    customer_display = serializers.SerializerMethodField()
    computed_status = serializers.SerializerMethodField()

    class Meta:
        model = Contract
        fields = "__all__"

    def get_customer_display(self, obj):
        if getattr(obj, "customer_ref", None):
            return obj.customer_ref.company
        if getattr(obj, "customer", None):
            return obj.customer
        return "-"

    def get_computed_status(self, obj):
        today = timezone.now().date()

        if getattr(obj, "is_trashed", False):
            return "Inactive"

        if getattr(obj, "end_date", None) and obj.end_date < today:
            return "Expired"

        if getattr(obj, "start_date", None) and obj.start_date <= today:
            if not getattr(obj, "end_date", None) or obj.end_date >= today:
                return "Active"

        return getattr(obj, "status", None) or "Draft"

    def validate(self, attrs):
        if attrs.get("customer_ref") and not attrs.get("customer"):
            attrs["customer"] = attrs["customer_ref"].company

        raw_customer = self.initial_data.get("customer")
        if not attrs.get("customer_ref") and raw_customer:
            try:
                customer_id = int(raw_customer)
            except (TypeError, ValueError):
                customer_id = None

            if customer_id is not None:
                customer = Client.objects.filter(pk=customer_id).first()
                if customer:
                    attrs["customer_ref"] = customer
                    attrs["customer"] = customer.company

        return attrs


class ContractTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContractType
        fields = "__all__"


class ContractAttachmentSerializer(serializers.ModelSerializer):
    file_url = serializers.SerializerMethodField()

    class Meta:
        model = ContractAttachment
        fields = "__all__"

    def get_file_url(self, obj):
        request = self.context.get("request")
        try:
            url = obj.file.url
        except Exception:
            url = ""
        if request and url:
            return request.build_absolute_uri(url)
        return url


class ContractCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContractComment
        fields = "__all__"


class ContractRenewalSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContractRenewal
        fields = "__all__"


class ContractTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContractTask
        fields = "__all__"


class ContractNoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContractNote
        fields = "__all__"

# ================== THIS IS EMAILCAMPAIGN CODE ==================
class EmailRecipientSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmailRecipient
        fields = "__all__"

class EmailCampaignSerializer(serializers.ModelSerializer):
    recipients = EmailRecipientSerializer(many=True, read_only=True)

    class Meta:
        model = EmailCampaign
        fields = "__all__"


class EmailTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = EmailTemplate
        fields = "__all__"
        extra_kwargs = {
            "slug": {"required": False, "allow_blank": True},
            "language": {"required": False},
        }


class SetupModuleSerializer(serializers.ModelSerializer):
    # Add an alias field `is_active` that maps to the model's `is_enabled` flag.
    # This aligns the backend representation with the frontend expectations,
    # which checks for `is_active`, `active`, or `enabled` to determine module status.
    is_active = serializers.BooleanField(source="is_enabled", required=False)

    class Meta:
        model = SetupModule
        # Include all model fields plus the alias. Using "__all__" already brings
        # `is_enabled`; adding `is_active` provides a convenient duplicate name.
        fields = "__all__"


class SetupCustomFieldSerializer(serializers.ModelSerializer):
    MODULE_ALIASES = {
        "customer": "customer",
        "customers": "customer",
        "lead": "leads",
        "leads": "leads",
        "staff": "staff",
        "support": "support",
        "finance": "finance",
        "contract": "contracts",
        "contracts": "contracts",
    }

    class Meta:
        model = SetupCustomField
        fields = "__all__"
        extra_kwargs = {
            "field_key": {"required": False, "allow_blank": True},
            "options": {"required": False},
        }

    def validate_module_slug(self, value):
        raw = str(value or "").strip().lower()
        return self.MODULE_ALIASES.get(raw, raw)

    def validate_options(self, value):
        if value in (None, ""):
            return []
        if isinstance(value, str):
            return [item.strip() for item in value.split(",") if item.strip()]
        if isinstance(value, list):
            out = []
            for item in value:
                text = str(item or "").strip()
                if text:
                    out.append(text)
            return out
        raise serializers.ValidationError("Options must be a list or comma separated string.")

    def validate(self, attrs):
        field_type = attrs.get("field_type")
        if field_type is None and self.instance:
            field_type = self.instance.field_type

        options = attrs.get("options")
        if options is None and self.instance:
            options = self.instance.options or []
        options = options or []

        label_value = attrs.get("label")
        if label_value is None and self.instance:
            label_value = self.instance.label

        field_key = attrs.get("field_key")
        if (field_key is None or str(field_key).strip() == "") and label_value:
            attrs["field_key"] = slugify(label_value)

        if field_type == "select" and not options:
            raise serializers.ValidationError({"options": "Options are required for select type fields."})

        default_value = attrs.get("default_value")
        if default_value is None and self.instance:
            default_value = self.instance.default_value

        if default_value not in (None, "") and field_type:
            try:
                if field_type in {"text", "textarea"}:
                    default_value = str(default_value)
                elif field_type == "number":
                    Decimal(str(default_value))
                    default_value = str(default_value)
                elif field_type == "email":
                    validate_email(str(default_value))
                    default_value = str(default_value).strip()
                elif field_type == "date":
                    parsed = parse_date(str(default_value))
                    if not parsed:
                        raise serializers.ValidationError({"default_value": "Default value must be YYYY-MM-DD."})
                    default_value = parsed.isoformat()
                elif field_type == "select":
                    default_text = str(default_value)
                    if options and default_text not in options:
                        raise serializers.ValidationError(
                            {"default_value": "Default value must be one of the available options."}
                        )
                    default_value = default_text
                elif field_type == "checkbox":
                    raw = str(default_value).strip().lower()
                    truthy = {"1", "true", "yes", "y", "on"}
                    falsy = {"0", "false", "no", "n", "off"}
                    if raw in truthy:
                        default_value = "1"
                    elif raw in falsy:
                        default_value = "0"
                    else:
                        raise serializers.ValidationError(
                            {"default_value": "Checkbox default must be true/false or 1/0."}
                        )
            except (InvalidOperation, ValueError, TypeError, DjangoValidationError):
                raise serializers.ValidationError(
                    {"default_value": f"Invalid default value for field type '{field_type}'."}
                )

        attrs["default_value"] = default_value
        return attrs


class SetupGDPRRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupGDPRRequest
        fields = "__all__"

    def update(self, instance, validated_data):
        next_status = validated_data.get("status")
        if next_status == "completed" and not instance.resolved_at:
            validated_data["resolved_at"] = timezone.now()
        return super().update(instance, validated_data)


class SetupSettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupSetting
        fields = "__all__"


class SetupHelpArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupHelpArticle
        fields = "__all__"
        extra_kwargs = {
            "slug": {"required": False, "allow_blank": True},
        }


class SetupCustomerGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupCustomerGroup
        fields = "__all__"


class SetupCustomerGroupAssignmentSerializer(serializers.ModelSerializer):
    customer_name = serializers.CharField(source="customer.company", read_only=True)
    group_name = serializers.CharField(source="group.name", read_only=True)

    class Meta:
        model = SetupCustomerGroupAssignment
        fields = "__all__"


class SetupThemeStyleSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupThemeStyle
        fields = "__all__"

    def validate(self, attrs):
        is_default = attrs.get("is_default")
        if is_default:
            qs = SetupThemeStyle.objects.filter(is_default=True)
            if self.instance:
                qs = qs.exclude(pk=self.instance.pk)
            if qs.exists():
                raise serializers.ValidationError("Only one default theme is allowed.")
        return attrs


class SetupTaxSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupTax
        fields = "__all__"

    def validate_rate(self, value):
        if value < 0:
            raise serializers.ValidationError("Tax rate must be greater than or equal to 0.")
        return value


class SetupCurrencySerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupCurrency
        fields = "__all__"

    def validate(self, attrs):
        code = attrs.get("code")
        if code:
            attrs["code"] = str(code).upper()

        is_default = attrs.get("is_default")
        if is_default:
            qs = SetupCurrency.objects.filter(is_default=True)
            if self.instance:
                qs = qs.exclude(pk=self.instance.pk)
            if qs.exists():
                raise serializers.ValidationError("Only one default currency is allowed.")
        return attrs


class SetupPaymentModeSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupPaymentMode
        fields = "__all__"


class SetupExpenseCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupExpenseCategory
        fields = "__all__"


class SetupSupportDepartmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupSupportDepartment
        fields = "__all__"


class SetupTicketPrioritySerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupTicketPriority
        fields = "__all__"


class SetupTicketStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupTicketStatus
        fields = "__all__"

    def validate_color(self, value):
        val = str(value or "")
        if len(val) != 7 or not val.startswith("#"):
            raise serializers.ValidationError("Color must be in #RRGGBB format.")
        return val


class SetupPredefinedReplySerializer(serializers.ModelSerializer):
    department_name = serializers.CharField(source="department.name", read_only=True)

    class Meta:
        model = SetupPredefinedReply
        fields = "__all__"


class SetupLeadSourceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupLeadSource
        fields = "__all__"


class SetupLeadStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupLeadStatus
        fields = "__all__"


class SetupContractTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupContractTemplate
        fields = "__all__"
        extra_kwargs = {
            "slug": {"required": False, "allow_blank": True},
            "variable_keys": {"required": False},
        }


class SetupRolePermissionSerializer(serializers.ModelSerializer):
    role_name = serializers.CharField(source="role.name", read_only=True)

    class Meta:
        model = SetupRolePermission
        fields = "__all__"


# ================= STAFF =================
class StaffSerializer(serializers.ModelSerializer):
    class Meta:
        model = Staff
        fields = [
            "staffid",
            "email",
            "firstname",
            "lastname",
            "facebook",
            "linkedin",
            "phonenumber",
            "skype",
            "password",
            "datecreated",
            "profile_image",
            "last_ip",
            "last_login",
            "last_activity",
            "last_password_change",
            "admin",
            "role",
            "active",
            "default_language",
            "direction",
            "media_path_slug",
            "is_not_staff",
            "hourly_rate",
            "two_factor_auth_enabled",
            "email_signature",
        ]
        extra_kwargs = {
            "password": {"write_only": True},
            "datecreated": {"read_only": True},
            "last_login": {"read_only": True},
            "last_activity": {"read_only": True},
            "last_password_change": {"read_only": True},
            "last_ip": {"read_only": True},
            "new_pass_key": {"read_only": True},
            "new_pass_key_requested": {"read_only": True},
            "two_factor_auth_code": {"write_only": True},
            "two_factor_auth_code_requested": {"read_only": True},
        }

# ---------------------------------------------------------------------------
# Custom Field Value Serializer
# ---------------------------------------------------------------------------
class CustomFieldValueSerializer(serializers.ModelSerializer):
    """Serializer for :class:`core.models.CustomFieldValue`.

    The ``content_type`` field is represented by its PK; the frontend can
    resolve the model name from that if needed. ``custom_field`` is a nested
    representation using its primary key.
    """

    # Expose useful read‑only fields for frontend consumption:
    # - `content_type` – a string like "app_label.model" identifying the target model.
    # - `object_id` – the primary key of the target instance (already present).
    # - `object_repr` – a simple textual representation of the target object.
    content_type_name = serializers.SerializerMethodField(read_only=True)
    object_repr = serializers.SerializerMethodField(read_only=True)
    custom_field_key = serializers.CharField(source="custom_field.field_key", read_only=True)
    custom_field_label = serializers.CharField(source="custom_field.label", read_only=True)
    module_slug = serializers.CharField(source="custom_field.module_slug", read_only=True)

    class Meta:
        model = CustomFieldValue
        fields = "__all__"

    def get_content_type_name(self, obj):
        """Return a human‑readable ``app_label.model`` string for the content type."""
        if obj.content_type:
            return f"{obj.content_type.app_label}.{obj.content_type.model}"
        return None

    def get_object_repr(self, obj):
        """Return ``str()`` of the related object if it exists, else ``None``."""
        try:
            return str(obj.content_object) if obj.content_object else None
        except Exception:
            return None


def _legacy_permissions_text(permission_rows):
    try:
        return json.dumps(permission_rows)
    except Exception:
        return "[]"


def normalize_permission_payload(payload):
    if payload in (None, ""):
        return []

    rows = []
    if isinstance(payload, dict):
        iterable = []
        for module_name, actions in payload.items():
            iterable.append({"module": module_name, "permissions": actions})
    elif isinstance(payload, list):
        iterable = payload
    else:
        raise serializers.ValidationError("permissions must be a list or object.")

    for item in iterable:
        if not isinstance(item, dict):
            raise serializers.ValidationError("Each permission row must be an object.")

        module = canonicalize_module(item.get("module") or item.get("module_slug"))
        if not module:
            raise serializers.ValidationError("Each permission row requires module.")

        raw_actions = (
            item.get("permissions")
            if item.get("permissions") is not None
            else item.get("actions")
        )
        if raw_actions is None:
            raw_actions = []
        if not isinstance(raw_actions, list):
            raise serializers.ValidationError("permissions/actions must be a list.")

        actions = []
        seen = set()
        for action in raw_actions:
            action_name = str(action or "").strip().lower()
            if not action_name:
                continue
            if action_name not in RBAC_ACTIONS:
                raise serializers.ValidationError(
                    f"Invalid action '{action_name}'. Allowed: {', '.join(RBAC_ACTIONS)}."
                )
            if action_name in seen:
                continue
            seen.add(action_name)
            actions.append(action_name)

        rows.append({"module": module, "permissions": actions})
    return rows


class PermissionDefinitionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Permission
        fields = ["id", "module", "action", "code", "description", "is_active"]


class RoleReadSerializer(serializers.ModelSerializer):
    permissions = serializers.SerializerMethodField()
    users_count = serializers.SerializerMethodField()

    class Meta:
        model = Role
        fields = [
            "id",
            "name",
            "description",
            "is_active",
            "is_super_admin",
            "level",
            "permissions",
            "users_count",
            "created_at",
            "updated_at",
        ]

    def get_permissions(self, obj):
        matrix = {}
        links = (
            obj.role_permissions.select_related("permission")
            .filter(is_allowed=True, permission__is_active=True)
            .order_by("permission__module", "permission__action")
        )
        for link in links:
            module = link.permission.module
            matrix.setdefault(module, [])
            matrix[module].append(link.permission.action)
        return [
            {"module": module, "permissions": actions}
            for module, actions in sorted(matrix.items(), key=lambda row: row[0].lower())
        ]

    def get_users_count(self, obj):
        return obj.user_roles.filter(is_active=True).count()


class RoleWriteSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=100)
    description = serializers.CharField(required=False, allow_blank=True, allow_null=True)
    is_active = serializers.BooleanField(required=False, default=True)
    is_super_admin = serializers.BooleanField(required=False, default=False)
    level = serializers.IntegerField(required=False, min_value=1, default=1)
    permissions = serializers.JSONField(required=False)

    def validate_name(self, value):
        trimmed = str(value or "").strip()
        if not trimmed:
            raise serializers.ValidationError("name is required.")

        qs = Role.objects.filter(name__iexact=trimmed)
        instance = getattr(self, "instance", None)
        if instance is not None:
            qs = qs.exclude(pk=instance.pk)
        if qs.exists():
            raise serializers.ValidationError("Role with this name already exists.")
        return trimmed

    def validate_permissions(self, value):
        return normalize_permission_payload(value)

    def validate(self, attrs):
        actor = self.context.get("actor")
        instance = getattr(self, "instance", None)
        next_is_super_admin = attrs.get(
            "is_super_admin",
            instance.is_super_admin if instance is not None else False,
        )
        next_is_active = attrs.get(
            "is_active",
            instance.is_active if instance is not None else True,
        )

        if next_is_super_admin and not is_super_admin(actor):
            raise serializers.ValidationError(
                {"is_super_admin": "Only Super Admin can create/update Super Admin roles."}
            )

        if instance is not None and instance.is_super_admin and not is_super_admin(actor):
            raise serializers.ValidationError(
                {"detail": "Only Super Admin can modify a Super Admin role."}
            )

        if instance is not None and instance.is_super_admin and (not next_is_super_admin or not next_is_active):
            remaining_active_super_admins = Role.objects.filter(
                is_super_admin=True,
                is_active=True,
            ).exclude(pk=instance.pk)
            if not remaining_active_super_admins.exists():
                raise serializers.ValidationError(
                    {"detail": "At least one active Super Admin role is required."}
                )
        return attrs

    def _replace_permissions(self, role, permission_rows):
        permission_ids = []
        for row in permission_rows:
            module = row["module"]
            for action in row["permissions"]:
                permission_obj = ensure_permission(module, action)
                permission_ids.append(permission_obj.id)

        RolePermission.objects.filter(role=role).exclude(permission_id__in=permission_ids).delete()

        existing = set(
            RolePermission.objects.filter(role=role, permission_id__in=permission_ids).values_list(
                "permission_id",
                flat=True,
            )
        )
        to_create = []
        for permission_id in permission_ids:
            if permission_id in existing:
                continue
            to_create.append(
                RolePermission(
                    role=role,
                    permission_id=permission_id,
                    is_allowed=True,
                )
            )
        if to_create:
            RolePermission.objects.bulk_create(to_create, ignore_conflicts=True)

    @transaction.atomic
    def create(self, validated_data):
        sync_default_permissions()
        permission_rows = validated_data.pop("permissions", [])
        role = Role.objects.create(
            name=validated_data["name"],
            description=validated_data.get("description") or "",
            is_active=validated_data.get("is_active", True),
            is_super_admin=validated_data.get("is_super_admin", False),
            level=validated_data.get("level", 1),
            permissions=_legacy_permissions_text(permission_rows),
        )
        self._replace_permissions(role, permission_rows)
        return role

    @transaction.atomic
    def update(self, instance, validated_data):
        sync_default_permissions()
        permission_rows = validated_data.pop("permissions", None)

        instance.name = validated_data.get("name", instance.name)
        instance.description = validated_data.get("description", instance.description)
        instance.is_active = validated_data.get("is_active", instance.is_active)
        instance.is_super_admin = validated_data.get("is_super_admin", instance.is_super_admin)
        instance.level = validated_data.get("level", instance.level)

        if permission_rows is not None:
            instance.permissions = _legacy_permissions_text(permission_rows)
        instance.save()

        if permission_rows is not None:
            self._replace_permissions(instance, permission_rows)
        return instance


class UserRoleAssignmentSerializer(serializers.Serializer):
    user_id = serializers.IntegerField()
    role_ids = serializers.ListField(
        child=serializers.IntegerField(min_value=1),
        required=False,
        allow_empty=True,
    )
    role_id = serializers.IntegerField(required=False, min_value=1)
    replace_existing = serializers.BooleanField(required=False, default=True)

    def validate(self, attrs):
        UserModel = get_user_model()
        user_id = attrs.get("user_id")
        user = UserModel.objects.filter(pk=user_id).first()
        if not user:
            raise serializers.ValidationError({"user_id": "User not found."})

        role_ids = attrs.get("role_ids")
        if role_ids is None:
            role_id = attrs.get("role_id")
            role_ids = [role_id] if role_id else []

        clean_role_ids = sorted(set([rid for rid in role_ids if rid]))
        if clean_role_ids:
            active_roles = list(
                Role.objects.filter(id__in=clean_role_ids, is_active=True).values(
                    "id",
                    "is_super_admin",
                )
            )
            found_ids = {row["id"] for row in active_roles}
            missing_ids = [rid for rid in clean_role_ids if rid not in found_ids]
            if missing_ids:
                raise serializers.ValidationError(
                    {"role_ids": f"Invalid/inactive role IDs: {missing_ids}"}
                )

            actor = self.context.get("actor")
            if not is_super_admin(actor):
                super_admin_ids = [row["id"] for row in active_roles if row["is_super_admin"]]
                if super_admin_ids:
                    raise serializers.ValidationError(
                        {"role_ids": "Only Super Admin can assign Super Admin roles."}
                    )

        attrs["user_obj"] = user
        attrs["clean_role_ids"] = clean_role_ids
        return attrs

    @transaction.atomic
    def save(self, **kwargs):
        user = self.validated_data["user_obj"]
        role_ids = self.validated_data["clean_role_ids"]
        replace_existing = self.validated_data.get("replace_existing", True)
        actor = self.context.get("actor")

        existing = {
            row.role_id: row
            for row in UserRole.objects.select_related("role").filter(user=user)
        }

        if replace_existing:
            for role_id, row in existing.items():
                if role_id in role_ids:
                    continue
                if row.is_active:
                    row.is_active = False
                    row.save(update_fields=["is_active", "updated_at"])

        assigned = []
        for role_id in role_ids:
            row = existing.get(role_id)
            if row:
                if not row.is_active:
                    row.is_active = True
                    row.assigned_by = actor
                    row.save(update_fields=["is_active", "assigned_by", "updated_at"])
                assigned.append(row)
                continue
            created = UserRole.objects.create(
                user=user,
                role_id=role_id,
                assigned_by=actor,
                is_active=True,
            )
            assigned.append(created)

        return {
            "user": user,
            "assigned_roles": [row.role for row in assigned],
            "active_role_ids": list(
                UserRole.objects.filter(user=user, is_active=True).values_list("role_id", flat=True)
            ),
        }
