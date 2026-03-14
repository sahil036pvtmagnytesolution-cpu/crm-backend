from decimal import Decimal, InvalidOperation

from .models import Item, ItemGroup


def _clean_text(value):
    if value is None:
        return ""
    return str(value).strip()


def _decimal_value(value, default="0"):
    try:
        raw = default if value in (None, "") else value
        return Decimal(str(raw))
    except (InvalidOperation, TypeError, ValueError):
        return Decimal(default)


def _normalize_status(value):
    if isinstance(value, bool):
        return "active" if value else "inactive"

    normalized = _clean_text(value).lower()
    if normalized in {"0", "false", "inactive", "disabled"}:
        return "inactive"
    return "active"


def _resolve_group(item_data):
    group_id = item_data.get("group")
    group_name = _clean_text(
        item_data.get("groupName")
        or item_data.get("group_name")
        or item_data.get("groupLabel")
    )

    if group_id:
      group = ItemGroup.objects.filter(pk=group_id).first()
      if group:
        return group

    if group_name:
        group, _ = ItemGroup.objects.get_or_create(name=group_name)
        return group

    return None


def sync_item_to_master(item_data):
    if not isinstance(item_data, dict):
        return None

    item_name = _clean_text(
        item_data.get("item_name")
        or item_data.get("description")
        or item_data.get("name")
        or item_data.get("label")
    )
    if not item_name:
        return None

    item_code = _clean_text(
        item_data.get("item_code")
        or item_data.get("sku")
        or item_data.get("code")
    )
    description = _clean_text(item_data.get("description") or item_name)
    long_description = _clean_text(
        item_data.get("long_description")
        or item_data.get("longDescription")
        or item_data.get("details")
    )
    unit_price = _decimal_value(
        item_data.get("unit_price")
        or item_data.get("rate")
        or item_data.get("unitPrice")
        or 0
    )
    tax = _clean_text(item_data.get("tax") or item_data.get("tax1") or "No Tax") or "No Tax"
    tax2 = _clean_text(item_data.get("tax2") or "No Tax") or "No Tax"
    unit = _clean_text(item_data.get("unit"))
    status = _normalize_status(item_data.get("status"))
    group = _resolve_group(item_data)

    item_id = item_data.get("id")

    if item_id:
        item = Item.objects.filter(pk=item_id).first()
    elif item_code:
        item = Item.objects.filter(item_code__iexact=item_code).first()
    else:
        item = Item.objects.filter(item_name__iexact=item_name).first()

    # Keep defaults limited to non-identity fields to avoid duplicate kwargs
    # when calling `Item.objects.create(item_name=..., **defaults)`.
    defaults = {
        "description": description,
        "long_description": long_description,
        "rate": unit_price,
        "tax": tax,
        "tax2": tax2,
        "unit": unit,
        "status": status,
        "group": group,
    }

    if item:
        item.item_name = item_name
        for field, value in defaults.items():
            setattr(item, field, value)
        if item_code:
            item.item_code = item_code
        item.save()
        return item

    return Item.objects.create(
        item_name=item_name,
        item_code=item_code or None,
        **defaults,
    )


def sync_items_to_master(items):
    saved_items = []
    if not isinstance(items, list):
        return saved_items

    for item in items:
        saved = sync_item_to_master(item)
        if saved:
            saved_items.append(saved)
    return saved_items
