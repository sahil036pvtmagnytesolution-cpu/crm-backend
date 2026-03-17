from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CalendarEventViewSet,
    dashboard_overview,
    proposal_detail,
    register_business,
    login,
    roles_api,
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
)
from .views import ClientViewSet, ApprovedUsersView
from .views import media_files_list, upload_media, media_file_delete
from . import views

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

urlpatterns = [

    # Auth
    path("register-business/", register_business),
    path("login/", login),

    # Roles
    path("Roles/", roles_api),
    path("Roles/approve/<int:pk>/", approve_role),

    # Proposals
    path("proposals/<int:pk>/assign/", assign_proposal),
    path("report/sales/", sales_proposals),
    path("proposals/<int:pk>/", proposal_detail),

    # Users list for assign dropdown
    path("users/", users_list),

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

    # Dashboard
    path("dashboard/small-stats/", SmallStatsView.as_view()),
    path("dashboard/overview/", dashboard_overview),
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
    
    ]
