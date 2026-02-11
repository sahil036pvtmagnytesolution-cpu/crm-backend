from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import check_password
from rest_framework_simplejwt.tokens import RefreshToken
from django.db import transaction

from .models import Business
from .serializers import BusinessSerializer
from .seeders.email_templates import seed_email_templates_optimized


# =========================
# REGISTER BUSINESS
# =========================
@api_view(['POST'])
def register_business(request):
    data = request.data.copy()
    
    required_fields = ['name', 'email', 'owner_name', 'password']
    for field in required_fields:
        if not data.get(field):
            return Response(
                {"status": False, "message": f"{field} is required"},
                status=400
            )

    # ❌ Duplicate user block
    if User.objects.filter(username=data['email']).exists():
        return Response(
            {"status": False, "message": "User already exists"},
            status=400
        )

    with transaction.atomic():

        # 🔹 CREATE USER (LOGIN BLOCKED)
        user = User.objects.create_user(
            username=data['email'],
            email=data['email'],
            password=data['password'],
            is_active=False
        )

        # 🔹 CREATE BUSINESS
        serializer = BusinessSerializer(data={
            "name": data["name"],
            "email": data["email"],
            "owner_name": data["owner_name"]
        })

        if not serializer.is_valid():
            return Response(
                {"status": False, "errors": serializer.errors},
                status=400
            )

        business = serializer.save()

    # 🔥 NON-BLOCKING HEAVY TASK
    try:
        seed_email_templates_optimized()
    except Exception as e:
        print("Email template seed failed:", e)

    return Response({
        "status": True,
        "message": "Signup successful. Please wait for admin approval."
    }, status=201)


# =========================
# LOGIN
# =========================
@api_view(['POST'])
def login(request):
    email = request.data.get("email")
    password = request.data.get("password")

    try:
        user = User.objects.get(username=email)
    except User.DoesNotExist:
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    if not check_password(password, user.password):
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    if not user.is_active:
        return Response(
            {"message": "Business not approved by admin yet"},
            status=status.HTTP_403_FORBIDDEN
        )

    refresh = RefreshToken.for_user(user)

    return Response({
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "email": user.email
        }
    }, status=status.HTTP_200_OK)
