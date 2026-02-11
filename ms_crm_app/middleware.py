from django.http import JsonResponse
from django.utils.deprecation import MiddlewareMixin
from django.urls import resolve, Resolver404

from .models import UserToken


class TokenAuthMiddleware(MiddlewareMixin):
    def process_request(self, request):

        # -----------------------------
        # Skip admin & static routes
        # -----------------------------
        if (
            request.path.startswith("/admin/")
            or request.path.startswith("/static/")
            or request.path.startswith("/media/")
        ):
            return None

        # -----------------------------
        # Resolve URL safely
        # -----------------------------
        try:
            current_path = resolve(request.path_info).url_name
        except Resolver404:
            return JsonResponse(
                {"error": "Invalid endpoint"},
                status=404
            )

        # -----------------------------
        # Public routes (no auth)
        # -----------------------------
        exempt_routes = {
            "signup",
            "login",
            "logout",
            "register-business",
        }

        if current_path in exempt_routes:
            return None

        # -----------------------------
        # Extract token
        # -----------------------------
        auth_header = request.headers.get("Authorization")

        if not auth_header:
            return JsonResponse(
                {"error": "Unauthorized - Token missing"},
                status=401,
            )

        # Accept both:
        # Authorization: token
        # Authorization: Bearer token
        if auth_header.startswith("Bearer "):
            token = auth_header.split(" ", 1)[1]
        else:
            token = auth_header

        # -----------------------------
        # Validate token
        # -----------------------------
        if not UserToken.objects.filter(
            access_token=token,
            is_active=True
        ).exists():
            return JsonResponse(
                {"error": "Unauthorized - Invalid Token"},
                status=401,
            )

        return None
