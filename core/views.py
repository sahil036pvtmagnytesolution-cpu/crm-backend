from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.core.mail import send_mail
from django.conf import settings
from .models import Business
from .serializers import BusinessSerializer

@api_view(['POST'])
def register_business(request):
    serializer = BusinessSerializer(data=request.data)
    if serializer.is_valid():
        business = serializer.save()

        # ✅ Notify superadmin
        try:
            send_mail(
                subject="New Business Registration Request",
                message=(
                    f"Business '{business.name}' was registered by {business.owner_name}.\n"
                    f"Email: {business.email}\n\nPlease login to Django Admin to approve."
                ),
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=[settings.SUPERADMIN_EMAIL],
                fail_silently=True,
            )
        except Exception as e:
            print("Email send failed:", e)

        return Response({
            "status": True,
            "message": "Business registered successfully. Awaiting superadmin approval."
        }, status=status.HTTP_201_CREATED)

    return Response({
        "status": False,
        "errors": serializer.errors
    }, status=status.HTTP_400_BAD_REQUEST)
