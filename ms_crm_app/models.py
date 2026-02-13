from django.db import models
from django.utils import timezone
from .constants import UserType

# Create your models here.

class UserProfile(models.Model):
    user_id = models.IntegerField(default=0,null=True, blank=True)
    user_name = models.CharField(max_length=100)
    user_type = models.IntegerField(choices=[(tag.value, tag.name) for tag in UserType],null=True, blank=True)
    business_name = models.CharField(max_length=100)
    user_email = models.EmailField(unique=True)
    contact_number = models.CharField(max_length=20)
    password = models.CharField(max_length=255)
    address = models.TextField(max_length=100)
    city = models.CharField(max_length=100, null=True, blank=True)
    created_by = models.IntegerField(null=True, blank=True)
    updated_by = models.IntegerField(null=True, blank=True)
    created_datetime = models.DateTimeField(default=timezone.now,null=True)
    updated_datetime = models.DateTimeField(default=timezone.now,null=True)

    def __str__(self):
        return self.user_name
    
    class Meta:
        db_table = "ms_user_profiles"

class UserToken(models.Model):
    user = models.ForeignKey(UserProfile, on_delete=models.CASCADE)
    access_token = models.TextField()
    refresh_token = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.user_name} - Token"
    
    class Meta:
        db_table = "ms_user_token"

class ActivityLog(models.Model):
    description = models.TextField()
    date = models.DateTimeField()
    staff_name = models.CharField(max_length=100, null=True, blank=True)

    class Meta:
        db_table = "ms_activity_log"
        managed = False   # 🔥 THIS IS THE KEY FIX

    def __str__(self):
        return self.description[:50]


class Announcements(models.Model):
    announcementid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=191)
    message = models.TextField(blank=True, null=True)
    showtousers = models.IntegerField()
    showtostaff = models.IntegerField()
    showname = models.IntegerField()
    dateadded = models.DateTimeField()
    userid = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_announcements'


class Clients(models.Model):
    userid = models.AutoField(primary_key=True)
    company = models.CharField(max_length=191, blank=True, null=True)
    vat = models.CharField(max_length=50, blank=True, null=True)
    phonenumber = models.CharField(max_length=30, blank=True, null=True)
    country = models.IntegerField()
    city = models.CharField(max_length=100, blank=True, null=True)
    zip = models.CharField(max_length=15, blank=True, null=True)
    state = models.CharField(max_length=50, blank=True, null=True)
    address = models.CharField(max_length=100, blank=True, null=True)
    website = models.CharField(max_length=150, blank=True, null=True)
    datecreated = models.DateTimeField()
    active = models.IntegerField()
    leadid = models.IntegerField(blank=True, null=True)
    billing_street = models.CharField(max_length=200, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=100, blank=True, null=True)
    billing_country = models.IntegerField(blank=True, null=True)
    shipping_street = models.CharField(max_length=200, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=100, blank=True, null=True)
    shipping_country = models.IntegerField(blank=True, null=True)
    longitude = models.CharField(max_length=191, blank=True, null=True)
    latitude = models.CharField(max_length=191, blank=True, null=True)
    default_language = models.CharField(max_length=40, blank=True, null=True)
    default_currency = models.IntegerField()
    show_primary_contact = models.IntegerField()
    stripe_id = models.CharField(max_length=40, blank=True, null=True)
    registration_confirmed = models.IntegerField()
    addedfrom = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_clients'


class ConsentPurposes(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    date_created = models.DateTimeField()
    last_updated = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_consent_purposes'


class Consents(models.Model):
    action = models.CharField(max_length=10)
    date = models.DateTimeField()
    ip = models.CharField(max_length=40)
    contact_id = models.IntegerField()
    lead_id = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    opt_in_purpose_description = models.TextField(blank=True, null=True)
    purpose_id = models.IntegerField()
    staff_name = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_consents'


class ContactPermissions(models.Model):
    permission_id = models.IntegerField()
    userid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_contact_permissions'


class Contacts(models.Model):
    userid = models.IntegerField()
    is_primary = models.IntegerField()
    firstname = models.CharField(max_length=191)
    lastname = models.CharField(max_length=191)
    email = models.CharField(max_length=100)
    phonenumber = models.CharField(max_length=100)
    title = models.CharField(max_length=100, blank=True, null=True)
    datecreated = models.DateTimeField()
    password = models.CharField(max_length=255, blank=True, null=True)
    new_pass_key = models.CharField(max_length=32, blank=True, null=True)
    new_pass_key_requested = models.DateTimeField(blank=True, null=True)
    email_verified_at = models.DateTimeField(blank=True, null=True)
    email_verification_key = models.CharField(max_length=32, blank=True, null=True)
    email_verification_sent_at = models.DateTimeField(blank=True, null=True)
    last_ip = models.CharField(max_length=40, blank=True, null=True)
    last_login = models.DateTimeField(blank=True, null=True)
    last_password_change = models.DateTimeField(blank=True, null=True)
    active = models.IntegerField()
    profile_image = models.CharField(max_length=191, blank=True, null=True)
    direction = models.CharField(max_length=3, blank=True, null=True)
    invoice_emails = models.IntegerField()
    estimate_emails = models.IntegerField()
    credit_note_emails = models.IntegerField()
    contract_emails = models.IntegerField()
    task_emails = models.IntegerField()
    project_emails = models.IntegerField()
    ticket_emails = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_contacts'


class ContractComments(models.Model):
    content = models.TextField(blank=True, null=True)
    contract_id = models.IntegerField()
    staffid = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_contract_comments'


class ContractRenewals(models.Model):
    contractid = models.IntegerField()
    old_start_date = models.DateField()
    new_start_date = models.DateField()
    old_end_date = models.DateField(blank=True, null=True)
    new_end_date = models.DateField(blank=True, null=True)
    old_value = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    new_value = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    date_renewed = models.DateTimeField()
    renewed_by = models.CharField(max_length=100)
    renewed_by_staff_id = models.IntegerField()
    is_on_old_expiry_notified = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_contract_renewals'


class Contracts(models.Model):
    content = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    subject = models.CharField(max_length=191, blank=True, null=True)
    client = models.IntegerField()
    datestart = models.DateField(blank=True, null=True)
    dateend = models.DateField(blank=True, null=True)
    contract_type = models.IntegerField(blank=True, null=True)
    addedfrom = models.IntegerField()
    dateadded = models.DateTimeField()
    isexpirynotified = models.IntegerField()
    contract_value = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    trash = models.IntegerField(blank=True, null=True)
    not_visible_to_client = models.IntegerField()
    hash = models.CharField(max_length=32, blank=True, null=True)
    signed = models.IntegerField()
    signature = models.CharField(max_length=40, blank=True, null=True)
    acceptance_firstname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_lastname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_email = models.CharField(max_length=100, blank=True, null=True)
    acceptance_date = models.DateTimeField(blank=True, null=True)
    acceptance_ip = models.CharField(max_length=40, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_contracts'


class ContractsTypes(models.Model):
    name = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_contracts_types'


class Countries(models.Model):
    country_id = models.AutoField(primary_key=True)
    iso2 = models.CharField(max_length=2, blank=True, null=True)
    short_name = models.CharField(max_length=80)
    long_name = models.CharField(max_length=80)
    iso3 = models.CharField(max_length=3, blank=True, null=True)
    numcode = models.CharField(max_length=6, blank=True, null=True)
    un_member = models.CharField(max_length=12, blank=True, null=True)
    calling_code = models.CharField(max_length=8, blank=True, null=True)
    cctld = models.CharField(max_length=5, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_countries'


class CreditnoteRefunds(models.Model):
    credit_note_id = models.IntegerField()
    staff_id = models.IntegerField()
    refunded_on = models.DateField()
    payment_mode = models.CharField(max_length=40)
    note = models.TextField(blank=True, null=True)
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_creditnote_refunds'


class Creditnotes(models.Model):
    clientid = models.IntegerField()
    deleted_customer_name = models.CharField(max_length=100, blank=True, null=True)
    number = models.IntegerField()
    prefix = models.CharField(max_length=50, blank=True, null=True)
    number_format = models.IntegerField()
    datecreated = models.DateTimeField()
    date = models.DateField()
    adminnote = models.TextField(blank=True, null=True)
    terms = models.TextField(blank=True, null=True)
    clientnote = models.TextField(blank=True, null=True)
    currency = models.IntegerField()
    subtotal = models.DecimalField(max_digits=15, decimal_places=2)
    total_tax = models.DecimalField(max_digits=15, decimal_places=2)
    total = models.DecimalField(max_digits=15, decimal_places=2)
    adjustment = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    addedfrom = models.IntegerField(blank=True, null=True)
    status = models.IntegerField(blank=True, null=True)
    project_id = models.IntegerField()
    discount_percent = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_total = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_type = models.CharField(max_length=30)
    billing_street = models.CharField(max_length=200, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=100, blank=True, null=True)
    billing_country = models.IntegerField(blank=True, null=True)
    shipping_street = models.CharField(max_length=200, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=100, blank=True, null=True)
    shipping_country = models.IntegerField(blank=True, null=True)
    include_shipping = models.IntegerField()
    show_shipping_on_credit_note = models.IntegerField()
    show_quantity_as = models.IntegerField()
    reference_no = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_creditnotes'


class Credits(models.Model):
    invoice_id = models.IntegerField()
    credit_id = models.IntegerField()
    staff_id = models.IntegerField()
    date = models.DateField()
    date_applied = models.DateTimeField()
    amount = models.DecimalField(max_digits=15, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'ms_credits'


class Currencies(models.Model):
    symbol = models.CharField(max_length=10)
    name = models.CharField(max_length=100)
    decimal_separator = models.CharField(max_length=5, blank=True, null=True)
    thousand_separator = models.CharField(max_length=5, blank=True, null=True)
    placement = models.CharField(max_length=10, blank=True, null=True)
    isdefault = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_currencies'


class CustomerAdmins(models.Model):
    staff_id = models.IntegerField()
    customer_id = models.IntegerField()
    date_assigned = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_customer_admins'


class CustomerGroups(models.Model):
    groupid = models.IntegerField()
    customer_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_customer_groups'


class CustomersGroups(models.Model):
    name = models.CharField(max_length=191)

    class Meta:
        managed = False
        db_table = 'ms_customers_groups'


class Customfields(models.Model):
    fieldto = models.CharField(max_length=15)
    name = models.CharField(max_length=150)
    slug = models.CharField(max_length=150)
    required = models.IntegerField()
    type = models.CharField(max_length=20)
    options = models.TextField(blank=True, null=True)
    display_inline = models.IntegerField()
    field_order = models.IntegerField(blank=True, null=True)
    active = models.IntegerField()
    show_on_pdf = models.IntegerField()
    show_on_ticket_form = models.IntegerField()
    only_admin = models.IntegerField()
    show_on_table = models.IntegerField()
    show_on_client_portal = models.IntegerField()
    disalow_client_to_edit = models.IntegerField()
    bs_column = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_customfields'


class Customfieldsvalues(models.Model):
    relid = models.IntegerField()
    fieldid = models.IntegerField()
    fieldto = models.CharField(max_length=15)
    value = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_customfieldsvalues'


class Departments(models.Model):
    departmentid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    imap_username = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=100, blank=True, null=True)
    email_from_header = models.IntegerField()
    host = models.CharField(max_length=150, blank=True, null=True)
    password = models.TextField(blank=True, null=True)
    encryption = models.CharField(max_length=3, blank=True, null=True)
    delete_after_import = models.IntegerField()
    calendar_id = models.TextField(blank=True, null=True)
    hidefromclient = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_departments'


class DismissedAnnouncements(models.Model):
    dismissedannouncementid = models.AutoField(primary_key=True)
    announcementid = models.IntegerField()
    staff = models.IntegerField()
    userid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_dismissed_announcements'


class Emaillists(models.Model):
    listid = models.AutoField(primary_key=True)
    name = models.TextField()
    creator = models.CharField(max_length=100)
    datecreated = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_emaillists'


class Emailtemplates(models.Model):
    emailtemplateid = models.AutoField(primary_key=True)
    type = models.TextField()
    slug = models.CharField(max_length=100)
    language = models.CharField(max_length=40, blank=True, null=True)
    name = models.TextField()
    subject = models.TextField()
    message = models.TextField()
    fromname = models.TextField()
    fromemail = models.CharField(max_length=100, blank=True, null=True)
    plaintext = models.IntegerField()
    active = models.IntegerField()
    order = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_emailtemplates'


class Estimates(models.Model):
    sent = models.IntegerField()
    datesend = models.DateTimeField(blank=True, null=True)
    clientid = models.IntegerField()
    deleted_customer_name = models.CharField(max_length=100, blank=True, null=True)
    project_id = models.IntegerField()
    number = models.IntegerField()
    prefix = models.CharField(max_length=50, blank=True, null=True)
    number_format = models.IntegerField()
    hash = models.CharField(max_length=32, blank=True, null=True)
    datecreated = models.DateTimeField()
    date = models.DateField()
    expirydate = models.DateField(blank=True, null=True)
    currency = models.IntegerField()
    subtotal = models.DecimalField(max_digits=15, decimal_places=2)
    total_tax = models.DecimalField(max_digits=15, decimal_places=2)
    total = models.DecimalField(max_digits=15, decimal_places=2)
    adjustment = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    addedfrom = models.IntegerField()
    status = models.IntegerField()
    clientnote = models.TextField(blank=True, null=True)
    adminnote = models.TextField(blank=True, null=True)
    discount_percent = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_total = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_type = models.CharField(max_length=30, blank=True, null=True)
    invoiceid = models.IntegerField(blank=True, null=True)
    invoiced_date = models.DateTimeField(blank=True, null=True)
    terms = models.TextField(blank=True, null=True)
    reference_no = models.CharField(max_length=100, blank=True, null=True)
    sale_agent = models.IntegerField()
    billing_street = models.CharField(max_length=200, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=100, blank=True, null=True)
    billing_country = models.IntegerField(blank=True, null=True)
    shipping_street = models.CharField(max_length=200, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=100, blank=True, null=True)
    shipping_country = models.IntegerField(blank=True, null=True)
    include_shipping = models.IntegerField()
    show_shipping_on_estimate = models.IntegerField()
    show_quantity_as = models.IntegerField()
    pipeline_order = models.IntegerField()
    is_expiry_notified = models.IntegerField()
    acceptance_firstname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_lastname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_email = models.CharField(max_length=100, blank=True, null=True)
    acceptance_date = models.DateTimeField(blank=True, null=True)
    acceptance_ip = models.CharField(max_length=40, blank=True, null=True)
    signature = models.CharField(max_length=40, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_estimates'


class Events(models.Model):
    eventid = models.AutoField(primary_key=True)
    title = models.TextField()
    description = models.TextField(blank=True, null=True)
    userid = models.IntegerField()
    start = models.DateTimeField()
    end = models.DateTimeField(blank=True, null=True)
    public = models.IntegerField()
    color = models.CharField(max_length=10, blank=True, null=True)
    isstartnotified = models.IntegerField()
    reminder_before = models.IntegerField()
    reminder_before_type = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_events'


class Expenses(models.Model):
    category = models.IntegerField()
    currency = models.IntegerField()
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    tax = models.IntegerField(blank=True, null=True)
    tax2 = models.IntegerField()
    reference_no = models.CharField(max_length=100, blank=True, null=True)
    note = models.TextField(blank=True, null=True)
    expense_name = models.CharField(max_length=191, blank=True, null=True)
    clientid = models.IntegerField()
    project_id = models.IntegerField()
    billable = models.IntegerField(blank=True, null=True)
    invoiceid = models.IntegerField(blank=True, null=True)
    paymentmode = models.CharField(max_length=50, blank=True, null=True)
    date = models.DateField()
    recurring_type = models.CharField(max_length=10, blank=True, null=True)
    repeat_every = models.IntegerField(blank=True, null=True)
    recurring = models.IntegerField()
    cycles = models.IntegerField()
    total_cycles = models.IntegerField()
    custom_recurring = models.IntegerField()
    last_recurring_date = models.DateField(blank=True, null=True)
    create_invoice_billable = models.IntegerField(blank=True, null=True)
    send_invoice_to_customer = models.IntegerField()
    recurring_from = models.IntegerField(blank=True, null=True)
    dateadded = models.DateTimeField()
    addedfrom = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_expenses'


class ExpensesCategories(models.Model):
    name = models.CharField(max_length=191)
    description = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_expenses_categories'


class Files(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20)
    file_name = models.CharField(max_length=191)
    filetype = models.CharField(max_length=40, blank=True, null=True)
    visible_to_customer = models.IntegerField()
    attachment_key = models.CharField(max_length=32, blank=True, null=True)
    external = models.CharField(max_length=40, blank=True, null=True)
    external_link = models.TextField(blank=True, null=True)
    thumbnail_link = models.TextField(blank=True, null=True, db_comment='For external usage')
    staffid = models.IntegerField()
    contact_id = models.IntegerField(blank=True, null=True)
    task_comment_id = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_files'


class FormQuestionBox(models.Model):
    boxid = models.AutoField(primary_key=True)
    boxtype = models.CharField(max_length=10)
    questionid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_form_question_box'


class FormQuestionBoxDescription(models.Model):
    questionboxdescriptionid = models.AutoField(primary_key=True)
    description = models.TextField()
    boxid = models.TextField()
    questionid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_form_question_box_description'


class FormQuestions(models.Model):
    questionid = models.AutoField(primary_key=True)
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20, blank=True, null=True)
    question = models.TextField()
    required = models.IntegerField()
    question_order = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_form_questions'


class FormResults(models.Model):
    resultid = models.AutoField(primary_key=True)
    boxid = models.IntegerField()
    boxdescriptionid = models.IntegerField(blank=True, null=True)
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20, blank=True, null=True)
    questionid = models.IntegerField()
    answer = models.TextField(blank=True, null=True)
    resultsetid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_form_results'


class GdprRequests(models.Model):
    clientid = models.IntegerField()
    contact_id = models.IntegerField()
    lead_id = models.IntegerField()
    request_type = models.CharField(max_length=191, blank=True, null=True)
    status = models.CharField(max_length=40, blank=True, null=True)
    request_date = models.DateTimeField()
    request_from = models.CharField(max_length=150, blank=True, null=True)
    description = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_gdpr_requests'


class Goals(models.Model):
    subject = models.CharField(max_length=191)
    description = models.TextField()
    start_date = models.DateField()
    end_date = models.DateField()
    goal_type = models.IntegerField()
    contract_type = models.IntegerField()
    achievement = models.IntegerField()
    notify_when_fail = models.IntegerField()
    notify_when_achieve = models.IntegerField()
    notified = models.IntegerField()
    staff_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_goals'


class Invoicepaymentrecords(models.Model):
    invoiceid = models.IntegerField()
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    paymentmode = models.CharField(max_length=40, blank=True, null=True)
    paymentmethod = models.CharField(max_length=191, blank=True, null=True)
    date = models.DateField()
    daterecorded = models.DateTimeField()
    note = models.TextField()
    transactionid = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_invoicepaymentrecords'


class Invoices(models.Model):
    sent = models.IntegerField()
    datesend = models.DateTimeField(blank=True, null=True)
    clientid = models.IntegerField()
    deleted_customer_name = models.CharField(max_length=100, blank=True, null=True)
    number = models.IntegerField()
    prefix = models.CharField(max_length=50, blank=True, null=True)
    number_format = models.IntegerField()
    datecreated = models.DateTimeField()
    date = models.DateField()
    duedate = models.DateField(blank=True, null=True)
    currency = models.IntegerField()
    subtotal = models.DecimalField(max_digits=15, decimal_places=2)
    total_tax = models.DecimalField(max_digits=15, decimal_places=2)
    total = models.DecimalField(max_digits=15, decimal_places=2)
    adjustment = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    addedfrom = models.IntegerField(blank=True, null=True)
    hash = models.CharField(max_length=32)
    status = models.IntegerField(blank=True, null=True)
    clientnote = models.TextField(blank=True, null=True)
    adminnote = models.TextField(blank=True, null=True)
    last_overdue_reminder = models.DateField(blank=True, null=True)
    cancel_overdue_reminders = models.IntegerField()
    allowed_payment_modes = models.TextField(blank=True, null=True)
    token = models.TextField(blank=True, null=True)
    discount_percent = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_total = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_type = models.CharField(max_length=30)
    recurring = models.IntegerField()
    recurring_type = models.CharField(max_length=10, blank=True, null=True)
    custom_recurring = models.IntegerField()
    cycles = models.IntegerField()
    total_cycles = models.IntegerField()
    is_recurring_from = models.IntegerField(blank=True, null=True)
    last_recurring_date = models.DateField(blank=True, null=True)
    terms = models.TextField(blank=True, null=True)
    sale_agent = models.IntegerField()
    billing_street = models.CharField(max_length=200, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=100, blank=True, null=True)
    billing_country = models.IntegerField(blank=True, null=True)
    shipping_street = models.CharField(max_length=200, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=100, blank=True, null=True)
    shipping_country = models.IntegerField(blank=True, null=True)
    include_shipping = models.IntegerField()
    show_shipping_on_invoice = models.IntegerField()
    show_quantity_as = models.IntegerField()
    project_id = models.IntegerField(blank=True, null=True)
    subscription_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_invoices'


class ItemTax(models.Model):
    itemid = models.IntegerField()
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20)
    taxrate = models.DecimalField(max_digits=15, decimal_places=2)
    taxname = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_item_tax'


class Itemable(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=15)
    description = models.TextField()
    long_description = models.TextField(blank=True, null=True)
    qty = models.DecimalField(max_digits=15, decimal_places=2)
    rate = models.DecimalField(max_digits=15, decimal_places=2)
    unit = models.CharField(max_length=40, blank=True, null=True)
    item_order = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_itemable'


class Items(models.Model):
    description = models.TextField()
    long_description = models.TextField(blank=True, null=True)
    rate = models.DecimalField(max_digits=15, decimal_places=2)
    tax = models.IntegerField(blank=True, null=True)
    tax2 = models.IntegerField(blank=True, null=True)
    unit = models.CharField(max_length=40, blank=True, null=True)
    group_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_items'


class ItemsGroups(models.Model):
    name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'ms_items_groups'


class KnowedgeBaseArticleFeedback(models.Model):
    articleanswerid = models.AutoField(primary_key=True)
    articleid = models.IntegerField()
    answer = models.IntegerField()
    ip = models.CharField(max_length=40)
    date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_knowedge_base_article_feedback'


class KnowledgeBase(models.Model):
    articleid = models.AutoField(primary_key=True)
    articlegroup = models.IntegerField()
    subject = models.TextField()
    description = models.TextField()
    slug = models.TextField()
    active = models.IntegerField()
    datecreated = models.DateTimeField()
    article_order = models.IntegerField()
    staff_article = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_knowledge_base'


class KnowledgeBaseGroups(models.Model):
    groupid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=191)
    group_slug = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    active = models.IntegerField()
    color = models.CharField(max_length=10, blank=True, null=True)
    group_order = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_knowledge_base_groups'


class LeadActivityLog(models.Model):
    leadid = models.IntegerField()
    description = models.TextField()
    additional_data = models.TextField(blank=True, null=True)
    date = models.DateTimeField()
    staffid = models.IntegerField()
    full_name = models.CharField(max_length=100, blank=True, null=True)
    custom_activity = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_lead_activity_log'


class LeadIntegrationEmails(models.Model):
    subject = models.TextField(blank=True, null=True)
    body = models.TextField(blank=True, null=True)
    dateadded = models.DateTimeField()
    leadid = models.IntegerField()
    emailid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_lead_integration_emails'


class Leads(models.Model):
    hash = models.CharField(max_length=65, blank=True, null=True)
    name = models.CharField(max_length=191)
    title = models.CharField(max_length=100, blank=True, null=True)
    company = models.CharField(max_length=191, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    country = models.IntegerField()
    zip = models.CharField(max_length=15, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=50, blank=True, null=True)
    address = models.CharField(max_length=100, blank=True, null=True)
    assigned = models.IntegerField()
    dateadded = models.DateTimeField()
    from_form_id = models.IntegerField()
    status = models.IntegerField()
    source = models.IntegerField()
    lastcontact = models.DateTimeField(blank=True, null=True)
    dateassigned = models.DateField(blank=True, null=True)
    last_status_change = models.DateTimeField(blank=True, null=True)
    addedfrom = models.IntegerField()
    email = models.CharField(max_length=100, blank=True, null=True)
    website = models.CharField(max_length=150, blank=True, null=True)
    leadorder = models.IntegerField(blank=True, null=True)
    phonenumber = models.CharField(max_length=50, blank=True, null=True)
    date_converted = models.DateTimeField(blank=True, null=True)
    lost = models.IntegerField()
    junk = models.IntegerField()
    last_lead_status = models.IntegerField()
    is_imported_from_email_integration = models.IntegerField()
    email_integration_uid = models.CharField(max_length=30, blank=True, null=True)
    is_public = models.IntegerField()
    default_language = models.CharField(max_length=40, blank=True, null=True)
    client_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_leads'


class LeadsEmailIntegration(models.Model):
    active = models.IntegerField()
    email = models.CharField(max_length=100)
    imap_server = models.CharField(max_length=100)
    password = models.TextField()
    check_every = models.IntegerField()
    responsible = models.IntegerField()
    lead_source = models.IntegerField()
    lead_status = models.IntegerField()
    encryption = models.CharField(max_length=3, blank=True, null=True)
    folder = models.CharField(max_length=100)
    last_run = models.CharField(max_length=50, blank=True, null=True)
    notify_lead_imported = models.IntegerField()
    notify_lead_contact_more_times = models.IntegerField()
    notify_type = models.CharField(max_length=20, blank=True, null=True)
    notify_ids = models.TextField(blank=True, null=True)
    mark_public = models.IntegerField()
    only_loop_on_unseen_emails = models.IntegerField()
    delete_after_import = models.IntegerField()
    create_task_if_customer = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_leads_email_integration'


class LeadsSources(models.Model):
    name = models.CharField(max_length=150)

    class Meta:
        managed = False
        db_table = 'ms_leads_sources'


class LeadsStatus(models.Model):
    name = models.CharField(max_length=50)
    statusorder = models.IntegerField(blank=True, null=True)
    color = models.CharField(max_length=10, blank=True, null=True)
    isdefault = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_leads_status'


class Listemails(models.Model):
    emailid = models.AutoField(primary_key=True)
    listid = models.IntegerField()
    email = models.CharField(max_length=100)
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_listemails'


class MailQueue(models.Model):
    engine = models.CharField(max_length=40, blank=True, null=True)
    email = models.CharField(max_length=191)
    cc = models.TextField(blank=True, null=True)
    bcc = models.TextField(blank=True, null=True)
    message = models.TextField()
    alt_message = models.TextField(blank=True, null=True)
    status = models.CharField(max_length=7, blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    headers = models.TextField(blank=True, null=True)
    attachments = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_mail_queue'


class Maillistscustomfields(models.Model):
    customfieldid = models.AutoField(primary_key=True)
    listid = models.IntegerField()
    fieldname = models.CharField(max_length=150)
    fieldslug = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_maillistscustomfields'


class Maillistscustomfieldvalues(models.Model):
    customfieldvalueid = models.AutoField(primary_key=True)
    listid = models.IntegerField()
    customfieldid = models.IntegerField()
    emailid = models.IntegerField()
    value = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_maillistscustomfieldvalues'


class Migrations(models.Model):
    version = models.BigIntegerField()

    class Meta:
        managed = False
        db_table = 'ms_migrations'


class Milestones(models.Model):
    name = models.CharField(max_length=191)
    description = models.TextField(blank=True, null=True)
    description_visible_to_customer = models.IntegerField(blank=True, null=True)
    due_date = models.DateField()
    project_id = models.IntegerField()
    color = models.CharField(max_length=10, blank=True, null=True)
    milestone_order = models.IntegerField()
    datecreated = models.DateField()

    class Meta:
        managed = False
        db_table = 'ms_milestones'


class Modules(models.Model):
    module_name = models.CharField(max_length=55)
    installed_version = models.CharField(max_length=11)
    active = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_modules'


class NewsfeedCommentLikes(models.Model):
    postid = models.IntegerField()
    commentid = models.IntegerField()
    userid = models.IntegerField()
    dateliked = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_newsfeed_comment_likes'


class NewsfeedPostComments(models.Model):
    content = models.TextField(blank=True, null=True)
    userid = models.IntegerField()
    postid = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_newsfeed_post_comments'


class NewsfeedPostLikes(models.Model):
    postid = models.IntegerField()
    userid = models.IntegerField()
    dateliked = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_newsfeed_post_likes'


class NewsfeedPosts(models.Model):
    postid = models.AutoField(primary_key=True)
    creator = models.IntegerField()
    datecreated = models.DateTimeField()
    visibility = models.CharField(max_length=100)
    content = models.TextField()
    pinned = models.IntegerField()
    datepinned = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_newsfeed_posts'


class Notes(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20)
    description = models.TextField(blank=True, null=True)
    date_contacted = models.DateTimeField(blank=True, null=True)
    addedfrom = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_notes'


class Notifications(models.Model):
    isread = models.IntegerField()
    isread_inline = models.IntegerField()
    date = models.DateTimeField()
    description = models.TextField()
    fromuserid = models.IntegerField()
    fromclientid = models.IntegerField()
    from_fullname = models.CharField(max_length=100)
    touserid = models.IntegerField()
    fromcompany = models.IntegerField(blank=True, null=True)
    link = models.TextField(blank=True, null=True)
    additional_data = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_notifications'


class Options(models.Model):
    name = models.CharField(max_length=191)
    value = models.TextField()
    autoload = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_options'


class PaymentModes(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    show_on_pdf = models.IntegerField()
    invoices_only = models.IntegerField()
    expenses_only = models.IntegerField()
    selected_by_default = models.IntegerField()
    active = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_payment_modes'


class PinnedProjects(models.Model):
    project_id = models.IntegerField()
    staff_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_pinned_projects'


class ProjectActivity(models.Model):
    project_id = models.IntegerField()
    staff_id = models.IntegerField()
    contact_id = models.IntegerField()
    fullname = models.CharField(max_length=100, blank=True, null=True)
    visible_to_customer = models.IntegerField()
    description_key = models.CharField(max_length=191, db_comment='Language file key')
    additional_data = models.TextField(blank=True, null=True)
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_project_activity'


class ProjectFiles(models.Model):
    file_name = models.CharField(max_length=191)
    subject = models.CharField(max_length=191, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    filetype = models.CharField(max_length=50, blank=True, null=True)
    dateadded = models.DateTimeField()
    last_activity = models.DateTimeField(blank=True, null=True)
    project_id = models.IntegerField()
    visible_to_customer = models.IntegerField(blank=True, null=True)
    staffid = models.IntegerField()
    contact_id = models.IntegerField()
    external = models.CharField(max_length=40, blank=True, null=True)
    external_link = models.TextField(blank=True, null=True)
    thumbnail_link = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_project_files'


class ProjectMembers(models.Model):
    project_id = models.IntegerField()
    staff_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_project_members'


class ProjectNotes(models.Model):
    project_id = models.IntegerField()
    content = models.TextField()
    staff_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_project_notes'


class ProjectSettings(models.Model):
    project_id = models.IntegerField()
    name = models.CharField(max_length=100)
    value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_project_settings'


class Projectdiscussioncomments(models.Model):
    discussion_id = models.IntegerField()
    discussion_type = models.CharField(max_length=10)
    parent = models.IntegerField(blank=True, null=True)
    created = models.DateTimeField()
    modified = models.DateTimeField(blank=True, null=True)
    content = models.TextField()
    staff_id = models.IntegerField()
    contact_id = models.IntegerField(blank=True, null=True)
    fullname = models.CharField(max_length=191, blank=True, null=True)
    file_name = models.CharField(max_length=191, blank=True, null=True)
    file_mime_type = models.CharField(max_length=70, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_projectdiscussioncomments'


class Projectdiscussions(models.Model):
    project_id = models.IntegerField()
    subject = models.CharField(max_length=191)
    description = models.TextField()
    show_to_customer = models.IntegerField()
    datecreated = models.DateTimeField()
    last_activity = models.DateTimeField(blank=True, null=True)
    staff_id = models.IntegerField()
    contact_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_projectdiscussions'


class Projects(models.Model):
    name = models.CharField(max_length=191)
    description = models.TextField(blank=True, null=True)
    status = models.IntegerField()
    clientid = models.IntegerField()
    billing_type = models.IntegerField()
    start_date = models.DateField()
    deadline = models.DateField(blank=True, null=True)
    project_created = models.DateField()
    date_finished = models.DateTimeField(blank=True, null=True)
    progress = models.IntegerField(blank=True, null=True)
    progress_from_tasks = models.IntegerField()
    project_cost = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    project_rate_per_hour = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    estimated_hours = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    addedfrom = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_projects'


class ProposalComments(models.Model):
    content = models.TextField(blank=True, null=True)
    proposalid = models.IntegerField()
    staffid = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_proposal_comments'


class Proposals(models.Model):
    subject = models.CharField(max_length=191, blank=True, null=True)
    content = models.TextField(blank=True, null=True)
    addedfrom = models.IntegerField()
    datecreated = models.DateTimeField()
    total = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    subtotal = models.DecimalField(max_digits=15, decimal_places=2)
    total_tax = models.DecimalField(max_digits=15, decimal_places=2)
    adjustment = models.DecimalField(max_digits=15, decimal_places=2, blank=True, null=True)
    discount_percent = models.DecimalField(max_digits=15, decimal_places=2)
    discount_total = models.DecimalField(max_digits=15, decimal_places=2)
    discount_type = models.CharField(max_length=30, blank=True, null=True)
    show_quantity_as = models.IntegerField()
    currency = models.IntegerField()
    open_till = models.DateField(blank=True, null=True)
    date = models.DateField()
    rel_id = models.IntegerField(blank=True, null=True)
    rel_type = models.CharField(max_length=40, blank=True, null=True)
    assigned = models.IntegerField(blank=True, null=True)
    hash = models.CharField(max_length=32)
    proposal_to = models.CharField(max_length=191, blank=True, null=True)
    country = models.IntegerField()
    zip = models.CharField(max_length=50, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    address = models.CharField(max_length=200, blank=True, null=True)
    email = models.CharField(max_length=150, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    allow_comments = models.IntegerField()
    status = models.IntegerField()
    estimate_id = models.IntegerField(blank=True, null=True)
    invoice_id = models.IntegerField(blank=True, null=True)
    date_converted = models.DateTimeField(blank=True, null=True)
    pipeline_order = models.IntegerField()
    is_expiry_notified = models.IntegerField()
    acceptance_firstname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_lastname = models.CharField(max_length=50, blank=True, null=True)
    acceptance_email = models.CharField(max_length=100, blank=True, null=True)
    acceptance_date = models.DateTimeField(blank=True, null=True)
    acceptance_ip = models.CharField(max_length=40, blank=True, null=True)
    signature = models.CharField(max_length=40, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_proposals'


class RelatedItems(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=30)
    item_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_related_items'


class Reminders(models.Model):
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField()
    isnotified = models.IntegerField()
    rel_id = models.IntegerField()
    staff = models.IntegerField()
    rel_type = models.CharField(max_length=40)
    notify_by_email = models.IntegerField()
    creator = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_reminders'


class Roles(models.Model):
    roleid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=100)
    permissions = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "ms_roles"


class SalesActivity(models.Model):
    rel_type = models.CharField(max_length=20, blank=True, null=True)
    rel_id = models.IntegerField()
    description = models.TextField()
    additional_data = models.TextField(blank=True, null=True)
    staffid = models.CharField(max_length=11, blank=True, null=True)
    full_name = models.CharField(max_length=100, blank=True, null=True)
    date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_sales_activity'


class Services(models.Model):
    serviceid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'ms_services'


class Sessions(models.Model):
    id = models.CharField(primary_key=True, max_length=128)
    ip_address = models.CharField(max_length=45)
    timestamp = models.PositiveIntegerField()
    data = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_sessions'


class SharedCustomerFiles(models.Model):
    file_id = models.IntegerField()
    contact_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_shared_customer_files'


class SpamFilters(models.Model):
    type = models.CharField(max_length=40)
    rel_type = models.CharField(max_length=10)
    value = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_spam_filters'


class Staff(models.Model):
    staffid = models.AutoField(primary_key=True)
    email = models.CharField(max_length=100)
    firstname = models.CharField(max_length=50)
    lastname = models.CharField(max_length=50)
    facebook = models.TextField(blank=True, null=True)
    linkedin = models.TextField(blank=True, null=True)
    phonenumber = models.CharField(max_length=30, blank=True, null=True)
    skype = models.CharField(max_length=50, blank=True, null=True)
    password = models.CharField(max_length=250)
    datecreated = models.DateTimeField()
    profile_image = models.CharField(max_length=191, blank=True, null=True)
    last_ip = models.CharField(max_length=40, blank=True, null=True)
    last_login = models.DateTimeField(blank=True, null=True)
    last_activity = models.DateTimeField(blank=True, null=True)
    last_password_change = models.DateTimeField(blank=True, null=True)
    new_pass_key = models.CharField(max_length=32, blank=True, null=True)
    new_pass_key_requested = models.DateTimeField(blank=True, null=True)
    admin = models.IntegerField()
    role = models.IntegerField(blank=True, null=True)
    active = models.IntegerField()
    default_language = models.CharField(max_length=40, blank=True, null=True)
    direction = models.CharField(max_length=3, blank=True, null=True)
    media_path_slug = models.CharField(max_length=191, blank=True, null=True)
    is_not_staff = models.IntegerField()
    hourly_rate = models.DecimalField(max_digits=15, decimal_places=2)
    two_factor_auth_enabled = models.IntegerField(blank=True, null=True)
    two_factor_auth_code = models.CharField(max_length=100, blank=True, null=True)
    two_factor_auth_code_requested = models.DateTimeField(blank=True, null=True)
    email_signature = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_staff'


class StaffDepartments(models.Model):
    staffdepartmentid = models.AutoField(primary_key=True)
    staffid = models.IntegerField()
    departmentid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_staff_departments'


class StaffPermissions(models.Model):
    staff_id = models.IntegerField()
    feature = models.CharField(max_length=40)
    capability = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_staff_permissions'


class Subscriptions(models.Model):
    name = models.CharField(max_length=191)
    description = models.TextField(blank=True, null=True)
    description_in_item = models.IntegerField()
    clientid = models.IntegerField()
    date = models.DateField(blank=True, null=True)
    currency = models.IntegerField()
    tax_id = models.IntegerField()
    stripe_plan_id = models.TextField(blank=True, null=True)
    stripe_subscription_id = models.TextField()
    next_billing_cycle = models.BigIntegerField(blank=True, null=True)
    ends_at = models.BigIntegerField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True)
    quantity = models.IntegerField()
    project_id = models.IntegerField()
    hash = models.CharField(max_length=32)
    created = models.DateTimeField()
    created_from = models.IntegerField()
    date_subscribed = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_subscriptions'


class Surveyresultsets(models.Model):
    resultsetid = models.AutoField(primary_key=True)
    surveyid = models.IntegerField()
    ip = models.CharField(max_length=40)
    useragent = models.CharField(max_length=150)
    date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_surveyresultsets'


class Surveys(models.Model):
    surveyid = models.AutoField(primary_key=True)
    subject = models.TextField()
    slug = models.TextField()
    description = models.TextField()
    viewdescription = models.TextField(blank=True, null=True)
    datecreated = models.DateTimeField()
    redirect_url = models.CharField(max_length=100, blank=True, null=True)
    send = models.IntegerField()
    onlyforloggedin = models.IntegerField(blank=True, null=True)
    fromname = models.CharField(max_length=100, blank=True, null=True)
    iprestrict = models.IntegerField()
    active = models.IntegerField()
    hash = models.CharField(max_length=32)

    class Meta:
        managed = False
        db_table = 'ms_surveys'


class Surveysemailsendcron(models.Model):
    surveyid = models.IntegerField()
    email = models.CharField(max_length=100)
    emailid = models.IntegerField(blank=True, null=True)
    listid = models.CharField(max_length=11, blank=True, null=True)
    log_id = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_surveysemailsendcron'


class Surveysendlog(models.Model):
    surveyid = models.IntegerField()
    total = models.IntegerField()
    date = models.DateTimeField()
    iscronfinished = models.IntegerField()
    send_to_mail_lists = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_surveysendlog'


class Taggables(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=20)
    tag_id = models.IntegerField()
    tag_order = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_taggables'


class Tags(models.Model):
    name = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_tags'


class TaskAssigned(models.Model):
    staffid = models.IntegerField()
    taskid = models.IntegerField()
    assigned_from = models.IntegerField()
    is_assigned_from_contact = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_task_assigned'


class TaskChecklistItems(models.Model):
    taskid = models.IntegerField()
    description = models.TextField()
    finished = models.IntegerField()
    dateadded = models.DateTimeField()
    addedfrom = models.IntegerField()
    finished_from = models.IntegerField(blank=True, null=True)
    list_order = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_task_checklist_items'


class TaskComments(models.Model):
    content = models.TextField()
    taskid = models.IntegerField()
    staffid = models.IntegerField()
    contact_id = models.IntegerField()
    file_id = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_task_comments'


class TaskFollowers(models.Model):
    staffid = models.IntegerField()
    taskid = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_task_followers'


class Tasks(models.Model):
    name = models.TextField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    priority = models.IntegerField(blank=True, null=True)
    dateadded = models.DateTimeField()
    startdate = models.DateField()
    duedate = models.DateField(blank=True, null=True)
    datefinished = models.DateTimeField(blank=True, null=True)
    addedfrom = models.IntegerField()
    is_added_from_contact = models.IntegerField()
    status = models.IntegerField()
    recurring_type = models.CharField(max_length=10, blank=True, null=True)
    repeat_every = models.IntegerField(blank=True, null=True)
    recurring = models.IntegerField()
    is_recurring_from = models.IntegerField(blank=True, null=True)
    cycles = models.IntegerField()
    total_cycles = models.IntegerField()
    custom_recurring = models.IntegerField()
    last_recurring_date = models.DateField(blank=True, null=True)
    rel_id = models.IntegerField(blank=True, null=True)
    rel_type = models.CharField(max_length=30, blank=True, null=True)
    is_public = models.IntegerField()
    billable = models.IntegerField()
    billed = models.IntegerField()
    invoice_id = models.IntegerField()
    hourly_rate = models.DecimalField(max_digits=15, decimal_places=2)
    milestone = models.IntegerField(blank=True, null=True)
    kanban_order = models.IntegerField()
    milestone_order = models.IntegerField()
    visible_to_client = models.IntegerField()
    deadline_notified = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_tasks'


class TasksChecklistTemplates(models.Model):
    description = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_tasks_checklist_templates'


class Taskstimers(models.Model):
    task_id = models.IntegerField()
    start_time = models.CharField(max_length=64)
    end_time = models.CharField(max_length=64, blank=True, null=True)
    staff_id = models.IntegerField()
    hourly_rate = models.DecimalField(max_digits=15, decimal_places=2)
    note = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_taskstimers'


class Taxes(models.Model):
    name = models.CharField(max_length=100)
    taxrate = models.DecimalField(max_digits=15, decimal_places=2)

    class Meta:
        managed = False
        db_table = 'ms_taxes'


class TicketAttachments(models.Model):
    ticketid = models.IntegerField()
    replyid = models.IntegerField(blank=True, null=True)
    file_name = models.CharField(max_length=191)
    filetype = models.CharField(max_length=50, blank=True, null=True)
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_ticket_attachments'


class TicketReplies(models.Model):
    ticketid = models.IntegerField()
    userid = models.IntegerField(blank=True, null=True)
    contactid = models.IntegerField()
    name = models.TextField(blank=True, null=True)
    email = models.TextField(blank=True, null=True)
    date = models.DateTimeField()
    message = models.TextField(blank=True, null=True)
    attachment = models.IntegerField(blank=True, null=True)
    admin = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_ticket_replies'


class Tickets(models.Model):
    ticketid = models.AutoField(primary_key=True)
    adminreplying = models.IntegerField()
    userid = models.IntegerField()
    contactid = models.IntegerField()
    email = models.TextField(blank=True, null=True)
    name = models.TextField(blank=True, null=True)
    department = models.IntegerField()
    priority = models.IntegerField()
    status = models.IntegerField()
    service = models.IntegerField(blank=True, null=True)
    ticketkey = models.CharField(max_length=32)
    subject = models.CharField(max_length=191)
    message = models.TextField(blank=True, null=True)
    admin = models.IntegerField(blank=True, null=True)
    date = models.DateTimeField()
    project_id = models.IntegerField()
    lastreply = models.DateTimeField(blank=True, null=True)
    clientread = models.IntegerField()
    adminread = models.IntegerField()
    assigned = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_tickets'


class TicketsPipeLog(models.Model):
    date = models.DateTimeField()
    email_to = models.CharField(max_length=100)
    name = models.CharField(max_length=191)
    subject = models.CharField(max_length=191)
    message = models.TextField()
    email = models.CharField(max_length=100)
    status = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'ms_tickets_pipe_log'


class TicketsPredefinedReplies(models.Model):
    name = models.CharField(max_length=191)
    message = models.TextField()

    class Meta:
        managed = False
        db_table = 'ms_tickets_predefined_replies'


class TicketsPriorities(models.Model):
    priorityid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'ms_tickets_priorities'


class TicketsStatus(models.Model):
    ticketstatusid = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    isdefault = models.IntegerField()
    statuscolor = models.CharField(max_length=7, blank=True, null=True)
    statusorder = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_tickets_status'


class Todos(models.Model):
    todoid = models.AutoField(primary_key=True)
    description = models.TextField()
    staffid = models.IntegerField()
    dateadded = models.DateTimeField()
    finished = models.IntegerField()
    datefinished = models.DateTimeField(blank=True, null=True)
    item_order = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_todos'


class TrackedMails(models.Model):
    uid = models.CharField(max_length=32)
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=40)
    date = models.DateTimeField()
    email = models.CharField(max_length=100)
    opened = models.IntegerField()
    date_opened = models.DateTimeField(blank=True, null=True)
    subject = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_tracked_mails'


class UserAutoLogin(models.Model):
    key_id = models.CharField(max_length=32)
    user_id = models.IntegerField()
    user_agent = models.CharField(max_length=150)
    last_ip = models.CharField(max_length=40)
    last_login = models.DateTimeField()
    staff = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'ms_user_auto_login'


class UserMeta(models.Model):
    umeta_id = models.BigAutoField(primary_key=True)
    staff_id = models.PositiveBigIntegerField()
    client_id = models.PositiveBigIntegerField()
    contact_id = models.PositiveBigIntegerField()
    meta_key = models.CharField(max_length=191, blank=True, null=True)
    meta_value = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ms_user_meta'


class Vault(models.Model):
    customer_id = models.IntegerField()
    server_address = models.CharField(max_length=191)
    port = models.IntegerField(blank=True, null=True)
    username = models.CharField(max_length=191)
    password = models.TextField()
    description = models.TextField(blank=True, null=True)
    creator = models.IntegerField()
    creator_name = models.CharField(max_length=100, blank=True, null=True)
    visibility = models.IntegerField()
    share_in_projects = models.IntegerField()
    last_updated = models.DateTimeField(blank=True, null=True)
    last_updated_from = models.CharField(max_length=100, blank=True, null=True)
    date_created = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_vault'


class ViewsTracking(models.Model):
    rel_id = models.IntegerField()
    rel_type = models.CharField(max_length=40)
    date = models.DateTimeField()
    view_ip = models.CharField(max_length=40)

    class Meta:
        managed = False
        db_table = 'ms_views_tracking'


class WebToLead(models.Model):
    form_key = models.CharField(max_length=32)
    lead_source = models.IntegerField()
    lead_status = models.IntegerField()
    notify_lead_imported = models.IntegerField()
    notify_type = models.CharField(max_length=20, blank=True, null=True)
    notify_ids = models.TextField(blank=True, null=True)
    responsible = models.IntegerField()
    name = models.CharField(max_length=191)
    form_data = models.TextField(blank=True, null=True)
    recaptcha = models.IntegerField()
    submit_btn_name = models.CharField(max_length=40, blank=True, null=True)
    success_submit_msg = models.TextField(blank=True, null=True)
    language = models.CharField(max_length=40, blank=True, null=True)
    allow_duplicate = models.IntegerField()
    mark_public = models.IntegerField()
    track_duplicate_field = models.CharField(max_length=20, blank=True, null=True)
    track_duplicate_field_and = models.CharField(max_length=20, blank=True, null=True)
    create_task_on_duplicate = models.IntegerField()
    dateadded = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'ms_web_to_lead'
