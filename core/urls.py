from django.urls import path
from .views import register_business

urlpatterns = [
    path('register-business/', register_business, name='register-business'),
    path('register_business/', register_business, name='register_business'),
]
