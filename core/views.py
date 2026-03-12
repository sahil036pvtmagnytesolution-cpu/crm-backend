import email

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

from .models import Business, Customer, Role, Proposal, StaffProfile
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
from .models import Client, Estimate, Invoice
from rest_framework.authentication import SessionAuthentication
from rest_framework_simplejwt.authentication import JWTAuthentication

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
        client = Client.objects.filter(
            company=estimate.customer
        ).first()

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
@api_view(["GET", "POST"])
@permission_classes([IsAuthenticated])
def invoice_list(request):

    # 🔹 AUTO CONVERT ESTIMATES → INVOICES
    estimates = Estimate.objects.all()

    for estimate in estimates:

        existing = Invoice.objects.filter(
            reference_estimate=estimate
        ).first()

        if existing:
            continue

        client = Client.objects.filter(
            company=estimate.customer
        ).first()

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
            status="Unpaid"
        )

    # 🔹 RETURN ALL INVOICES
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

    # ====================== GET ======================
    if request.method == "GET":
        serializer = InvoiceSerializer(invoice)
        return Response(serializer.data)

    # ====================== UPDATE ======================
    if request.method == "PUT":

        data = request.data.copy()

    # safe defaults
    data.setdefault("tax_amount", invoice.tax_amount)
    data.setdefault("total_amount", invoice.total_amount)

    serializer = InvoiceSerializer(invoice, data=data, partial=True)

    if serializer.is_valid():

        updated_invoice = serializer.save()

        payment = InvoicePayment.objects.filter(
        invoice=updated_invoice
    ).first()

    if payment:
        # 🔄 update existing payment
        payment.payment_mode = updated_invoice.payment_mode or "Null"
        payment.transaction_id = f"{updated_invoice.payment_mode}-{updated_invoice.id}"
        payment.amount = updated_invoice.total_amount
        payment.save()

    else:
        # ➕ create payment if not exist
        InvoicePayment.objects.create(
            invoice=updated_invoice,
            payment_mode=updated_invoice.payment_mode or "Null",
            transaction_id=f"{updated_invoice.payment_mode}-{updated_invoice.id}",
            amount=updated_invoice.total_amount
        )

        return Response(serializer.data)

    # 🔴 IMPORTANT DEBUG
    print("❌ SERIALIZER ERRORS:", serializer.errors)

    return Response(serializer.errors, status=400)

    # ====================== DELETE ======================
    if request.method == "DELETE":
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
        client = Client.objects.filter(company=estimate.customer).first()

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
            status="Unpaid"
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
        client = Client.objects.filter(company=estimate.customer).first()
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
            status="Unpaid"
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

        client = Client.objects.filter(
            company=estimate.customer
        ).first()

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
            status="Unpaid"
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
    client = Client.objects.filter(
        company=estimate.customer
    ).first()

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
        status="Unpaid"
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