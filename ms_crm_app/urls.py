from django.urls import path
from .views import manage_data, login, signup, logout
from .views import roles_list_create

urlpatterns = [
    path('login/', login, name='login'),
    path('signup/', signup, name='signup'),
    path('manage_data/Roles/', roles_list_create),
    path('manage/<str:model_name>/', manage_data),
    path('manage/<str:model_name>/<str:field>/<str:value>/', manage_data),
    path('manage/<str:model_name>/<int:item_id>/', manage_data),
]
