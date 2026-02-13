from django.shortcuts import get_object_or_404
from django.apps import apps

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework import status

from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.models import User

from .models import UserToken, Roles
from .serializers import UserProfileSerializers
from .helpers.utility import (
    app_name,
    get_serializer_class,
    get_filtered_queryset,
    CustomPageNumberPagination
)
from .constants import UserType
from core.models import Business

# ✅ SAFE TABLE ENSURE
from ms_crm_app.helpers.ensure_tables import ensure_roles_table


# ======================================================
# GENERIC CRUD API
# ======================================================
@api_view(['GET', 'POST', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def manage_data(request, model_name, item_id=None):

    try:
        model = apps.get_model(app_name, model_name)
        serializer_class = get_serializer_class(model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        queryset = get_filtered_queryset(
            model,
            None,
            None,
            request.query_params
        ).order_by('id')

        paginator = CustomPageNumberPagination()
        page = paginator.paginate_queryset(queryset, request)
        serializer = serializer_class(page, many=True)

        return paginator.get_paginated_response(serializer.data)

    if request.method == 'POST':
        serializer = serializer_class(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'PUT':
        if not item_id:
            return Response(
                {"message": "item_id is required for update"},
                status=status.HTTP_400_BAD_REQUEST
            )

        instance = get_object_or_404(model, pk=item_id)
        serializer = serializer_class(instance, data=request.data, partial=True)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'DELETE':
        if not item_id:
            return Response(
                {"message": "item_id is required for delete"},
                status=status.HTTP_400_BAD_REQUEST
            )

        instance = get_object_or_404(model, pk=item_id)
        instance.delete()
        return Response(
            {"message": "Deleted successfully"},
            status=status.HTTP_204_NO_CONTENT
        )


# ======================================================
# AUTH
# ======================================================
@api_view(['POST'])
def login(request):
    email = request.data.get("email")
    password = request.data.get("password")

    if not email or not password:
        return Response(
            {"status": False, "message": "Email and password required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    user = authenticate(username=email, password=password)
    if not user:
        return Response(
            {"status": False, "message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    refresh = RefreshToken.for_user(user)

    # 🔥 GET BUSINESS (APPROVED ONE)
    business = Business.objects.filter(owner=user, is_approved=True).first()

    return Response({
        "status": True,
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "business_name": business.db_name if business else None,  # ✅ FIX
        "user": {
            "id": user.id,
            "email": user.email
        }
    }, status=status.HTTP_200_OK)


@api_view(['POST'])
def signup(request):
    data = request.data.copy()

    email = data.get("user_email")
    password = data.get("password")

    if not email or not password:
        return Response(
            {"message": "Email and password required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    if User.objects.filter(username=email).exists():
        return Response(
            {"message": "User already exists"},
            status=status.HTTP_400_BAD_REQUEST
        )

    auth_user = User.objects.create_user(
        username=email,
        email=email,
        password=password
    )

    data["password"] = make_password(password)
    data["user_type"] = UserType.ADMIN

    serializer = UserProfileSerializers(data=data)
    if serializer.is_valid():
        serializer.save(user_id=auth_user.id)
        return Response(
            {"message": "Signup successful"},
            status=status.HTTP_201_CREATED
        )

    auth_user.delete()
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def logout(request):
    access_token = request.data.get("accessToken")
    UserToken.objects.filter(access_token=access_token).delete()

    return Response(
        {"message": "Logout successful"},
        status=status.HTTP_200_OK
    )


# ======================================================
# ROLES API (SAFE + TENANT READY)
# ======================================================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def roles_list_create(request):

    # 🔐 TENANT HEADER REQUIRED
    if not request.headers.get("X-TENANT-DB"):
        return Response(
            {"message": "Business context missing"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # ✅ ENSURE TABLE (NO SIDE EFFECT)
    ensure_roles_table()

    if request.method == "GET":
        roles = Roles.objects.all().values(
            "roleid", "name", "permissions"
        )
        return Response(list(roles))

    if request.method == "POST":
        role = Roles.objects.create(
            name=request.data.get("name"),
            permissions=request.data.get("permissions")
        )
        return Response({
            "roleid": role.roleid,
            "name": role.name,
            "permissions": role.permissions
        }, status=status.HTTP_201_CREATED)
