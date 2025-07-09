from django.db import models
from django.utils import timezone
from .constants import UserType

# Create your models here.

class UserProfile(models.Model):
    user_id = models.IntegerField(default=0,null=True, blank=True)
    user_name = models.CharField(max_length=100)
    user_type = models.IntegerField(choices=[(tag.value, tag.name) for tag in UserType],null=True, blank=True)
    business_name = models.CharField(max_length=100)
    user_email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    password = models.CharField(max_length=128) 
    address = models.TextField(max_length=100)
    city = models.CharField(max_length=100, null=True, blank=True)
    created_by = models.IntegerField(null=True, blank=True)
    updated_by = models.IntegerField(null=True, blank=True)
    created_datetime = models.DateTimeField(default=timezone.now,null=True)
    updated_datetime = models.DateTimeField(default=timezone.now,null=True)

    def __str__(self):
        return self.user_name
    
    class Meta:
        db_table = "ms_user_profiles"

class UserToken(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    access_token = models.TextField()
    refresh_token = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.user_name} - Token"
    
    class Meta:
        db_table = "ms_user_token"

class QRCode(models.Model):
    code = models.CharField(max_length=255, unique=True)
    code_type = models.CharField(max_length=100)
    code_path = models.CharField(max_length=500, null=True, blank=True)
    isdeleted = models.BooleanField(default=False)
    created_date = models.DateTimeField(default=timezone.now)
    modified_date = models.DateTimeField(auto_now=True)
    isActive = models.BooleanField(default=True)
    reserver_1 = models.IntegerField(default=0)
    reserver_2 = models.CharField(max_length=255, null=True, blank=True)