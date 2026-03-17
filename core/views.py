import email

from django.contrib.auth.models import User
from django.contrib.auth.hashers import check_password, make_password
from django.db import transaction
import threading

from django.core.mail import send_mail
from django.conf import settings
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import MultiPartParser, FormParser

from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken

from .models import Business, Customer, Item, ItemGroup, Role, Proposal, StaffProfile
from ms_crm_app.models import Staff, KnowledgeBase, KnowledgeBaseGroups
from ms_crm_app.helpers.ensure_tables import ensure_project_tables, ensure_knowledge_base_tables
from ms_crm_app.helpers.ensure_tables import ensure_staff_table
from .serializers import BusinessSerializer, RoleSerializer, ProposalSerializer, StaffSerializer
from core.seeders.email_templates import seed_email_templates_optimized
from rest_framework.permissions import AllowAny
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from rest_framework.viewsets import ModelViewSet
from .models import Expense
from .serializers import ExpenseSerializer
from .models import (
    Contract,
    ContractType,
    ContractAttachment,
    ContractComment,
    ContractRenewal,
    ContractTask,
    ContractNote,
)
from .serializers import (
    ContractSerializer,
    ContractTypeSerializer,
    ContractAttachmentSerializer,
    ContractCommentSerializer,
    ContractRenewalSerializer,
    ContractTaskSerializer,
    ContractNoteSerializer,
)

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

from rest_framework.views import APIView
from django.contrib.auth import get_user_model
from rest_framework.response import Response

from django.core.mail import EmailMultiAlternatives
from django.utils.html import strip_tags
from django.utils.encoding import force_bytes
from django.core.mail import EmailMessage
from django.contrib.staticfiles import finders
from django.core.files.base import ContentFile
from django.core.mail import get_connection
from email.mime.image import MIMEImage
import os
import pandas as pd
from django.utils import timezone
from .models import EmailCampaign, EmailRecipient
from .models import Invoice
from .serializers import InvoiceSerializer
from .models import InvoiceTask, InvoiceReminder
from .serializers import ( InvoiceSerializer, InvoiceReminderSerializer, InvoiceTaskSerializer )
from django.core.mail import EmailMessage
from .models import InvoiceEmailLog
from .serializers import InvoiceEmailLogSerializer
from .models import Invoice, InvoiceEmailLog
from rest_framework.permissions import AllowAny
from .models import InvoicePayment
from .serializers import InvoicePaymentSerializer
from .models import Client, Contact, CreditNote, CreditNoteReminder, CreditNoteTask, Estimate, Invoice
from rest_framework.authentication import SessionAuthentication
from rest_framework_simplejwt.authentication import JWTAuthentication
from .serializers import ContactSerializer
from .serializers import CreditNoteReminderSerializer, CreditNoteSerializer, CreditNoteTaskSerializer
from .serializers import ItemGroupSerializer, ItemSerializer
from .item_master import sync_item_to_master, sync_items_to_master
from .models import Project
from .serializers import ProjectSerializer
from django.db.models import Count, Sum
from django.db.utils import OperationalError, ProgrammingError
from django.utils.text import slugify

class ApprovedUsersView(APIView):

    def get(self, request):
        User = get_user_model()

        users = User.objects.filter(is_active=True)

        data = [
            {
                "id": u.id,
                "name": u.first_name or u.username,
                "email": u.email,
            }
            for u in users
        ]

        return Response(data)

class ProposalViewSet(ModelViewSet):
    queryset = Proposal.objects.all()
    serializer_class = ProposalSerializer
     # ================= ASSIGN + EMAIL =================
    @action(detail=True, methods=['post'])
    def assign(self, request, pk=None):

        print("ASSIGN API HIT")

        proposal = self.get_object()
        user_id = request.data.get("user_id")

        if not user_id:
            proposal.assigned_to = None
            proposal.save()
            return Response({"message": "Unassigned successfully"})

        try:
            User = get_user_model()
            user = User.objects.get(id=user_id)

            proposal.assigned_to = user
            proposal.save()

            print("SENDING MAIL TO:", user.email)  # 👈 Debug print

            # ===== SEND EMAIL =====
            subject = f"New Proposal Assigned - #{proposal.id}"

            message = f"""
Hello {user.first_name or user.username},

You have been assigned a new proposal.

Proposal ID: {proposal.id}
Subject: {proposal.subject}
Total: ₹{proposal.total}

Please login to CRM to review it.

Regards,
CRM Team
            """

            send_mail(
                subject,
                message,
                settings.DEFAULT_FROM_EMAIL,
                [user.email],
                fail_silently=False,
            )

            return Response(
                {"message": "Assigned & Email Sent Successfully"}
            )

        except Exception as e:
            return Response(
                {"error": str(e)},
                status=status.HTTP_400_BAD_REQUEST
            )

class EstimateViewSet(ModelViewSet):

    queryset = Estimate.objects.filter(customer__is_active=True)
    serializer_class = EstimateSerializer
    # ================ Create Estimate =================
    def perform_create(self, serializer):
        estimate = serializer.save()
        create_invoice_from_estimate(estimate)
    # ================ Update Estimate =================
    def perform_update(self, serializer):
        estimate = serializer.save()
        create_invoice_from_estimate(estimate)

    # ================= CREATE INVOICE =================
    def create_invoice(self, estimate):

        # 🔹 Only run when status = Sent
        if estimate.status != "Sent":
            return

        # 🔹 Check invoice already exists (duplicate रोकने के लिए)
        existing_invoice = Invoice.objects.filter(
            reference_estimate=estimate
        ).first()

        if existing_invoice:
            return

        # 🔹 Find client
        client = estimate.customer

        if not client:
            print("⚠ Client not found")
            return

        # 🔹 Create invoice
        invoice = Invoice.objects.create(
            invoice_number=f"INV-{estimate.id}",
            customer=client,
            invoice_date=estimate.date,
            due_date=estimate.expiry_date,
            subtotal=estimate.amount,
            total_amount=estimate.amount,
            status="Unpaid",
            reference_estimate=estimate
        )

        print("✅ Invoice created:", invoice.invoice_number)

        # 🔹 Update estimate status
        estimate.status = "Approved"
        estimate.save()

        print("✅ Estimate status updated to Approved")

class CalendarEventViewSet(ModelViewSet):
    queryset = CalendarEvent.objects.all()
    serializer_class = CalendarEventSerializer

class EstimateListCreateView(generics.ListCreateAPIView):
    queryset = Estimate.objects.all()
    serializer_class = EstimateSerializer

class ClientViewSet(viewsets.ModelViewSet):
    queryset = Client.objects.all().order_by("-id")
    serializer_class = ClientSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class LeadViewSet(viewsets.ModelViewSet):
    queryset = Lead.objects.all().order_by("-id")
    serializer_class = LeadSerializer


class ProjectViewSet(ModelViewSet):
    queryset = Project.objects.all().select_related("client").prefetch_related("members").order_by("-id")
    serializer_class = ProjectSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def _missing_table_error(self):
        return Response(
            {
                "detail": "Projects table not found. Run backend migrations (core 0044_project).",
            },
            status=status.HTTP_503_SERVICE_UNAVAILABLE,
        )

    def _handle_missing_table(self, exc, *, empty_ok: bool):
        msg = str(exc)
        if "core_project" in msg and ("doesn't exist" in msg or "1146" in msg):
            # Table not created yet (migration not applied).
            return Response([]) if empty_ok else self._missing_table_error()
        return None

    def get_queryset(self):
        try:
            ensure_project_tables()
        except Exception as exc:
            print("Project table ensure failed:", exc)
        qs = super().get_queryset()

        client_id = (
            self.request.query_params.get("clientid")
            or self.request.query_params.get("client")
        )
        if client_id:
            try:
                qs = qs.filter(client_id=int(client_id))
            except (TypeError, ValueError):
                pass

        return qs

    def list(self, request, *args, **kwargs):
        try:
            ensure_project_tables()
            return super().list(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=True)
            if handled is not None:
                return handled
            raise

    def create(self, request, *args, **kwargs):
        try:
            ensure_project_tables()
            return super().create(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def perform_create(self, serializer):
        project = serializer.save(created_by=getattr(self.request, "user", None))

        if not getattr(project, "send_email", False):
            return

        mentor = getattr(project, "mentor", None) or getattr(project, "created_by", None)
        recipients = set()

        if mentor and getattr(mentor, "email", None):
            recipients.add(mentor.email)

        for member in project.members.all():
            if getattr(member, "email", None):
                recipients.add(member.email)

        recipients = [e for e in recipients if e]
        if not recipients:
            return

        client_name = getattr(getattr(project, "client", None), "company", None) or "-"
        start_date = project.start_date.isoformat() if project.start_date else "-"
        deadline = project.deadline.isoformat() if project.deadline else "-"
        mentor_name = _user_display(mentor) if mentor else "-"
        member_names = ", ".join([_user_display(m) for m in project.members.all()]) or "-"
        visible_tabs = ", ".join(project.visible_tabs or []) or "-"
        settings_list = "<br/>".join([f"• {s}" for s in (project.settings or [])]) or "-"

        subject = f"New Project Created: {project.name}"
        html_message = f"""
<h3>New project created</h3>
<p><b>Project:</b> {project.name}</p>
<p><b>Customer:</b> {client_name}</p>
<p><b>Mentor:</b> {mentor_name}</p>
<p><b>Members:</b> {member_names}</p>
<p><b>Status:</b> {project.status}</p>
<p><b>Start:</b> {start_date}</p>
<p><b>Deadline:</b> {deadline}</p>
<p><b>Visible Tabs:</b> {visible_tabs}</p>
<p><b>Project Settings:</b><br/>{settings_list}</p>
<hr/>
{project.description or ""}
"""
        message = strip_tags(html_message)

        try:
            send_mail(
                subject,
                message,
                settings.DEFAULT_FROM_EMAIL,
                recipients,
                fail_silently=False,
                html_message=html_message,
            )
        except Exception as e:
            # Don't fail project creation because of email.
            print("Project email failed:", e)

    @action(detail=True, methods=["post"])
    def send_created_email(self, request, pk=None):
        project = self.get_object()

        mentor = getattr(project, "mentor", None) or getattr(project, "created_by", None)
        recipients = set()

        if mentor and getattr(mentor, "email", None):
            recipients.add(mentor.email)

        for member in project.members.all():
            if getattr(member, "email", None):
                recipients.add(member.email)

        recipients = [e for e in recipients if e]
        if not recipients:
            return Response({"detail": "No recipient emails found."}, status=status.HTTP_400_BAD_REQUEST)

        client_name = getattr(getattr(project, "client", None), "company", None) or "-"
        start_date = project.start_date.isoformat() if project.start_date else "-"
        deadline = project.deadline.isoformat() if project.deadline else "-"
        mentor_name = _user_display(mentor) if mentor else "-"
        member_names = ", ".join([_user_display(m) for m in project.members.all()]) or "-"
        visible_tabs = ", ".join(project.visible_tabs or []) or "-"
        settings_list = "<br/>".join([f"• {s}" for s in (project.settings or [])]) or "-"

        subject = f"New Project Created: {project.name}"
        html_message = f"""
<h3>New project created</h3>
<p><b>Project:</b> {project.name}</p>
<p><b>Customer:</b> {client_name}</p>
<p><b>Mentor:</b> {mentor_name}</p>
<p><b>Members:</b> {member_names}</p>
<p><b>Status:</b> {project.status}</p>
<p><b>Start:</b> {start_date}</p>
<p><b>Deadline:</b> {deadline}</p>
<p><b>Visible Tabs:</b> {visible_tabs}</p>
<p><b>Project Settings:</b><br/>{settings_list}</p>
<hr/>
{project.description or ""}
"""
        message = strip_tags(html_message)

        try:
            send_mail(
                subject,
                message,
                settings.DEFAULT_FROM_EMAIL,
                recipients,
                fail_silently=False,
                html_message=html_message,
            )
        except Exception as e:
            return Response({"detail": f"Email failed: {e}"}, status=status.HTTP_400_BAD_REQUEST)

        return Response({"message": "Email sent", "recipients": recipients})

    @action(detail=False, methods=["get"])
    def summary(self, request):
        try:
            qs = self.get_queryset()
            summary = (
                qs.values("status")
                .annotate(count=Count("id"), total_rate=Sum("total_rate"))
                .order_by("status")
            )
            return Response(list(summary))
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=True)
            if handled is not None:
                return handled
            raise

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
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


class ContractTypeViewSet(ModelViewSet):
    queryset = ContractType.objects.all().order_by("name", "id")
    serializer_class = ContractTypeSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]


def _user_display(user):
    return (
        getattr(user, "username", None)
        or getattr(user, "email", None)
        or getattr(user, "get_username", lambda: "")()
        or str(user)
    )


class _ContractChildFilterMixin:
    contract_query_param = "contract"

    def filter_by_contract(self, qs):
        contract_id = self.request.query_params.get(self.contract_query_param)
        if contract_id:
            return qs.filter(contract_id=contract_id)
        return qs.none()


class ContractAttachmentViewSet(_ContractChildFilterMixin, ModelViewSet):
    queryset = ContractAttachment.objects.all().order_by("-uploaded_at", "-id")
    serializer_class = ContractAttachmentSerializer
    parser_classes = [MultiPartParser, FormParser]
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return self.filter_by_contract(super().get_queryset())

    def get_serializer_context(self):
        ctx = super().get_serializer_context()
        ctx["request"] = self.request
        return ctx

    def perform_create(self, serializer):
        serializer.save(uploaded_by=_user_display(self.request.user))


class ContractCommentViewSet(_ContractChildFilterMixin, ModelViewSet):
    queryset = ContractComment.objects.all().order_by("-created_at", "-id")
    serializer_class = ContractCommentSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return self.filter_by_contract(super().get_queryset())

    def perform_create(self, serializer):
        serializer.save(created_by=_user_display(self.request.user))


class ContractNoteViewSet(_ContractChildFilterMixin, ModelViewSet):
    queryset = ContractNote.objects.all().order_by("-created_at", "-id")
    serializer_class = ContractNoteSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return self.filter_by_contract(super().get_queryset())

    def perform_create(self, serializer):
        serializer.save(created_by=_user_display(self.request.user))


class ContractTaskViewSet(_ContractChildFilterMixin, ModelViewSet):
    queryset = ContractTask.objects.all().order_by("-created_at", "-id")
    serializer_class = ContractTaskSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return self.filter_by_contract(super().get_queryset())

    def perform_create(self, serializer):
        serializer.save(created_by=_user_display(self.request.user))


class ContractRenewalViewSet(_ContractChildFilterMixin, ModelViewSet):
    queryset = ContractRenewal.objects.all().order_by("-renewed_at", "-id")
    serializer_class = ContractRenewalSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return self.filter_by_contract(super().get_queryset())

    def perform_create(self, serializer):
        contract = serializer.validated_data.get("contract")
        renewal = serializer.save(
            old_start_date=getattr(contract, "start_date", None),
            old_end_date=getattr(contract, "end_date", None),
            old_value=getattr(contract, "contract_value", None),
            renewed_by=_user_display(self.request.user),
        )

        # Update contract to renewed values (if provided)
        updated = False
        if renewal.new_start_date:
            contract.start_date = renewal.new_start_date
            updated = True
        if renewal.new_end_date:
            contract.end_date = renewal.new_end_date
            updated = True
        if renewal.new_value is not None:
            contract.contract_value = renewal.new_value
            updated = True

        if updated:
            contract.save(update_fields=["start_date", "end_date", "contract_value"])


class ContractViewSet(ModelViewSet):
    queryset = Contract.objects.all().order_by("-id")
    serializer_class = ContractSerializer
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    @action(detail=True, methods=["post"], url_path="convert-to-invoice")
    def convert_to_invoice(self, request, pk=None):
        contract = self.get_object()

        customer = getattr(contract, "customer_ref", None)
        if not customer and getattr(contract, "customer", None):
            customer = Client.objects.filter(company__iexact=str(contract.customer).strip()).first()

        if not customer:
            return Response(
                {"error": "Contract customer is missing"},
                status=status.HTTP_400_BAD_REQUEST,
            )

        make_draft = bool(request.data.get("draft", True))
        inv_status = "Draft" if make_draft else "Unpaid"

        value = getattr(contract, "contract_value", None) or 0
        invoice = Invoice.objects.create(
            invoice_number=f"INV-CON-{contract.id}",
            customer=customer,
            invoice_date=timezone.now().date(),
            due_date=timezone.now().date(),
            payment_mode="Null",
            subtotal=value,
            tax_amount=0,
            total_amount=value,
            status=inv_status,
            items=[
                {
                    "description": contract.subject or "Contract",
                    "long_description": (contract.content or contract.description or "").strip(),
                    "qty": 1,
                    "rate": float(value) if value else 0,
                }
            ],
        )

        return Response(InvoiceSerializer(invoice, context={"request": request}).data, status=201)

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
        proposal.save()
        return Response({"message": "Unassigned successfully"})

    try:
        user = User.objects.get(pk=user_id)
        proposal.assigned_to = user
        proposal.save()

        # ✅ Correct proposal page link
        frontend_url = f"http://localhost:3000/sales/proposals/{proposal.id}"

        subject = f"New Proposal Assigned - #{proposal.id}"

        html_content = f"""
        <div style="font-family: Arial, sans-serif; background:#f4f6f9; padding:20px;">
            <div style="max-width:600px; margin:auto; background:#ffffff; border-radius:8px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.1);">

                <div style="background:#2c3e50; padding:20px; text-align:center;">
                    <img src="cid:companylogo" style="max-height:60px;"><br>
                    <h2 style="color:#ffffff; margin:10px 0 0;">New Proposal Assigned</h2>
                </div>

                <div style="padding:20px;">
                    <p>Hello <strong>{user.first_name or user.username}</strong>,</p>
                    <p>You have been assigned a new proposal. Details are below:</p>

                    <table style="width:100%; border-collapse: collapse; margin-top:15px;">
                        <tr>
                            <td style="padding:8px; border:1px solid #ddd;"><strong>Proposal ID</strong></td>
                            <td style="padding:8px; border:1px solid #ddd;">#{proposal.id}</td>
                        </tr>
                        <tr>
                            <td style="padding:8px; border:1px solid #ddd;"><strong>Subject</strong></td>
                            <td style="padding:8px; border:1px solid #ddd;">{getattr(proposal, 'subject', 'N/A')}</td>
                        </tr>
                        <tr>
                            <td style="padding:8px; border:1px solid #ddd;"><strong>Total</strong></td>
                            <td style="padding:8px; border:1px solid #ddd;">₹{getattr(proposal, 'total', '0')}</td>
                        </tr>
                    </table>

                    <div style="text-align:center; margin-top:25px;">
                        <a href="{frontend_url}" 
                           style="background:#27ae60; color:#ffffff; padding:12px 25px; text-decoration:none; border-radius:5px; display:inline-block;">
                           View Proposal
                        </a>
                    </div>

                    <p style="margin-top:30px;">Regards,<br><strong>Magnyte Solution CRM Team</strong></p>
                </div>
            </div>
        </div>
        """

        text_content = strip_tags(html_content)

        email = EmailMultiAlternatives(
            subject,
            text_content,
            settings.DEFAULT_FROM_EMAIL,
            [user.email],
        )

        email.attach_alternative(html_content, "text/html")

        # ✅ Correct logo path
        logo_path = os.path.join(
            settings.BASE_DIR.parent,
            "crm-frontend",
            "public",
            "ms.png"
        )

        if os.path.exists(logo_path):
            with open(logo_path, "rb") as f:
                logo = MIMEImage(f.read())
                logo.add_header("Content-ID", "<companylogo>")
                logo.add_header("Content-Disposition", "inline", filename="ms.png")
                email.attach(logo)
            print("Logo attached successfully")
        else:
            print("Logo file not found at:", logo_path)

        # ✅ IMPORTANT: Send email
        email.send()

        print("HTML EMAIL SENT TO:", user.email)

        return Response({"message": "Assigned & Professional Email Sent"})

    except User.DoesNotExist:
        return Response({"error": "User not found"}, status=404)

    except Exception as e:
        print("EMAIL ERROR:", str(e))
        return Response({"error": str(e)}, status=400)


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

    users = User.objects.filter(is_active=True)

    data = [
        {
            "id": u.id,
            "name": u.first_name or u.username,
            "email": u.email,
        }
        for u in users
    ]

    return Response(data)

# ==============================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def dashboard_overview(request):

    total_proposals = Proposal.objects.count()
    total_users = User.objects.count()

    data = [
        {
            "title": "Total Proposals",
            "value": total_proposals
        },
        {
            "title": "Total Users",
            "value": total_users
        }
    ]

    return Response(data)

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
    
# ========================= EmailCampaign =========================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def upload_and_send_emails(request):

    subject = request.data.get("subject")
    message = request.data.get("message")
    excel_file = request.FILES.get("file")

    if not subject or not message:
        return Response({"error": "Subject and message required"}, status=400)

    if not excel_file:
        return Response({"error": "Excel file required"}, status=400)

    try:
        df = pd.read_excel(excel_file)
    except Exception as e:
        return Response({"error": "Invalid Excel file"}, status=400)

    # ✅ Detect column automatically (email / Email)
    if "email" in df.columns:
        email_column = "email"
    elif "Email" in df.columns:
        email_column = "Email"
    else:
        return Response({"error": "Excel must contain 'email' column"}, status=400)

    campaign = EmailCampaign.objects.create(
        subject=subject,
        message=message
    )

    sent_list = []
    failed_list = []

    for email in df[email_column]:

        recipient = EmailRecipient.objects.create(
            campaign=campaign,
            email=email
        )

        try:
            send_mail(
                subject,
                message,
                settings.DEFAULT_FROM_EMAIL,
                [email],
                fail_silently=False,
            )

            recipient.is_sent = True
            recipient.sent_at = timezone.now()
            recipient.save()

            sent_list.append(email)

        except Exception as e:
            print("Email failed:", e)
            failed_list.append(email)

    return Response({
        "message": "Processed Successfully",
        "sent_emails": sent_list,
        "failed_emails": failed_list
    }, status=200)   

# ========================= SINGLE EMAIL SEND =========================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def send_single_email(request):

    email = request.data.get("email")
    subject = request.data.get("subject")
    message = request.data.get("message")

    if not email or not subject or not message:
        return Response({"error": "All fields required"}, status=400)

    try:
        send_mail(
            subject,
            message,
            settings.DEFAULT_FROM_EMAIL,
            [email],
            fail_silently=False,
        )

        return Response({
            "status": "success",
            "email": email
        })

    except Exception as e:
        return Response({
            "status": "failed",
            "email": email,
            "error": str(e)
        }, status=400)
# ========================= Invoice Model =========================
def _sync_invoice_payment(invoice):
    payment = InvoicePayment.objects.filter(invoice=invoice).first()

    if payment:
        payment.payment_mode = invoice.payment_mode or "Null"
        payment.transaction_id = f"{invoice.payment_mode}-{invoice.id}"
        payment.amount = invoice.total_amount
        payment.save()
        return

    InvoicePayment.objects.create(
        invoice=invoice,
        payment_mode=invoice.payment_mode or "Null",
        transaction_id=f"{invoice.payment_mode}-{invoice.id}",
        amount=invoice.total_amount,
    )


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def invoice_list(request):
    if request.method == "POST":
        data = request.data.copy()
        customer_id = data.get("customer") or data.get("clientid")

        if not customer_id:
            return Response({"error": "Customer is required"}, status=400)

        try:
            customer = Client.objects.get(pk=customer_id)
        except Client.DoesNotExist:
            return Response({"error": "Customer not found"}, status=404)

        payload = {
            "invoice_number": data.get("invoice_number") or data.get("number") or "",
            "reference_estimate": data.get("reference_estimate") or None,
            "customer": customer.id,
            "invoice_date": data.get("invoice_date") or timezone.now().date(),
            "due_date": data.get("due_date") or timezone.now().date(),
            "payment_mode": data.get("payment_mode") or data.get("paymentMode") or "Null",
            "subtotal": data.get("subtotal") or 0,
            "tax_amount": data.get("tax_amount") or 0,
            "total_amount": data.get("total_amount") or 0,
            "status": data.get("status") or "Draft",
            "items": data.get("items") or [],
        }

        serializer = InvoiceSerializer(data=payload)
        if serializer.is_valid():
            invoice = serializer.save()
            _sync_invoice_payment(invoice)
            return Response(InvoiceSerializer(invoice).data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=400)

    estimates = Estimate.objects.all()

    for estimate in estimates:
        existing = Invoice.objects.filter(reference_estimate=estimate).first()
        if existing:
            continue

        client = estimate.customer
        if not client:
            continue

        Invoice.objects.create(
            invoice_number=f"INV-{estimate.estimate_number}",
            reference_estimate=estimate,
            customer=client,
            invoice_date=estimate.date,
            due_date=estimate.expiry_date,
            subtotal=estimate.amount,
            tax_amount=estimate.total_tax,
            total_amount=estimate.amount + estimate.total_tax,
            status="Unpaid",
            items=getattr(estimate, "items", []),
        )

    invoices = Invoice.objects.filter(customer__is_active=True).order_by("-id")
    serializer = InvoiceSerializer(invoices, many=True)
    return Response(serializer.data)


# ====================== Invoice Detail ===============================
@api_view(["GET", "PUT", "DELETE"])
@permission_classes([IsAuthenticated])
def invoice_detail(request, pk):
    try:
        invoice = Invoice.objects.get(pk=pk)
    except Invoice.DoesNotExist:
        return Response({"error": "Invoice not found"}, status=404)

    if request.method == "GET":
        serializer = InvoiceSerializer(invoice)
        return Response(serializer.data)

    if request.method == "PUT":
        data = request.data.copy()
        data.setdefault("tax_amount", invoice.tax_amount)
        data.setdefault("total_amount", invoice.total_amount)
        data.setdefault("items", invoice.items)

        serializer = InvoiceSerializer(invoice, data=data, partial=True)
        if serializer.is_valid():
            updated_invoice = serializer.save()
            _sync_invoice_payment(updated_invoice)
            return Response(InvoiceSerializer(updated_invoice).data)
        return Response(serializer.errors, status=400)

    invoice.delete()
    return Response({"message": "Invoice deleted successfully"}, status=204)
# ====================== Invoice Reminders ======================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def invoice_reminders(request, pk):

    if request.method == "GET":

        reminders = InvoiceReminder.objects.filter(invoice_id=pk)

        serializer = InvoiceReminderSerializer(reminders, many=True)

        return Response(serializer.data)


    if request.method == "POST":

        data = request.data.copy()

        data["invoice"] = pk

        serializer = InvoiceReminderSerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=201)

        return Response(serializer.errors, status=400)



# ====================== Invoice Tasks ======================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def invoice_tasks(request, pk):

    if request.method == "GET":

        tasks = InvoiceTask.objects.filter(invoice_id=pk)

        serializer = InvoiceTaskSerializer(tasks, many=True)

        return Response(serializer.data)


    if request.method == "POST":

        data = request.data.copy()

        data["invoice"] = pk

        serializer = InvoiceTaskSerializer(data=data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=201)

        return Response(serializer.errors, status=400)

# ====================== send invoice email ====================================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def send_invoice_email(request):

    invoice_id = request.data.get("invoice_id")
    email = request.data.get("email")
    message = request.data.get("message")

    if not invoice_id or not email:
        return Response(
            {"error": "invoice_id and email required"},
            status=400
        )

    try:

        invoice = Invoice.objects.get(id=invoice_id)

        subject = f"Invoice #{invoice.invoice_number}"

        # SEND EMAIL
        send_mail(
            subject,
            message,
            settings.DEFAULT_FROM_EMAIL,
            [email],
            fail_silently=False,
        )

        # SAVE HISTORY
        log = InvoiceEmailLog.objects.create(
            invoice=invoice,
            email=email,
            message=message
        )

        print("EMAIL LOG SAVED:", log.id)

        return Response({
            "success": True,
            "message": "Email sent and logged"
        })

    except Exception as e:

        print("EMAIL ERROR:", str(e))

        return Response({"error": str(e)}, status=400)

# ======================= Invoice Email History =======================
@api_view(["GET"])
@permission_classes([AllowAny])
def invoice_email_history(request, pk):

    logs = InvoiceEmailLog.objects.filter(invoice_id=pk).order_by("-id")

    serializer = InvoiceEmailLogSerializer(logs, many=True)

    return Response(serializer.data)

# ====================== Payment Invoice ===============================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def invoice_payment_records(request):

    invoices = Invoice.objects.all()

    for invoice in invoices:

        payment = InvoicePayment.objects.filter(invoice=invoice).first()

        if payment:
            # 🔄 update existing payment
            payment.payment_mode = invoice.payment_mode or "Null"
            payment.transaction_id = f"{invoice.payment_mode}-{invoice.id}"
            payment.amount = invoice.total_amount
            payment.save()

        else:
            # ➕ create new payment
            InvoicePayment.objects.create(
                invoice=invoice,
                payment_mode=invoice.payment_mode or "Null",
                transaction_id=f"{invoice.payment_mode}-{invoice.id}",
                amount=invoice.total_amount
            )

    payments = InvoicePayment.objects.filter(invoice__customer__is_active=True).order_by("-id")
    serializer = InvoicePaymentSerializer(payments, many=True)

    return Response(serializer.data)   

# ====================== CREATE PAYMENT ======================
@api_view(["POST"])
@permission_classes([IsAuthenticated])
def create_invoice_payment(request):

    serializer = InvoicePaymentSerializer(data=request.data)

    if serializer.is_valid():
        payment = serializer.save()

        return Response({
            "success": True,
            "message": "Payment recorded successfully",
            "data": InvoicePaymentSerializer(payment).data
        }, status=201)

    return Response(serializer.errors, status=400)

# ====================== Auto Repair ==========================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def fix_invoice_payments(request):

    invoices = Invoice.objects.all()

    created = 0

    for invoice in invoices:

        if not InvoicePayment.objects.filter(invoice=invoice).exists():

            InvoicePayment.objects.create(
            invoice=invoice,
            payment_mode=invoice.payment_mode or "Null",
            transaction_id=f"{invoice.payment_mode}-{invoice.id}",
            amount=invoice.total_amount
        )

            created += 1

    return Response({
        "message": "Payments fixed",
        "created": created
    })

# ====================== Convert Old Estimates ======================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def convert_existing_estimates(request):

    estimates = Estimate.objects.all()

    created = 0

    for estimate in estimates:

        # check invoice already exists
        if Invoice.objects.filter(reference_estimate=estimate).exists():
            continue

        # find client
        client = estimate.customer

        if not client:
            continue

        Invoice.objects.create(
            invoice_number=f"INV-{estimate.estimate_number}",
            reference_estimate=estimate,
            customer=client,
            invoice_date=estimate.date,
            due_date=estimate.expiry_date,
            subtotal=estimate.amount,
            tax_amount=estimate.total_tax,
            total_amount=estimate.amount + estimate.total_tax,
            status="Unpaid",
            items=getattr(estimate, "items", []),
        )

        created += 1

    return Response({
        "message": "Invoices generated from old estimates",
        "created": created
    })

# ====================== Convert Old Estimates ======================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def convert_old_estimates_to_invoices(request):

    estimates = Estimate.objects.all()
    created = 0

    for estimate in estimates:

        # already converted check
        if Invoice.objects.filter(reference_estimate=estimate).exists():
            continue

        # client find
        client = estimate.customer
        if not client:
            continue

        # create invoice
        Invoice.objects.create(
            invoice_number=f"INV-{estimate.estimate_number}",
            reference_estimate=estimate,
            customer=client,
            invoice_date=estimate.date,
            due_date=estimate.expiry_date,
            subtotal=estimate.amount,
            tax_amount=estimate.total_tax,
            total_amount=estimate.amount + estimate.total_tax,
            status="Unpaid",
            items=getattr(estimate, "items", []),
        )

        created += 1

    return Response({
        "message": "Old estimates converted",
        "created_invoices": created
    })

# ====================== FIX OLD ESTIMATES ======================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def fix_estimate_invoices(request):

    estimates = Estimate.objects.all()
    created = 0

    for estimate in estimates:

        # invoice already exist?
        existing = Invoice.objects.filter(
            invoice_number=f"INV-{estimate.estimate_number}"
        ).first()

        if existing:
            continue

        client = estimate.customer

        if not client:
            print("Client not found:", estimate.customer)
            continue

        Invoice.objects.create(
            invoice_number=f"INV-{estimate.estimate_number}",
            reference_estimate=estimate,
            customer=client,
            invoice_date=estimate.date,
            due_date=estimate.expiry_date,
            subtotal=estimate.amount,
            tax_amount=estimate.total_tax,
            total_amount=estimate.amount + estimate.total_tax,
            status="Unpaid",
            items=getattr(estimate, "items", []),
        )

        created += 1

    return Response({
        "message": "Old estimates converted to invoices",
        "created": created
    })

# ====================== HELPER FUNCTION ======================
def create_invoice_from_estimate(estimate):

    # 🔹 Only create when status is Sent
    if estimate.status != "Sent":
        return

    # 🔹 check if invoice already exists
    existing = Invoice.objects.filter(
        reference_estimate=estimate
    ).first()

    if existing:
        return

    # 🔹 find client
    client = estimate.customer

    if not client:
        print("Client not found:", estimate.customer)
        return

    # 🔹 create invoice
    invoice = Invoice.objects.create(
        invoice_number=f"INV-{estimate.estimate_number}",
        reference_estimate=estimate,
        customer=client,
        invoice_date=estimate.date,
        due_date=estimate.expiry_date,
        subtotal=estimate.amount,
        tax_amount=estimate.total_tax,
        total_amount=estimate.amount + estimate.total_tax,
        status="Unpaid",
            items=getattr(estimate, "items", []),
        )

    print("✅ Invoice created from estimate:", invoice.invoice_number)

# ======================== Customer Pach =========================
@api_view(["PATCH"])
@permission_classes([IsAuthenticated])
def toggle_client_active(request, pk):

    try:
        client = Client.objects.get(pk=pk)
    except Client.DoesNotExist:
        return Response({"error": "Client not found"}, status=404)

    is_active = request.data.get("is_active")

    client.is_active = is_active
    client.save()

    # invoices
    Invoice.objects.filter(customer=client).update(
        status="Draft" if not is_active else "Unpaid"
    )

    # estimates
    Estimate.objects.filter(customer=client).update(
        status="Cancelled" if not is_active else "Draft"
    )

    return Response({"message": "Customer status updated"})


def get_contacts_db_alias():
    return "default"


def _serialize_contact(contact):
    return {
        "id": contact.id,
        "userid": None,
        "is_primary": int(contact.is_primary),
        "firstname": contact.firstname,
        "lastname": contact.lastname,
        "email": contact.email,
        "phonenumber": contact.phonenumber,
        "title": contact.title,
        "datecreated": contact.created_at,
        "password": contact.password,
        "last_login": contact.last_login,
        "active": int(contact.active),
        "direction": contact.direction,
        "invoice_emails": int(contact.invoice_emails),
        "estimate_emails": int(contact.estimate_emails),
        "credit_note_emails": int(contact.credit_note_emails),
        "contract_emails": int(contact.contract_emails),
        "task_emails": int(contact.task_emails),
        "project_emails": int(contact.project_emails),
        "ticket_emails": int(contact.ticket_emails),
        "company": contact.company or "-",
    }


def _get_or_create_client(company_name, phonenumber=""):
    if not company_name:
        return None

    client = Client.objects.filter(company__iexact=company_name).first()
    if client:
        return client

    return Client.objects.create(
        company=company_name,
        phone=phonenumber or "",
        country="",
        city="",
        zip_code="",
        state="",
        billing_address="",
        shipping_address="",
        is_active=True,
    )


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def contacts_list_create(request):
    if request.method == "GET":
        contacts = Contact.objects.all().order_by("-created_at", "-id")
        return Response([_serialize_contact(contact) for contact in contacts])

    data = request.data
    company_name = (data.get("company") or "").strip()
    client = _get_or_create_client(
        company_name,
        data.get("phonenumber") or "",
    )

    contact = Contact.objects.create(
        is_primary=bool(int(data.get("is_primary", 0) or 0)),
        firstname=data.get("firstname", "").strip(),
        lastname=data.get("lastname", "").strip(),
        email=data.get("email", "").strip(),
        company=company_name or (client.company if client else ""),
        phonenumber=data.get("phonenumber", "").strip(),
        title=data.get("title") or "",
        password=data.get("password") or "",
        last_login=timezone.now(),
        active=bool(int(data.get("active", 1) or 1)),
        direction=data.get("direction") or None,
        invoice_emails=bool(int(data.get("invoice_emails", 0) or 0)),
        estimate_emails=bool(int(data.get("estimate_emails", 0) or 0)),
        credit_note_emails=bool(int(data.get("credit_note_emails", 0) or 0)),
        contract_emails=bool(int(data.get("contract_emails", 0) or 0)),
        task_emails=bool(int(data.get("task_emails", 0) or 0)),
        project_emails=bool(int(data.get("project_emails", 0) or 0)),
        ticket_emails=bool(int(data.get("ticket_emails", 0) or 0)),
    )

    return Response(_serialize_contact(contact), status=status.HTTP_201_CREATED)


@api_view(["GET", "PATCH", "PUT", "DELETE"])
@permission_classes([IsAuthenticated])
def contacts_detail(request, pk):
    try:
        contact = Contact.objects.get(pk=pk)
    except Contact.DoesNotExist:
        return Response({"error": "Contact not found"}, status=404)

    if request.method == "GET":
        return Response(_serialize_contact(contact))

    if request.method == "DELETE":
        contact.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    data = request.data

    if "company" in data:
        company_name = (data.get("company") or "").strip()
        client = _get_or_create_client(
            company_name,
            data.get("phonenumber") or contact.phonenumber,
        )
        contact.company = company_name or (client.company if client else contact.company)

    updatable_fields = {
        "is_primary": bool,
        "firstname": str,
        "lastname": str,
        "email": str,
        "company": str,
        "phonenumber": str,
        "title": str,
        "password": str,
        "active": bool,
        "direction": str,
        "invoice_emails": bool,
        "estimate_emails": bool,
        "credit_note_emails": bool,
        "contract_emails": bool,
        "task_emails": bool,
        "project_emails": bool,
        "ticket_emails": bool,
    }

    for field, caster in updatable_fields.items():
        if field in data:
            raw_value = data.get(field)
            if raw_value is None:
                setattr(contact, field, None)
            elif caster is bool:
                setattr(contact, field, bool(int(raw_value)))
            else:
                setattr(contact, field, raw_value)

    if "last_login" in data and data.get("last_login"):
        contact.last_login = data.get("last_login")

    contact.save()
    return Response(_serialize_contact(contact))


# ================= STAFF API =================
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def staff_list_create(request):
    """List all staff members or create a new staff member"""
    ensure_staff_table()

    if request.method == "GET":
        staff_members = Staff.objects.all().order_by("-staffid")
        serializer = StaffSerializer(staff_members, many=True)
        return Response(serializer.data)

    data = request.data.copy()

    raw_password = (data.get("password") or "").strip()
    if not raw_password:
        return Response(
            {"detail": "Password is required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    data["password"] = make_password(raw_password)
    data["admin"] = int(data.get("admin", 0) or 0)
    data["active"] = int(data.get("active", 1) or 1)
    data["is_not_staff"] = int(data.get("is_not_staff", 0) or 0)
    data["default_language"] = data.get("default_language") or "english"
    data["direction"] = data.get("direction") or "ltr"
    data["two_factor_auth_enabled"] = int(data.get("two_factor_auth_enabled", 0) or 0)

    try:
        data["hourly_rate"] = float(data.get("hourly_rate") or 0)
    except (TypeError, ValueError):
        data["hourly_rate"] = 0

    serializer = StaffSerializer(data=data)
    serializer.is_valid(raise_exception=True)
    staff = serializer.save(datecreated=timezone.now())
    return Response(StaffSerializer(staff).data, status=status.HTTP_201_CREATED)


@api_view(["GET", "PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def staff_detail(request, pk):
    """Get, update or delete a specific staff member"""
    ensure_staff_table()

    try:
        staff = Staff.objects.get(pk=pk)
    except Staff.DoesNotExist:
        return Response(
            {"error": "Staff member not found"},
            status=status.HTTP_404_NOT_FOUND,
        )

    if request.method == "GET":
        return Response(StaffSerializer(staff).data)

    if request.method == "DELETE":
        staff.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    data = request.data.copy()

    if "password" in data:
        raw_password = (data.get("password") or "").strip()
        if raw_password:
            data["password"] = make_password(raw_password)
        else:
            data.pop("password", None)

    serializer = StaffSerializer(staff, data=data, partial=True)
    serializer.is_valid(raise_exception=True)
    staff = serializer.save()
    return Response(StaffSerializer(staff).data)


def _serialize_kb_group(group):
    return {
        "groupid": group.groupid,
        "name": group.name,
        "group_slug": group.group_slug,
        "description": group.description,
        "active": group.active,
        "color": group.color,
        "group_order": group.group_order,
    }


def _serialize_kb_article(article, group_name=None):
    return {
        "articleid": article.articleid,
        "articlegroup": article.articlegroup,
        "group_name": group_name,
        "subject": article.subject,
        "description": article.description,
        "slug": article.slug,
        "active": article.active,
        "datecreated": article.datecreated.isoformat() if article.datecreated else None,
        "article_order": article.article_order,
        "staff_article": article.staff_article,
    }


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def knowledge_base_groups_list_create(request):
    from core.middleware import get_current_db

    try:
        ensure_knowledge_base_tables()
    except Exception as exc:
        return Response(
            {"detail": f"Knowledge base tables ensure failed: {exc}"},
            status=status.HTTP_503_SERVICE_UNAVAILABLE,
        )

    db = get_current_db()

    if request.method == "GET":
        groups = KnowledgeBaseGroups.objects.using(db).all().order_by("group_order", "groupid")
        return Response([_serialize_kb_group(g) for g in groups])

    data = request.data or {}
    name = (data.get("name") or "").strip()
    if not name:
        return Response({"detail": "Group name is required"}, status=status.HTTP_400_BAD_REQUEST)

    group = KnowledgeBaseGroups.objects.using(db).create(
        name=name,
        group_slug=(data.get("group_slug") or slugify(name) or name),
        description=data.get("description") or "",
        active=int(data.get("active", 1)),
        color=data.get("color") or "#28B8DA",
        group_order=int(data.get("group_order") or 0),
    )
    return Response(_serialize_kb_group(group), status=status.HTTP_201_CREATED)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def knowledge_base_list_create(request):
    from core.middleware import get_current_db

    try:
        ensure_knowledge_base_tables()
    except Exception as exc:
        return Response(
            {"detail": f"Knowledge base tables ensure failed: {exc}"},
            status=status.HTTP_503_SERVICE_UNAVAILABLE,
        )

    db = get_current_db()

    if request.method == "GET":
        qs = KnowledgeBase.objects.using(db).all().order_by("-articleid")

        group_id = request.query_params.get("group")
        if group_id:
            try:
                qs = qs.filter(articlegroup=int(group_id))
            except (TypeError, ValueError):
                pass

        active_only = request.query_params.get("active")
        if active_only is not None and str(active_only).strip() != "":
            try:
                qs = qs.filter(active=int(active_only))
            except (TypeError, ValueError):
                pass

        groups = KnowledgeBaseGroups.objects.using(db).all()
        group_map = {g.groupid: g.name for g in groups}

        return Response([_serialize_kb_article(a, group_map.get(a.articlegroup)) for a in qs])

    data = request.data or {}
    subject = (data.get("subject") or "").strip()
    description = (data.get("description") or "").strip()
    if not subject or not description:
        return Response(
            {"detail": "Subject and description are required"},
            status=status.HTTP_400_BAD_REQUEST,
        )

    group_id = data.get("articlegroup")
    if not group_id:
        first_group = KnowledgeBaseGroups.objects.using(db).order_by("group_order", "groupid").first()
        group_id = first_group.groupid if first_group else 1

    slug = data.get("slug") or slugify(subject) or subject

    article = KnowledgeBase.objects.using(db).create(
        articlegroup=int(group_id),
        subject=subject,
        description=description,
        slug=slug,
        active=int(data.get("active", 1)),
        datecreated=timezone.now(),
        article_order=int(data.get("article_order") or 0),
        staff_article=int(data.get("staff_article") or 0),
    )

    group_name = None
    if group_id:
        grp = KnowledgeBaseGroups.objects.using(db).filter(groupid=group_id).first()
        group_name = grp.name if grp else None
    return Response(_serialize_kb_article(article, group_name), status=status.HTTP_201_CREATED)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
@permission_classes([IsAuthenticated])
def items_groups_list_create(request):
    if request.method == "GET":
        groups = ItemGroup.objects.all().order_by("name", "id")
        serializer = ItemGroupSerializer(groups, many=True)
        return Response(serializer.data)

    serializer = ItemGroupSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def items_groups_detail(request, pk):
    try:
        group = ItemGroup.objects.get(pk=pk)
    except ItemGroup.DoesNotExist:
        return Response({"error": "Item group not found"}, status=404)

    if request.method == "DELETE":
        group.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    serializer = ItemGroupSerializer(group, data=request.data, partial=request.method == "PATCH")
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def items_list_create(request):
    if request.method == "GET":
        items = Item.objects.select_related("group").all().order_by("-created_at", "-id")
        serializer = ItemSerializer(items, many=True)
        return Response(serializer.data)

    item = sync_item_to_master(request.data.copy())
    if not item:
        return Response({"error": "Item name or description is required"}, status=status.HTTP_400_BAD_REQUEST)

    serializer = ItemSerializer(item)
    return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(["PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def items_detail(request, pk):
    try:
        item = Item.objects.get(pk=pk)
    except Item.DoesNotExist:
        return Response({"error": "Item not found"}, status=404)

    if request.method == "DELETE":
        item.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    payload = request.data.copy()
    payload["item_name"] = payload.get("item_name") or item.item_name
    payload["item_code"] = payload.get("item_code") or item.item_code
    if "status" not in payload:
        payload["status"] = item.status

    synced_item = sync_item_to_master({"id": item.id, **payload}) or item
    serializer = ItemSerializer(synced_item)
    return Response(serializer.data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def public_items_list(request):
    items = Item.objects.select_related("group").all().order_by("item_name", "id")
    serializer = ItemSerializer(items, many=True)
    return Response(serializer.data)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def creditnotes_list_create(request):
    if request.method == "GET":
        notes = CreditNote.objects.using("default").all().order_by("-datecreated", "-id")
        serializer = CreditNoteSerializer(notes, many=True)
        return Response(serializer.data)

    data = request.data.copy()

    customer_id = data.get("clientid")
    customer = None
    if customer_id:
      customer = Client.objects.using("default").filter(pk=customer_id).first()

    prefix = "CN-"
    raw_number = data.get("creditNoteNumber") or data.get("number")
    if raw_number:
        raw_number = str(raw_number)
        if raw_number.upper().startswith("CN-"):
            prefix = "CN-"
            raw_number = raw_number[3:]
    next_number = CreditNote.objects.using("default").count() + 1
    try:
        note_number = int(raw_number) if raw_number else next_number
    except (TypeError, ValueError):
        note_number = next_number

    payload = {
        "client": customer,
        "deleted_customer_name": data.get("deleted_customer_name") or (customer.company if customer else ""),
        "number": note_number,
        "prefix": data.get("prefix") or prefix,
        "number_format": data.get("number_format") or "",
        "date": data.get("creditNoteDate") or data.get("date") or timezone.now().date(),
        "duedate": data.get("expiryDate") or data.get("duedate") or None,
        "project_id": data.get("project_id") or None,
        "reference_no": data.get("reference") or data.get("reference_no") or "",
        "subtotal": data.get("subtotal") or 0,
        "total_tax": data.get("total_tax") or 0,
        "total": data.get("total") or 0,
        "adjustment": data.get("adjustment") or 0,
        "addedfrom": data.get("addedfrom") or 0,
        "status": data.get("status") or 1,
        "clientnote": data.get("clientnote") or "",
        "adminnote": data.get("adminNote") or data.get("adminnote") or "",
        "terms": data.get("terms") or "",
        "currency": data.get("currency") or "INR",
        "discount_percent": data.get("discount_percent") or 0,
        "discount_total": data.get("discount") or data.get("discount_total") or 0,
        "discount_type": data.get("discountType") or data.get("discount_type") or "none",
        "billing_street": data.get("billTo", {}).get("street", "") if isinstance(data.get("billTo"), dict) else data.get("billing_street") or "",
        "billing_city": data.get("billTo", {}).get("city", "") if isinstance(data.get("billTo"), dict) else data.get("billing_city") or "",
        "billing_state": data.get("billTo", {}).get("state", "") if isinstance(data.get("billTo"), dict) else data.get("billing_state") or "",
        "billing_zip": data.get("billTo", {}).get("zip", "") if isinstance(data.get("billTo"), dict) else data.get("billing_zip") or "",
        "billing_country": data.get("billTo", {}).get("country", "") if isinstance(data.get("billTo"), dict) else data.get("billing_country") or "",
        "shipping_street": data.get("shipTo", {}).get("street", "") if isinstance(data.get("shipTo"), dict) else data.get("shipping_street") or "",
        "shipping_city": data.get("shipTo", {}).get("city", "") if isinstance(data.get("shipTo"), dict) else data.get("shipping_city") or "",
        "shipping_state": data.get("shipTo", {}).get("state", "") if isinstance(data.get("shipTo"), dict) else data.get("shipping_state") or "",
        "shipping_zip": data.get("shipTo", {}).get("zip", "") if isinstance(data.get("shipTo"), dict) else data.get("shipping_zip") or "",
        "shipping_country": data.get("shipTo", {}).get("country", "") if isinstance(data.get("shipTo"), dict) else data.get("shipping_country") or "",
        "include_shipping": bool(data.get("include_shipping") or False),
        "show_shipping_on_credit_note": bool(data.get("show_shipping_on_credit_note") or False),
        "show_quantity_as": data.get("show_quantity_as") or data.get("quantityType") or "Qty",
        "email_signature": data.get("email_signature") or "",
        "items": data.get("items") or [],
    }

    credit_note = CreditNote.objects.using("default").create(**payload)
    sync_items_to_master(payload["items"])
    serializer = CreditNoteSerializer(credit_note)
    return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def creditnote_detail(request, pk):
    try:
        credit_note = CreditNote.objects.using("default").get(pk=pk)
    except CreditNote.DoesNotExist:
        return Response({"error": "Credit note not found"}, status=404)

    serializer = CreditNoteSerializer(credit_note)
    return Response(serializer.data)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def creditnote_reminders(request, pk):
    if request.method == "GET":
        reminders = CreditNoteReminder.objects.using("default").filter(credit_note_id=pk)
        serializer = CreditNoteReminderSerializer(reminders, many=True)
        return Response(serializer.data)

    serializer = CreditNoteReminderSerializer(
        data={**request.data, "credit_note": pk}
    )
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def creditnote_tasks(request, pk):
    if request.method == "GET":
        tasks = CreditNoteTask.objects.using("default").filter(credit_note_id=pk)
        serializer = CreditNoteTaskSerializer(tasks, many=True)
        return Response(serializer.data)

    serializer = CreditNoteTaskSerializer(
        data={**request.data, "credit_note": pk}
    )
    if serializer.is_valid():
        serializer.save()
    return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


# ========================= MEDIA FILE API =========================
import os
from datetime import datetime
from django.conf import settings
from rest_framework.parsers import MultiPartParser, FormParser

# In-memory storage for media files (demo mode)
# In production, use a proper database model and file storage
MEDIA_FILES = []
MEDIA_ID_COUNTER = [0]  # Using list to allow modification in nested function


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def media_files_list(request):
    """Get all media files"""
    return Response(MEDIA_FILES)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def upload_media(request):
    """Upload a media file"""
    if 'file' not in request.FILES:
        return Response({"error": "No file provided"}, status=400)
    
    file = request.FILES['file']
    MEDIA_ID_COUNTER[0] += 1
    
    # Determine file type
    filename = file.name
    ext = filename.split('.')[-1].lower() if '.' in filename else ''
    
    image_exts = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg', 'webp']
    video_exts = ['mp4', 'avi', 'mov', 'wmv', 'flv']
    audio_exts = ['mp3', 'wav', 'ogg', 'aac']
    doc_exts = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt']
    
    if ext in image_exts:
        file_type = 'image'
    elif ext in video_exts:
        file_type = 'video'
    elif ext in audio_exts:
        file_type = 'audio'
    elif ext in doc_exts:
        file_type = 'document'
    else:
        file_type = 'other'
    
    # Format file size
    file_size = file.size
    if file_size >= 1024 * 1024:
        size_str = f"{round(file_size / (1024 * 1024) * 100) / 100} MB"
    elif file_size >= 1024:
        size_str = f"{round(file_size / 1024 * 100) / 100} KB"
    else:
        size_str = f"{file_size} Bytes"
    
    media_file = {
        "id": MEDIA_ID_COUNTER[0],
        "name": filename,
        "type": file_type,
        "size": size_str,
        "url": f"/media/{filename}",
        "uploaded_at": datetime.now().strftime("%Y-%m-%d")
    }
    
    MEDIA_FILES.append(media_file)
    
    return Response(media_file, status=201)


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def media_file_delete(request, pk):
    """Delete a media file"""
    global MEDIA_FILES
    MEDIA_FILES = [f for f in MEDIA_FILES if f["id"] != int(pk)]
    return Response({"status": "deleted"}, status=200)


