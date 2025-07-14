from django.urls import path
from . import views

urlpatterns = [
    # URL for managing data without specifying item ID or field/value pair
    path('manage_data/<str:model_name>/', views.manage_data, name='manage_data'),

    # URL for managing data with a specific item ID
    path('manage_data/<str:model_name>/<int:item_id>/', views.manage_data, name='manage_data_detail'),

    # URL for managing data with a specific field and value
    path('manage_data/<str:model_name>/<str:field>/<str:value>/', views.manage_data, name='manage_data_field_value'),
    
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path("signup/", views.signup, name="signup"),
]