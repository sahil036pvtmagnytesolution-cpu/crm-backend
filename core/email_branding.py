import os
import re
from email.mime.image import MIMEImage
from typing import Iterable, List, Optional

from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.utils.html import escape, strip_tags


BRAND_NAME = "Magnyte Solution CRM"
LOGO_CID = "crm_brand_logo"


def _as_list(values) -> List[str]:
    if not values:
        return []
    if isinstance(values, (list, tuple, set)):
        return [str(v).strip() for v in values if str(v).strip()]
    value = str(values).strip()
    return [value] if value else []


def _default_logo_path() -> str:
    configured = str(getattr(settings, "EMAIL_LOGO_PATH", "") or "").strip()
    if configured:
        return configured

    return os.path.join(
        settings.BASE_DIR.parent,
        "crm-frontend",
        "public",
        "ms.png",
    )


def _html_from_text(message: str) -> str:
    safe_text = escape(str(message or ""))
    return safe_text.replace("\n", "<br/>")


def build_branded_email_html(content_html: str) -> str:
    logo_path = _default_logo_path()
    logo_html = ""
    if os.path.exists(logo_path):
        logo_html = (
            f'<img src="cid:{LOGO_CID}" alt="{escape(BRAND_NAME)}" '
            'style="height:72px;max-width:220px;object-fit:contain;display:block;margin:0 auto 10px;" />'
        )

    return f"""
<div style="background:#f4f7fb;padding:24px;font-family:Arial,sans-serif;">
  <div style="max-width:680px;margin:0 auto;background:#ffffff;border:1px solid #dbe3ec;border-radius:12px;overflow:hidden;">
    <div style="background:#0a3459;padding:20px;text-align:center;">
      {logo_html}
      <div style="font-size:20px;font-weight:700;color:#ffffff;">{escape(BRAND_NAME)}</div>
    </div>
    <div style="padding:22px;color:#1f2937;font-size:14px;line-height:1.6;">
      {content_html}
    </div>
    <div style="border-top:1px solid #e5e7eb;background:#f8fafc;padding:14px 22px;color:#64748b;font-size:12px;">
      This is an automated email from {escape(BRAND_NAME)}.
    </div>
  </div>
</div>
""".strip()


def send_branded_email(
    subject: str,
    message: str,
    to_emails,
    *,
    html_message: Optional[str] = None,
    cc: Optional[Iterable[str]] = None,
    fail_silently: bool = False,
    from_email: Optional[str] = None,
) -> int:
    to_list = _as_list(to_emails)
    cc_list = _as_list(cc)

    if not to_list:
        raise ValueError("At least one recipient email is required.")

    content_html = html_message or _html_from_text(message)
    branded_html = build_branded_email_html(content_html)

    plain_text = str(message or "").strip()
    if not plain_text:
        plain_text = strip_tags(re.sub(r"(?i)<br\s*/?>", "\n", content_html))
        plain_text = re.sub(r"\n{3,}", "\n\n", plain_text).strip()

    email_message = EmailMultiAlternatives(
        subject=subject,
        body=plain_text,
        from_email=from_email or settings.DEFAULT_FROM_EMAIL,
        to=to_list,
        cc=cc_list,
    )
    email_message.attach_alternative(branded_html, "text/html")

    logo_path = _default_logo_path()
    if os.path.exists(logo_path):
        with open(logo_path, "rb") as logo_file:
            logo = MIMEImage(logo_file.read())
            logo.add_header("Content-ID", f"<{LOGO_CID}>")
            logo.add_header("Content-Disposition", "inline", filename=os.path.basename(logo_path))
            email_message.attach(logo)

    return email_message.send(fail_silently=fail_silently)
