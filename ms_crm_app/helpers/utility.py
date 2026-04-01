from importlib import import_module
from rest_framework import serializers
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response 
from django.utils import timezone

app_name = 'ms_crm_app'

def get_serializer_class(model_name):
    """Return the appropriate serializer class for a given model name.

    The original implementation assumed serializer classes were named
    ``<ModelName>Serializers`` which does not match the actual naming in this
    project (e.g., ``ContactSerializer``).  To make the generic ``manage_data``
    endpoint robust, we now attempt to locate either ``<ModelName>Serializer``
    *or* ``<ModelName>Serializers`` in the ``ms_crm_app.serializers`` module.
    """
    module_name = 'ms_crm_app.serializers'
    try:
        module = import_module(module_name)
        # Try the conventional singular form first.
        possible_names = [f"{model_name}Serializer", f"{model_name}Serializers"]
        serializer_class = None
        for name in possible_names:
            serializer_class = getattr(module, name, None)
            if serializer_class:
                break
        if serializer_class is None:
            raise AttributeError(
                f"Serializer for model '{model_name}' not found in module '{module_name}'. "
                f"Tried names: {', '.join(possible_names)}"
            )
        if not issubclass(serializer_class, serializers.Serializer):
            raise TypeError(f"'{serializer_class}' is not a valid serializer class")
        return serializer_class
    except ModuleNotFoundError:
        raise ImportError(f"Module '{module_name}' not found")
    
def get_filtered_queryset(model_class, field=None, value=None, params=None):
    EXCLUDED_KEYS = ['page', 'per_page']
    if field and value:
        return model_class.objects.filter(**{field: value})
    elif params:
        filters = {}
        for k, v in params.items():
            if k in EXCLUDED_KEYS:
                continue
            if v:
                filters[f"{k}__in" if ',' in v else k] = v.split(',') if ',' in v else v
        return model_class.objects.filter(**filters)
    return model_class.objects.none()

class CustomPageNumberPagination(PageNumberPagination):
    page_size = None  # Disable default
    page_size_query_param = 'per_page'  # Allow user to set
    max_page_size = 1000  # Prevent abuse

    def get_paginated_response(self, data):
        return Response({
            'status': True,
            'data': data,
            'pagination': {
                'total_items': self.page.paginator.count,
                'current_page': self.page.number,
                'per_page': self.get_page_size(self.request),
                'total_pages': self.page.paginator.num_pages,
            }
        })
