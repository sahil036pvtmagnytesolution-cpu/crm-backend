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
from .item_master import sync_items_to_master


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
    class Meta:
        model = Expense
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
