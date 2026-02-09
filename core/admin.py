from django.contrib import admin, messages
from django.utils.html import format_html
from django.urls import path
from django.shortcuts import redirect
from django.conf import settings
from django.contrib.auth.models import User
from .models import Business
import subprocess
import MySQLdb


@admin.register(Business)
class BusinessAdmin(admin.ModelAdmin):
    list_display = (
        'name',
        'email',
        'owner_name',
        'is_approved',
        'created_at'
    )
    list_filter = ('is_approved', 'created_at')
    search_fields = ('name', 'email', 'owner_name')
    readonly_fields = ('approve_button',)

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path(
                'approve/<int:business_id>/',
                self.admin_site.admin_view(self.approve_business),
                name='approve-business',
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
            '<a class="button" href="approve/{}/">Approve</a>',
            obj.id
        )

    approve_button.short_description = 'Approval'

    # =============================
    # APPROVE BUSINESS ACTION
    # =============================
    def approve_business(self, request, business_id):
        try:
            business = Business.objects.get(id=business_id)

            if business.is_approved:
                self.message_user(
                    request,
                    "Already approved.",
                    level=messages.WARNING
                )
                return redirect("..")

            # =============================
            # CREATE TENANT DB
            # =============================
            db_name = f"ms_crm_{business.name.lower().replace(' ', '_')}"
            business.db_name = db_name

            root_conn = MySQLdb.connect(
                host=settings.DATABASES['default']['HOST'],
                user=settings.DATABASES['default']['USER'],
                passwd=settings.DATABASES['default']['PASSWORD'],
                charset='utf8mb4',
                autocommit=True
            )
            with root_conn.cursor() as cursor:
                cursor.execute(f"CREATE DATABASE IF NOT EXISTS `{db_name}`")
            root_conn.close()

            # =============================
            # DUMP SCHEMA
            # =============================
            dump_result = subprocess.run(
                [
                    "mysqldump",
                    "-u",
                    settings.DATABASES['default']['USER'],
                    f"--password={settings.DATABASES['default']['PASSWORD']}",
                    "--no-data",
                    settings.DATABASES['default']['NAME'],
                ],
                capture_output=True,
                text=True
            )

            if dump_result.returncode != 0:
                self.message_user(
                    request,
                    f"Schema dump failed:\n{dump_result.stderr}",
                    level=messages.ERROR
                )
                return redirect("..")

            schema_sql = dump_result.stdout

            # =============================
            # APPLY SCHEMA TO TENANT DB
            # =============================
            tenant_conn = MySQLdb.connect(
                host=settings.DATABASES['default']['HOST'],
                user=settings.DATABASES['default']['USER'],
                passwd=settings.DATABASES['default']['PASSWORD'],
                db=db_name,
                charset='utf8mb4',
                autocommit=True
            )
            with tenant_conn.cursor() as cursor:
                for statement in schema_sql.split(";\n"):
                    if statement.strip():
                        cursor.execute(statement)
            tenant_conn.close()

            # =============================
            # ACTIVATE DJANGO USER
            # =============================
            try:
                user = User.objects.get(username=business.email)
                user.is_active = True
                user.save()
            except User.DoesNotExist:
                self.message_user(
                    request,
                    "Warning: Django user not found for this business",
                    level=messages.WARNING
                )

            # =============================
            # APPROVE BUSINESS
            # =============================
            business.is_approved = True
            business.save()

            self.message_user(
                request,
                f"Business '{business.name}' approved, DB '{db_name}' created & login enabled ✅",
                level=messages.SUCCESS
            )
            return redirect("..")

        except Exception as e:
            self.message_user(
                request,
                f"Error: {str(e)}",
                level=messages.ERROR
            )
            return redirect("..")
