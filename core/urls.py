from django.urls import path
from .views import (
    register_business,
    login,                 # ✅ login added
    roles_api,
    approve_role,
    sales_proposals,
    create_proposal,
    assign_proposal,
)
from .views import delete_proposal  # 🔥 DELETE endpoint


urlpatterns = [
    # Auth / Business
    path("register-business/", register_business),
    path("register_business/", register_business),  # backward compatible
    path("login/", login),  # ✅ FIX: login endpoint

    # Roles
    path("Roles/", roles_api),
    path("Roles/approve/<int:pk>/", approve_role),

    # Proposals
    path("proposals/", create_proposal),                 # POST create
    path("proposals/<int:pk>/assign/", assign_proposal), # POST assign
    path("report/sales/", sales_proposals),              # GET list

     # 🔥 DELETE
    path("proposals/<int:pk>/", delete_proposal),

]
