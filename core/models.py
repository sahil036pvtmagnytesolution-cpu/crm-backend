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

class Customer(models.Model):
    company = models.CharField(max_length=255)
    primary_contact = models.CharField(max_length=255, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    phone = models.CharField(max_length=20, null=True, blank=True)

    is_active = models.BooleanField(default=True)

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.company
