from django.db import models
from django.contrib.auth.models import User
from django.db import models

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
        managed = False   # 🔒 VERY IMPORTANT

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


# ⚠️ NEW optimized Business model (used by serializers/views)
class Business(models.Model):
    name = models.CharField(
        max_length=100,
        unique=True,
        db_index=True
    )

    email = models.EmailField(
        unique=True,
        db_index=True
    )

    owner_name = models.CharField(max_length=100)

    is_approved = models.BooleanField(
        default=False,
        db_index=True
    )

    db_name = models.CharField(
        max_length=100,
        blank=True,
        null=True,
        unique=True
    )

    created_at = models.DateTimeField(
        auto_now_add=True,
        db_index=True
    )

    class Meta:
        db_table = "core_business"
        ordering = ["-created_at"]
        indexes = [
            models.Index(fields=["email", "is_approved"]),
        ]

    def __str__(self):
        return self.name

# =========================
# ROLE MODEL
# =========================

class Role(models.Model):
    name = models.CharField(max_length=100)
    permissions = models.TextField(default="Basic")  # ✅ safety
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
    subject = models.CharField(max_length=255)
    total = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.IntegerField(default=1)

    created_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="created_proposals"
    )

    # ✅ ADD THIS FIELD (THIS WAS MISSING)
    assigned = models.ForeignKey(
        User,
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
        related_name="assigned_proposals"
    )

    created_at = models.DateTimeField(auto_now_add=True)
