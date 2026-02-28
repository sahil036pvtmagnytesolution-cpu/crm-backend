from django.contrib.auth.models import User
from django.contrib.auth.hashers import check_password
from django.db import transaction
import threading

from django.core.mail import send_mail
from django.conf import settings
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken

from .models import Business, Role, Proposal, StaffProfile
from .serializers import BusinessSerializer, RoleSerializer, ProposalSerializer
from core.seeders.email_templates import seed_email_templates_optimized
from rest_framework.permissions import AllowAny
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from rest_framework.viewsets import ModelViewSet
from .models import Expense
from .serializers import ExpenseSerializer

from django.contrib import admin
from .models import Expense

from rest_framework import viewsets
from .models import Lead
from .serializers import LeadSerializer

from .models import Client
from .serializers import ClientSerializer

from rest_framework import viewsets, status
from .models import Client
from .serializers import ClientSerializer
from rest_framework.permissions import AllowAny

from rest_framework import generics
from rest_framework.response import Response
from rest_framework import status
from .models import Estimate
from .serializers import EstimateSerializer

from .models import CalendarEvent
from .serializers import CalendarEventSerializer

from .models import Proposal
from .serializers import ProposalSerializer

class ProposalViewSet(ModelViewSet):
    queryset = Proposal.objects.all()
    serializer_class = ProposalSerializer

class EstimateViewSet(ModelViewSet):
    queryset = Estimate.objects.all()
    serializer_class = EstimateSerializer

class CalendarEventViewSet(ModelViewSet):
    queryset = CalendarEvent.objects.all()
    serializer_class = CalendarEventSerializer

class EstimateListCreateView(generics.ListCreateAPIView):
    queryset = Estimate.objects.all()
    serializer_class = EstimateSerializer

class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all()
    serializer_class = ClientSerializer
    permission_classes = [AllowAny]

class LeadViewSet(viewsets.ModelViewSet):
    queryset = Lead.objects.all().order_by("-id")
    serializer_class = LeadSerializer

class SmallStatsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        data = {
            "users": 10,
            "sales": 25,
            "revenue": 50000,
        }
        return Response(data)

# =========================
# ASYNC HELPER
# =========================
def run_async(func, *args):
    t = threading.Thread(target=func, args=args)
    t.daemon = True
    t.start()


class ExpenseViewSet(ModelViewSet):
    queryset = Expense.objects.all().order_by('-id')
    serializer_class = ExpenseSerializer

# =========================
# REGISTER BUSINESS
# =========================
@api_view(["POST"])
@permission_classes([AllowAny])
def register_business(request):

    data = request.data

    for field in ("name", "email", "owner_name", "password"):
        if not data.get(field):
            return Response(
                {"status": False, "message": f"{field} is required"},
                status=400,
            )

    if User.objects.filter(username=data["email"]).exists():
        return Response(
            {"status": False, "message": "User already exists"},
            status=400,
        )

    with transaction.atomic():
        user = User(
            username=data["email"],
            email=data["email"],
            is_active=False,
        )
        user.set_password(data["password"])
        user.save()

        Business.objects.create(
            name=data["name"],
            email=data["email"],
            owner_name=data["owner_name"],
        )

    run_async(seed_email_templates_optimized)

    return Response(
        {
            "status": True,
            "message": "Signup successful. Please wait for admin approval.",
        },
        status=201,
    )


# =========================
# LOGIN (JWT)
# =========================
@api_view(["POST"])
@permission_classes([AllowAny])
def login(request):

    email = request.data.get("email")
    password = request.data.get("password")

    try:
        user = User.objects.get(username=email)
    except User.DoesNotExist:
        return Response({"message": "Invalid credentials"}, status=401)

    if not user.is_active:
        return Response(
            {"message": "Business not approved by admin yet"},
            status=403,
        )

    if not check_password(password, user.password):
        return Response({"message": "Invalid credentials"}, status=401)

    refresh = RefreshToken.for_user(user)

    return Response(
        {
            "access_token": str(refresh.access_token),
            "refresh_token": str(refresh),
            "user": {
                "id": user.id,
                "email": user.email,
                "is_superuser": user.is_superuser,
            },
        },
        status=200,
    )


# =========================
# ROLES API (UNCHANGED)
# =========================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def roles_api(request):
    if request.method == "GET":
        roles = Role.objects.all().order_by("-id")
        serializer = RoleSerializer(roles, many=True)
        return Response(serializer.data, status=200)

    serializer = RoleSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(
            {"success": True, "message": "Role created"},
            status=201,
        )
    return Response(serializer.errors, status=400)


# =========================
# APPROVE ROLE (UNCHANGED)
# =========================
@api_view(["PATCH"])
@permission_classes([IsAuthenticated])
def approve_role(request, pk):
    try:
        role = Role.objects.get(id=pk)
        role.is_approved = True
        role.save()
        return Response(
            {"success": True, "message": "Role approved"},
            status=200,
        )
    except Role.DoesNotExist:
        return Response(
            {"success": False, "message": "Role not found"},
            status=404,
        )


# =========================
# SALES LIST
# =========================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def sales_proposals(request):
    proposals = Proposal.objects.all().order_by("-id")
    serializer = ProposalSerializer(proposals, many=True)
    return Response(serializer.data, status=200)

# =========================
# ASSIGN PROPOSAL
# =========================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def assign_proposal(request, pk):
    try:
        proposal = Proposal.objects.get(pk=pk)
    except Proposal.DoesNotExist:
        return Response({"error": "Proposal not found"}, status=404)

    user_id = request.data.get("user_id")

    if user_id is None:
        proposal.assigned_to = None
    else:
        try:
            user = User.objects.get(pk=user_id)
            proposal.assigned_to = user
        except User.DoesNotExist:
            return Response({"error": "User not found"}, status=404)

    proposal.save()
    return Response({"message": "Assigned successfully"})


# =========================
# CREATE PROPOSAL
# =========================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def create_proposal(request):
    serializer = ProposalSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save(created_by=request.user)
        return Response(serializer.data, status=201)
    return Response(serializer.errors, status=400)


# =========================
# PROPOSAL DETAIL (GET + PUT + DELETE)
# =========================
@api_view(["GET", "PUT", "DELETE"])
@permission_classes([IsAuthenticated])
def proposal_detail(request, pk):
    try:
        proposal = Proposal.objects.get(id=pk)
    except Proposal.DoesNotExist:
        return Response({"error": "Proposal not found"}, status=404)

    if request.method == "GET":
        serializer = ProposalSerializer(proposal)
        return Response(serializer.data)

    if request.method == "PUT":
        serializer = ProposalSerializer(proposal, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=400)

    if request.method == "DELETE":
        proposal.delete()
        return Response({"message": "Deleted successfully"}, status=200)

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def users_list(request):
    users = User.objects.all()[:5]   # ✅ only 5 users
    data = [{"id": u.id, "name": u.username} for u in users]
    return Response(data)


# ==============================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard_overview(request):
    total_proposals = Proposal.objects.count()
    total_users = User.objects.count()

    return Response({
        "total_proposals": total_proposals,
        "total_users": total_users,
    })



@api_view(["GET"])
@permission_classes([IsAuthenticated])
def small_stats(request):
    data = [
        {"title": "Total Sales", "val": "₹0", "pct": 0, "color": "#28a745"},
        {"title": "Total Leads", "val": "0", "pct": 0, "color": "#17a2b8"},
        {"title": "Projects", "val": "0", "pct": 0, "color": "#ffc107"},
        {"title": "Tasks", "val": "0", "pct": 0, "color": "#dc3545"},
    ]
    return Response(data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard_overview(request):
    return Response([])


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def leads_overview(request):
    return Response({
        "labels": ["New", "Contacted", "Qualified"],
        "data": [5, 3, 2],
        "colors": ["#007bff", "#28a745", "#ffc107"]
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def project_status(request):
    return Response({
        "labels": ["Pending", "Completed"],
        "data": [4, 6],
        "colors": ["#dc3545", "#28a745"]
    })


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def weekly_payments(request):
    return Response({
        "labels": ["Mon", "Tue", "Wed", "Thu", "Fri"],
        "datasets": [
            {
                "label": "Payments",
                "data": [0, 0, 0, 0, 0]
            }
        ]
    })

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard_activity(request):
    return Response([
        {
            "time": "10:30 AM",
            "text": "New proposal created",
            "project": "Website Development",
            "status": "New",
        },
        {
            "time": "12:15 PM",
            "text": "Lead converted",
            "project": "CRM System",
            "status": "Completed",
        },
    ])

# =========================Customer API=========================
class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all()
    serializer_class = ClientSerializer
    permission_classes = [AllowAny]

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        if not serializer.is_valid():
            print("❌ SERIALIZER ERROR:", serializer.errors)  # 👈 Important
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        self.perform_create(serializer)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
# =========================Email SetView=========================
    