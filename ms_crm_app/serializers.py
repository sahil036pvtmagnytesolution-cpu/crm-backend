from rest_framework import serializers;
# Import the app-specific models.
from .models import *;
from .models import Roles
# Import the newly added shared models from the core app.
from core.models import CompanyInfo, SMSTask, SetupTask

class UserProfileSerializers(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

# def validate_user_email(self, value):
#         if UserProfile.objects.filter(user_email=value).exists():
#             raise serializers.ValidationError("Email already exists")
#         return value

class RolesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Roles
        fields = "__all__"

# Serializer for the new GDPR request model
class GdprRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = GdprRequest
        # expose all fields except internal auto fields if any
        fields = [
            'id', 'customer_name', 'email', 'user_type', 'request_type',
            'status', 'details', 'request_id', 'requested_at',
            'processed_by', 'completed_at', 'verification_status', 'data_format'
        ]
        read_only_fields = ['id', 'request_id', 'requested_at', 'processed_by', 'completed_at']

# ------------------------------------------------------------
# Additional serializers for new Setup related models
# ------------------------------------------------------------

class CompanyInfoSerializer(serializers.ModelSerializer):
    def _delete_existing_logo(self, instance):
        logo_field = getattr(instance, "logo", None)
        logo_name = getattr(logo_field, "name", "")
        if logo_name:
            try:
                logo_field.delete(save=False)
            except Exception:
                pass

    def create(self, validated_data):
        # Enforce frontend-only branding assets: never persist uploaded media logos.
        validated_data.pop("logo", None)
        instance = super().create(validated_data)
        if getattr(instance, "logo", None):
            self._delete_existing_logo(instance)
            instance.logo = None
            instance.save(update_fields=["logo"])
        return instance

    def update(self, instance, validated_data):
        # Ignore any incoming logo file and clear previously stored media logo.
        validated_data.pop("logo", None)
        self._delete_existing_logo(instance)
        instance.logo = None
        return super().update(instance, validated_data)

    class Meta:
        model = CompanyInfo
        fields = "__all__"

# Alias to satisfy get_serializer_class utility which expects the plural form
class CompanyInfoSerializers(CompanyInfoSerializer):
    pass

class SMSTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = SMSTask
        fields = "__all__"

class SMSTaskSerializers(SMSTaskSerializer):
    pass

class SetupTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = SetupTask
        fields = "__all__"

class SetupTaskSerializers(SetupTaskSerializer):
    pass

# Serializer for Ticket Status model
class TicketsStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = TicketsStatus
        fields = "__all__"

# Serializer for Departments model
class DepartmentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Departments
        fields = "__all__"

# Serializer for TicketsPredefinedReplies model
class TicketsPredefinedRepliesSerializer(serializers.ModelSerializer):
    class Meta:
        model = TicketsPredefinedReplies
        fields = "__all__"

# Serializer for TicketsPriorities model
class TicketsPrioritiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = TicketsPriorities
        fields = "__all__"

# Serializer for Services model
class ServicesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Services
        fields = "__all__"

# Serializer for SpamFilters model
class SpamFiltersSerializer(serializers.ModelSerializer):
    class Meta:
        model = SpamFilters
        fields = "__all__"


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = "__all__"

    def validate_name(self, value):
        return str(value or "").strip()


class ProductStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductStatus
        fields = "__all__"

    def validate_name(self, value):
        return str(value or "").strip()


class CustomerStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerStatus
        fields = "__all__"

    def validate_name(self, value):
        return str(value or "").strip()


class LeadSourceSerializer(serializers.ModelSerializer):
    class Meta:
        model = LeadSource
        fields = "__all__"

    def validate_name(self, value):
        return str(value or "").strip()


class WebFormFieldSerializer(serializers.ModelSerializer):
    field_options = serializers.JSONField(required=False)

    class Meta:
        model = WebFormField
        fields = "__all__"

    def validate_field_name(self, value):
        return str(value or "").strip().lower().replace(" ", "_")

    def validate_label(self, value):
        return str(value or "").strip()

    def validate_mapped_field(self, value):
        mapped = str(value or "").strip().lower()
        allowed = {
            "first_name",
            "last_name",
            "email",
            "phone",
            "company",
            "message",
            "priority",
            "dynamic",
        }
        if mapped and mapped not in allowed:
            raise serializers.ValidationError(
                "mapped_field must be one of first_name, last_name, email, phone, company, message, priority, dynamic."
            )
        return mapped or "dynamic"

    def validate_field_options(self, value):
        if value in (None, ""):
            return []
        if isinstance(value, str):
            return [item.strip() for item in value.split(",") if item.strip()]
        if isinstance(value, list):
            cleaned = []
            for item in value:
                as_text = str(item or "").strip()
                if as_text:
                    cleaned.append(as_text)
            return cleaned
        raise serializers.ValidationError("field_options must be a list or comma-separated string.")

    def validate(self, attrs):
        if not attrs.get("label") and attrs.get("field_name"):
            attrs["label"] = str(attrs["field_name"]).replace("_", " ").title()
        return attrs


class EmailIntegrationSerializer(serializers.ModelSerializer):
    host = serializers.CharField(required=False, allow_blank=True, write_only=True)
    port = serializers.IntegerField(required=False, allow_null=True, write_only=True)
    email = serializers.CharField(required=False, allow_blank=True, write_only=True)

    class Meta:
        model = EmailIntegration
        fields = "__all__"
        extra_kwargs = {
            "password": {"write_only": True},
        }

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data["host"] = instance.imap_host or instance.email_host or instance.smtp_host or ""
        data["port"] = instance.imap_port or instance.email_port or instance.smtp_port
        data["email"] = instance.email_address or instance.username or ""
        return data

    def _apply_compat_fields(self, attrs):
        host = attrs.pop("host", None)
        port = attrs.pop("port", None)
        email = attrs.pop("email", None)

        if host is not None:
            host_value = str(host or "").strip()
            if host_value:
                attrs.setdefault("imap_host", host_value)
                attrs.setdefault("smtp_host", host_value)
                attrs.setdefault("email_host", host_value)

        if port is not None:
            try:
                port_value = int(port)
            except (TypeError, ValueError):
                port_value = None
            if port_value is not None and port_value > 0:
                attrs.setdefault("imap_port", port_value)
                attrs.setdefault("smtp_port", port_value)
                attrs.setdefault("email_port", port_value)

        if email is not None:
            email_value = str(email or "").strip()
            if email_value:
                attrs.setdefault("email_address", email_value)
                attrs.setdefault("username", email_value)

        return attrs

    def create(self, validated_data):
        payload = self._apply_compat_fields(dict(validated_data))
        return super().create(payload)

    def update(self, instance, validated_data):
        payload = self._apply_compat_fields(dict(validated_data))
        password = payload.get("password")
        if password in (None, ""):
            payload.pop("password", None)
        return super().update(instance, payload)


class LeadSerializer(serializers.ModelSerializer):
    product_name = serializers.CharField(source="product.name", read_only=True)
    product_status_name = serializers.CharField(source="product_status.name", read_only=True)
    customer_status_name = serializers.CharField(source="customer_status.name", read_only=True)
    source_name = serializers.CharField(source="source.name", read_only=True)

    class Meta:
        model = Lead
        fields = [
            "id",
            "first_name",
            "last_name",
            "email",
            "phone",
            "company",
            "message",
            "priority",
            "assigned_to_user",
            "assigned_to_team",
            "dynamic_data",
            "product",
            "product_status",
            "customer_status",
            "source",
            "product_name",
            "product_status_name",
            "customer_status_name",
            "source_name",
            "created_at",
            "updated_at",
        ]
        read_only_fields = ["id", "created_at", "updated_at"]
        extra_kwargs = {
            "source": {"required": False, "allow_null": True},
            "customer_status": {"required": False, "allow_null": True},
            "product_status": {"required": False, "allow_null": True},
            "product": {"required": False, "allow_null": True},
        }

    def validate_email(self, value):
        normalized_email = str(value).strip().lower()
        queryset = Lead.objects.filter(email__iexact=normalized_email)
        if self.instance:
            queryset = queryset.exclude(pk=self.instance.pk)
        if queryset.exists():
            raise serializers.ValidationError("Lead with this email already exists.")
        return normalized_email

    def create(self, validated_data):
        if not validated_data.get("source"):
            source, _ = LeadSource.objects.get_or_create(
                name="Website",
                defaults={"is_active": True},
            )
            validated_data["source"] = source

        if not validated_data.get("customer_status"):
            customer_status, _ = CustomerStatus.objects.get_or_create(
                name="New",
                defaults={"is_active": True},
            )
            validated_data["customer_status"] = customer_status

        return super().create(validated_data)


class LeadCaptureConfigurationSerializer(serializers.ModelSerializer):
    class Meta:
        model = LeadCaptureConfiguration
        fields = "__all__"

    def validate_default_priority(self, value):
        val = str(value or "").strip().lower()
        if not val:
            return "medium"
        allowed = {"low", "medium", "high", "urgent"}
        if val not in allowed:
            raise serializers.ValidationError("default_priority must be one of low, medium, high, urgent.")
        return val

    def validate(self, attrs):
        for name in [
            "default_source",
            "default_status",
            "default_product",
            "default_product_status",
            "auto_assign_user",
            "auto_assign_team",
            "notification_email",
            "api_key_token",
            "auto_response_subject",
        ]:
            if name in attrs:
                attrs[name] = str(attrs.get(name) or "").strip()
        return attrs


class WebToLeadSerializer(serializers.Serializer):
    name = serializers.CharField(required=False, allow_blank=True, default="")
    first_name = serializers.CharField(required=False, allow_blank=True, default="")
    last_name = serializers.CharField(required=False, allow_blank=True, default="")
    email = serializers.EmailField()
    phone = serializers.CharField(required=False, allow_blank=True, default="")
    company = serializers.CharField(required=False, allow_blank=True, default="")
    message = serializers.CharField(required=False, allow_blank=True, default="")
    priority = serializers.CharField(required=False, allow_blank=True, default="")
    product = serializers.PrimaryKeyRelatedField(
        queryset=Product.objects.filter(is_active=True),
        required=False,
        allow_null=True,
    )
    product_status = serializers.PrimaryKeyRelatedField(
        queryset=ProductStatus.objects.all(),
        required=False,
        allow_null=True,
    )
    source = serializers.PrimaryKeyRelatedField(
        queryset=LeadSource.objects.all(),
        required=False,
        allow_null=True,
    )
    customer_status = serializers.PrimaryKeyRelatedField(
        queryset=CustomerStatus.objects.all(),
        required=False,
        allow_null=True,
    )
    api_key = serializers.CharField(required=False, allow_blank=True, default="")
    recaptcha_token = serializers.CharField(required=False, allow_blank=True, default="")
    dynamic_data = serializers.DictField(required=False, default=dict)

    def validate(self, attrs):
        config = self.context.get("lead_capture_config")
        dynamic_data = attrs.get("dynamic_data") or {}
        missing_required = []

        active_required_fields = (
            WebFormField.objects.filter(is_active=True, is_required=True)
            .values_list("field_name", flat=True)
        )
        for field_name in active_required_fields:
            input_value = self.initial_data.get(field_name)
            if input_value in (None, ""):
                input_value = dynamic_data.get(field_name)
            if input_value in (None, ""):
                missing_required.append(field_name)

        if missing_required:
            raise serializers.ValidationError({"missing_required_fields": missing_required})

        email = str(attrs.get("email") or "").strip().lower()
        attrs["email"] = email
        prevent_duplicates = True
        if config is not None:
            prevent_duplicates = bool(config.prevent_duplicates)

        existing_lead = Lead.objects.filter(email__iexact=email).first()
        if existing_lead is not None:
            if prevent_duplicates:
                raise serializers.ValidationError({"email": "Lead with this email already exists."})
            attrs["_existing_lead"] = existing_lead

        return attrs

    def create(self, validated_data):
        config = self.context.get("lead_capture_config")
        dynamic_data = dict(validated_data.pop("dynamic_data", {}) or {})
        existing_lead = validated_data.pop("_existing_lead", None)
        raw_name = str(validated_data.pop("name", "") or "").strip()
        first_name = str(validated_data.get("first_name", "") or "").strip()
        last_name = str(validated_data.get("last_name", "") or "").strip()

        if raw_name and not first_name and not last_name:
            parts = raw_name.split()
            first_name = parts[0]
            last_name = " ".join(parts[1:]) if len(parts) > 1 else ""

        field_mappings = WebFormField.objects.filter(is_active=True)
        for field in field_mappings:
            key = field.field_name
            incoming_value = self.initial_data.get(key, dynamic_data.get(key))
            if incoming_value in (None, ""):
                continue
            mapped_to = str(field.mapped_field or "dynamic").strip().lower()

            if mapped_to == "first_name":
                first_name = str(incoming_value).strip()
            elif mapped_to == "last_name":
                last_name = str(incoming_value).strip()
            elif mapped_to in {"phone", "company", "message", "priority"}:
                validated_data[mapped_to] = str(incoming_value).strip()
            elif mapped_to == "email":
                validated_data["email"] = str(incoming_value).strip().lower()
            else:
                dynamic_data[key] = incoming_value

        source = validated_data.get("source")
        if source is None:
            source_name = getattr(config, "default_source", "") if config else ""
            if source_name:
                source = LeadSource.objects.filter(name__iexact=source_name).first()
            if source is None:
                source, _ = LeadSource.objects.get_or_create(
                    name="Website",
                    defaults={"is_active": True},
                )

        customer_status = validated_data.get("customer_status")
        if customer_status is None:
            status_name = getattr(config, "default_status", "") if config else ""
            if status_name:
                customer_status = CustomerStatus.objects.filter(name__iexact=status_name).first()
            if customer_status is None:
                customer_status, _ = CustomerStatus.objects.get_or_create(
                    name="New",
                    defaults={"is_active": True},
                )

        product = validated_data.get("product")
        if product is None and config and config.default_product:
            product = Product.objects.filter(name__iexact=config.default_product).first()

        product_status = validated_data.get("product_status")
        if product_status is None and config and config.default_product_status:
            product_status = ProductStatus.objects.filter(name__iexact=config.default_product_status).first()

        default_priority = str(getattr(config, "default_priority", "") or "").strip()
        priority = str(validated_data.get("priority", "") or "").strip().lower()
        if not priority:
            priority = default_priority or "medium"

        lead_payload = {
            "first_name": first_name,
            "last_name": last_name,
            "email": validated_data["email"],
            "phone": str(validated_data.get("phone", "") or "").strip(),
            "company": str(validated_data.get("company", "") or "").strip(),
            "message": str(validated_data.get("message", "") or "").strip(),
            "priority": priority,
            "assigned_to_user": self._as_int(getattr(config, "auto_assign_user", "")) if config else None,
            "assigned_to_team": str(getattr(config, "auto_assign_team", "") or "").strip() if config else "",
            "dynamic_data": dynamic_data,
            "product": product,
            "product_status": product_status,
            "source": source,
            "customer_status": customer_status,
        }

        if existing_lead is not None:
            for key, value in lead_payload.items():
                setattr(existing_lead, key, value)
            existing_lead.save()
            return existing_lead

        lead = Lead.objects.create(**lead_payload)
        return lead

    @staticmethod
    def _as_int(value):
        try:
            return int(str(value).strip())
        except (TypeError, ValueError):
            return None
