from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    proposal_detail,
    register_business,
    login,
    roles_api,
    approve_role,
    sales_proposals,
    create_proposal,
    assign_proposal,
    users_list,
    ExpenseViewSet,  # ✅ NEW
)
from .views import SmallStatsView

# ✅ Router for Expense API
router = DefaultRouter()
router.register(r'expenses', ExpenseViewSet, basename="expenses")

urlpatterns = [
    # Auth / Business
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

    # Detail + Update
    path("proposals/<int:pk>/", proposal_detail),

    path("dashboard/small-stats/", SmallStatsView.as_view(), name="small-stats"),

    path("users/", users_list),

    # ✅ Expenses API
    path("", include(router.urls)),
]