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

    user = authenticate(username=email, password=password)

    if user is None:
        return Response({"message": "Invalid credentials"}, status=401)

    if not user.is_active:
        return Response(
            {"message": "Business not approved by admin yet"},
            status=403
        )

    refresh = RefreshToken.for_user(user)

    return Response({
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "email": user.email
        }
    })