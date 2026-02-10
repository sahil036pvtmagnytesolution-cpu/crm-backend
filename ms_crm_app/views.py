from django.shortcuts import get_object_or_404
from django.apps import apps

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status

from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken
from .models import UserToken
from .serializers import UserProfileSerializers
from .helpers.utility import (
    app_name,
    get_serializer_class,
    get_filtered_queryset,
    CustomPageNumberPagination
)
from .constants import UserType
from core.models import Business


@api_view(['GET', 'POST', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def manage_data(request, model_name, item_id=None):

    # 🔍 Model + Serializer resolve
    try:
        model = apps.get_model(app_name, model_name)
        serializer_class = get_serializer_class(model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    # ---------- GET ----------
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

    # ---------- POST ----------
    if request.method == 'POST':
        serializer = serializer_class(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # ---------- PUT ----------
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

    # ---------- DELETE ----------
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
    
    # JWT TOKEN GENERATION🗝️
    refresh = RefreshToken.for_user(user)

    return Response({
        "status": True,   # 🔥 IMPORTANT
        "access": str(refresh.access_token),
        "refresh": str(refresh),
        "user": {
            "id": user.id,
            "email": user.email
        }
    }, status=status.HTTP_200_OK)


from django.contrib.auth.models import User

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

    # ❌ duplicate check
    if User.objects.filter(username=email).exists():
        return Response(
            {"message": "User already exists"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # ✅ CREATE DJANGO AUTH USER
    auth_user = User.objects.create_user(
        username=email,
        email=email,
        password=password
    )

    # ✅ CREATE USER PROFILE
    data["password"] = make_password(password)
    data["user_type"] = UserType.ADMIN

    serializer = UserProfileSerializers(data=data)
    if serializer.is_valid():
        serializer.save(user_id=auth_user.id)
        return Response(
            {"message": "Signup successful"},
            status=status.HTTP_201_CREATED
        )

    # rollback auth user if profile fails
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
