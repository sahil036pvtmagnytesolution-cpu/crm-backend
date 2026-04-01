from django.shortcuts import get_object_or_404
from django.core.mail import EmailMessage, send_mail
from django.conf import settings
from django.utils import timezone
from django.db import ProgrammingError, OperationalError, connections
from .models import ActivityLog
from django.apps import apps
import csv
import io
import json

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
from .serializers import (
    CompanyInfoSerializer,
    SMSTaskSerializer,
    SetupTaskSerializer,
)
from .helpers.utility import (
    app_name,
    get_serializer_class,
    get_filtered_queryset,
    CustomPageNumberPagination
)
from .constants import UserType
from core.models import Business
from core.middleware import get_current_db

# ✅ SAFE TABLE ENSURE
from ms_crm_app.helpers.ensure_tables import (
    ensure_roles_table,
    ensure_gdpr_requests_table,
    ensure_setup_management_tables,
)


def _create_legacy_activity_log(description, request=None):
    """Write to legacy ms_activity_log without breaking API flow on schema drift."""
    staff_identifier = None
    user = getattr(request, "user", None)
    if user is not None and getattr(user, "is_authenticated", False):
        staff_identifier = getattr(user, "id", None)

    try:
        ActivityLog.objects.create(
            description=description,
            date=timezone.now(),
            staff_name=staff_identifier,
        )
    except Exception as exc:
        print("ActivityLog create failed:", exc)


_GDPR_EXPORT_TABLES = {
    "customer": "ms_contacts",
    "lead": "ms_leads",
    "staff": "ms_staff",
}

_GDPR_EXPORT_FIELDS = {
    "customer": [
        "userid",
        "firstname",
        "lastname",
        "email",
        "phonenumber",
        "title",
        "datecreated",
        "last_login",
        "active",
    ],
    "lead": [
        "name",
        "title",
        "company",
        "email",
        "phonenumber",
        "website",
        "address",
        "city",
        "state",
        "zip",
        "dateadded",
        "lastcontact",
        "status",
        "source",
    ],
    "staff": [
        "staffid",
        "firstname",
        "lastname",
        "email",
        "phonenumber",
        "facebook",
        "linkedin",
        "skype",
        "datecreated",
        "last_login",
        "active",
        "default_language",
    ],
}


def _safe_export_value(value):
    if value is None:
        return ""
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return value


def _fetch_gdpr_export_rows(user_type, email):
    normalized_type = str(user_type or "").strip().lower()
    table_name = _GDPR_EXPORT_TABLES.get(normalized_type)
    expected_fields = _GDPR_EXPORT_FIELDS.get(normalized_type, [])
    normalized_email = str(email or "").strip()

    if not table_name or not expected_fields or not normalized_email:
        return []

    db_alias = get_current_db()
    connection = connections[db_alias]

    with connection.cursor() as cursor:
        cursor.execute(f"SHOW COLUMNS FROM `{table_name}`")
        available_columns = {row[0] for row in cursor.fetchall()}
        selected_fields = [field for field in expected_fields if field in available_columns]
        if "email" not in available_columns or not selected_fields:
            return []

        select_clause = ", ".join(f"`{field}`" for field in selected_fields)
        cursor.execute(
            f"SELECT {select_clause} FROM `{table_name}` WHERE LOWER(`email`) = LOWER(%s)",
            [normalized_email],
        )
        rows = cursor.fetchall()

    result = []
    for row in rows:
        item = {}
        for idx, field_name in enumerate(selected_fields):
            item[field_name] = _safe_export_value(row[idx])
        result.append(item)

    return result


def _build_simple_pdf(lines):
    safe_lines = [str(line).replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)") for line in lines]
    content_lines = ["BT", "/F1 10 Tf", "45 790 Td", "14 TL"]

    first = True
    for line in safe_lines:
        if first:
            content_lines.append(f"({line}) Tj")
            first = False
        else:
            content_lines.append("T*")
            content_lines.append(f"({line}) Tj")

    content_lines.append("ET")
    stream_bytes = "\n".join(content_lines).encode("latin-1", errors="replace")

    objects = [
        b"1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n",
        b"2 0 obj\n<< /Type /Pages /Kids [3 0 R] /Count 1 >>\nendobj\n",
        b"3 0 obj\n<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] "
        b"/Resources << /Font << /F1 5 0 R >> >> /Contents 4 0 R >>\nendobj\n",
        (
            f"4 0 obj\n<< /Length {len(stream_bytes)} >>\nstream\n".encode("ascii")
            + stream_bytes
            + b"\nendstream\nendobj\n"
        ),
        b"5 0 obj\n<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>\nendobj\n",
    ]

    output = b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n"
    offsets = [0]
    for obj in objects:
        offsets.append(len(output))
        output += obj

    xref_pos = len(output)
    output += f"xref\n0 {len(offsets)}\n".encode("ascii")
    output += b"0000000000 65535 f \n"
    for offset in offsets[1:]:
        output += f"{offset:010d} 00000 n \n".encode("ascii")

    output += (
        f"trailer\n<< /Size {len(offsets)} /Root 1 0 R >>\nstartxref\n{xref_pos}\n%%EOF".encode("ascii")
    )
    return output


def _build_gdpr_attachment(gdpr_request, export_rows):
    export_format = str(getattr(gdpr_request, "data_format", "json") or "json").strip().lower()
    if export_format not in {"json", "csv", "pdf"}:
        export_format = "json"

    request_summary = {
        "request_id": gdpr_request.request_id,
        "customer_name": gdpr_request.customer_name,
        "email": gdpr_request.email,
        "user_type": gdpr_request.user_type,
        "request_type": gdpr_request.request_type,
        "status": gdpr_request.status,
        "data_format": export_format,
        "details": gdpr_request.details or "",
        "requested_at": _safe_export_value(gdpr_request.requested_at),
    }

    limited_rows = export_rows[:25]

    if export_format == "csv":
        merged_rows = []
        if limited_rows:
            for row in limited_rows:
                merged = {**request_summary, **row}
                merged_rows.append({k: _safe_export_value(v) for k, v in merged.items()})
        else:
            merged_rows.append({**request_summary, "record_status": "No matching records found"})

        field_names = list(merged_rows[0].keys())
        buffer = io.StringIO()
        writer = csv.DictWriter(buffer, fieldnames=field_names)
        writer.writeheader()
        writer.writerows(merged_rows)
        content = buffer.getvalue().encode("utf-8")
        return (
            f"gdpr_export_{gdpr_request.request_id}.csv",
            content,
            "text/csv",
        )

    if export_format == "pdf":
        lines = [
            "GDPR Request Export",
            "",
            f"Request ID: {gdpr_request.request_id}",
            f"Customer Name: {gdpr_request.customer_name}",
            f"Email: {gdpr_request.email}",
            f"User Type: {gdpr_request.user_type}",
            f"Request Type: {gdpr_request.request_type}",
            f"Requested Format: {export_format.upper()}",
            f"Status: {gdpr_request.status}",
            f"Details: {gdpr_request.details or 'N/A'}",
            "",
            f"Matching Records: {len(export_rows)}",
            "",
        ]

        if limited_rows:
            for index, row in enumerate(limited_rows, start=1):
                lines.append(f"Record {index}:")
                for key, value in row.items():
                    lines.append(f"  {key}: {_safe_export_value(value)}")
                lines.append("")
        else:
            lines.append("No matching records found for the submitted email.")

        content = _build_simple_pdf(lines[:180])
        return (
            f"gdpr_export_{gdpr_request.request_id}.pdf",
            content,
            "application/pdf",
        )

    payload = {
        "request_summary": request_summary,
        "record_count": len(export_rows),
        "records": limited_rows,
    }
    content = json.dumps(payload, indent=2, default=str).encode("utf-8")
    return (
        f"gdpr_export_{gdpr_request.request_id}.json",
        content,
        "application/json",
    )


def _send_gdpr_submission_email(gdpr_request):
    request_type_label = dict(gdpr_request.REQUEST_TYPE_CHOICES).get(
        gdpr_request.request_type,
        gdpr_request.request_type,
    )

    export_rows = []
    attachment = None
    attachment_note = ""

    try:
        export_rows = _fetch_gdpr_export_rows(gdpr_request.user_type, gdpr_request.email)
        attachment = _build_gdpr_attachment(gdpr_request, export_rows)
    except Exception as exc:
        print("GDPR export generation failed:", exc)
        attachment_note = "Export attachment could not be generated at submission time."

    body_lines = [
        "Your GDPR request has been received.",
        "",
        f"Request ID: {gdpr_request.request_id}",
        f"Request Type: {request_type_label}",
        f"Requested Export Format: {str(gdpr_request.data_format).upper()}",
        f"Current Status: {gdpr_request.status}",
        f"Requested By: {gdpr_request.customer_name} ({gdpr_request.email})",
        f"Details: {gdpr_request.details or 'N/A'}",
        f"Exported Records Found: {len(export_rows)}",
    ]

    if attachment:
        body_lines.append("An export file is attached based on the selected format.")
    if attachment_note:
        body_lines.append(attachment_note)

    email_message = EmailMessage(
        subject=f"GDPR Request Submitted - {gdpr_request.request_id}",
        body="\n".join(body_lines),
        from_email=getattr(settings, "DEFAULT_FROM_EMAIL", None),
        to=[gdpr_request.email],
    )

    if attachment:
        filename, content, content_type = attachment
        email_message.attach(filename, content, content_type)

    email_message.send(fail_silently=True)


# ======================================================
# GENERIC CRUD API
# ======================================================
@api_view(['GET', 'POST', 'PUT', 'DELETE'])
@permission_classes([IsAuthenticated])
def manage_data(request, model_name, item_id=None, field=None, value=None):

    try:
        serializer_class = get_serializer_class(model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    try:
        # Prefer the serializer's model so legacy endpoints keep working
        # even when the model lives outside `ms_crm_app` (e.g. in `core`).
        serializer_meta = getattr(serializer_class, "Meta", None)
        model = getattr(serializer_meta, "model", None) or apps.get_model(app_name, model_name)
    except Exception:
        return Response({"error": "Invalid model name"}, status=status.HTTP_404_NOT_FOUND)

    table_name = getattr(getattr(model, "_meta", None), "db_table", "")
    if table_name in {"core_company_info", "core_sms_task", "core_setup_task"}:
        try:
            ensure_setup_management_tables()
        except Exception as exc:
            print("Setup management table ensure failed:", exc)

    try:
        if request.method == 'GET':
            queryset = get_filtered_queryset(
                model,
                field,
                value,
                request.query_params
            )
            if not field and not value and not request.query_params:
                queryset = model.objects.all()
            queryset = queryset.order_by('id')

            paginator = CustomPageNumberPagination()
            page = paginator.paginate_queryset(queryset, request)
            if page is not None:
                serializer = serializer_class(page, many=True)
                return paginator.get_paginated_response(serializer.data)
            serializer = serializer_class(queryset, many=True)
            return Response({"status": True, "data": serializer.data}, status=status.HTTP_200_OK)

        if request.method == 'POST':
            # Generic create using the appropriate serializer for the model
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
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            if request.method == "GET":
                return Response({"status": True, "data": []}, status=status.HTTP_200_OK)
            return Response(
                {"detail": "Table not found for this tenant. Bootstrap setup tables or run migrations."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise

# ======================================================
# GDPR Specific API
# ======================================================
@api_view(['GET', 'POST'])
@permission_classes([AllowAny])
def gdpr_requests(request):
    """List all GDPR requests or create a new one."""
    from .models import GdprRequest
    from .serializers import GdprRequestSerializer

    try:
        ensure_gdpr_requests_table()
    except Exception as exc:
        print("GDPR requests table ensure failed:", exc)

    if request.method == 'GET':
        try:
            queryset = GdprRequest.objects.all().order_by('-requested_at')
            serializer = GdprRequestSerializer(queryset, many=True)
            return Response(serializer.data)
        except (ProgrammingError, OperationalError) as exc:
            msg = str(exc).lower()
            if "doesn't exist" in msg or "1146" in msg:
                return Response([])
            raise

    # POST - create
    try:
        serializer = GdprRequestSerializer(data=request.data)
        if serializer.is_valid():
            import uuid
            instance = serializer.save(request_id=str(uuid.uuid4()))
            user_id = getattr(getattr(request, "user", None), "id", None)
            actor_label = f"user {user_id}" if user_id else "anonymous"
            _create_legacy_activity_log(
                description=f"GDPR request {instance.request_id} created via API by {actor_label}",
                request=request,
            )
            # Send submit acknowledgement with request details and export attachment.
            try:
                _send_gdpr_submission_email(instance)
            except Exception:
                pass
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            return Response(
                {"detail": "GDPR requests table not found. Run migrations or setup table bootstrap."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise


@api_view(['GET', 'PUT', 'DELETE'])
@permission_classes([AllowAny])
def gdpr_request_detail(request, pk):
    """Retrieve, update or delete a specific GDPR request."""
    from .models import GdprRequest
    from .serializers import GdprRequestSerializer

    try:
        ensure_gdpr_requests_table()
    except Exception as exc:
        print("GDPR requests table ensure failed:", exc)

    try:
        instance = get_object_or_404(GdprRequest, pk=pk)
    except (ProgrammingError, OperationalError) as exc:
        msg = str(exc).lower()
        if "doesn't exist" in msg or "1146" in msg:
            return Response(
                {"detail": "GDPR requests table not found. Run migrations or setup table bootstrap."},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        raise

    if request.method == 'GET':
        serializer = GdprRequestSerializer(instance)
        return Response(serializer.data)

    if request.method == 'PUT':
        serializer = GdprRequestSerializer(instance, data=request.data, partial=True)
        if serializer.is_valid():
            updated = serializer.save()
            user_id = getattr(getattr(request, "user", None), "id", None)
            actor_label = f"user {user_id}" if user_id else "anonymous"
            _create_legacy_activity_log(
                description=f"GDPR request {updated.request_id} updated by {actor_label}",
                request=request,
            )
            # Notify on completion
            if updated.status == 'completed':
                try:
                    send_mail(
                        subject='GDPR Request Completed',
                        message=f"Your GDPR request (ID: {updated.request_id}) has been completed.",
                        from_email=None,
                        recipient_list=[updated.email],
                        fail_silently=True,
                    )
                except Exception:
                    pass
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    if request.method == 'DELETE':
        instance.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


# ======================================================
# AUTH
# ======================================================
@api_view(["POST"])
@permission_classes([AllowAny])
def login(request):

    email = request.data.get("email")
    password = request.data.get("password")

    if not email or not password:
        return Response(
            {"message": "Email and password required"},
            status=status.HTTP_400_BAD_REQUEST
        )

    # ✅ AUTH USER (PERMANENT)
    try:
        user = User.objects.get(username=email)
    except User.DoesNotExist:
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    if not user.check_password(password):
        return Response(
            {"message": "Invalid credentials"},
            status=status.HTTP_401_UNAUTHORIZED
        )

    # ✅ BUSINESS APPROVAL (REAL TABLE)
    business = Business.objects.filter(
        email__iexact=user.email,
        is_approved=1
    ).first()

    if not business:
        return Response(
            {"message": "Business not approved yet by admin"},
            status=status.HTTP_403_FORBIDDEN
        )

    refresh = RefreshToken.for_user(user)

    return Response({
        "message": "Login successful",
        "access_token": str(refresh.access_token),
        "refresh_token": str(refresh),
        "business": {
            "name": business.name
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

