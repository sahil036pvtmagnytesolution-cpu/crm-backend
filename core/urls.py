from django.urls import path
from . import views

urlpatterns = [
    path('register-business/', views.register_business, name='register-business'),
]