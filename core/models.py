from django.db import models


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
    name = models.CharField(max_length=100, unique=True)
    permissions = models.TextField(blank=True, null=True)
    is_approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "core_roles"
        ordering = ["-id"]

    def __str__(self):
        return self.name
