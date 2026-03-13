from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from datetime import date


class Business(models.Model):
    """
    EXISTING TABLE ONLY
    NO MIGRATION
    NO DATA LOSS
    """

    name = models.CharField(max_length=255)
    email = models.EmailField()
    owner_name = models.CharField(max_length=255)
    is_approved = models.BooleanField()
    created_at = models.DateTimeField()

    class Meta:
        db_table = "ms_business"
        managed = False

    def __str__(self):
        return self.name


class EmailTemplate(models.Model):
    module = models.CharField(max_length=50)
    slug = models.CharField(max_length=100)
    language = models.CharField(max_length=20, default="english")
    subject = models.CharField(max_length=255)
    body = models.TextField()

    class Meta:
        unique_together = ("module", "slug", "language")
        indexes = [
            models.Index(fields=["module", "slug"]),
        ]

    def __str__(self):
        return f"{self.module} - {self.slug}"


# ⚠️ renamed (duplicate model avoid)
class Business(models.Model):
    name = models.CharField(max_length=100, unique=True, db_index=True)
    email = models.EmailField(unique=True, db_index=True)
    owner_name = models.CharField(max_length=100)
    is_approved = models.BooleanField(default=False, db_index=True)
    db_name = models.CharField(max_length=100, blank=True, null=True, unique=True)
    created_at = models.DateTimeField(auto_now_add=True, db_index=True)

    class Meta:
        db_table = "core_business"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["email", "is_approved"]),
        ]

    def __str__(self):
        return self.name


class Role(models.Model):
    name = models.CharField(max_length=100)
    permissions = models.TextField(default="Basic")
    is_approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_roles"
        ordering = ["-id"]

    def __str__(self):
        return self.name


class StaffProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    manager = models.ForeignKey(
        User,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="team_members"
    )

    def __str__(self):
        return self.user.username


class Proposal(models.Model):

    STATUS_CHOICES = [
        ("1", "Draft"),
        ("2", "Pending"),
        ("3", "Approved"),
    ]

    subject = models.CharField(max_length=255)

    created_by = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="created_proposals"
    )

    assigned_to = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_proposals"
    )

    items = models.JSONField(default=list, blank=True)

    discount_total = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    adjustment = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    total = models.DecimalField(max_digits=12, decimal_places=2, default=0)

    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="1")

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject


class Expense(models.Model):
    CATEGORY_CHOICES = [
        ("Travel", "Travel"),
        ("Food", "Food"),
        ("Office", "Office"),
    ]

    name = models.CharField(max_length=255)
    note = models.TextField(blank=True, null=True)
    category = models.CharField(max_length=100, choices=CATEGORY_CHOICES)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    date = models.DateField()
    customer = models.CharField(max_length=255, blank=True, null=True)

    currency = models.CharField(max_length=20, default="INR ₹")
    tax1 = models.CharField(max_length=50, blank=True, null=True)
    tax2 = models.CharField(max_length=50, blank=True, null=True)
    payment_mode = models.CharField(max_length=100, blank=True, null=True)
    reference = models.CharField(max_length=255, blank=True, null=True)
    repeat_every = models.CharField(max_length=50, blank=True, null=True)

    status = models.CharField(max_length=50, default="Not Invoiced")

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Lead(models.Model):
    name = models.CharField(max_length=255)
    email = models.EmailField(blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    source = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(max_length=50, default="New")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Client(models.Model):
    company = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    vat_number = models.CharField(max_length=100, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    state = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=20, blank=True, null=True)
    country = models.CharField(max_length=100, blank=True, null=True)
    currency = models.CharField(max_length=10, blank=True, null=True)
    default_language = models.CharField(max_length=50, blank=True, null=True)

    billing_address = models.TextField(blank=True, null=True)
    shipping_address = models.TextField(blank=True, null=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.company

class Estimate(models.Model):

    estimate_number = models.CharField(max_length=100)

    # ✅ FIX: CharField से ForeignKey
    customer = models.ForeignKey(
        Client,
        on_delete=models.CASCADE,
        related_name="estimates"
    )

    amount = models.DecimalField(max_digits=10, decimal_places=2)

    total_tax = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0
    )

    date = models.DateField()
    expiry_date = models.DateField()

    status = models.CharField(
        max_length=100,
        default="Draft"
    )

    items = models.JSONField(default=list, blank=True)

    def __str__(self):
        return self.estimate_number

class CalendarEvent(models.Model):
    title = models.CharField(max_length=255)
    date = models.DateField()
    color = models.CharField(max_length=20, default="#2196f3")

    def __str__(self):
        return self.title

class EmailCampaign(models.Model):
    subject = models.CharField(max_length=255)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject

class EmailRecipient(models.Model):
    campaign = models.ForeignKey(EmailCampaign, on_delete=models.CASCADE, related_name="recipients")
    email = models.EmailField()
    is_sent = models.BooleanField(default=False)
    sent_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.email

class Invoice(models.Model):

    PAYMENT_CHOICES = [
        ("Null", "Null"),
        ("Bank", "Bank"),
        ("Cash", "Cash"),
        ("UPI", "UPI"),
    ]

    invoice_number = models.CharField(max_length=50)

    # ✅ NEW FIELD (Estimate link)
    reference_estimate = models.ForeignKey(
        'Estimate',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="invoices"
    )

    customer = models.ForeignKey(Client, on_delete=models.CASCADE)

    invoice_date = models.DateField(default=date.today)
    due_date = models.DateField(default=date.today)

    payment_mode = models.CharField(
        max_length=20,
        choices=PAYMENT_CHOICES,
        default="Bank"
    )

    subtotal = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    tax_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    items = models.JSONField(default=list, blank=True)

    status = models.CharField(
        max_length=20,
        choices=[
            ("Draft","Draft"),
            ("Unpaid","Unpaid"),
            ("Paid","Paid"),
            ("Overdue","Overdue"),
        ],
        default="Draft"
    )

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.invoice_number

class InvoiceReminder(models.Model):
    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="reminders")
    description = models.TextField()
    date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Reminder for {self.invoice.invoice_number}"

class InvoiceTask(models.Model):
    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="tasks")
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Task for {self.invoice.invoice_number}"


class InvoiceEmailLog(models.Model):
    invoice = models.ForeignKey(
        Invoice,
        on_delete=models.CASCADE,
        related_name="email_logs"
    )

    email = models.EmailField()
    message = models.TextField()
    sent_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.email


class InvoicePayment(models.Model):

    invoice = models.ForeignKey(Invoice, on_delete=models.CASCADE, related_name="Payments")
    payment_mode = models.CharField(max_length=20)
    transaction_id = models.CharField(max_length=50)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_date = models.DateField(auto_now_add=True)
    def __str__(self):
        return f"{self.invoice.invoice_number} - {self.amount}"


class CreditNote(models.Model):
    client = models.ForeignKey(
        Client,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="credit_notes",
    )
    deleted_customer_name = models.CharField(max_length=255, blank=True, null=True)
    number = models.PositiveIntegerField(default=1)
    prefix = models.CharField(max_length=20, default="CN-")
    number_format = models.CharField(max_length=30, blank=True, null=True)
    datecreated = models.DateTimeField(auto_now_add=True)
    date = models.DateField(default=date.today)
    duedate = models.DateField(blank=True, null=True)
    project_id = models.IntegerField(blank=True, null=True)
    reference_no = models.CharField(max_length=100, blank=True, null=True)
    subtotal = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total_tax = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    total = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    adjustment = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    addedfrom = models.IntegerField(blank=True, null=True, default=0)
    status = models.IntegerField(default=1)
    clientnote = models.TextField(blank=True, null=True)
    adminnote = models.TextField(blank=True, null=True)
    terms = models.TextField(blank=True, null=True)
    currency = models.CharField(max_length=20, blank=True, null=True, default="INR")
    discount_percent = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount_total = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    discount_type = models.CharField(max_length=30, blank=True, null=True, default="none")
    billing_street = models.CharField(max_length=255, blank=True, null=True)
    billing_city = models.CharField(max_length=100, blank=True, null=True)
    billing_state = models.CharField(max_length=100, blank=True, null=True)
    billing_zip = models.CharField(max_length=30, blank=True, null=True)
    billing_country = models.CharField(max_length=100, blank=True, null=True)
    shipping_street = models.CharField(max_length=255, blank=True, null=True)
    shipping_city = models.CharField(max_length=100, blank=True, null=True)
    shipping_state = models.CharField(max_length=100, blank=True, null=True)
    shipping_zip = models.CharField(max_length=30, blank=True, null=True)
    shipping_country = models.CharField(max_length=100, blank=True, null=True)
    include_shipping = models.BooleanField(default=False)
    show_shipping_on_credit_note = models.BooleanField(default=False)
    show_quantity_as = models.CharField(max_length=30, blank=True, null=True, default="Qty")
    email_signature = models.TextField(blank=True, null=True)
    items = models.JSONField(default=list, blank=True)

    class Meta:
        db_table = "core_creditnote"
        ordering = ["-datecreated", "-id"]

    def __str__(self):
        return f"{self.prefix}{self.number}"


class CreditNoteReminder(models.Model):
    credit_note = models.ForeignKey(
        CreditNote,
        on_delete=models.CASCADE,
        related_name="reminders",
    )
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True, default="Pending")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_creditnote_reminder"
        ordering = ["-created_at", "-id"]


class CreditNoteTask(models.Model):
    credit_note = models.ForeignKey(
        CreditNote,
        on_delete=models.CASCADE,
        related_name="tasks",
    )
    description = models.TextField(blank=True, null=True)
    date = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=50, blank=True, null=True, default="Open")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_creditnote_task"
        ordering = ["-created_at", "-id"]


class ItemGroup(models.Model):
    name = models.CharField(max_length=191, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_item_group"
        ordering = ["name", "id"]

    def __str__(self):
        return self.name


class Item(models.Model):
    item_name = models.CharField(max_length=255, blank=True, db_index=True)
    item_code = models.CharField(max_length=100, blank=True, null=True, db_index=True)
    description = models.CharField(max_length=255)
    long_description = models.TextField(blank=True, null=True)
    rate = models.DecimalField(max_digits=12, decimal_places=2, default=0)
    tax = models.CharField(max_length=50, blank=True, null=True, default="No Tax")
    tax2 = models.CharField(max_length=50, blank=True, null=True, default="No Tax")
    unit = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(max_length=20, default="active", db_index=True)
    group = models.ForeignKey(
        ItemGroup,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="items",
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_item"
        ordering = ["-created_at", "-id"]

    def save(self, *args, **kwargs):
        if not self.item_name:
            self.item_name = (self.description or self.item_code or "Unnamed Item").strip()
        if not self.description:
            self.description = self.item_name
        if self.status not in {"active", "inactive"}:
            self.status = "active"
        super().save(*args, **kwargs)

    def __str__(self):
        return self.item_name or self.description


class Customer(models.Model):
    company = models.CharField(max_length=255)
    primary_contact = models.CharField(max_length=255, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    phone = models.CharField(max_length=20, null=True, blank=True)

    is_active = models.BooleanField(default=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.company


class Contact(models.Model):
    firstname = models.CharField(max_length=191)
    lastname = models.CharField(max_length=191)
    email = models.EmailField()
    company = models.CharField(max_length=255, blank=True, null=True)
    phonenumber = models.CharField(max_length=100, blank=True, null=True)
    title = models.CharField(max_length=100, blank=True, null=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    is_primary = models.BooleanField(default=False)
    active = models.BooleanField(default=True)
    direction = models.CharField(max_length=10, blank=True, null=True)
    invoice_emails = models.BooleanField(default=False)
    estimate_emails = models.BooleanField(default=False)
    credit_note_emails = models.BooleanField(default=False)
    contract_emails = models.BooleanField(default=False)
    task_emails = models.BooleanField(default=False)
    project_emails = models.BooleanField(default=False)
    ticket_emails = models.BooleanField(default=False)
    last_login = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_contact"
        ordering = ["-created_at", "-id"]

    def __str__(self):
        return f"{self.firstname} {self.lastname}".strip()


class AdminClient(Client):
    class Meta:
        proxy = True
        app_label = "core"
        verbose_name = "Client"
        verbose_name_plural = "Clients"


class AdminContact(Contact):
    class Meta:
        proxy = True
        app_label = "core"
        verbose_name = "Contact"
        verbose_name_plural = "Contacts"
