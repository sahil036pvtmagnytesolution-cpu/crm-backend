from django.contrib import admin, messages
from django.utils.html import format_html
from django.urls import path
from django.shortcuts import redirect
from django.conf import settings
from django.contrib.auth.models import User

from .models import Business
from django.db import connection

import MySQLdb


@admin.register(Business)
class BusinessAdmin(admin.ModelAdmin):
    list_display = ("name", "email", "owner_name", "is_approved", "created_at")
    list_filter = ("is_approved", "created_at")
    search_fields = ("name", "email", "owner_name")

    # 👇 IMPORTANT: approve_button ko form me dikhane ke liye
    readonly_fields = ("approve_button",)
    fields = (
        "name",
        "email",
        "owner_name",
        "is_approved",
        "db_name",
        "approve_button",
    )

    # =============================
    # CUSTOM URL
    # =============================
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                "<int:business_id>/approve/",
                self.admin_site.admin_view(self.approve_business),
                name="approve-business",
            ),
        ]
        return custom_urls + urls

    # =============================
    # APPROVE BUTTON
    # =============================
    def approve_button(self, obj):
        if obj.is_approved:
            return "✅ Approved"

        return format_html(
            '<a class="button" href="/admin/core/business/{}/approve/">Approve</a>',
            obj.id,
    )


    approve_button.short_description = "Approval"

    # =============================
    # APPROVE BUSINESS (FAST & SAFE)
    # =============================
    def approve_business(self, request, business_id):
        try:
            business = Business.objects.get(id=business_id)

            if business.is_approved:
                self.message_user(
                    request,
                    "Business already approved",
                    level=messages.WARNING,
                )
                return redirect(
                    f"/admin/core/business/{business.id}/change/"
                )

            # -----------------------------
            # CREATE TENANT DB (OPTIONAL, SAFE)
            # -----------------------------
            db_name = f"ms_crm_{business.id}"
            business.db_name = db_name

            root_conn = MySQLdb.connect(
                host=settings.DATABASES["default"]["HOST"],
                user=settings.DATABASES["default"]["USER"],
                passwd=settings.DATABASES["default"]["PASSWORD"],
                charset="utf8mb4",
                autocommit=True,
            )

            with root_conn.cursor() as cursor:
                cursor.execute(
                    f"CREATE DATABASE IF NOT EXISTS `{db_name}`"
                )
            root_conn.close()

            # -----------------------------
            # 🔥 INSTANT APPROVAL (NO DELAY)
            # -----------------------------
            with connection.cursor() as cursor:
                cursor.execute(
                    "UPDATE core_business SET is_approved = 1 WHERE id = %s",
                    [business_id],
            )

            # -----------------------------
            # ACTIVATE USER (OPTIONAL)
            # -----------------------------
            User.objects.filter(
                username=business.email
            ).update(is_active=True)

            self.message_user(
                request,
                f"Business '{business.name}' approved successfully ✅",
                level=messages.SUCCESS,
            )

        except Business.DoesNotExist:
            self.message_user(
                request,
                "Business not found",
                level=messages.ERROR,
            )

        except Exception as e:
            self.message_user(
                request,
                f"Approval failed: {e}",
                level=messages.ERROR,
            )

        return redirect(
            f"/admin/core/business/{business_id}/change/"
        )

    # ==================================================
    # PERMANENT BACKUP APPROVAL (ADMIN ACTION)
    # ==================================================
    actions = ["approve_selected_businesses"]

    def approve_selected_businesses(self, request, queryset):
        approved_count = 0

        for business in queryset:
            if business.is_approved:
                continue

            # Same logic as button (NO CHANGE)
            db_name = f"ms_crm_{business.id}"
            business.db_name = db_name

            root_conn = MySQLdb.connect(
                host=settings.DATABASES["default"]["HOST"],
                user=settings.DATABASES["default"]["USER"],
                passwd=settings.DATABASES["default"]["PASSWORD"],
                charset="utf8mb4",
                autocommit=True,
            )

            with root_conn.cursor() as cursor:
                cursor.execute(
                    f"CREATE DATABASE IF NOT EXISTS `{db_name}`"
                )
            root_conn.close()

            business.is_approved = True
            business.save(update_fields=["is_approved", "db_name"])

            User.objects.filter(
                username=business.email
            ).update(is_active=True)

            approved_count += 1

        self.message_user(
            request,
            f"{approved_count} business(es) approved successfully ✅",
            level=messages.SUCCESS,
        )

    approve_selected_businesses.short_description = "✅ Approve selected businesses (Permanent)"
