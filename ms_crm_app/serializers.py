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