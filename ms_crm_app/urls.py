from django.urls import include, path
from rest_framework.routers import DefaultRouter
from .views import manage_data, login, signup, logout
from .views import roles_list_create
from .views import gdpr_requests, gdpr_request_detail
from .views import (
    CustomerStatusViewSet,
    EmailIntegrationViewSet,
    LeadSourceViewSet,
    LeadViewSet,
    ProductStatusViewSet,
    ProductViewSet,
    WebFormFieldViewSet,
)

router = DefaultRouter()
router.register(r"leads", LeadViewSet, basename="lead")
router.register(r"sources", LeadSourceViewSet, basename="source")
router.register(r"products", ProductViewSet, basename="product")
router.register(r"product-status", ProductStatusViewSet, basename="product-status")
router.register(r"customer-status", CustomerStatusViewSet, basename="customer-status")
router.register(r"web-form-fields", WebFormFieldViewSet, basename="web-form-field")
router.register(r"email-integrations", EmailIntegrationViewSet, basename="email-integration")

lead_urlpatterns = [
    path("", include(router.urls)),
]

urlpatterns = [
    path('login/', login, name='login'),
    path('signup/', signup, name='signup'),
    path('manage_data/Roles/', roles_list_create),
    # Generic CRUD endpoints for a given model
    path('manage/<str:model_name>/', manage_data),
    # Endpoint to address a specific record of a model by its primary key
    path('manage/<str:model_name>/<int:item_id>/', manage_data),
    # Endpoint for filtered queries by field/value on a model
    path('manage/<str:model_name>/<str:field>/<str:value>/', manage_data),
    # Legacy endpoint that addressed a record by ID without a model name (kept for compatibility)
    path('manage/<int:item_id>/', manage_data),
    # GDPR endpoints
    path('gdpr/requests/', gdpr_requests, name='gdpr_requests'),
    path('gdpr/requests/<int:pk>/', gdpr_request_detail, name='gdpr_request_detail'),
] + lead_urlpatterns
