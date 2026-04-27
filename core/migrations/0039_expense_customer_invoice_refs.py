from django.db import migrations, models
import django.db.models.deletion


def backfill_expense_refs(apps, schema_editor):
    Expense = apps.get_model("core", "Expense")
    Client = apps.get_model("core", "Client")
    Invoice = apps.get_model("core", "Invoice")

    for expense in Expense.objects.all():
        update_fields = set()

        if not getattr(expense, "customer_ref_id", None):
            raw_customer = (getattr(expense, "customer", None) or "").strip()
            customer = None

            if raw_customer.isdigit():
                customer = Client.objects.filter(pk=int(raw_customer)).first()

            if not customer and raw_customer:
                customer = Client.objects.filter(company__iexact=raw_customer).first()

            if customer:
                expense.customer_ref_id = customer.id
                update_fields.add("customer_ref")

        invoice = None
        if not getattr(expense, "invoice_ref_id", None):
            raw_ref = (getattr(expense, "reference", None) or "").strip()

            if raw_ref.isdigit():
                invoice = Invoice.objects.filter(pk=int(raw_ref)).first()

            if not invoice and raw_ref:
                invoice = Invoice.objects.filter(invoice_number__iexact=raw_ref).first()

            if invoice:
                expense.invoice_ref_id = invoice.id
                update_fields.add("invoice_ref")

        if invoice is None and getattr(expense, "invoice_ref_id", None):
            invoice = Invoice.objects.filter(pk=expense.invoice_ref_id).first()

        if invoice:
            if not getattr(expense, "customer_ref_id", None) and getattr(
                invoice, "customer_id", None
            ):
                expense.customer_ref_id = invoice.customer_id
                update_fields.add("customer_ref")

            if not (getattr(expense, "payment_mode", None) or "").strip() and getattr(
                invoice, "payment_mode", None
            ):
                expense.payment_mode = invoice.payment_mode
                update_fields.add("payment_mode")

        if update_fields:
            expense.save(update_fields=sorted(update_fields))


class Migration(migrations.Migration):

    dependencies = [
        ("core", "0038_item_master_fields_and_sales_items"),
    ]

    operations = [
        migrations.AddField(
            model_name="expense",
            name="customer_ref",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.SET_NULL,
                related_name="expenses",
                to="core.client",
            ),
        ),
        migrations.AddField(
            model_name="expense",
            name="invoice_ref",
            field=models.ForeignKey(
                blank=True,
                null=True,
                on_delete=django.db.models.deletion.SET_NULL,
                related_name="expenses",
                to="core.invoice",
            ),
        ),
        migrations.RunPython(backfill_expense_refs, migrations.RunPython.noop),
    ]

