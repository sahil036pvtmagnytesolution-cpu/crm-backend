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
    create_proposal,
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
)
from .views import ClientViewSet

router = DefaultRouter()

# ✅ Expenses
router.register(r'expenses', ExpenseViewSet, basename="expenses")

# ✅ Leads
router.register(r'leads', LeadViewSet)

# ✅ Clients
router.register(r'clients', ClientViewSet)

# ✅ Calendar Events
router.register(r'calendar-events', CalendarEventViewSet, basename="calendar-events")

# Estimate
router.register(r'estimates', EstimateViewSet, basename='estimates')
# Estimate, Invoice, Payments (Placeholders)

# Email
router.register(r'proposals', ProposalViewSet)


urlpatterns = [
    # Auth
    path("register-business/", register_business),
    path("register_business/", register_business),
    path("login/", login),

    # Roles
    path("Roles/", roles_api),
    path("Roles/approve/<int:pk>/", approve_role),

    # Proposals
    path("proposals/", create_proposal),
    path("proposals/<int:pk>/assign/", assign_proposal),
    path("report/sales/", sales_proposals),
    path("proposals/<int:pk>/", proposal_detail),

    # Dashboard
    path("dashboard/small-stats/", SmallStatsView.as_view(), name="small-stats"),
    path("users/", users_list),

    # Router URLs
    path("", include(router.urls)),

    # Dashboard Overview
    path("dashboard/overview/", dashboard_overview),

    path("dashboard/leads-overview/", leads_overview),
    path("dashboard/project-status/", project_status),
    path("dashboard/weekly-payments/", weekly_payments),
    path("dashboard/activity/", dashboard_activity),

    # Estimate, Invoice, Payments (Placeholders)
    path("Estimates/", EstimateListCreateView.as_view()),
    # path("invoices/", InvoiceListCreateView.as_view(), name="invoices"),
    # path("payments/", PaymentListCreateView.as_view(), name="payments"),
    
]