from rest_framework import serializers
from .models import Business, Role


class BusinessSerializer(serializers.ModelSerializer):
    class Meta:
        model = Business
        fields = "__all__"
        read_only_fields = ["is_approved", "db_name", "created_at"]


class RoleSerializer(serializers.ModelSerializer):
    status = serializers.SerializerMethodField()

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

    # ✅ ADD THIS (NO EXISTING CODE TOUCHED)
    def create(self, validated_data):
        """
        Frontend se is_approved nahi aata,
        to yahan default set kar rahe hain
        """
        validated_data.setdefault("is_approved", True)
        validated_data.setdefault("permissions", "")
        return super().create(validated_data)
