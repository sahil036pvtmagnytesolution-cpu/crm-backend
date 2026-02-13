from django.urls import path
from .views import register_business, roles_api, approve_role

urlpatterns = [
    path("register-business/", register_business),
    path("register_business/", register_business),

    # Roles
    path("Roles/", roles_api),
    path("Roles/approve/<int:pk>/", approve_role),
]
