from rest_framework import serializers
from .models import Business, Role
from .models import Proposal
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import User

class BusinessSerializer(serializers.ModelSerializer):
    class Meta:
        model = Business
        fields = "__all__"
        read_only_fields = ["is_approved", "db_name", "created_at"]


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

    # ✅ ADD THIS (KEY FIX)
    def validate_permissions(self, value):
        if not value or not value.strip():
            return "Basic"   # default permission
        return value

class ProposalSerializer(serializers.ModelSerializer):
    assigned_to_name = serializers.CharField(
        source="assigned_to.username",
        read_only=True
    )

    class Meta:
        model = Proposal
        fields = "__all__"

class ProposalSerializer(serializers.ModelSerializer):
    class Meta:
        model = Proposal
        fields = "__all__"
        read_only_fields = ["id", "created_by", "created_at"]


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
