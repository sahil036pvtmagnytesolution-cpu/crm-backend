from django.shortcuts import get_object_or_404
from rest_framework.decorators import api_view 
from rest_framework.response import Response
from rest_framework import status
from django.apps import apps
from .models import *
from .serializers import *
from .helpers.utility import app_name, get_serializer_class, get_filtered_queryset, CustomPageNumberPagination
from .helpers.auth_helper import generate_custom_tokens
from django.contrib.auth.hashers import make_password, check_password

@api_view(['GET', 'POST', 'PUT', 'DELETE'])
def manage_data(request, model_name, field=None, value=None, item_id=None):            
            
    try:
        model_class = apps.get_model(app_name, model_name)
    except LookupError:
        return Response({'error': f'Model "{model_name}" not found'}, status=status.HTTP_404_NOT_FOUND)

    try:
        serializer_class = get_serializer_class(model_name)
    except (ImportError, AttributeError) as e:
        return Response({'error': str(e)}, status=status.HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        try:
            queryset = get_filtered_queryset(model_class, field, value, request.query_params).order_by('id')

            paginator = CustomPageNumberPagination()
            paginated_qs = paginator.paginate_queryset(queryset, request)
            serializer = serializer_class(paginated_qs, many=True)

            return paginator.get_paginated_response(serializer.data)
        except Exception as e:
            return Response({'status': False, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    

    elif request.method == 'POST':
        try:
            request_data = request.data.copy() if hasattr(request.data, 'copy') else request.data
            serializer = serializer_class(data=request_data)
            if serializer.is_valid():
                serializer.save() 
                return Response({'status': True, 'data': serializer.data}, status=status.HTTP_201_CREATED)
            else:
                print(serializer.errors)
                return Response({"status": False, "message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'status': False, 'message': 'Internal Server Error', 'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    elif request.method == 'DELETE':
        try:
            queryset = None

            if item_id:
                item = get_object_or_404(model_class, pk=item_id)
                item.delete()
                return Response({'status': True, 'message': 'Item deleted successfully'})

            elif field and value:
                queryset = model_class.objects.filter(**{field: value})
            elif request.query_params:
                filters = request.query_params.dict()
                queryset = model_class.objects.filter(**filters)

            if not queryset or not queryset.exists():
                return Response({'status': False, 'message': 'No matching items found'}, status=status.HTTP_404_NOT_FOUND)
            
            delete_multiple = False
            try:
                delete_multiple = request.data.get('delete_multiple', False)
            except Exception:
                pass

            if delete_multiple:
                count, _ = queryset.delete()
                return Response({'status': True, 'message': f'{count} items deleted successfully'}, status=status.HTTP_200_OK)
            elif queryset.count() > 1:
                return Response({'status': False, 'message': 'Multiple items matched. Set delete_multiple=true to confirm bulk delete.'}, status=status.HTTP_400_BAD_REQUEST)
            else:
                queryset.first().delete()
                return Response({'status': True, 'message': 'Item deleted successfully'})

        except Exception as e:
            return Response({'status': False, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    elif request.method == 'PUT':
        try:
            request_data = request.data.copy() if hasattr(request.data, 'copy') else request.data
            update_multiple = request_data.pop('update_multiple', False)

            queryset = None

            if item_id:
                queryset = model_class.objects.filter(pk=item_id)
            elif field and value:
                queryset = model_class.objects.filter(**{field: value})
            elif request.query_params:
                filters = request.query_params.dict()
                queryset = model_class.objects.filter(**filters)
            else:
                return Response({'status': False, 'message': 'Missing item_id or field/value pair or query filters'}, status=status.HTTP_400_BAD_REQUEST)

            if not queryset.exists():
                return Response({'status': False, 'message': 'No matching items found'}, status=status.HTTP_404_NOT_FOUND)

            if update_multiple:
                updated_count = 0
                for instance in queryset:
                    serializer = serializer_class(instance, data=request_data, partial=True)
                    if serializer.is_valid():
                        serializer.save()
                        updated_count += 1
                    else:
                        return Response({
                            'status': False,
                            'message': 'Validation failed on one or more records',
                            'errors': serializer.errors
                        }, status=status.HTTP_400_BAD_REQUEST)

                return Response({'status': True, 'message': f'{updated_count} items updated successfully'}, status=status.HTTP_200_OK)

            if queryset.count() > 1:
                return Response({
                    'status': False,
                    'message': 'Multiple items matched. Set "update_multiple": true to update all.'
                }, status=400)

            instance = queryset.first()
            serializer = serializer_class(instance, data=request_data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response({'status': True, 'message': 'Item updated successfully'}, status=status.HTTP_200_OK)
            else:
                return Response({'status': False, 'errors': serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return Response({'status': False, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
def login(request):
    try:
        user_email = request.data.get('user_email')
        user_password = request.data.get('password')
        if not user_email or not user_password:
            return Response({'status': False, 'message': 'Email and password required'}, status=status.HTTP_400_BAD_REQUEST)

        userInstance = UserProfile.objects.filter(user_email=user_email).first()
        if userInstance and check_password(user_password, userInstance.password):
            UserToken.objects.filter(user=userInstance).delete()
            tokens = generate_custom_tokens(userInstance)

            UserToken.objects.create(
                user=userInstance,
                access_token=tokens["access"],
                refresh_token=tokens["refresh"]
            )

            userSerilizer = UserProfileSerializers(userInstance)

            return Response({'status': True, 'message': 'Login successful', 'token': tokens['access'], 'userData': userSerilizer.data}, status=status.HTTP_200_OK)
        else:
            return Response({'status': False, 'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

    except Exception as e:
        return Response({'status': False, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
def signup(request):
    try:
        user_id= request.data.get('user_id')
        created_by_ID =  request.data.get('created_by_ID')
        updated_by_ID =  request.data.get('updated_by_ID')
        created_datetime =  request.data.get('created_datetime')
        updated_datetime =  request.data.get('updated_datetime')
        user_name = request.data.get('user_name')
        business_name = request.data.get('business_name')
        user_email = request.data.get('user_email')
        contact_number = request.data.get('contact_number')
        password = request.data.get('password')
        address = request.data.get('address')
        city = request.data.get('city')

        if not all([user_name, business_name, user_email, contact_number, password, address, city]):
            return Response({'status': False, 'message': 'All fields are required'}, status=status.HTTP_400_BAD_REQUEST)

        if UserProfile.objects.filter(user_email=user_email).exists():
            return Response({'status': False, 'message': 'User already exists'}, status=status.HTTP_400_BAD_REQUEST)

        user = UserProfile.objects.create(
            user_id=user_id,
            user_name=user_name,
            user_type = UserType.ADMIN,
            business_name=business_name,
            user_email=user_email,
            contact_number=contact_number,
            password=make_password(password),  # Hash password
            address=address,
            city=city,
            created_by_ID=created_by_ID,
            updated_by_ID=updated_by_ID,
            created_datetime=created_datetime,
            updated_datetime=updated_datetime
        )

        return Response({'status': True, 'message': 'Signup successful'}, status=status.HTTP_201_CREATED)

    except Exception as e:
        return Response({'status': False, 'message': 'Internal Server Error', 'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    # Handle Logout (Clears session)
@api_view(['POST'])
def logout(request):
    try:
        access_token = request.data["accessToken"] 
        UserToken.objects.filter(access_token=access_token).delete()

        return Response({'status': True, "message": "Logout successful"}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({"message": "Invalid token"}, status=400)
