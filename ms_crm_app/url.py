from django.urls import path
from . import views
from .views import login
from .views import login, dashboard

urlpatterns = [
    # URL for managing data without specifying item ID or field/value pair
    path('manage_data/<str:model_name>/', views.manage_data, name='manage_data'),

    # URL for managing data with a specific item ID
    path('manage_data/<str:model_name>/<int:item_id>/', views.manage_data, name='manage_data_detail'),

    # URL for managing data with a specific field and value
    path('manage_data/<str:model_name>/<str:field>/<str:value>/', views.manage_data, name='manage_data_field_value'),
    path('login/', login, name='login'),
    path('logout/', views.logout, name='logout'),
    path("signup/", views.signup, name="signup"),
    path("dashboard/", dashboard, name="dashboard"),    
]