"""
URL configuration for ms_crm_proj project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from core.views import public_items_list, activity_logs_api
from ms_crm_app.urls import lead_urlpatterns
from core.views import (
    assign_role_to_user_api,
    my_permissions_api,
    permissions_catalog_api,
    role_detail_api,
    roles_create_api,
    roles_list_api,
)

urlpatterns = [
    path("admin/", admin.site.urls),

    # JWT
    path("api/token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("api/token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),

    # ✅ ONLY ONE API PREFIX
    path("api/manage_data/", include("core.urls")),
    path("api/roles/create/", roles_create_api),
    path("api/roles/create", roles_create_api),
    path("api/roles/", roles_list_api),
    path("api/roles", roles_list_api),
    path("api/roles/<int:pk>/", role_detail_api),
    path("api/roles/<int:pk>", role_detail_api),
    path("api/roles/assign-to-user/", assign_role_to_user_api),
    path("api/roles/assign-to-user", assign_role_to_user_api),
    path("api/roles/permissions/", permissions_catalog_api),
    path("api/roles/permissions", permissions_catalog_api),
    path("api/roles/my-permissions/", my_permissions_api),
    path("api/roles/my-permissions", my_permissions_api),
    path("api/items/", public_items_list),
    path("api/activity-logs/", activity_logs_api),
    path("core_api/", include("core.urls")),
    # Include the ms_crm_app URLs which contain the newly added setup endpoints
    path("api/app/", include("ms_crm_app.urls")),
    path("api/", include((lead_urlpatterns, "ms_crm_app"))),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


