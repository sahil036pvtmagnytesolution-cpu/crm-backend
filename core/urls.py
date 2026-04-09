from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CalendarEventViewSet,
    dashboard_overview,
    dashboard_module_records,
    proposal_detail,
    register_business,
    login,
    logout,
    approve_role,
    sales_proposals,
    assign_proposal,
    users_list,
    ExpenseViewSet,
    ContractViewSet,
    ContractTypeViewSet,
    ContractAttachmentViewSet,
    ContractCommentViewSet,
    ContractRenewalViewSet,
    ContractTaskViewSet,
    ContractNoteViewSet,
    SmallStatsView,
    LeadViewSet,
    leads_overview,
    project_status,
    weekly_payments,
    dashboard_activity,
    EstimateListCreateView,
    EstimateViewSet,
    ProposalViewSet,
    upload_and_send_emails,
    send_single_email,
    invoice_payment_records,
    toggle_client_active,
    contacts_list_create,
    contacts_detail,
    staff_list_create,
    staff_detail,
    knowledge_base_groups_list_create,
    knowledge_base_list_create,
    items_groups_list_create,
    items_groups_detail,
    items_list_create,
    items_detail,
    public_items_list,
    creditnotes_list_create,
    creditnote_detail,
    creditnote_reminders,
    creditnote_tasks,
    ProjectViewSet,
    announcements_list,
    announcements_detail,
    goals_list,
    goals_detail,
    activity_log_list,
    activity_logs_api,
    surveys_list,
    database_backups,
    database_backup_detail,
    database_backup_download,
    ticket_pipe_log_list,
    support_ticket_pipe_create,
    # Custom field value API
    CustomFieldValueViewSet,
)
from .views import ClientViewSet, ApprovedUsersView
from .views import media_files_list, upload_media, media_file_delete
from . import views
from .views import (
    SetupModuleViewSet,
    EmailTemplateViewSet,
    SetupCustomFieldViewSet,
    SetupCurrencyViewSet,
    SetupContractTemplateViewSet,
    SetupExpenseCategoryViewSet,
    SetupSettingViewSet,
    SetupHelpArticleViewSet,
    SetupLeadSourceViewSet,
    SetupLeadStatusViewSet,
    SetupPaymentModeViewSet,
    SetupPredefinedReplyViewSet,
    SetupRolePermissionViewSet,
    SetupSupportDepartmentViewSet,
    SetupTaxViewSet,
    SetupThemeStyleViewSet,
    SetupTicketPriorityViewSet,
    SetupTicketStatusViewSet,
    SetupGDPRRequestViewSet,
    SetupCustomerGroupViewSet,
    SetupCustomerGroupAssignmentViewSet,
    TicketViewSet,
)
from ms_crm_app.views import manage_data as legacy_manage_data
from .views import (
    assign_role_to_user_api,
    legacy_roles_api,
    my_permissions_api,
    permissions_catalog_api,
    role_detail_api,
    roles_create_api,
    roles_list_api,
)

router = DefaultRouter()

router.register(r'expenses', ExpenseViewSet, basename="expenses")
router.register(r'contracts', ContractViewSet, basename="contracts")
router.register(r'contract-types', ContractTypeViewSet, basename="contract-types")
router.register(r'contract-attachments', ContractAttachmentViewSet, basename="contract-attachments")
router.register(r'contract-comments', ContractCommentViewSet, basename="contract-comments")
router.register(r'contract-renewals', ContractRenewalViewSet, basename="contract-renewals")
router.register(r'contract-tasks', ContractTaskViewSet, basename="contract-tasks")
router.register(r'contract-notes', ContractNoteViewSet, basename="contract-notes")
router.register(r'leads', LeadViewSet)
router.register(r'clients', ClientViewSet)
router.register(r'calendar-events', CalendarEventViewSet, basename="calendar-events")
router.register(r'estimates', EstimateViewSet, basename='estimates')
router.register(r'proposals', ProposalViewSet)
router.register(r'projects', ProjectViewSet, basename="projects")
router.register(r'setup/modules', SetupModuleViewSet, basename="setup-modules")
router.register(r'setup/email-templates', EmailTemplateViewSet, basename="setup-email-templates")
router.register(r'setup/tickets', TicketViewSet, basename="setup-tickets")
router.register(r'setup/custom-fields', SetupCustomFieldViewSet, basename="setup-custom-fields")
router.register(r'setup/settings', SetupSettingViewSet, basename="setup-settings")
router.register(r'setup/help-articles', SetupHelpArticleViewSet, basename="setup-help-articles")
router.register(r'setup/customer-groups', SetupCustomerGroupViewSet, basename="setup-customer-groups")
router.register(r'setup/customer-group-assignments', SetupCustomerGroupAssignmentViewSet, basename="setup-customer-group-assignments")
router.register(r'setup/theme-styles', SetupThemeStyleViewSet, basename="setup-theme-styles")
router.register(r'setup/taxes', SetupTaxViewSet, basename="setup-taxes")
router.register(r'setup/currencies', SetupCurrencyViewSet, basename="setup-currencies")
router.register(r'setup/payment-modes', SetupPaymentModeViewSet, basename="setup-payment-modes")
router.register(r'setup/expense-categories', SetupExpenseCategoryViewSet, basename="setup-expense-categories")
router.register(r'setup/support-departments', SetupSupportDepartmentViewSet, basename="setup-support-departments")
router.register(r'setup/ticket-priorities', SetupTicketPriorityViewSet, basename="setup-ticket-priorities")
router.register(r'setup/ticket-statuses', SetupTicketStatusViewSet, basename="setup-ticket-statuses")
router.register(r'setup/gdpr-requests', SetupGDPRRequestViewSet, basename="setup-gdpr-requests")
router.register(r'setup/predefined-replies', SetupPredefinedReplyViewSet, basename="setup-predefined-replies")
router.register(r'setup/lead-sources', SetupLeadSourceViewSet, basename="setup-lead-sources")
router.register(r'setup/lead-statuses', SetupLeadStatusViewSet, basename="setup-lead-statuses")
router.register(r'setup/contract-templates', SetupContractTemplateViewSet, basename="setup-contract-templates")
router.register(r'setup/role-permissions', SetupRolePermissionViewSet, basename="setup-role-permissions")
# Custom field values endpoint
router.register(r'custom-field-values', CustomFieldValueViewSet, basename="custom-field-values")

urlpatterns = [

    # Auth
    path("register-business/", register_business),
    path("login/", login),
    path("logout/", logout),

    # Roles
    path("Roles/", legacy_roles_api),
    path("Roles/approve/<int:pk>/", approve_role),
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

    # Proposals
    path("proposals/<int:pk>/assign/", assign_proposal),
    path("report/sales/", sales_proposals),
    path("proposals/<int:pk>/", proposal_detail),

    # Users list for assign dropdown
    path("users/", users_list),

    # Timesheets overview (placeholder)
    path("timesheets/", views.timesheets_overview),

    # Contacts
    path("contacts/", contacts_list_create),
    path("contacts/<int:pk>/", contacts_detail),

    # Staff
    path("staff/", staff_list_create),
    path("staff/<int:pk>/", staff_detail),

    # Knowledge Base
    path("knowledge-base-groups/", knowledge_base_groups_list_create),
    path("knowledge-base/", knowledge_base_list_create),

    # Items
    path("Items/", items_list_create),
    path("Items/<int:pk>/", items_detail),
    path("ItemsGroups/", items_groups_list_create),
    path("ItemsGroups/<int:pk>/", items_groups_detail),
    path("items-master/", public_items_list),

    # Credit Notes
    path("Creditnotes/", creditnotes_list_create),
    path("Creditnotesave/<int:pk>/", creditnote_detail),
    path("Creditnote/<int:pk>/reminders/", creditnote_reminders),
    path("Creditnotes/<int:pk>/tasks/", creditnote_tasks),
    path("Creditnotes/<int:pk>/activity/", views.creditnote_activity),

    # Projects (back-compat with older frontend paths)
    path(
        "Projects/",
        ProjectViewSet.as_view({"get": "list", "post": "create"}),
    ),
    path(
        "Projects/summary/",
        ProjectViewSet.as_view({"get": "summary"}),
    ),
    path(
        "Projects/<int:pk>/",
        ProjectViewSet.as_view(
            {
                "get": "retrieve",
                "put": "update",
                "patch": "partial_update",
                "delete": "destroy",
            }
        ),
    ),

    # Router URLs
    path("", include(router.urls)),

    # Legacy manage-data endpoints used by frontend setup pages
    path("manage/<str:model_name>/", legacy_manage_data),
    path("manage/<str:model_name>/<str:field>/<str:value>/", legacy_manage_data),
    path("manage/<str:model_name>/<int:item_id>/", legacy_manage_data),

    # Dashboard
    path("dashboard/small-stats/", SmallStatsView.as_view()),
    path("dashboard/overview/", dashboard_overview),
    path("dashboard/modules-records/", dashboard_module_records),
    path("dashboard/leads-overview/", leads_overview),
    path("dashboard/project-status/", project_status),
    path("dashboard/weekly-payments/", weekly_payments),
    path("dashboard/activity/", dashboard_activity),

    # Estimate
    path("Estimates/", EstimateListCreateView.as_view()),

    path("approved-users/", ApprovedUsersView.as_view()),

    # Email Campaign
    path("email-campaign/", upload_and_send_emails),
    path("send-single-email/", send_single_email),

    # Invoice
    path("invoices/", views.invoice_list),
    path("invoices/<int:pk>/", views.invoice_detail),

    # Invoice reminders/tasks
    path("invoices/<int:pk>/reminders/", views.invoice_reminders),
    path("invoices/<int:pk>/tasks/", views.invoice_tasks),
    path("invoices/<int:pk>/activity/", views.invoice_activity),

    # Invoice email
    path("send-invoice-email/", views.send_invoice_email),
    path("invoices/<int:pk>/email-history/", views.invoice_email_history),

    # Payments
    path("manage_data/Invoicepaymentrecords/", invoice_payment_records, name="invoice_payment_records"),
    path("manage_data/create-invoice-payment/", views.create_invoice_payment, name="create_invoice_payment"),

    # fix invoice
    path("fix-invoice-payments/", views.fix_invoice_payments),

    # Convert old estimate
    path("convert-old-estimate/", views.convert_existing_estimates),
    path("convert-estimates/", views.convert_old_estimates_to_invoices),

    # fix estimate invoices
    path("fix-estimate-invoices/", views.fix_estimate_invoices),

    # customers
    path("clients/<int:pk>/toggle-active/", toggle_client_active),
    
    # Media API
    path("media-files/", media_files_list, name="media-files-list"),
    path("media-files/<int:pk>/", media_file_delete, name="media-file-delete"),
    path("upload-media/", upload_media, name="upload-media"),

    # Utilities
    path("utilities/announcements/", announcements_list),
    path("utilities/announcements/<int:pk>/", announcements_detail),
    path("utilities/goals/", goals_list),
    path("utilities/goals/<int:pk>/", goals_detail),
    path("utilities/activity-log/", activity_log_list),
    path("activity-logs/", activity_logs_api),
    path("utilities/surveys/", surveys_list),
    path("utilities/surveys/<int:pk>/", views.surveys_detail),
    path("utilities/database-backups/", database_backups),
    path("utilities/database-backups/<int:pk>/", database_backup_detail),
    path("utilities/database-backups/<int:pk>/download/", database_backup_download),
    path("utilities/ticket-pipe-log/", ticket_pipe_log_list),
    path("support/ticket-pipe/", support_ticket_pipe_create),
    
    ]
