from rest_framework import serializers
from .models import Business, Role, Proposal
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User
from core.models import Proposal
from .models import Proposal

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
        items = validated_data.pop("items", [])
        proposal = Proposal.objects.create(**validated_data)

        proposal.items = items
        proposal.total = self.calculate_total(
            items,
            proposal.discount_total,
            proposal.adjustment
        )
        proposal.save()
        return proposal

    # ✅ UPDATE METHOD
    def update(self, instance, validated_data):
        items = validated_data.pop("items", instance.items)

        for attr, value in validated_data.items():
            setattr(instance, attr, value)

        instance.items = items
        instance.total = self.calculate_total(
            items,
            instance.discount_total,
            instance.adjustment
        )
        instance.save()
        return instance

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