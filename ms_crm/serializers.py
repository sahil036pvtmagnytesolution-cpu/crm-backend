from rest_framework import serializers;
from .models import *;

class UserProfileSerializers(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = '__all__'

class QRCodeSerializers(serializers.ModelSerializer):   
    class Meta:
        model = QRCode
        fields = '__all__'