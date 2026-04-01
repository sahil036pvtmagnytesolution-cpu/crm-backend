import email
import html
import uuid
import subprocess
import binascii
import json
from decimal import Decimal, InvalidOperation
from datetime import datetime

from django.contrib.auth.models import User
from django.contrib.auth.hashers import check_password, make_password
from django.core.exceptions import ValidationError as DjangoValidationError
from django.core.validators import validate_email
from django.db import transaction
import threading

from django.http import FileResponse
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

from .models import (
    Business,
    Customer,
    Item,
    ItemGroup,
    Permission,
    Role,
    RoleAuditLog,
    Proposal,
    StaffProfile,
    ActivityLog as CoreActivityLog,
    LegacyBusiness,
    CustomFieldValue,
)
from django.contrib.contenttypes.models import ContentType
from ms_crm_app.models import (
    Staff,
    Contacts,
    Notifications,
    KnowledgeBase,
    KnowledgeBaseGroups,
    ActivityLog as LegacyActivityLog,
    Announcements as LegacyAnnouncements,
    Goals as LegacyGoals,
    Surveys as LegacySurveys,
    TicketsPipeLog as LegacyTicketsPipeLog,
)
from ms_crm_app.helpers.ensure_tables import (
    ensure_project_tables,
    ensure_knowledge_base_tables,
    ensure_staff_table,
    ensure_announcements_table,
    ensure_goals_table,
    ensure_activity_log_table,
    ensure_surveys_table,
    ensure_tickets_pipe_log_table,
)
from core.utils.activity_log import log_activity, serialize_activity_log
from .serializers import (
    BusinessSerializer,
    RoleSerializer,
    ProposalSerializer,
    StaffSerializer,
    CustomFieldValueSerializer,
    PermissionDefinitionSerializer,
    RoleReadSerializer,
    RoleWriteSerializer,
    UserRoleAssignmentSerializer,
)
from core.seeders.email_templates import seed_email_templates_optimized
from core.business_onboarding import (
    ensure_business_runtime_ready,
    generate_unique_business_db_name,
    send_login_success_email,
    send_signup_received_email,
)
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
from django.db import connections
import re
from .models import Estimate
from .serializers import EstimateSerializer

from .models import CalendarEvent
from .serializers import CalendarEventSerializer

from .models import Proposal
from .serializers import ProposalSerializer

from rest_framework.views import APIView
from django.contrib.auth import get_user_model
from rest_framework.response import Response

from django.utils.html import strip_tags
from django.utils.encoding import force_bytes
from django.utils.dateparse import parse_date
from django.core.mail import EmailMessage
from django.contrib.staticfiles import finders
from django.core.files.base import ContentFile
from django.core.mail import get_connection
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
from .email_branding import send_branded_email
from .models import Project
from .serializers import ProjectSerializer
from django.db.models import Count, Sum, Q
from django.db.utils import OperationalError, ProgrammingError
from django.utils.text import slugify
from .middleware import (
    build_user_access_payload,
    is_super_admin,
    sync_default_permissions,
    user_has_permission,
)

@api_view(["GET"])
@permission_classes([IsAuthenticated])
def timesheets_overview(request):
    """
    Timesheets overview API.
    The frontend expects a list response from /core_api/timesheets/.
    Since there is no backing model/table yet, return an empty list to
    prevent 404/500 errors and allow the UI to show "No timesheets found".
    """
    return Response([])

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

            send_branded_email(
                subject=subject,
                message=message,
                to_emails=[user.email],
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
        create_invoice_from_estimate(estimate, user=getattr(self.request, "user", None))
    # ================ Update Estimate =================
    def perform_update(self, serializer):
        estimate = serializer.save()
        create_invoice_from_estimate(estimate, user=getattr(self.request, "user", None))

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

    def perform_create(self, serializer):
        lead = serializer.save()
        name = getattr(lead, "name", None) or "Unknown"
        log_activity(f"Lead Created [Name: {name}]", user=getattr(self.request, "user", None))

    def perform_update(self, serializer):
        instance = serializer.instance
        old_status = getattr(instance, "status", None)
        lead = serializer.save()
        name = getattr(lead, "name", None) or "Unknown"
        new_status = getattr(lead, "status", None)
        if old_status != new_status and new_status is not None:
            log_activity(
                f"Lead Status Changed [Name: {name} | Status: {old_status} -> {new_status}]",
                user=getattr(self.request, "user", None),
            )
        else:
            log_activity(f"Lead Updated [Name: {name}]", user=getattr(self.request, "user", None))

    def perform_destroy(self, instance):
        name = getattr(instance, "name", None) or "Unknown"
        super().perform_destroy(instance)
        log_activity(f"Lead Deleted [Name: {name}]", user=getattr(self.request, "user", None))


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
            send_branded_email(
                subject=subject,
                message=message,
                to_emails=recipients,
                html_message=html_message,
                fail_silently=False,
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
            send_branded_email(
                subject=subject,
                message=message,
                to_emails=recipients,
                html_message=html_message,
                fail_silently=False,
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
    if Business.objects.filter(email__iexact=data["email"]).exists():
        return Response(
            {"status": False, "message": "Business email already exists"},
            status=400,
        )
    if Business.objects.filter(name__iexact=data["name"]).exists():
        return Response(
            {"status": False, "message": "Business name already exists"},
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

        business = Business.objects.create(
            name=data["name"],
            email=data["email"],
            owner_name=data["owner_name"],
            db_name=generate_unique_business_db_name(data["name"]),
        )

    run_async(seed_email_templates_optimized)
    run_async(send_signup_received_email, business)

    return Response(
        {
            "status": True,
            "message": "Signup successful. Approval request email sent. Please wait for super admin approval.",
            "business": {
                "name": business.name,
                "email": business.email,
                "db_name": business.db_name,
                "is_approved": business.is_approved,
            },
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

    if not email or not password:
        return Response({"message": "Email and password are required"}, status=400)

    user = User.objects.filter(username__iexact=email).first()
    if not user:
        log_activity(f"Failed Login Attempt [Email: {email or '-'}]", user=None)
        return Response({"message": "Invalid credentials"}, status=401)

    if not check_password(password, user.password):
        log_activity(f"Failed Login Attempt [Email: {email or '-'}]", user=None)
        return Response({"message": "Invalid credentials"}, status=401)

    business = Business.objects.filter(email__iexact=email).order_by("-created_at").first()
    if not business:
        log_activity(f"Failed Login Attempt [Email: {email or '-'}]", user=None)
        return Response({"message": "Business profile not found"}, status=403)

    if not business.is_approved or not user.is_active:
        log_activity(f"Failed Login Attempt [Email: {email or '-'}]", user=None)
        return Response(
            {"message": "Business not approved by super admin yet"},
            status=403,
        )

    try:
        ensure_business_runtime_ready(business)
    except Exception as exc:
        log_activity(f"Failed Login Attempt [Email: {email or '-'} | Tenant setup failed]", user=None)
        return Response(
            {"message": f"Business tenant setup failed: {exc}"},
            status=500,
        )

    sync_default_permissions()
    rbac_payload = build_user_access_payload(user)
    refresh = RefreshToken.for_user(user)
    log_activity(f"Staff Login [Email: {user.email or user.username}]", user=user)
    login_mail_sent, login_mail_error = send_login_success_email(business)

    return Response(
        {
            "access_token": str(refresh.access_token),
            "refresh_token": str(refresh),
            "user": {
                "id": user.id,
                "email": user.email,
                "is_superuser": user.is_superuser,
                "roles": rbac_payload.get("roles", []),
                "permissions": rbac_payload.get("permissions", {}),
                "is_super_admin": rbac_payload.get("is_super_admin", False),
            },
            "business": {
                "id": business.id,
                "name": business.name,
                "owner_name": business.owner_name,
                "db_name": business.db_name,
                "is_approved": business.is_approved,
            },
            "login_mail": {
                "sent": login_mail_sent,
                "error": login_mail_error,
            },
            "rbac": rbac_payload,
        },
        status=200,
    )


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def logout(request):
    user = getattr(request, "user", None)
    identifier = "-"
    if user is not None:
        identifier = user.email or user.username or "-"
    log_activity(f"Staff Logout [Email: {identifier}]", user=user)
    return Response({"message": "Logged out"}, status=status.HTTP_200_OK)


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


RBAC_SETTINGS_MODULE = "Settings"


def _has_settings_permission(user, action):
    if is_super_admin(user):
        return True
    return user_has_permission(user, RBAC_SETTINGS_MODULE, action)


def _deny_response(module_name, action_name):
    return Response(
        {
            "detail": "Permission denied.",
            "required": {
                "module": module_name,
                "action": action_name,
            },
        },
        status=status.HTTP_403_FORBIDDEN,
    )


def _write_audit(*, actor=None, role=None, target_user=None, event_type, changes=None):
    try:
        RoleAuditLog.objects.create(
            actor=actor if getattr(actor, "is_authenticated", False) else None,
            role=role,
            target_user=target_user,
            event_type=event_type,
            changes=changes or {},
        )
    except Exception:
        pass


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def permissions_catalog_api(request):
    if not _has_settings_permission(request.user, Permission.ACTION_VIEW):
        return _deny_response(RBAC_SETTINGS_MODULE, Permission.ACTION_VIEW)

    sync_default_permissions()
    queryset = Permission.objects.filter(is_active=True).order_by("module", "action")
    serializer = PermissionDefinitionSerializer(queryset, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def roles_list_api(request):
    if not _has_settings_permission(request.user, Permission.ACTION_VIEW):
        return _deny_response(RBAC_SETTINGS_MODULE, Permission.ACTION_VIEW)

    sync_default_permissions()
    queryset = Role.objects.prefetch_related("role_permissions__permission", "user_roles").all().order_by("-id")
    serializer = RoleReadSerializer(queryset, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def roles_create_api(request):
    if not _has_settings_permission(request.user, Permission.ACTION_CREATE):
        return _deny_response(RBAC_SETTINGS_MODULE, Permission.ACTION_CREATE)

    serializer = RoleWriteSerializer(data=request.data, context={"actor": request.user})
    serializer.is_valid(raise_exception=True)
    role = serializer.save()

    _write_audit(
        actor=request.user,
        role=role,
        event_type=RoleAuditLog.EVENT_CREATE,
        changes={"name": role.name},
    )

    return Response(RoleReadSerializer(role).data, status=status.HTTP_201_CREATED)


@api_view(["GET", "PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def role_detail_api(request, pk):
    role = Role.objects.filter(pk=pk).first()
    if not role:
        return Response({"detail": "Role not found."}, status=status.HTTP_404_NOT_FOUND)

    if request.method == "GET":
        required_action = Permission.ACTION_VIEW
    elif request.method == "DELETE":
        required_action = Permission.ACTION_DELETE
    else:
        required_action = Permission.ACTION_EDIT

    if not _has_settings_permission(request.user, required_action):
        return _deny_response(RBAC_SETTINGS_MODULE, required_action)

    if request.method == "GET":
        return Response(RoleReadSerializer(role).data, status=status.HTTP_200_OK)

    if request.method in {"PUT", "PATCH"}:
        partial = request.method == "PATCH"
        serializer = RoleWriteSerializer(
            instance=role,
            data=request.data,
            partial=partial,
            context={"actor": request.user},
        )
        serializer.is_valid(raise_exception=True)
        updated_role = serializer.save()

        _write_audit(
            actor=request.user,
            role=updated_role,
            event_type=RoleAuditLog.EVENT_UPDATE,
            changes={"name": updated_role.name, "is_active": updated_role.is_active},
        )

        return Response(RoleReadSerializer(updated_role).data, status=status.HTTP_200_OK)

    if role.is_super_admin and not is_super_admin(request.user):
        return Response(
            {"detail": "Only Super Admin can delete a Super Admin role."},
            status=status.HTTP_403_FORBIDDEN,
        )

    if role.is_super_admin:
        active_super_admin_count = Role.objects.filter(is_super_admin=True, is_active=True).count()
        if active_super_admin_count <= 1:
            return Response(
                {"detail": "Cannot delete the last active Super Admin role."},
                status=status.HTTP_400_BAD_REQUEST,
            )

    role_data = {
        "id": role.id,
        "name": role.name,
        "is_super_admin": role.is_super_admin,
    }
    role.delete()
    _write_audit(
        actor=request.user,
        role=None,
        event_type=RoleAuditLog.EVENT_DELETE,
        changes=role_data,
    )
    return Response({"success": True, "message": "Role deleted."}, status=status.HTTP_200_OK)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def assign_role_to_user_api(request):
    if not _has_settings_permission(request.user, Permission.ACTION_EDIT):
        return _deny_response(RBAC_SETTINGS_MODULE, Permission.ACTION_EDIT)

    serializer = UserRoleAssignmentSerializer(data=request.data, context={"actor": request.user})
    serializer.is_valid(raise_exception=True)
    result = serializer.save()

    user_obj = result["user"]
    active_role_ids = result["active_role_ids"]
    assigned_role_names = list(
        Role.objects.filter(id__in=active_role_ids).order_by("-is_super_admin", "-level", "name").values_list(
            "name", flat=True
        )
    )

    _write_audit(
        actor=request.user,
        role=None,
        target_user=user_obj,
        event_type=RoleAuditLog.EVENT_ASSIGN,
        changes={"role_ids": active_role_ids},
    )

    return Response(
        {
            "success": True,
            "user": {
                "id": user_obj.id,
                "email": user_obj.email,
                "username": user_obj.username,
            },
            "assigned_roles": assigned_role_names,
            "rbac": build_user_access_payload(user_obj),
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def my_permissions_api(request):
    sync_default_permissions()
    return Response(build_user_access_payload(request.user), status=status.HTTP_200_OK)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def legacy_roles_api(request):
    if request.method == "GET":
        return roles_list_api(request)
    return roles_create_api(request)


# =========================
# SALES LIST
# =========================
@api_view(["GET"])
@permission_classes([IsAuthenticated])
def sales_proposals(request):
    proposals = Proposal.objects.all().order_by("-id")
    serializer = ProposalSerializer(proposals, many=True)
    return Response(serializer.data, status=200)


def send_proposal_assignment_email(proposal, user):
    if not user:
        return False
    candidates = [
        getattr(user, "email", None),
        getattr(user, "username", None),
        getattr(user, "first_name", None),
        getattr(user, "last_name", None),
    ]
    recipient = next(
        (value for value in candidates if value and "@" in str(value)),
        None,
    )
    if not recipient:
        return False

    try:
        frontend_url = f"http://localhost:3000/sales/proposals/{proposal.id}"
        subject = f"New Proposal Assigned - #{proposal.id}"

        html_content = f"""
<h3 style="margin:0 0 10px 0;color:#0f172a;">New Proposal Assigned</h3>
<p>Hello <strong>{user.first_name or user.username}</strong>,</p>
<p>You have been assigned a new proposal. Details are below:</p>
<table style="width:100%; border-collapse: collapse; margin-top:15px;">
    <tr>
        <td style="padding:8px; border:1px solid #d1d5db;"><strong>Proposal ID</strong></td>
        <td style="padding:8px; border:1px solid #d1d5db;">#{proposal.id}</td>
    </tr>
    <tr>
        <td style="padding:8px; border:1px solid #d1d5db;"><strong>Subject</strong></td>
        <td style="padding:8px; border:1px solid #d1d5db;">{getattr(proposal, 'subject', 'N/A')}</td>
    </tr>
    <tr>
        <td style="padding:8px; border:1px solid #d1d5db;"><strong>Total</strong></td>
        <td style="padding:8px; border:1px solid #d1d5db;">{getattr(proposal, 'total', '0')}</td>
    </tr>
</table>
<div style="text-align:center; margin-top:25px;">
    <a href="{frontend_url}" 
       style="background:#27ae60; color:#ffffff; padding:12px 25px; text-decoration:none; border-radius:5px; display:inline-block;">
       View Proposal
    </a>
</div>
<p style="margin-top:24px;">Regards,<br/><strong>Magnyte Solution CRM Team</strong></p>
"""

        text_content = strip_tags(html_content)
        send_branded_email(
            subject=subject,
            message=text_content,
            to_emails=[recipient],
            html_message=html_content,
            fail_silently=False,
        )
        print("HTML EMAIL SENT TO:", recipient)
        return True
    except Exception as e:
        print("EMAIL ERROR:", str(e))
        return False

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
        email_sent = send_proposal_assignment_email(proposal, user)
        recipient = (
            getattr(user, "email", None)
            or getattr(user, "username", None)
            or getattr(user, "first_name", None)
            or getattr(user, "last_name", None)
            or ""
        )
        return Response(
            {
                "message": "Assigned successfully",
                "email_sent": email_sent,
                "email_to": recipient,
            }
        )

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
        proposal = serializer.save(created_by=request.user)
        if proposal.assigned_to:
            send_proposal_assignment_email(proposal, proposal.assigned_to)
        return Response(serializer.data, status=201)
    return Response(serializer.errors, status=400)


# =========================
# PROPOSAL DETAIL (GET + PUT + DELETE)
# =========================
@api_view(["GET", "PUT", "PATCH", "DELETE"])
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
        previous_assigned_id = proposal.assigned_to_id
        serializer = ProposalSerializer(proposal, data=request.data)
        if serializer.is_valid():
            proposal = serializer.save()
            if proposal.assigned_to_id and proposal.assigned_to_id != previous_assigned_id:
                send_proposal_assignment_email(proposal, proposal.assigned_to)
            return Response(serializer.data)
        return Response(serializer.errors, status=400)

    if request.method == "PATCH":
        serializer = ProposalSerializer(proposal, data=request.data, partial=True)
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
    today = timezone.localdate()
    start_date = today - timedelta(days=6)
    days = [start_date + timedelta(days=offset) for offset in range(7)]
    totals = {day: 0.0 for day in days}

    payments = InvoicePayment.objects.filter(payment_date__range=(start_date, today))
    for payment in payments:
        pay_date = payment.payment_date
        if isinstance(pay_date, datetime):
            pay_date = pay_date.date()
        if pay_date in totals:
            try:
                amount = float(payment.amount or 0)
            except (TypeError, ValueError):
                amount = 0.0
            totals[pay_date] += amount

    labels = [day.strftime("%a") for day in days]
    data = [round(totals[day], 2) for day in days]

    return Response({
        "labels": labels,
        "datasets": [
            {
                "label": "Payments",
                "data": data
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

    def perform_create(self, serializer):
        client = serializer.save()
        name = getattr(client, "company", None) or "Unknown"
        log_activity(f"Customer Created [Name: {name}]", user=getattr(self.request, "user", None))

    def perform_update(self, serializer):
        instance = serializer.instance
        old_active = getattr(instance, "is_active", None)
        client = serializer.save()
        name = getattr(client, "company", None) or "Unknown"
        log_activity(f"Customer Updated [Name: {name}]", user=getattr(self.request, "user", None))
        if old_active is not None and old_active != getattr(client, "is_active", None):
            log_activity(
                f"Customer Status Changed [Name: {name} | Active: {old_active} -> {client.is_active}]",
                user=getattr(self.request, "user", None),
            )

    def perform_destroy(self, instance):
        name = getattr(instance, "company", None) or "Unknown"
        super().perform_destroy(instance)
        log_activity(f"Customer Deleted [Name: {name}]", user=getattr(self.request, "user", None))

    
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
            send_branded_email(
                subject=subject,
                message=message,
                to_emails=[email],
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
        send_branded_email(
            subject=subject,
            message=message,
            to_emails=[email],
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
def _sync_invoice_payment(invoice, user=None):
    payment = InvoicePayment.objects.filter(invoice=invoice).first()

    if payment:
        payment.payment_mode = invoice.payment_mode or "Null"
        payment.transaction_id = f"{invoice.payment_mode}-{invoice.id}"
        payment.amount = invoice.total_amount
        payment.save()
        log_activity(
            f"Payment Updated [Invoice No: {invoice.invoice_number}]",
            user=user,
        )
        return

    InvoicePayment.objects.create(
        invoice=invoice,
        payment_mode=invoice.payment_mode or "Null",
        transaction_id=f"{invoice.payment_mode}-{invoice.id}",
        amount=invoice.total_amount,
    )
    log_activity(
        f"Payment Added [Invoice No: {invoice.invoice_number}]",
        user=user,
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
            _sync_invoice_payment(invoice, user=getattr(request, "user", None))
            log_activity(
                f"Invoice Created [Invoice No: {invoice.invoice_number}]",
                user=getattr(request, "user", None),
            )
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
            _sync_invoice_payment(updated_invoice, user=getattr(request, "user", None))
            log_activity(
                f"Invoice Updated [Invoice No: {updated_invoice.invoice_number}]",
                user=getattr(request, "user", None),
            )
            return Response(InvoiceSerializer(updated_invoice).data)
        return Response(serializer.errors, status=400)

    log_activity(
        f"Invoice Deleted [Invoice No: {invoice.invoice_number}]",
        user=getattr(request, "user", None),
    )
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
        send_branded_email(
            subject=subject,
            message=message,
            to_emails=[email],
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
        invoice_no = getattr(getattr(payment, "invoice", None), "invoice_number", None) or "-"
        log_activity(
            f"Payment Added [Invoice No: {invoice_no}]",
            user=getattr(request, "user", None),
        )

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
def create_invoice_from_estimate(estimate, user=None):

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

    log_activity(
        f"Invoice Created [Invoice No: {invoice.invoice_number}]",
        user=user,
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

    old_active = client.is_active
    raw_active = request.data.get("is_active")
    if isinstance(raw_active, str):
        is_active = raw_active.strip().lower() in {"1", "true", "yes", "y"}
    elif raw_active is None:
        is_active = client.is_active
    else:
        is_active = bool(raw_active)

    client.is_active = is_active
    client.save()
    name = getattr(client, "company", None) or "Unknown"
    log_activity(
        f"Customer Status Changed [Name: {name} | Active: {old_active} -> {is_active}]",
        user=getattr(request, "user", None),
    )

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
    """List or create contacts.

    The original implementation queried *all* fields of the ``Contact`` model.
    In environments where the address columns (``street``, ``city``, ``state``,
    ``zip_code`` and ``country``) have not been created yet, this resulted in an
    ``OperationalError`` ("Unknown column 'core_contact.street'"). The address
    fields are not used by the API response – ``_serialize_contact`` deliberately
    omits them – so we can safely restrict the query to the columns that are
    required for the serialization. Using ``only()`` ensures Django does *not*
    include the missing columns in the SELECT statement, preventing the error
    while keeping the existing behaviour intact.
    """
    if request.method == "GET":
        # Explicitly fetch only the fields that ``_serialize_contact`` needs.
        # This guards against missing address columns in the database.
        contacts = (
            Contact.objects.only(
                "id",
                "is_primary",
                "firstname",
                "lastname",
                "email",
                "phonenumber",
                "title",
                "password",
                "last_login",
                "active",
                "direction",
                "invoice_emails",
                "estimate_emails",
                "credit_note_emails",
                "contract_emails",
                "task_emails",
                "project_emails",
                "ticket_emails",
                "company",
                "created_at",
            )
            .order_by("-created_at", "-id")
        )
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
    staff_name = f"{getattr(staff, 'firstname', '')} {getattr(staff, 'lastname', '')}".strip() or getattr(staff, "email", "") or "Staff"
    log_activity(f"Staff Created [Name: {staff_name}]", user=getattr(request, "user", None))
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
        staff_name = f"{getattr(staff, 'firstname', '')} {getattr(staff, 'lastname', '')}".strip() or getattr(staff, "email", "") or "Staff"
        log_activity(f"Staff Deleted [Name: {staff_name}]", user=getattr(request, "user", None))
        staff.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    data = request.data.copy()

    if "password" in data:
        raw_password = (data.get("password") or "").strip()
        if raw_password:
            data["password"] = make_password(raw_password)
        else:
            data.pop("password", None)

    old_active = getattr(staff, "active", None)
    serializer = StaffSerializer(staff, data=data, partial=True)
    serializer.is_valid(raise_exception=True)
    staff = serializer.save()
    if old_active is not None and old_active != getattr(staff, "active", None):
        staff_name = f"{getattr(staff, 'firstname', '')} {getattr(staff, 'lastname', '')}".strip() or getattr(staff, "email", "") or "Staff"
        log_activity(
            f"Staff Status Changed [Name: {staff_name} | Active: {old_active} -> {staff.active}]",
            user=getattr(request, "user", None),
        )
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
from datetime import datetime, timedelta
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


# ========================= UTILITIES APIs =========================
def _apply_limit(qs, request):
    limit = request.query_params.get("limit")
    if limit:
        try:
            qs = qs[: int(limit)]
        except (TypeError, ValueError):
            pass
    return qs


def _safe_legacy_list(request, model, fields, order_by=None):
    from core.middleware import get_current_db

    db = get_current_db()
    try:
        qs = model.objects.using(db).all()
        if order_by:
            qs = qs.order_by(order_by)
        qs = _apply_limit(qs, request)
        return Response(list(qs.values(*fields)))
    except (ProgrammingError, OperationalError) as exc:
        print(f"Utilities list failed for {model.__name__}: {exc}")
        return Response([])


def _purge_demo_ticket_pipe_log():
    from core.middleware import get_current_db

    db = get_current_db()
    try:
        sample_emails = {
            "aarav.sharma@example.com",
            "neha.patel@example.com",
            "rohan.mehta@example.com",
        }
        sample_messages = {
            "Facing login issue after password reset.",
            "Invoice email received but PDF is missing.",
            "Test email for ticket pipe log.",
        }
        LegacyTicketsPipeLog.objects.using(db).filter(
            email__in=sample_emails,
            email_to="support@magnyte.com",
        ).delete()
        LegacyTicketsPipeLog.objects.using(db).filter(
            message__in=sample_messages
        ).delete()
    except (ProgrammingError, OperationalError) as exc:
        print("Ticket pipe log demo purge failed:", exc)


def _parse_sql_insert_values(values_text):
    rows = []
    i = 0
    n = len(values_text)

    while i < n:
        c = values_text[i]
        if c == "(":
            i += 1
            fields = []
            current = []
            in_string = False
            escape = False

            while i < n:
                ch = values_text[i]
                if in_string:
                    if escape:
                        current.append(ch)
                        escape = False
                    elif ch == "\\":
                        escape = True
                    elif ch == "'":
                        in_string = False
                    else:
                        current.append(ch)
                else:
                    if ch == "'":
                        in_string = True
                    elif ch == ",":
                        fields.append("".join(current).strip())
                        current = []
                    elif ch == ")":
                        fields.append("".join(current).strip())
                        rows.append(fields)
                        break
                    else:
                        current.append(ch)
                i += 1
        i += 1

    return rows


def _coerce_staffid(value, staff_type, allow_null):
    if value is None:
        return None if allow_null else 0
    if "int" in staff_type or "decimal" in staff_type or "numeric" in staff_type:
        if isinstance(value, int):
            return value
        if isinstance(value, str):
            try:
                return int(value)
            except ValueError:
                return None if allow_null else 0
        return None if allow_null else 0
    return value


def _seed_activity_log_if_empty(db_alias):
    try:
        with connections[db_alias].cursor() as cursor:
            cursor.execute("SELECT COUNT(*) FROM ms_activity_log")
            row = cursor.fetchone()
            if row and row[0] > 0:
                return

            cursor.execute("SHOW COLUMNS FROM ms_activity_log LIKE 'staffid'")
            staff_col = cursor.fetchone()
            staff_type = (staff_col[1] or "").lower() if staff_col else ""
            allow_null = (staff_col[2] == "YES") if staff_col else True

            sql_path = os.path.join(settings.BASE_DIR, "my_crm.sql")
            if not os.path.exists(sql_path):
                return

            with open(sql_path, "r", encoding="utf-8", errors="ignore") as handle:
                sql_text = handle.read()

            match = re.search(r"INSERT INTO `ms_activity_log`.*?VALUES\s*(.*?);", sql_text, re.S)
            if not match:
                return

            values_text = match.group(1)
            rows = _parse_sql_insert_values(values_text)
            if not rows:
                return

            payload = []
            for row_vals in rows:
                if len(row_vals) < 4:
                    continue
                def _parse_value(raw):
                    if raw is None:
                        return None
                    raw = raw.strip()
                    if raw.upper() == "NULL":
                        return None
                    if re.fullmatch(r"-?\d+", raw or ""):
                        try:
                            return int(raw)
                        except ValueError:
                            return raw
                    return raw

                parsed = [_parse_value(v) for v in row_vals[:4]]
                parsed[3] = _coerce_staffid(parsed[3], staff_type, allow_null)
                payload.append(tuple(parsed))

            if payload:
                cursor.executemany(
                    "INSERT INTO ms_activity_log (id, description, date, staffid) VALUES (%s, %s, %s, %s)",
                    payload,
                )
    except Exception as exc:
        print("Activity log seed failed:", exc)


def _seed_surveys_if_empty(db_alias):
    try:
        with connections[db_alias].cursor() as cursor:
            cursor.execute("SELECT COUNT(*) FROM ms_surveys")
            row = cursor.fetchone()
            if row and row[0] > 0:
                return

            sql_path = os.path.join(settings.BASE_DIR, "my_crm.sql")
            if not os.path.exists(sql_path):
                return

            with open(sql_path, "r", encoding="utf-8", errors="ignore") as handle:
                sql_text = handle.read()

            match = re.search(r"INSERT INTO `ms_surveys`.*?VALUES\s*(.*?);", sql_text, re.S)
            if not match:
                return

            values_text = match.group(1)
            rows = _parse_sql_insert_values(values_text)
            if not rows:
                return

            def _parse_value(raw):
                if raw is None:
                    return None
                raw = raw.strip()
                if raw.upper() == "NULL":
                    return None
                if re.fullmatch(r"-?\d+", raw or ""):
                    try:
                        return int(raw)
                    except ValueError:
                        return raw
                return raw

            payload = []
            for row_vals in rows:
                if len(row_vals) < 13:
                    continue
                parsed = [_parse_value(v) for v in row_vals[:13]]
                payload.append(tuple(parsed))

            if payload:
                cursor.executemany(
                    """
                    INSERT INTO ms_surveys
                    (surveyid, subject, slug, description, viewdescription, datecreated,
                     redirect_url, send, onlyforloggedin, fromname, iprestrict, active, hash)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """,
                    payload,
                )
    except Exception as exc:
        print("Surveys seed failed:", exc)


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def announcements_list(request):
    fields = [
        "announcementid",
        "name",
        "message",
        "showtousers",
        "showtostaff",
        "showname",
        "dateadded",
        "userid",
    ]

    try:
        ensure_announcements_table()
    except Exception as exc:
        print("Announcements table ensure failed:", exc)

    if request.method == "GET":
        return _safe_legacy_list(request, LegacyAnnouncements, fields, order_by="-dateadded")

    def _normalize_list(raw):
        if raw is None:
            return []
        if isinstance(raw, (list, tuple, set)):
            return list(raw)
        if isinstance(raw, str):
            raw = raw.strip()
            if not raw:
                return []
            if raw.startswith("[") and raw.endswith("]"):
                try:
                    parsed = json.loads(raw)
                    return _normalize_list(parsed)
                except Exception:
                    pass
            return [item for item in re.split(r"[,\s;]+", raw) if item]
        return [raw]

    def _parse_int_list(raw):
        items = _normalize_list(raw)
        parsed = []
        for item in items:
            try:
                parsed.append(int(item))
            except (TypeError, ValueError):
                continue
        return parsed

    def _parse_email_list(raw):
        items = _normalize_list(raw)
        emails = []
        for item in items:
            if item is None:
                continue
            value = str(item).strip()
            if not value or "@" not in value:
                continue
            emails.append(value)
        return emails

    def _resolve_owner_email():
        try:
            business = LegacyBusiness.objects.first()
            if business and getattr(business, "email", None):
                return business.email
        except Exception as exc:
            print("Owner lookup failed:", exc)
        user = getattr(request, "user", None)
        return getattr(user, "email", None) or getattr(user, "username", None)

    def _resolve_sender_staff():
        user = getattr(request, "user", None)
        identifier = (
            getattr(user, "email", None)
            or getattr(user, "username", None)
            or ""
        ).strip()
        if not identifier:
            return None
        try:
            return Staff.objects.filter(email__iexact=identifier).first()
        except Exception:
            return None

    def _resolve_sender_name(sender_staff):
        if sender_staff:
            full_name = f"{sender_staff.firstname} {sender_staff.lastname}".strip()
            return full_name or getattr(sender_staff, "email", None) or "System"
        user = getattr(request, "user", None)
        if user:
            try:
                full_name = user.get_full_name()
            except Exception:
                full_name = ""
            full_name = (full_name or "").strip()
            if full_name:
                return full_name
            return getattr(user, "email", None) or getattr(user, "username", None) or "System"
        return "System"

    data = request.data or {}
    name = (data.get("name") or "").strip()
    message = data.get("message") or ""
    if not name:
        return Response({"detail": "Title is required."}, status=status.HTTP_400_BAD_REQUEST)

    showtousers = int(bool(data.get("showtousers") or data.get("show_to_users")))
    showtostaff = int(bool(data.get("showtostaff") or data.get("show_to_staff")))
    showname = int(bool(data.get("showname", 1)))

    if showtousers == 0 and showtostaff == 0:
        return Response(
            {"detail": "Select at least one audience (users or staff)."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    from core.middleware import get_current_db

    db = get_current_db()
    try:
        announcement = LegacyAnnouncements.objects.using(db).create(
            name=name,
            message=message,
            showtousers=showtousers,
            showtostaff=showtostaff,
            showname=showname,
            dateadded=timezone.now(),
            userid=getattr(request.user, "username", None)
            or getattr(request.user, "email", None)
            or "System",
        )
    except (ProgrammingError, OperationalError) as exc:
        print("Announcement create failed:", exc)
        return Response(
            {"detail": "Unable to create announcement."},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR,
        )

    # -----------------------------
    # Send announcement email + notifications
    # -----------------------------
    try:
        notify_owner = bool(
            data.get("notify_owner", True)
            if not isinstance(data.get("notify_owner", True), str)
            else str(data.get("notify_owner", "true")).lower() not in {"0", "false", "no"}
        )

        recipient_staff_ids = set(_parse_int_list(data.get("recipient_staff_ids") or data.get("staff_ids")))
        recipient_contact_ids = set(_parse_int_list(data.get("recipient_contact_ids") or data.get("contact_ids")))
        recipient_staff_emails = set(_parse_email_list(data.get("recipient_staff_emails")))
        recipient_emails = set(_parse_email_list(data.get("recipient_emails") or data.get("emails")))

        email_recipients = set()
        notify_staff_ids = set()

        if notify_owner:
            owner_email = _resolve_owner_email()
            if owner_email:
                email_recipients.add(owner_email)
                try:
                    owner_staff = Staff.objects.filter(email__iexact=owner_email).first()
                    if owner_staff:
                        notify_staff_ids.add(owner_staff.staffid)
                except Exception:
                    pass

        if recipient_staff_ids:
            for staff in Staff.objects.filter(staffid__in=recipient_staff_ids):
                if getattr(staff, "email", None):
                    email_recipients.add(staff.email)
                notify_staff_ids.add(staff.staffid)

        if recipient_staff_emails:
            email_recipients.update(recipient_staff_emails)
            for staff in Staff.objects.filter(email__in=list(recipient_staff_emails)):
                notify_staff_ids.add(staff.staffid)

        if recipient_contact_ids:
            for contact in Contacts.objects.filter(id__in=recipient_contact_ids):
                if getattr(contact, "email", None):
                    email_recipients.add(contact.email)

        if recipient_emails:
            email_recipients.update(recipient_emails)
            for staff in Staff.objects.filter(email__in=list(recipient_emails)):
                notify_staff_ids.add(staff.staffid)

        sender_staff = _resolve_sender_staff()
        sender_name = _resolve_sender_name(sender_staff)

        if email_recipients:
            html_message = f"""
<h3>New Announcement</h3>
<p><b>Title:</b> {announcement.name}</p>
<p><b>By:</b> {sender_name}</p>
<hr/>
<p>{(announcement.message or '').replace('\n', '<br/>')}</p>
"""
            plain_message = strip_tags(html_message)
            try:
                send_branded_email(
                    subject=f"New Announcement: {announcement.name}",
                    message=plain_message,
                    to_emails=sorted(email_recipients),
                    html_message=html_message,
                    fail_silently=False,
                )
            except Exception as exc:
                print("Announcement email failed:", exc)

        if notify_staff_ids:
            from_user_id = sender_staff.staffid if sender_staff else 0
            description = f"New Announcement: {announcement.name}"
            link = f"/utilities/announcements/{announcement.announcementid}/"
            additional_data = json.dumps(
                {
                    "announcement_id": announcement.announcementid,
                    "title": announcement.name,
                }
            )
            now = timezone.now()
            payload = [
                Notifications(
                    isread=0,
                    isread_inline=0,
                    date=now,
                    description=description,
                    fromuserid=from_user_id,
                    fromclientid=0,
                    from_fullname=sender_name,
                    touserid=staff_id,
                    fromcompany=None,
                    link=link,
                    additional_data=additional_data,
                )
                for staff_id in sorted(notify_staff_ids)
            ]
            try:
                Notifications.objects.bulk_create(payload, batch_size=200)
            except Exception as exc:
                print("Announcement notification failed:", exc)
    except Exception as exc:
        print("Announcement alert processing failed:", exc)

    return Response(
        {
            "announcementid": announcement.announcementid,
            "name": announcement.name,
            "message": announcement.message,
            "showtousers": announcement.showtousers,
            "showtostaff": announcement.showtostaff,
            "showname": announcement.showname,
            "dateadded": announcement.dateadded.isoformat() if announcement.dateadded else None,
            "userid": announcement.userid,
        },
        status=status.HTTP_201_CREATED,
    )


@api_view(["PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def announcements_detail(request, pk):
    try:
        ensure_announcements_table()
    except Exception as exc:
        print("Announcements table ensure failed:", exc)

    from core.middleware import get_current_db

    db = get_current_db()
    announcement = LegacyAnnouncements.objects.using(db).filter(pk=pk).first()

    if not announcement:
        return Response({"detail": "Announcement not found."}, status=status.HTTP_404_NOT_FOUND)

    if request.method == "DELETE":
        announcement.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    data = request.data or {}
    name = data.get("name")
    message = data.get("message")
    showtousers = data.get("showtousers")
    showtostaff = data.get("showtostaff")
    showname = data.get("showname")

    if name is not None:
        announcement.name = str(name).strip()
    if message is not None:
        announcement.message = message
    if showtousers is not None:
        announcement.showtousers = int(bool(showtousers))
    if showtostaff is not None:
        announcement.showtostaff = int(bool(showtostaff))
    if showname is not None:
        announcement.showname = int(bool(showname))

    if announcement.showtousers == 0 and announcement.showtostaff == 0:
        return Response(
            {"detail": "Select at least one audience (users or staff)."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    announcement.save()

    return Response(
        {
            "announcementid": announcement.announcementid,
            "name": announcement.name,
            "message": announcement.message,
            "showtousers": announcement.showtousers,
            "showtostaff": announcement.showtostaff,
            "showname": announcement.showname,
            "dateadded": announcement.dateadded.isoformat() if announcement.dateadded else None,
            "userid": announcement.userid,
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def goals_list(request):
    fields = [
        "id",
        "subject",
        "description",
        "start_date",
        "end_date",
        "goal_type",
        "contract_type",
        "achievement",
        "notify_when_fail",
        "notify_when_achieve",
        "notified",
        "staff_id",
    ]

    try:
        ensure_goals_table()
    except Exception as exc:
        print("Goals table ensure failed:", exc)

    if request.method == "GET":
        return _safe_legacy_list(request, LegacyGoals, fields, order_by="-end_date")

    data = request.data or {}
    subject = (data.get("subject") or "").strip()
    description = data.get("description") or ""
    start_date = data.get("start_date")
    end_date = data.get("end_date")

    if not subject or not start_date or not end_date:
        return Response(
            {"detail": "Subject, start date and end date are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    def _to_int(value, default=0):
        try:
            return int(value)
        except (TypeError, ValueError):
            return default

    from core.middleware import get_current_db

    db = get_current_db()
    try:
        goal = LegacyGoals.objects.using(db).create(
            subject=subject,
            description=description,
            start_date=start_date,
            end_date=end_date,
            goal_type=_to_int(data.get("goal_type")),
            contract_type=_to_int(data.get("contract_type")),
            achievement=_to_int(data.get("achievement")),
            notify_when_fail=_to_int(data.get("notify_when_fail")),
            notify_when_achieve=_to_int(data.get("notify_when_achieve")),
            notified=_to_int(data.get("notified")),
            staff_id=_to_int(data.get("staff_id")),
        )
    except (ProgrammingError, OperationalError) as exc:
        print("Goals create failed:", exc)
        return Response(
            {"detail": "Unable to create goal."},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR,
        )

    return Response(
        {
            "id": goal.id,
            "subject": goal.subject,
            "description": goal.description,
            "start_date": goal.start_date,
            "end_date": goal.end_date,
            "goal_type": goal.goal_type,
            "contract_type": goal.contract_type,
            "achievement": goal.achievement,
            "notify_when_fail": goal.notify_when_fail,
            "notify_when_achieve": goal.notify_when_achieve,
            "notified": goal.notified,
            "staff_id": goal.staff_id,
        },
        status=status.HTTP_201_CREATED,
    )


@api_view(["PUT", "PATCH", "DELETE"])
@permission_classes([IsAuthenticated])
def goals_detail(request, pk):
    try:
        ensure_goals_table()
    except Exception as exc:
        print("Goals table ensure failed:", exc)

    from core.middleware import get_current_db

    db = get_current_db()
    goal = LegacyGoals.objects.using(db).filter(pk=pk).first()

    if not goal:
        return Response({"detail": "Goal not found."}, status=status.HTTP_404_NOT_FOUND)

    if request.method == "DELETE":
        goal.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)

    data = request.data or {}

    if "subject" in data:
        goal.subject = (data.get("subject") or "").strip()
    if "description" in data:
        goal.description = data.get("description") or ""
    if "start_date" in data:
        goal.start_date = data.get("start_date") or goal.start_date
    if "end_date" in data:
        goal.end_date = data.get("end_date") or goal.end_date

    def _to_int(value, default):
        try:
            return int(value)
        except (TypeError, ValueError):
            return default

    if "goal_type" in data:
        goal.goal_type = _to_int(data.get("goal_type"), goal.goal_type)
    if "contract_type" in data:
        goal.contract_type = _to_int(data.get("contract_type"), goal.contract_type)
    if "achievement" in data:
        goal.achievement = _to_int(data.get("achievement"), goal.achievement)
    if "notify_when_fail" in data:
        goal.notify_when_fail = _to_int(data.get("notify_when_fail"), goal.notify_when_fail)
    if "notify_when_achieve" in data:
        goal.notify_when_achieve = _to_int(data.get("notify_when_achieve"), goal.notify_when_achieve)
    if "notified" in data:
        goal.notified = _to_int(data.get("notified"), goal.notified)
    if "staff_id" in data:
        goal.staff_id = _to_int(data.get("staff_id"), goal.staff_id)

    if not goal.subject or not goal.start_date or not goal.end_date:
        return Response(
            {"detail": "Subject, start date and end date are required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    goal.save()

    return Response(
        {
            "id": goal.id,
            "subject": goal.subject,
            "description": goal.description,
            "start_date": goal.start_date,
            "end_date": goal.end_date,
            "goal_type": goal.goal_type,
            "contract_type": goal.contract_type,
            "achievement": goal.achievement,
            "notify_when_fail": goal.notify_when_fail,
            "notify_when_achieve": goal.notify_when_achieve,
            "notified": goal.notified,
            "staff_id": goal.staff_id,
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def activity_log_list(request):
    return _activity_logs_response(request)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def activity_logs_api(request):
    return _activity_logs_response(request)


def _serialize_legacy_activity_log(log):
    staff = getattr(log, "staff_name", None) or "-"
    date_value = getattr(log, "date", None)
    if date_value:
        try:
            date_value = timezone.localtime(date_value)
        except Exception:
            pass
        date_value = date_value.strftime("%Y-%m-%d %H:%M:%S")
    else:
        date_value = "-"
    return {
        "id": getattr(log, "id", None),
        "description": getattr(log, "description", "") or "",
        "staff": staff,
        "staff_name": staff,
        "date": date_value,
    }


def _activity_logs_response(request):
    current_user = getattr(request, "user", None)
    try:
        if CoreActivityLog.objects.exists():
            qs = CoreActivityLog.objects.filter(user=current_user).order_by("-created_at")
            qs = _apply_limit(qs, request)
            return Response([serialize_activity_log(log) for log in qs])
    except (ProgrammingError, OperationalError) as exc:
        print("Core activity log query failed:", exc)

    try:
        ensure_activity_log_table()
    except Exception as exc:
        print("Activity log table ensure failed:", exc)

    from core.middleware import get_current_db

    db = get_current_db()
    try:
        candidate_staff_ids = []
        if current_user is not None:
            candidate_staff_ids.extend([
                str(getattr(current_user, "id", "")).strip(),
                str(getattr(current_user, "username", "")).strip(),
                str(getattr(current_user, "email", "")).strip(),
                str(getattr(current_user, "get_full_name", lambda: "")()).strip(),
            ])
        candidate_staff_ids = [x for x in candidate_staff_ids if x]

        qs = LegacyActivityLog.objects.using(db).all()
        if candidate_staff_ids:
            staff_filter = Q()
            for value in candidate_staff_ids:
                staff_filter |= Q(staff_name__iexact=value)
            qs = qs.filter(staff_filter)
        else:
            qs = qs.none()

        qs = qs.order_by("-date")
        qs = _apply_limit(qs, request)
        return Response([_serialize_legacy_activity_log(log) for log in qs])
    except (ProgrammingError, OperationalError) as exc:
        print("Legacy activity log query failed:", exc)
        return Response([])


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def surveys_list(request):
    try:
        ensure_surveys_table()
    except Exception as exc:
        print("Surveys table ensure failed:", exc)

    from core.middleware import get_current_db

    db = get_current_db()
    _seed_surveys_if_empty(db)

    if request.method == "GET":
        fields = [
            "surveyid",
            "subject",
            "description",
            "datecreated",
            "active",
            "send",
            "slug",
        ]
        return _safe_legacy_list(request, LegacySurveys, fields, order_by="-datecreated")

    data = request.data or {}
    subject = (data.get("subject") or "").strip()
    description = (data.get("description") or "").strip()
    viewdescription = (data.get("viewdescription") or "").strip()

    if not subject:
        return Response({"detail": "Subject is required."}, status=status.HTTP_400_BAD_REQUEST)

    slug = (data.get("slug") or "").strip()
    if not slug:
        slug = slugify(subject)
    if not slug:
        slug = f"survey-{uuid.uuid4().hex[:8]}"

    base_slug = slug
    suffix = 1
    while LegacySurveys.objects.using(db).filter(slug=slug).exists():
        slug = f"{base_slug}-{suffix}"
        suffix += 1

    active = 1 if bool(data.get("active", True)) else 0
    send = 1 if bool(data.get("send", False)) else 0
    onlyforloggedin = 1 if bool(data.get("onlyforloggedin", False)) else 0
    fromname = (
        data.get("fromname")
        or getattr(request.user, "username", None)
        or getattr(request.user, "email", None)
        or ""
    )
    iprestrict = 1 if bool(data.get("iprestrict", False)) else 0
    redirect_url = data.get("redirect_url") or None

    try:
        survey = LegacySurveys.objects.using(db).create(
            subject=subject,
            slug=slug,
            description=description or "No description",
            viewdescription=viewdescription or "",
            datecreated=timezone.now(),
            redirect_url=redirect_url,
            send=send,
            onlyforloggedin=onlyforloggedin,
            fromname=fromname,
            iprestrict=iprestrict,
            active=active,
            hash=uuid.uuid4().hex,
        )
    except (ProgrammingError, OperationalError) as exc:
        print("Survey create failed:", exc)
        return Response(
            {"detail": "Unable to create survey."},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR,
        )

    return Response(
        {
            "surveyid": survey.surveyid,
            "subject": survey.subject,
            "description": survey.description,
            "datecreated": survey.datecreated,
            "active": survey.active,
            "send": survey.send,
            "slug": survey.slug,
        },
        status=status.HTTP_201_CREATED,
    )


@api_view(["PUT", "PATCH"])
@permission_classes([IsAuthenticated])
def surveys_detail(request, pk):
    try:
        ensure_surveys_table()
    except Exception as exc:
        print("Surveys table ensure failed:", exc)

    from core.middleware import get_current_db

    db = get_current_db()
    survey = LegacySurveys.objects.using(db).filter(pk=pk).first()
    if not survey:
        return Response({"detail": "Survey not found."}, status=status.HTTP_404_NOT_FOUND)

    data = request.data or {}
    updated = False

    if "active" in data:
        survey.active = int(bool(data.get("active")))
        updated = True

    if "subject" in data:
        subject = (data.get("subject") or "").strip()
        if subject:
            survey.subject = subject
            updated = True

    if "description" in data:
        survey.description = (data.get("description") or "").strip()
        updated = True

    if "slug" in data:
        slug = (data.get("slug") or "").strip()
        if slug:
            survey.slug = slug
            updated = True

    if not updated:
        return Response(
            {"detail": "No fields to update."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if not survey.subject:
        return Response({"detail": "Subject is required."}, status=status.HTTP_400_BAD_REQUEST)

    survey.save()

    return Response(
        {
            "surveyid": survey.surveyid,
            "subject": survey.subject,
            "description": survey.description,
            "datecreated": survey.datecreated,
            "active": survey.active,
            "send": survey.send,
            "slug": survey.slug,
        },
        status=status.HTTP_200_OK,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def ticket_pipe_log_list(request):
    try:
        ensure_tickets_pipe_log_table()
    except Exception as exc:
        print("Ticket pipe log table ensure failed:", exc)

    _purge_demo_ticket_pipe_log()

    fields = [
        "id",
        "date",
        "group_name",
        "log_filter",
        "name",
        "message",
        "status",
        "email_to",
        "subject",
        "email",
        "cc_emails",
        "mention_emails",
        "role_name",
        "tag",
    ]
    return _safe_legacy_list(request, LegacyTicketsPipeLog, fields, order_by="-date")


def _extract_email_values(raw_value):
    if raw_value is None:
        return []

    if isinstance(raw_value, list):
        candidates = raw_value
    else:
        candidates = str(raw_value).replace(";", ",").split(",")

    unique = []
    seen = set()
    for item in candidates:
        if isinstance(item, dict):
            value = (
                item.get("email")
                or item.get("value")
                or item.get("label")
                or ""
            )
        else:
            value = item

        email_value = str(value or "").strip()
        if not email_value or "@" not in email_value:
            continue

        key = email_value.lower()
        if key in seen:
            continue

        seen.add(key)
        unique.append(email_value)

    return unique


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def support_ticket_pipe_create(request):
    from core.middleware import get_current_db

    try:
        ensure_tickets_pipe_log_table()
    except Exception as exc:
        print("Support ticket table ensure failed:", exc)

    payload = request.data or {}

    email_to = str(payload.get("email") or payload.get("email_to") or "").strip()
    if not email_to or "@" not in email_to:
        return Response(
            {"detail": "Valid recipient Email is required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    raw_html_message = str(payload.get("message") or "").strip()
    raw_plain_message = str(payload.get("massage") or "").strip()

    # Strip risky blocks but keep standard rich-text formatting from Support editor.
    html_message = re.sub(r"(?is)<(script|style).*?>.*?</\1>", "", raw_html_message).strip()

    plain_source = raw_plain_message or html_message
    plain_source = re.sub(r"(?i)<br\s*/?>", "\n", plain_source)
    plain_source = re.sub(r"(?i)</p>", "\n", plain_source)

    message = strip_tags(plain_source)
    message = html.unescape(message)
    message = message.replace("\r\n", "\n").replace("\r", "\n")
    message = re.sub(r"[ \t]+\n", "\n", message)
    message = re.sub(r"\n{3,}", "\n\n", message).strip()
    if not message:
        return Response(
            {"detail": "Message is required."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    contact_value = str(payload.get("contact") or "").strip()
    name = str(payload.get("name") or "").strip() or contact_value or email_to
    group_name = str(payload.get("group") or payload.get("group_name") or "General").strip() or "General"
    role_name = str(payload.get("role") or payload.get("role_name") or "").strip()
    tag = str(payload.get("tag") or "").strip()
    log_filter = str(payload.get("filter") or payload.get("log_filter") or tag).strip()
    ticket_status = str(payload.get("status") or "Draft").strip() or "Draft"
    subject = str(payload.get("subject") or f"Support Ticket - {group_name}").strip()

    cc_emails = _extract_email_values(payload.get("cc"))
    mention_emails = _extract_email_values(payload.get("mention"))

    cc_recipients = []
    seen_cc = {email_to.lower()}
    for value in cc_emails + mention_emails:
        key = value.lower()
        if key in seen_cc:
            continue
        seen_cc.add(key)
        cc_recipients.append(value)

    mail_status = "sent"
    try:
        send_branded_email(
            subject=subject,
            message=message,
            to_emails=[email_to],
            cc=cc_recipients,
            html_message=html_message or None,
            fail_silently=False,
        )
    except Exception as exc:
        print("Support ticket email failed:", exc)
        mail_status = "failed"

    db = get_current_db()
    record = LegacyTicketsPipeLog.objects.using(db).create(
        date=timezone.now(),
        email_to=email_to,
        name=name,
        subject=subject,
        message=message,
        email=",".join(cc_recipients),
        status=ticket_status,
        group_name=group_name,
        log_filter=log_filter,
        cc_emails=",".join(cc_emails),
        mention_emails=",".join(mention_emails),
        role_name=role_name,
        tag=tag,
    )

    return Response(
        {
            "id": record.id,
            "status": ticket_status,
            "mail_status": mail_status,
            "email_to": email_to,
            "cc": cc_emails,
            "mention": mention_emails,
        },
        status=status.HTTP_201_CREATED,
    )


BACKUP_HISTORY = []
BACKUP_ID_COUNTER = [0]


def _backup_storage_dir():
    base_dir = settings.MEDIA_ROOT
    backup_dir = os.path.join(base_dir, "db_backups")
    os.makedirs(backup_dir, exist_ok=True)
    return backup_dir


def _load_backup_history_if_needed():
    if BACKUP_HISTORY:
        return

    backup_dir = _backup_storage_dir()
    if not os.path.isdir(backup_dir):
        return

    groups = {}
    for entry in os.listdir(backup_dir):
        path = os.path.join(backup_dir, entry)
        if not os.path.isfile(path):
            continue
        base, ext = os.path.splitext(entry)
        ext = ext.lower()
        if ext not in {".sql", ".pdf"}:
            continue
        group = groups.setdefault(base, {})
        if ext == ".sql":
            group["sql"] = path
        elif ext == ".pdf":
            group["pdf"] = path

    if not groups:
        return

    def group_mtime(group):
        times = [os.path.getmtime(p) for p in group.values() if p]
        return max(times) if times else 0

    records = []
    current_tz = timezone.get_current_timezone()
    for base, group in sorted(groups.items(), key=lambda item: group_mtime(item[1]), reverse=True):
        sql_path = group.get("sql")
        pdf_path = group.get("pdf")
        primary_path = sql_path or pdf_path
        if not primary_path:
            continue
        created_at = datetime.fromtimestamp(group_mtime(group), tz=current_tz).isoformat()
        download_type = "pdf" if pdf_path else "sql"
        name = os.path.basename(sql_path or pdf_path)
        records.append(
            {
                "id": len(records) + 1,
                "name": name,
                "created_at": created_at,
                "status": "completed",
                "size": os.path.getsize(primary_path) if os.path.exists(primary_path) else None,
                "created_by": "",
                "notes": "",
                "download_type": download_type,
                "file_path": sql_path,
                "pdf_path": pdf_path,
            }
        )

    BACKUP_HISTORY.extend(records)
    BACKUP_ID_COUNTER[0] = max(BACKUP_ID_COUNTER[0], len(BACKUP_HISTORY))


def _safe_backup_filename(raw_name, fallback):
    cleaned = os.path.basename((raw_name or "").strip())
    cleaned = cleaned.replace(" ", "_")
    if not cleaned:
        cleaned = fallback
    if not cleaned.lower().endswith(".sql"):
        cleaned = f"{cleaned}.sql"
    return cleaned


def _delete_backup_files(record):
    for key in ("file_path", "pdf_path"):
        path = record.get(key)
        if path and os.path.exists(path):
            try:
                os.remove(path)
            except Exception as exc:
                print(f"Failed to delete backup file {path}: {exc}")


def _run_mysqldump(db_conf, file_path):
    host = db_conf.get("HOST") or "localhost"
    user = db_conf.get("USER") or ""
    password = db_conf.get("PASSWORD") or ""
    port = str(db_conf.get("PORT") or "3306")
    db_name = db_conf.get("NAME")
    if not db_name:
        raise ValueError("Database name is missing")

    env = os.environ.copy()
    if password:
        env["MYSQL_PWD"] = password

    cmd = [
        "mysqldump",
        f"--host={host}",
        f"--user={user}",
        f"--port={port}",
        "--single-transaction",
        "--skip-lock-tables",
        db_name,
    ]

    with open(file_path, "w", encoding="utf-8") as output:
        result = subprocess.run(
            cmd,
            stdout=output,
            stderr=subprocess.PIPE,
            text=True,
            env=env,
        )

    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or "mysqldump failed")


def _dumpdata_fallback(file_path):
    from django.core.management import call_command

    with open(file_path, "w", encoding="utf-8") as output:
        call_command("dumpdata", stdout=output)


def _sanitize_pdf_line(value):
    return "".join(ch if ch >= " " or ch == "\t" else " " for ch in value)


def _pdf_hex_string(value):
    data = value.encode("utf-8", errors="replace")
    return binascii.hexlify(data).decode("ascii")


def _create_simple_pdf(text, output_path):
    page_width = 595
    page_height = 842
    margin = 40
    font_size = 9
    line_height = 12
    max_lines = int((page_height - 2 * margin) / line_height)
    raw_lines = text.splitlines() or [""]
    lines = [_sanitize_pdf_line(line) for line in raw_lines]

    content_objects = []

    for idx in range(0, len(lines), max_lines):
        chunk = lines[idx : idx + max_lines]
        y = page_height - margin
        content_lines = ["BT", f"/F1 {font_size} Tf"]
        for line in chunk:
            content_lines.append(
                f"1 0 0 1 {margin} {y} Tm <{_pdf_hex_string(line)}> Tj"
            )
            y -= line_height
        content_lines.append("ET")
        content_stream = "\n".join(content_lines)
        content_objects.append(content_stream)

    objects = []
    objects.append("<< /Type /Catalog /Pages 2 0 R >>")

    page_refs = []
    for page_index, _ in enumerate(content_objects):
        page_obj_num = 4 + page_index * 2
        page_refs.append(f"{page_obj_num} 0 R")
    pages_dict = f"<< /Type /Pages /Kids [{' '.join(page_refs)}] /Count {len(content_objects)} >>"
    objects.append(pages_dict)
    objects.append("<< /Type /Font /Subtype /Type1 /BaseFont /Courier >>")

    for page_index, content in enumerate(content_objects):
        page_obj_num = 4 + page_index * 2
        content_obj_num = page_obj_num + 1
        content_bytes = content.encode("utf-8")
        content_obj = (
            f"<< /Length {len(content_bytes)} >>\nstream\n{content}\nendstream"
        )
        objects.append(
            f"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 {page_width} {page_height}] "
            f"/Resources << /Font << /F1 3 0 R >> >> /Contents {content_obj_num} 0 R >>"
        )
        objects.append(content_obj)

    pdf = bytearray()
    pdf.extend(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n")
    offsets = [0]
    for idx, obj in enumerate(objects, start=1):
        offsets.append(len(pdf))
        pdf.extend(f"{idx} 0 obj\n{obj}\nendobj\n".encode("utf-8"))

    xref_offset = len(pdf)
    pdf.extend(f"xref\n0 {len(objects) + 1}\n".encode("utf-8"))
    pdf.extend(b"0000000000 65535 f \n")
    for offset in offsets[1:]:
        pdf.extend(f"{offset:010d} 00000 n \n".encode("utf-8"))
    pdf.extend(
        f"trailer\n<< /Size {len(objects) + 1} /Root 1 0 R >>\nstartxref\n{xref_offset}\n%%EOF\n".encode(
            "utf-8"
        )
    )

    with open(output_path, "wb") as output:
        output.write(pdf)


def _public_backup_record(record, request=None):
    safe_record = {
        key: value
        for key, value in record.items()
        if key not in {"file_path", "pdf_path"}
    }
    if request and record.get("id"):
        safe_record["download_url"] = request.build_absolute_uri(
            f"/core_api/utilities/database-backups/{record['id']}/download/"
        )
    return safe_record


@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def database_backups(request):
    if request.method == "GET":
        _load_backup_history_if_needed()
        return Response([_public_backup_record(item, request) for item in BACKUP_HISTORY])

    BACKUP_ID_COUNTER[0] += 1
    now = timezone.now()
    fallback_name = f"backup-{now.strftime('%Y%m%d-%H%M%S')}"
    name = _safe_backup_filename((request.data or {}).get("name"), fallback_name)
    backup_dir = _backup_storage_dir()
    file_path = os.path.join(backup_dir, name)
    pdf_path = None
    download_type = "sql"
    status_value = "completed"

    from core.middleware import get_current_db

    db_alias = get_current_db()
    db_conf = settings.DATABASES.get(db_alias) or settings.DATABASES.get("default", {})

    try:
        _run_mysqldump(db_conf, file_path)
    except Exception as exc:
        try:
            _dumpdata_fallback(file_path)
            status_value = "generated"
            print(f"mysqldump failed; fallback dumpdata used: {exc}")
        except Exception as fallback_exc:
            if os.path.exists(file_path):
                os.remove(file_path)
            return Response(
                {"detail": f"Backup failed: {fallback_exc}"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

    try:
        with open(file_path, "r", encoding="utf-8", errors="ignore") as output:
            backup_text = output.read()
        pdf_name = name.rsplit(".", 1)[0] + ".pdf"
        pdf_path = os.path.join(backup_dir, pdf_name)
        _create_simple_pdf(backup_text, pdf_path)
        download_type = "pdf"
    except Exception as exc:
        print(f"PDF generation skipped: {exc}")
        download_type = "sql"

    record = {
        "id": BACKUP_ID_COUNTER[0],
        "name": name,
        "created_at": now.isoformat(),
        "status": status_value,
        "size": os.path.getsize(file_path) if os.path.exists(file_path) else None,
        "created_by": getattr(request.user, "username", "") or getattr(request.user, "email", ""),
        "notes": (request.data or {}).get("notes") or "",
        "download_type": download_type,
        "file_path": file_path,
        "pdf_path": pdf_path,
    }
    record["download_url"] = request.build_absolute_uri(
        f"/core_api/utilities/database-backups/{record['id']}/download/"
    )
    BACKUP_HISTORY.insert(0, record)
    return Response(_public_backup_record(record, request), status=status.HTTP_201_CREATED)


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def database_backup_detail(request, pk):
    _load_backup_history_if_needed()
    record = next((item for item in BACKUP_HISTORY if item.get("id") == pk), None)
    if not record:
        return Response({"detail": "Backup not found."}, status=status.HTTP_404_NOT_FOUND)

    _delete_backup_files(record)
    BACKUP_HISTORY[:] = [item for item in BACKUP_HISTORY if item.get("id") != pk]
    return Response({"status": "deleted"}, status=status.HTTP_200_OK)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def database_backup_download(request, pk):
    _load_backup_history_if_needed()
    record = next((item for item in BACKUP_HISTORY if item.get("id") == pk), None)
    if not record:
        return Response({"detail": "Backup not found."}, status=status.HTTP_404_NOT_FOUND)

    path = record.get("pdf_path") or record.get("file_path")
    if not path or not os.path.exists(path):
        return Response({"detail": "File not found."}, status=status.HTTP_404_NOT_FOUND)

    filename = os.path.basename(path)
    return FileResponse(open(path, "rb"), as_attachment=True, filename=filename)


from ms_crm_app.helpers.ensure_tables import ensure_setup_tables
from .models import (
    EmailTemplate,
    SetupCustomField,
    SetupContractTemplate,
    SetupCurrency,
    SetupCustomerGroup,
    SetupCustomerGroupAssignment,
    SetupExpenseCategory,
    SetupGDPRRequest,
    SetupHelpArticle,
    SetupLeadSource,
    SetupLeadStatus,
    SetupModule,
    SetupPaymentMode,
    SetupPredefinedReply,
    SetupRolePermission,
    SetupSetting,
    SetupSupportDepartment,
    SetupTax,
    SetupThemeStyle,
    SetupTicketPriority,
    SetupTicketStatus,
)
from .serializers import (
    EmailTemplateSerializer,
    SetupContractTemplateSerializer,
    SetupCurrencySerializer,
    SetupCustomFieldSerializer,
    SetupCustomerGroupAssignmentSerializer,
    SetupCustomerGroupSerializer,
    SetupExpenseCategorySerializer,
    SetupGDPRRequestSerializer,
    SetupHelpArticleSerializer,
    SetupLeadSourceSerializer,
    SetupLeadStatusSerializer,
    SetupModuleSerializer,
    SetupPaymentModeSerializer,
    SetupPredefinedReplySerializer,
    SetupRolePermissionSerializer,
    SetupSettingSerializer,
    SetupSupportDepartmentSerializer,
    SetupTaxSerializer,
    SetupThemeStyleSerializer,
    SetupTicketPrioritySerializer,
    SetupTicketStatusSerializer,
)


DEFAULT_SETUP_MODULES = [
    {
        "name": "Staff",
        "slug": "staff",
        "description": "Manage staff members, roles, active status and assignments.",
        "route": "/staff",
        "icon": "users",
        "sort_order": 1,
    },
    {
        "name": "Customer",
        "slug": "customer",
        "description": "Manage customers, contacts and account status.",
        "route": "/customer",
        "icon": "building",
        "sort_order": 2,
    },
    {
        "name": "Support",
        "slug": "support",
        "description": "Support ticket pipe, routing and service mailbox operations.",
        "route": "/support",
        "icon": "headset",
        "sort_order": 3,
    },
    {
        "name": "Leads",
        "slug": "leads",
        "description": "Lead capture, lifecycle and status tracking.",
        "route": "/leads",
        "icon": "bullseye",
        "sort_order": 4,
    },
    {
        "name": "Finance",
        "slug": "finance",
        "description": "Expense and payment related controls and reporting links.",
        "route": "/reports/expenses",
        "icon": "coins",
        "sort_order": 5,
    },
    {
        "name": "Contracts",
        "slug": "contracts",
        "description": "Contract master data, terms and renewal tracking.",
        "route": "/Sale/ContractsDashboard/",
        "icon": "file-contract",
        "sort_order": 6,
    },
    {
        "name": "Modules",
        "slug": "modules",
        "description": "Enable or disable modules visible in setup and app navigation.",
        "route": "/setup?tab=modules",
        "icon": "layer-group",
        "sort_order": 7,
    },
    {
        "name": "Email Template",
        "slug": "email-template",
        "description": "Centralized email templates for notifications and transactional emails.",
        "route": "/setup?tab=email-template",
        "icon": "envelope",
        "sort_order": 8,
    },
    {
        "name": "Custom Fields",
        "slug": "custom-fields",
        "description": "Create module-wise custom fields without code changes.",
        "route": "/setup?tab=custom-fields",
        "icon": "table-columns",
        "sort_order": 9,
    },
    {
        "name": "GDPR",
        "slug": "gdpr",
        "description": "Track GDPR requests, processing and completion timeline.",
        "route": "/setup?tab=gdpr",
        "icon": "shield-check",
        "sort_order": 10,
    },
    {
        "name": "Roles",
        "slug": "roles",
        "description": "Role and permission definition.",
        "route": "/role/save",
        "icon": "user-shield",
        "sort_order": 11,
    },
    {
        "name": "Theme Style",
        "slug": "theme-style",
        "description": "Customize brand colors and shared UI style options.",
        "route": "/setup?tab=theme-style",
        "icon": "palette",
        "sort_order": 12,
    },
    {
        "name": "Settings",
        "slug": "settings",
        "description": "System preferences and default operational values.",
        "route": "/setup?tab=settings",
        "icon": "gear",
        "sort_order": 13,
    },
    {
        "name": "Help",
        "slug": "help",
        "description": "Setup module documentation and team self-help knowledge.",
        "route": "/setup?tab=help",
        "icon": "circle-info",
        "sort_order": 14,
    },
]


DEFAULT_SETUP_SETTINGS = [
    {
        "category": "company",
        "key": "company_name",
        "display_name": "Company Name",
        "value": "Magnyte CRM",
        "input_type": "text",
        "description": "Display company name across setup and emails.",
        "is_public": True,
        "is_editable": True,
    },
    {
        "category": "company",
        "key": "company_email",
        "display_name": "Company Email",
        "value": "support@magnyte.com",
        "input_type": "email",
        "description": "Primary support and notification sender email.",
        "is_public": True,
        "is_editable": True,
    },
    {
        "category": "localization",
        "key": "default_timezone",
        "display_name": "Default Timezone",
        "value": "Asia/Kolkata",
        "input_type": "text",
        "description": "Default timezone for new records and reminders.",
        "is_public": True,
        "is_editable": True,
    },
    {
        "category": "localization",
        "key": "currency",
        "display_name": "Currency",
        "value": "INR",
        "input_type": "text",
        "description": "Default currency for finance module.",
        "is_public": True,
        "is_editable": True,
    },
    {
        "category": "compliance",
        "key": "gdpr_auto_acknowledge",
        "display_name": "GDPR Auto Acknowledge",
        "value": "true",
        "input_type": "boolean",
        "description": "Send automated acknowledgement for GDPR requests.",
        "is_public": False,
        "is_editable": True,
    },
]


DEFAULT_HELP_ARTICLES = [
    {
        "title": "Setup Overview",
        "slug": "setup-overview",
        "module_slug": "modules",
        "summary": "How setup module controls all CRM sub-modules.",
        "content": (
            "Use Setup to control module availability and maintain core operational "
            "entities such as email templates, custom fields and settings."
        ),
        "sort_order": 1,
        "is_published": True,
    },
    {
        "title": "Managing Email Templates",
        "slug": "setup-email-templates",
        "module_slug": "email-template",
        "summary": "Create and edit templates used in CRM workflows.",
        "content": (
            "Each template is identified by module + slug + language. "
            "Keep subject concise and include reusable placeholders in the body."
        ),
        "sort_order": 2,
        "is_published": True,
    },
    {
        "title": "GDPR Request Handling",
        "slug": "setup-gdpr-handling",
        "module_slug": "gdpr",
        "summary": "Track data export and delete requests safely.",
        "content": (
            "Create a GDPR request for each customer demand, move status as work "
            "progresses, and capture resolution notes before completion."
        ),
        "sort_order": 3,
        "is_published": True,
    },
]


def _seed_setup_modules():
    existing = {obj.slug: obj for obj in SetupModule.objects.all()}

    for item in DEFAULT_SETUP_MODULES:
        slug = item["slug"]
        module = existing.get(slug)
        if module:
            changed = False
            for field in ("name", "description", "route", "icon", "sort_order"):
                next_value = item.get(field)
                if getattr(module, field) != next_value:
                    setattr(module, field, next_value)
                    changed = True
            if changed:
                module.save(
                    update_fields=[
                        "name",
                        "description",
                        "route",
                        "icon",
                        "sort_order",
                        "updated_at",
                    ]
                )
            continue

        SetupModule.objects.create(**item, is_enabled=True)


def _seed_setup_settings():
    for item in DEFAULT_SETUP_SETTINGS:
        SetupSetting.objects.update_or_create(
            category=item["category"],
            key=item["key"],
            defaults=item,
        )


def _seed_help_articles():
    for item in DEFAULT_HELP_ARTICLES:
        SetupHelpArticle.objects.update_or_create(
            slug=item["slug"],
            defaults=item,
        )


class SetupBaseViewSet(viewsets.ModelViewSet):
    authentication_classes = [JWTAuthentication, SessionAuthentication]
    permission_classes = [IsAuthenticated]

    def initial(self, request, *args, **kwargs):
        try:
            ensure_setup_tables()
        except Exception as exc:
            print("Setup tables ensure failed:", exc)
        super().initial(request, *args, **kwargs)

    def _handle_missing_table(self, exc, *, empty_ok):
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            if empty_ok:
                return Response([])
            return Response(
                {"detail": "Setup table not found. Run migrations or setup table bootstrap."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        return None

    def list(self, request, *args, **kwargs):
        try:
            return super().list(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=True)
            if handled is not None:
                return handled
            raise

    def create(self, request, *args, **kwargs):
        try:
            return super().create(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise

    def update(self, request, *args, **kwargs):
        try:
            return super().update(request, *args, **kwargs)
        except (ProgrammingError, OperationalError) as exc:
            handled = self._handle_missing_table(exc, empty_ok=False)
            if handled is not None:
                return handled
            raise


class SetupModuleViewSet(SetupBaseViewSet):
    serializer_class = SetupModuleSerializer

    def get_queryset(self):
        _seed_setup_modules()
        queryset = SetupModule.objects.all()

        include_deleted = str(self.request.query_params.get("include_deleted", "")).strip().lower() in {
            "1",
            "true",
            "yes",
        }
        deleted_only = str(self.request.query_params.get("deleted", "")).strip().lower() in {
            "1",
            "true",
            "yes",
        }
        if deleted_only:
            queryset = queryset.filter(is_deleted=True)
        elif not include_deleted:
            queryset = queryset.filter(is_deleted=False)

        enabled = str(self.request.query_params.get("enabled", "")).strip().lower()
        if enabled in {"1", "true", "yes"}:
            queryset = queryset.filter(is_enabled=True)
        elif enabled in {"0", "false", "no"}:
            queryset = queryset.filter(is_enabled=False)

        search = str(self.request.query_params.get("search", "")).strip()
        if search:
            queryset = queryset.filter(
                Q(name__icontains=search)
                | Q(description__icontains=search)
                | Q(slug__icontains=search)
            )

        return queryset.order_by("sort_order", "name", "id")

    def destroy(self, request, *args, **kwargs):
        module = self.get_object()
        if not module.is_deleted:
            module.is_deleted = True
            module.deleted_at = timezone.now()
            module.save(update_fields=["is_deleted", "deleted_at", "updated_at"])
        return Response(status=status.HTTP_204_NO_CONTENT)

    @action(detail=True, methods=["post"], url_path="restore")
    def restore(self, request, pk=None):
        module = SetupModule.objects.filter(pk=pk).first()
        if not module:
            return Response({"detail": "Module not found."}, status=status.HTTP_404_NOT_FOUND)
        if not module.is_deleted:
            serializer = self.get_serializer(module)
            return Response(serializer.data, status=status.HTTP_200_OK)

        module.is_deleted = False
        module.deleted_at = None
        module.save(update_fields=["is_deleted", "deleted_at", "updated_at"])
        serializer = self.get_serializer(module)
        return Response(serializer.data, status=status.HTTP_200_OK)

    @action(detail=False, methods=["post"], url_path="bulk-toggle")
    def bulk_toggle(self, request):
        payload = request.data if isinstance(request.data, list) else request.data.get("items", [])
        if not isinstance(payload, list) or not payload:
            return Response(
                {"detail": "items list is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        updated = []
        with transaction.atomic():
            for item in payload:
                module_id = item.get("id")
                if module_id is None:
                    continue
                module = SetupModule.objects.filter(pk=module_id).first()
                if not module:
                    continue
                module.is_enabled = bool(item.get("is_enabled", module.is_enabled))
                module.save(update_fields=["is_enabled", "updated_at"])
                updated.append(module)

        data = SetupModuleSerializer(updated, many=True).data
        return Response(data, status=status.HTTP_200_OK)


class EmailTemplateViewSet(SetupBaseViewSet):
    serializer_class = EmailTemplateSerializer

    def get_queryset(self):
        try:
            seed_email_templates_optimized()
        except Exception as exc:
            print("Email template seed failed:", exc)

        queryset = EmailTemplate.objects.all()

        module = str(self.request.query_params.get("module", "")).strip()
        language = str(self.request.query_params.get("language", "")).strip()
        search = str(self.request.query_params.get("search", "")).strip()

        if module:
            queryset = queryset.filter(module__iexact=module)
        if language:
            queryset = queryset.filter(language__iexact=language)
        if search:
            queryset = queryset.filter(
                Q(module__icontains=search)
                | Q(slug__icontains=search)
                | Q(subject__icontains=search)
                | Q(body__icontains=search)
            )

        return queryset.order_by("module", "slug", "language", "id")

    def perform_create(self, serializer):
        subject = serializer.validated_data.get("subject")
        slug_value = serializer.validated_data.get("slug")
        if not slug_value and subject:
            serializer.save(slug=slugify(subject))
            return
        serializer.save()

    def perform_update(self, serializer):
        subject = serializer.validated_data.get("subject")
        slug_value = serializer.validated_data.get("slug")
        if (slug_value is None or slug_value == "") and subject:
            serializer.save(slug=slugify(subject))
            return
        serializer.save()


CUSTOM_FIELD_MODULE_ALIASES = {
    "customer": "customer",
    "customers": "customer",
    "lead": "leads",
    "leads": "leads",
    "staff": "staff",
    "support": "support",
    "finance": "finance",
    "contract": "contracts",
    "contracts": "contracts",
}

CUSTOM_FIELD_MODULE_MODEL_MAP = {
    "customer": ("core", "client"),
    "leads": ("core", "lead"),
    "staff": ("ms_crm_app", "staff"),
    "support": ("ms_crm_app", "ticketspipelog"),
    "finance": ("core", "expense"),
    "contracts": ("core", "contract"),
}


def _normalize_custom_field_module_slug(raw_module):
    module = str(raw_module or "").strip().lower()
    return CUSTOM_FIELD_MODULE_ALIASES.get(module, module)


def _is_empty_custom_value(value):
    if value is None:
        return True
    if isinstance(value, str) and value.strip() == "":
        return True
    if isinstance(value, list) and len(value) == 0:
        return True
    return False


def _coerce_custom_field_value(field, raw_value):
    if _is_empty_custom_value(raw_value):
        return None

    field_type = str(getattr(field, "field_type", "text") or "text").strip().lower()
    options = getattr(field, "options", None) or []

    if field_type in {"text", "textarea"}:
        return str(raw_value)

    if field_type == "number":
        value = Decimal(str(raw_value))
        if value % 1 == 0:
            return int(value)
        return float(value)

    if field_type == "email":
        email_text = str(raw_value).strip()
        validate_email(email_text)
        return email_text

    if field_type == "date":
        parsed = parse_date(str(raw_value).strip())
        if not parsed:
            raise ValueError("Date must be in YYYY-MM-DD format.")
        return parsed.isoformat()

    if field_type == "select":
        selected = str(raw_value)
        if options and selected not in options:
            raise ValueError("Value must be one of the configured options.")
        return selected

    if field_type == "checkbox":
        if isinstance(raw_value, bool):
            return raw_value
        if isinstance(raw_value, (int, float)):
            return bool(raw_value)
        lowered = str(raw_value).strip().lower()
        truthy = {"1", "true", "yes", "y", "on"}
        falsy = {"0", "false", "no", "n", "off"}
        if lowered in truthy:
            return True
        if lowered in falsy:
            return False
        raise ValueError("Checkbox value must be true/false or 1/0.")

    return raw_value


def _resolve_custom_field_content_type(module_slug=None, model_name=None, content_type_name=None):
    if model_name:
        try:
            app_label, model = str(model_name).strip().lower().split(".", 1)
            return ContentType.objects.get(app_label=app_label, model=model)
        except Exception:
            return None

    if content_type_name:
        try:
            app_label, model = str(content_type_name).strip().lower().split(".", 1)
            return ContentType.objects.get(app_label=app_label, model=model)
        except Exception:
            return None

    app_model = CUSTOM_FIELD_MODULE_MODEL_MAP.get(module_slug or "")
    if not app_model:
        return None

    try:
        app_label, model = app_model
        return ContentType.objects.get(app_label=app_label, model=model)
    except Exception:
        return None


class SetupCustomFieldViewSet(SetupBaseViewSet):
    serializer_class = SetupCustomFieldSerializer

    def get_queryset(self):
        queryset = SetupCustomField.objects.all()
        module_slug = _normalize_custom_field_module_slug(self.request.query_params.get("module", ""))
        active = str(self.request.query_params.get("active", "")).strip().lower()

        if module_slug:
            queryset = queryset.filter(module_slug__iexact=module_slug)
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)

        return queryset.order_by("module_slug", "sort_order", "id")


class CustomFieldValueViewSet(SetupBaseViewSet):
    serializer_class = CustomFieldValueSerializer

    def get_queryset(self):
        qs = CustomFieldValue.objects.select_related("custom_field", "content_type")

        module_slug = _normalize_custom_field_module_slug(self.request.query_params.get("module", ""))
        if module_slug:
            qs = qs.filter(custom_field__module_slug__iexact=module_slug)

        cf_id = self.request.query_params.get("custom_field")
        if cf_id:
            try:
                qs = qs.filter(custom_field_id=int(cf_id))
            except (TypeError, ValueError):
                pass
        else:
            cf_key = self.request.query_params.get("custom_field_key")
            if cf_key:
                qs = qs.filter(custom_field__field_key=cf_key)

        ct_param = self.request.query_params.get("content_type")
        model_param = self.request.query_params.get("model")
        obj_id = self.request.query_params.get("object_id")
        ct = _resolve_custom_field_content_type(module_slug, model_param, ct_param)
        if ct is not None:
            qs = qs.filter(content_type=ct)
        if obj_id:
            try:
                qs = qs.filter(object_id=int(obj_id))
            except (TypeError, ValueError):
                pass

        raw_value = self.request.query_params.get("value")
        if raw_value is not None:
            try:
                decoded = json.loads(raw_value)
                qs = qs.filter(value=decoded)
            except Exception:
                qs = qs.filter(value=raw_value)

        return qs.order_by("custom_field", "content_type", "object_id")

    @action(detail=False, methods=["get"], url_path="fetch-values")
    def fetch_values(self, request):
        module_slug = _normalize_custom_field_module_slug(
            request.query_params.get("module") or request.query_params.get("module_slug")
        )
        object_id = request.query_params.get("object_id")
        if not module_slug:
            return Response({"detail": "module is required."}, status=status.HTTP_400_BAD_REQUEST)
        try:
            object_id = int(object_id)
        except (TypeError, ValueError):
            return Response({"detail": "Valid object_id is required."}, status=status.HTTP_400_BAD_REQUEST)

        include_inactive = str(request.query_params.get("include_inactive", "")).strip().lower() in {
            "1", "true", "yes"
        }
        fields = SetupCustomField.objects.filter(module_slug__iexact=module_slug)
        if not include_inactive:
            fields = fields.filter(is_active=True)
        fields = list(fields.order_by("sort_order", "id"))

        ct = _resolve_custom_field_content_type(
            module_slug,
            request.query_params.get("model"),
            request.query_params.get("content_type"),
        )
        if ct is None:
            return Response({"detail": "Unable to resolve model/content_type for module."}, status=400)

        saved_values = CustomFieldValue.objects.filter(
            custom_field__in=fields,
            content_type=ct,
            object_id=object_id,
        ).select_related("custom_field")
        saved_map = {item.custom_field_id: item.value for item in saved_values}

        values = {}
        field_rows = []
        for field in fields:
            value = saved_map.get(field.id, field.default_value)
            values[field.field_key] = value
            field_rows.append(
                {
                    "id": field.id,
                    "module_slug": field.module_slug,
                    "label": field.label,
                    "field_key": field.field_key,
                    "field_type": field.field_type,
                    "options": field.options or [],
                    "default_value": field.default_value,
                    "is_required": field.is_required,
                    "is_active": field.is_active,
                    "sort_order": field.sort_order,
                    "value": value,
                }
            )

        return Response(
            {
                "module_slug": module_slug,
                "object_id": object_id,
                "content_type": f"{ct.app_label}.{ct.model}",
                "fields": field_rows,
                "values": values,
            },
            status=status.HTTP_200_OK,
        )

    @action(detail=False, methods=["post"], url_path="save-values")
    def save_values(self, request):
        payload = request.data if isinstance(request.data, dict) else {}
        module_slug = _normalize_custom_field_module_slug(
            payload.get("module") or payload.get("module_slug")
        )
        object_id = payload.get("object_id")
        values_payload = payload.get("values") or payload.get("custom_fields") or {}

        if not module_slug:
            return Response({"detail": "module is required."}, status=status.HTTP_400_BAD_REQUEST)
        try:
            object_id = int(object_id)
            if object_id <= 0:
                raise ValueError
        except (TypeError, ValueError):
            return Response({"detail": "Valid object_id is required."}, status=status.HTTP_400_BAD_REQUEST)

        if not isinstance(values_payload, dict):
            return Response({"detail": "values must be an object."}, status=status.HTTP_400_BAD_REQUEST)

        ct = _resolve_custom_field_content_type(
            module_slug,
            payload.get("model"),
            payload.get("content_type"),
        )
        if ct is None:
            return Response({"detail": "Unable to resolve model/content_type for module."}, status=400)

        fields = list(
            SetupCustomField.objects.filter(module_slug__iexact=module_slug, is_active=True)
            .order_by("sort_order", "id")
        )
        if not fields:
            return Response(
                {
                    "module_slug": module_slug,
                    "object_id": object_id,
                    "saved_count": 0,
                    "values": {},
                    "results": [],
                },
                status=status.HTTP_200_OK,
            )

        errors = {}
        normalized_values = {}
        for field in fields:
            incoming = values_payload.get(field.field_key, None)
            value_to_validate = incoming
            if _is_empty_custom_value(value_to_validate) and not _is_empty_custom_value(field.default_value):
                value_to_validate = field.default_value

            if field.is_required and _is_empty_custom_value(value_to_validate):
                errors[field.field_key] = "This field is required."
                continue

            try:
                coerced = _coerce_custom_field_value(field, value_to_validate)
            except (ValueError, InvalidOperation, TypeError, DjangoValidationError) as exc:
                errors[field.field_key] = str(exc) or f"Invalid value for {field.label}."
                continue

            normalized_values[field.field_key] = coerced

        if errors:
            return Response(
                {
                    "detail": "Custom field validation failed.",
                    "errors": errors,
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        saved = []
        with transaction.atomic():
            for field in fields:
                value = normalized_values.get(field.field_key, None)
                obj, _ = CustomFieldValue.objects.update_or_create(
                    custom_field=field,
                    content_type=ct,
                    object_id=object_id,
                    defaults={"value": value},
                )
                saved.append(obj)

        serializer = self.get_serializer(saved, many=True)
        return Response(
            {
                "module_slug": module_slug,
                "object_id": object_id,
                "content_type": f"{ct.app_label}.{ct.model}",
                "saved_count": len(saved),
                "values": normalized_values,
                "results": serializer.data,
            },
            status=status.HTTP_200_OK,
        )


class SetupGDPRRequestViewSet(SetupBaseViewSet):
    serializer_class = SetupGDPRRequestSerializer

    def get_queryset(self):
        queryset = SetupGDPRRequest.objects.all()
        request_type = str(self.request.query_params.get("request_type", "")).strip().lower()
        status_filter = str(self.request.query_params.get("status", "")).strip().lower()
        search = str(self.request.query_params.get("search", "")).strip()

        if request_type:
            queryset = queryset.filter(request_type=request_type)
        if status_filter:
            queryset = queryset.filter(status=status_filter)
        if search:
            queryset = queryset.filter(
                Q(customer_name__icontains=search)
                | Q(email__icontains=search)
                | Q(details__icontains=search)
            )

        return queryset.order_by("-created_at", "-id")

    @action(detail=True, methods=["post"], url_path="mark-completed")
    def mark_completed(self, request, pk=None):
        instance = self.get_object()
        instance.status = "completed"
        instance.resolved_at = timezone.now()
        instance.resolution_notes = request.data.get("resolution_notes", instance.resolution_notes)
        instance.save(update_fields=["status", "resolution_notes", "resolved_at", "updated_at"])
        serializer = self.get_serializer(instance)
        return Response(serializer.data, status=status.HTTP_200_OK)


class SetupSettingViewSet(SetupBaseViewSet):
    serializer_class = SetupSettingSerializer

    def get_queryset(self):
        _seed_setup_settings()
        queryset = SetupSetting.objects.all()
        category = str(self.request.query_params.get("category", "")).strip()
        if category:
            queryset = queryset.filter(category__iexact=category)
        return queryset.order_by("category", "display_name", "id")

    @action(detail=False, methods=["post"], url_path="bulk-upsert")
    def bulk_upsert(self, request):
        items = request.data if isinstance(request.data, list) else request.data.get("items", [])
        if not isinstance(items, list) or not items:
            return Response(
                {"detail": "items list is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        saved = []
        with transaction.atomic():
            for raw in items:
                category = str(raw.get("category", "")).strip()
                key = str(raw.get("key", "")).strip()
                display_name = str(raw.get("display_name", "")).strip() or key.replace("_", " ").title()
                if not category or not key:
                    continue

                setting, _ = SetupSetting.objects.update_or_create(
                    category=category,
                    key=key,
                    defaults={
                        "display_name": display_name,
                        "value": raw.get("value", ""),
                        "input_type": raw.get("input_type", "text"),
                        "description": raw.get("description", ""),
                        "is_public": bool(raw.get("is_public", False)),
                        "is_editable": bool(raw.get("is_editable", True)),
                    },
                )
                saved.append(setting)

        serializer = self.get_serializer(saved, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class SetupHelpArticleViewSet(SetupBaseViewSet):
    serializer_class = SetupHelpArticleSerializer

    def get_queryset(self):
        _seed_help_articles()
        queryset = SetupHelpArticle.objects.all()

        module_slug = str(self.request.query_params.get("module", "")).strip()
        published = str(self.request.query_params.get("published", "")).strip().lower()
        search = str(self.request.query_params.get("search", "")).strip()

        if module_slug:
            queryset = queryset.filter(module_slug__iexact=module_slug)
        if published in {"1", "true", "yes"}:
            queryset = queryset.filter(is_published=True)
        elif published in {"0", "false", "no"}:
            queryset = queryset.filter(is_published=False)
        if search:
            queryset = queryset.filter(
                Q(title__icontains=search)
                | Q(summary__icontains=search)
                | Q(content__icontains=search)
            )

        return queryset.order_by("module_slug", "sort_order", "title", "id")

    # ------------------------------------------------------------
    # Email notification on create / update
    # ------------------------------------------------------------
    def _resolve_review_recipients(self):
        """Resolve company review recipient emails for Help article submissions."""
        recipients = []
        seen = set()

        def add_email(value):
            email_value = str(value or "").strip()
            if not email_value or "@" not in email_value:
                return
            key = email_value.lower()
            if key in seen:
                return
            seen.add(key)
            recipients.append(email_value)

        # 1) Primary source: setup setting (company/company_email).
        try:
            configured_company_email = SetupSetting.objects.filter(
                category__iexact="company",
                key__iexact="company_email",
            ).values_list("value", flat=True).first()
            add_email(configured_company_email)
        except Exception:
            pass

        # 2) Business profile email for logged-in user.
        try:
            user = getattr(self.request, "user", None)
            user_identifier = (
                str(getattr(user, "email", "") or getattr(user, "username", "")).strip()
            )
            if user_identifier:
                business = (
                    Business.objects.filter(email__iexact=user_identifier)
                    .order_by("-created_at")
                    .first()
                )
                if business:
                    add_email(getattr(business, "email", None))
        except Exception:
            pass

        # 3) Legacy business email fallback (for older datasets).
        try:
            legacy_business = LegacyBusiness.objects.first()
            if legacy_business:
                add_email(getattr(legacy_business, "email", None))
        except Exception:
            pass

        # 4) Final personal fallback from authenticated user.
        user = getattr(self.request, "user", None)
        add_email(getattr(user, "email", None))
        add_email(getattr(user, "username", None))

        if not recipients:
            recipients.append("support@magnyte.com")

        return recipients

    def _send_review_email(self, article, *, action="created"):
        """Send a review email for a created/updated help article."""
        recipients = self._resolve_review_recipients()
        verb = "created" if action == "created" else "updated"
        subject = f"Help Article {verb.title()} for Review: {article.title}"
        message = (
            f"A help article has been {verb} in the system.\n\n"
            f"Title: {article.title}\n"
            f"Module: {article.module_slug or '-'}\n"
            f"Published: {'Yes' if article.is_published else 'No'}\n"
            f"\nSummary:\n{article.summary or ''}\n\n"
            f"Content preview (first 200 chars):\n{(article.content or '')[:200]}"
        )
        try:
            send_branded_email(
                subject=subject,
                message=message,
                to_emails=recipients,
                fail_silently=False,
            )
            return {
                "sent": True,
                "to": recipients,
            }
        except Exception as exc:
            # Logging failure should not break the API response.
            print(f"Help article review email failed: {exc}")
            return {
                "sent": False,
                "to": recipients,
                "error": str(exc),
            }

    def perform_create(self, serializer):
        """Create a Help article and trigger the review email."""
        article = serializer.save()
        self._last_review_email = self._send_review_email(article, action="created")

    def perform_update(self, serializer):
        """Update a Help article and trigger the review email."""
        article = serializer.save()
        self._last_review_email = self._send_review_email(article, action="updated")

    def create(self, request, *args, **kwargs):
        self._last_review_email = {"sent": False, "to": []}
        response = super().create(request, *args, **kwargs)
        if isinstance(response.data, dict):
            response.data["review_email"] = self._last_review_email
        return response

    def update(self, request, *args, **kwargs):
        self._last_review_email = {"sent": False, "to": []}
        response = super().update(request, *args, **kwargs)
        if isinstance(response.data, dict):
            response.data["review_email"] = self._last_review_email
        return response

class SetupCustomerGroupViewSet(SetupBaseViewSet):
    serializer_class = SetupCustomerGroupSerializer

    def get_queryset(self):
        queryset = SetupCustomerGroup.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        search = str(self.request.query_params.get("search", "")).strip()

        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)

        if search:
            queryset = queryset.filter(
                Q(name__icontains=search) | Q(description__icontains=search)
            )

        return queryset.order_by("name", "id")


class SetupCustomerGroupAssignmentViewSet(SetupBaseViewSet):
    serializer_class = SetupCustomerGroupAssignmentSerializer

    def get_queryset(self):
        queryset = SetupCustomerGroupAssignment.objects.select_related(
            "customer", "group"
        ).all()
        customer_id = self.request.query_params.get("customer")
        if customer_id:
            try:
                queryset = queryset.filter(customer_id=int(customer_id))
            except (TypeError, ValueError):
                pass
        return queryset.order_by("-updated_at", "-id")

    @action(detail=False, methods=["post"], url_path="upsert")
    def upsert(self, request):
        customer_id = request.data.get("customer_id") or request.data.get("customer")
        group_id = request.data.get("group_id") or request.data.get("group")

        try:
            customer_id = int(customer_id)
        except (TypeError, ValueError):
            return Response(
                {"detail": "Valid customer_id is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if not group_id:
            SetupCustomerGroupAssignment.objects.filter(customer_id=customer_id).delete()
            return Response(
                {"status": "unassigned", "customer_id": customer_id},
                status=status.HTTP_200_OK,
            )

        try:
            group_id = int(group_id)
        except (TypeError, ValueError):
            return Response(
                {"detail": "Valid group_id is required."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if not SetupCustomerGroup.objects.filter(pk=group_id).exists():
            return Response(
                {"detail": "Customer group not found."},
                status=status.HTTP_404_NOT_FOUND,
            )

        if not Client.objects.filter(pk=customer_id).exists():
            return Response(
                {"detail": "Customer not found."},
                status=status.HTTP_404_NOT_FOUND,
            )

        assignment, _ = SetupCustomerGroupAssignment.objects.update_or_create(
            customer_id=customer_id,
            defaults={"group_id": group_id},
        )
        serializer = self.get_serializer(assignment)
        return Response(serializer.data, status=status.HTTP_200_OK)


class SetupThemeStyleViewSet(SetupBaseViewSet):
    serializer_class = SetupThemeStyleSerializer

    def get_queryset(self):
        queryset = SetupThemeStyle.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupTaxViewSet(SetupBaseViewSet):
    serializer_class = SetupTaxSerializer

    def get_queryset(self):
        queryset = SetupTax.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupCurrencyViewSet(SetupBaseViewSet):
    serializer_class = SetupCurrencySerializer

    def get_queryset(self):
        queryset = SetupCurrency.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("code", "id")


class SetupPaymentModeViewSet(SetupBaseViewSet):
    serializer_class = SetupPaymentModeSerializer

    def get_queryset(self):
        queryset = SetupPaymentMode.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupExpenseCategoryViewSet(SetupBaseViewSet):
    serializer_class = SetupExpenseCategorySerializer

    def get_queryset(self):
        queryset = SetupExpenseCategory.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupSupportDepartmentViewSet(SetupBaseViewSet):
    serializer_class = SetupSupportDepartmentSerializer

    def get_queryset(self):
        queryset = SetupSupportDepartment.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupTicketPriorityViewSet(SetupBaseViewSet):
    serializer_class = SetupTicketPrioritySerializer

    def get_queryset(self):
        queryset = SetupTicketPriority.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("level", "name", "id")


class SetupTicketStatusViewSet(SetupBaseViewSet):
    serializer_class = SetupTicketStatusSerializer

    def get_queryset(self):
        queryset = SetupTicketStatus.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupPredefinedReplyViewSet(SetupBaseViewSet):
    serializer_class = SetupPredefinedReplySerializer

    def get_queryset(self):
        queryset = SetupPredefinedReply.objects.select_related("department").all()
        department_id = self.request.query_params.get("department")
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if department_id:
            try:
                queryset = queryset.filter(department_id=int(department_id))
            except (TypeError, ValueError):
                pass
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("title", "id")


class SetupLeadSourceViewSet(SetupBaseViewSet):
    serializer_class = SetupLeadSourceSerializer

    def get_queryset(self):
        queryset = SetupLeadSource.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")


class SetupLeadStatusViewSet(SetupBaseViewSet):
    serializer_class = SetupLeadStatusSerializer

    def get_queryset(self):
        queryset = SetupLeadStatus.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("sequence", "name", "id")


class SetupContractTemplateViewSet(SetupBaseViewSet):
    serializer_class = SetupContractTemplateSerializer

    def get_queryset(self):
        queryset = SetupContractTemplate.objects.all()
        active = str(self.request.query_params.get("active", "")).strip().lower()
        if active in {"1", "true", "yes"}:
            queryset = queryset.filter(is_active=True)
        elif active in {"0", "false", "no"}:
            queryset = queryset.filter(is_active=False)
        return queryset.order_by("name", "id")

    def perform_create(self, serializer):
        name = serializer.validated_data.get("name")
        slug_value = serializer.validated_data.get("slug")
        if not slug_value and name:
            serializer.save(slug=slugify(name))
            return
        serializer.save()

    def perform_update(self, serializer):
        name = serializer.validated_data.get("name")
        slug_value = serializer.validated_data.get("slug")
        if (slug_value is None or slug_value == "") and name:
            serializer.save(slug=slugify(name))
            return
        serializer.save()


class SetupRolePermissionViewSet(SetupBaseViewSet):
    serializer_class = SetupRolePermissionSerializer

    def get_queryset(self):
        queryset = SetupRolePermission.objects.select_related("role").all()
        role_id = self.request.query_params.get("role")
        module_slug = str(self.request.query_params.get("module", "")).strip()
        if role_id:
            try:
                queryset = queryset.filter(role_id=int(role_id))
            except (TypeError, ValueError):
                pass
        if module_slug:
            queryset = queryset.filter(module_slug__iexact=module_slug)
        return queryset.order_by("role_id", "module_slug", "id")













