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
    # ------------------------------------------------------------
    # Setup related endpoints – these use the generic manage_data view
    # to provide CRUD operations for the newly added models.
    # ------------------------------------------------------------
    path('setup/company-info/', views.manage_data, {'model_name': 'CompanyInfo'}, name='company_info'),
    path('setup/company-info/<int:item_id>/', views.manage_data, {'model_name': 'CompanyInfo'}, name='company_info_detail'),
    path('setup/sms-tasks/', views.manage_data, {'model_name': 'SMSTask'}, name='sms_task'),
    path('setup/sms-tasks/<int:item_id>/', views.manage_data, {'model_name': 'SMSTask'}, name='sms_task_detail'),
    path('setup/tasks/', views.manage_data, {'model_name': 'SetupTask'}, name='setup_task'),
    path('setup/tasks/<int:item_id>/', views.manage_data, {'model_name': 'SetupTask'}, name='setup_task_detail'),
    # ------------------------------------------------------------
    # Contact CRUD – expose the Contact model via the generic manage_data view.
    # ------------------------------------------------------------
    path('contacts/', views.manage_data, {'model_name': 'Contact'}, name='contacts'),
    path('contacts/<int:item_id>/', views.manage_data, {'model_name': 'Contact'}, name='contact_detail'),
    # ------------------------------------------------------------
    # Client CRUD – expose the Client model for address management.
    # ------------------------------------------------------------
    path('clients/', views.manage_data, {'model_name': 'Client'}, name='clients'),
    path('clients/<int:item_id>/', views.manage_data, {'model_name': 'Client'}, name='client_detail'),
]