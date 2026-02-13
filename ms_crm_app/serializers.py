from rest_framework import serializers;
from .models import *;
from .models import Roles

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