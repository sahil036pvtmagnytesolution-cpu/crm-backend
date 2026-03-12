from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CalendarEventViewSet,
    dashboard_overview,
    proposal_detail,
    register_business,
    login,
    roles_api,
    approve_role,
    sales_proposals,
    assign_proposal,
    users_list,
    ExpenseViewSet,
    SmallStatsView,
    LeadViewSet,
    leads_overview,
    project_status,
    weekly_payments,
    dashboard_activity,
    EstimateListCreateView,
    EstimateViewSet,
    ProposalViewSet,
    upload_and_send_emails,
    send_single_email,
    invoice_payment_records,
    toggle_client_active,
)
from .views import ClientViewSet, ApprovedUsersView
from . import views

router = DefaultRouter()

router.register(r'expenses', ExpenseViewSet, basename="expenses")
router.register(r'leads', LeadViewSet)
router.register(r'clients', ClientViewSet)
router.register(r'calendar-events', CalendarEventViewSet, basename="calendar-events")
router.register(r'estimates', EstimateViewSet, basename='estimates')
router.register(r'proposals', ProposalViewSet)

urlpatterns = [

    # Auth
    path("register-business/", register_business),
    path("login/", login),

    # Roles
    path("Roles/", roles_api),
    path("Roles/approve/<int:pk>/", approve_role),

    # Proposals
    path("proposals/<int:pk>/assign/", assign_proposal),
    path("report/sales/", sales_proposals),
    path("proposals/<int:pk>/", proposal_detail),

    # Users list for assign dropdown
    path("users/", users_list),

    # Router URLs
    path("", include(router.urls)),

    # Dashboard
    path("dashboard/small-stats/", SmallStatsView.as_view()),
    path("dashboard/overview/", dashboard_overview),
    path("dashboard/leads-overview/", leads_overview),
    path("dashboard/project-status/", project_status),
    path("dashboard/weekly-payments/", weekly_payments),
    path("dashboard/activity/", dashboard_activity),

    # Estimate
    path("Estimates/", EstimateListCreateView.as_view()),

    path("approved-users/", ApprovedUsersView.as_view()),

    # Email Campaign
    path("email-campaign/", upload_and_send_emails),
    path("send-single-email/", send_single_email),

    # Invoice
    path("invoices/", views.invoice_list),
    path("invoices/<int:pk>/", views.invoice_detail),

    # Invoice reminders/tasks
    path("invoices/<int:pk>/reminders/", views.invoice_reminders),
    path("invoices/<int:pk>/tasks/", views.invoice_tasks),

    # Invoice email
    path("send-invoice-email/", views.send_invoice_email),
    path("invoices/<int:pk>/email-history/", views.invoice_email_history),

    # Payments
    path("manage_data/Invoicepaymentrecords/", invoice_payment_records, name="invoice_payment_records"),
    path("manage_data/create-invoice-payment/", views.create_invoice_payment, name="create_invoice_payment"),

    # fix invoice
    path("fix-invoice-payments/", views.fix_invoice_payments),

    # Convert old estimate
    path("convert-old-estimate/", views.convert_existing_estimates),
    path("convert-estimates/", views.convert_old_estimates_to_invoices),

    # fix estimate invoices
    path("fix-estimate-invoices/", views.fix_estimate_invoices),

    # customers
    path("clients/<int:pk>/toggle-active/", toggle_client_active),


]