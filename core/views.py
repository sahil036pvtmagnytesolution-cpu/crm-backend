from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth import authenticate
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
from .models import Business
from .serializers import BusinessSerializer
from django.contrib.auth.hashers import make_password
from .serializers import BusinessSerializer
from django.contrib.auth.hashers import check_password

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

    # ❌ Block duplicate signup
    if User.objects.filter(username=data['email']).exists():
        return Response(
            {"status": False, "message": "User already exists"},
            status=400
        )

    # ✅ Create Django user (LOGIN DISABLED)
    user = User.objects.create_user(
        username=data['email'],
        email=data['email'],
        password=data['password'],
        is_active=False   # 🔐 BLOCK LOGIN
    )

    # ✅ Create Business
    serializer = BusinessSerializer(data={
        "name": data["name"],
        "email": data["email"],
        "owner_name": data["owner_name"]
    })

    if serializer.is_valid():
        serializer.save()
        return Response({
            "status": True,
            "message": "Signup successful. Please wait for admin approval."
        }, status=201)

    return Response({
        "status": False,
        "errors": serializer.errors
    }, status=400)


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

    # 🔐 Password check
    if not check_password(password, user.password):
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    # 🚫 Business not approved yet
    if not user.is_active:
        return Response(
            {"message": "Business not approved by admin yet"},
            status=status.HTTP_403_FORBIDDEN
        )

    # ✅ Approved user → token generate
    refresh = RefreshToken.for_user(user)

    return Response({
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "email": user.email
        }
    }, status=status.HTTP_200_OK)