from django.urls import path
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
    # delete_proposal,
)
from .views import SmallStatsView

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

    # ✅ DETAIL + UPDATE
    path("proposals/<int:pk>/", proposal_detail),

    path('dashboard/small-stats/', SmallStatsView.as_view(), name='small-stats'),

    path("users/", users_list),

]
