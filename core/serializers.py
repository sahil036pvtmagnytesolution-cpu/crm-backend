from django.utils import timezone
from rest_framework import serializers
from .models import Business, Contact, CreditNote, CreditNoteReminder, CreditNoteTask, Customer, Item, ItemGroup, Role, Proposal
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User
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
from .item_master import sync_items_to_master
from .models import Project
from ms_crm_app.models import Staff


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
