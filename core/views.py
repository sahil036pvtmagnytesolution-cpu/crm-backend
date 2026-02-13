from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import check_password
from rest_framework_simplejwt.tokens import RefreshToken
from django.db import transaction

from .models import Business
from .serializers import BusinessSerializer
from core.seeders.email_templates import seed_email_templates_optimized

from rest_framework.decorators import api_view
from .models import Role
from .serializers import RoleSerializer

import threading


# =========================
# ASYNC HELPER
# =========================
def run_async(func, *args):
    """
    🔥 Simple non-blocking runner
    Request complete hone ke baad
    background me kaam karega
    """
    t = threading.Thread(target=func, args=args)
    t.daemon = True
    t.start()


# =========================
# REGISTER BUSINESS
# =========================
@api_view(['POST'])
def register_business(request):
    data = request.data

    # 🔹 ultra-fast validation
    for field in ('name', 'email', 'owner_name', 'password'):
        if not data.get(field):
            return Response(
                {"status": False, "message": f"{field} is required"},
                status=400
            )

    if User.objects.filter(username=data['email']).exists():
        return Response(
            {"status": False, "message": "User already exists"},
            status=400
        )

    with transaction.atomic():

        # 🔥 FAST USER CREATE (no serializer)
        user = User(
            username=data['email'],
            email=data['email'],
            is_active=False
        )
        user.set_password(data['password'])   # hashing (still needed)
        user.save()

        # 🔥 FAST BUSINESS CREATE (NO SERIALIZER)
        Business.objects.create(
            name=data['name'],
            email=data['email'],
            owner_name=data['owner_name']
        )

    # 🚀 BACKGROUND WORK
    run_async(seed_email_templates_optimized)

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

    # 🔥 IMPORTANT: approval check FIRST
    if not user.is_active:
        return Response(
            {"message": "Business not approved by admin yet"},
            status=status.HTTP_403_FORBIDDEN
        )

    # password check AFTER approval
    if not check_password(password, user.password):
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    refresh = RefreshToken.for_user(user)

    return Response({
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "email": user.email
        }
    }, status=status.HTTP_200_OK)

# =========================
# GET + CREATE ROLES
# =========================
@api_view(["GET", "POST"])
def roles_api(request):

    if request.method == "GET":
        roles = Role.objects.all()
        serializer = RoleSerializer(roles, many=True)
        return Response(serializer.data, status=200)

    if request.method == "POST":
        serializer = RoleSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()   # is_approved = False (Pending)
            return Response(
                {"success": True, "message": "Role created"},
                status=201
            )
        return Response(serializer.errors, status=400)


# =========================
# APPROVE ROLE (ADMIN)
# =========================
@api_view(["PATCH"])
def approve_role(request, pk):
    try:
        role = Role.objects.get(id=pk)
        role.is_approved = True
        role.save()
        return Response(
            {"success": True, "message": "Role approved"},
            status=200
        )
    except Role.DoesNotExist:
        return Response(
            {"success": False, "message": "Role not found"},
            status=404
        )