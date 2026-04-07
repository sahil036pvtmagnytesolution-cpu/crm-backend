import os
import re
from email.mime.image import MIMEImage
from typing import Iterable, List, Optional, Sequence, Tuple

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
    raw_text = str(message or "").replace("\r\n", "\n")
    lines = [line.strip() for line in raw_text.split("\n")]

    detail_rows: List[Tuple[str, str]] = []
    paragraphs: List[str] = []
    paragraph_buffer: List[str] = []

    def flush_paragraph():
        if paragraph_buffer:
            paragraphs.append(" ".join(paragraph_buffer).strip())
            paragraph_buffer.clear()

    for line in lines:
        if not line:
            flush_paragraph()
            continue

        is_key_value_line = (
            ":" in line
            and line.count(":") == 1
            and not line.lower().startswith(("http://", "https://"))
        )
        if is_key_value_line:
            key, value = line.split(":", 1)
            key = key.strip()
            value = value.strip()
            if key and value:
                flush_paragraph()
                detail_rows.append((key, value))
                continue

        paragraph_buffer.append(line)

    flush_paragraph()

    intro = paragraphs[0] if paragraphs else None
    body_html = "".join(f"<p>{escape(paragraph)}</p>" for paragraph in paragraphs[1:])
    return build_module_email_html(
        intro=intro,
        details=detail_rows,
        body_html=body_html or None,
        closing="",
    )


def _escape_with_breaks(value: str) -> str:
    return escape(str(value or "")).replace("\n", "<br/>")


def build_module_email_html(
    *,
    title: Optional[str] = None,
    greeting: Optional[str] = None,
    intro: Optional[str] = None,
    details: Optional[Sequence[Tuple[str, object]]] = None,
    body_html: Optional[str] = None,
    cta_label: Optional[str] = None,
    cta_url: Optional[str] = None,
    closing: Optional[str] = None,
) -> str:
    parts: List[str] = []

    if title:
        parts.append(f'<h3 style="margin:0 0 10px 0;color:#0f172a;">{escape(title)}</h3>')

    if greeting:
        parts.append(f"<p>Hello <strong>{escape(greeting)}</strong>,</p>")

    if intro:
        parts.append(f"<p>{_escape_with_breaks(intro)}</p>")

    normalized_details = []
    for row in details or []:
        if not row or len(row) < 2:
            continue
        label, value = row[0], row[1]
        label_text = str(label or "").strip()
        value_text = str(value or "").strip() or "-"
        if label_text:
            normalized_details.append((label_text, value_text))

    if normalized_details:
        detail_rows_html = []
        for label, value in normalized_details:
            detail_rows_html.append(
                "<tr>"
                f'<td style="padding:8px; border:1px solid #d1d5db;"><strong>{escape(label)}</strong></td>'
                f'<td style="padding:8px; border:1px solid #d1d5db;">{_escape_with_breaks(value)}</td>'
                "</tr>"
            )
        parts.append(
            '<table style="width:100%; border-collapse: collapse; margin-top:15px;">'
            f"{''.join(detail_rows_html)}"
            "</table>"
        )

    if body_html:
        parts.append(body_html)

    if cta_label and cta_url:
        parts.append(
            '<div style="text-align:center; margin-top:25px;">'
            f'<a href="{escape(cta_url)}" '
            'style="background:#27ae60; color:#ffffff; padding:12px 25px; '
            'text-decoration:none; border-radius:5px; display:inline-block;">'
            f"{escape(cta_label)}"
            "</a>"
            "</div>"
        )

    if closing is None:
        parts.append(f"<p style=\"margin-top:24px;\">Regards,<br/><strong>{escape(BRAND_NAME)} Team</strong></p>")
    elif closing:
        parts.append(f'<p style="margin-top:24px;">{closing}</p>')

    return "".join(parts) or "<p></p>"


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
    attachments: Optional[Iterable] = None,
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

    for attachment in attachments or []:
        filename = None
        content = None
        content_type = None

        if isinstance(attachment, dict):
            filename = attachment.get("filename")
            content = attachment.get("content")
            content_type = attachment.get("content_type")
        elif isinstance(attachment, (list, tuple)):
            if len(attachment) >= 2:
                filename = attachment[0]
                content = attachment[1]
            if len(attachment) >= 3:
                content_type = attachment[2]

        if filename and content is not None:
            if content_type:
                email_message.attach(filename, content, content_type)
            else:
                email_message.attach(filename, content)

    logo_path = _default_logo_path()
    if os.path.exists(logo_path):
        with open(logo_path, "rb") as logo_file:
            logo = MIMEImage(logo_file.read())
            logo.add_header("Content-ID", f"<{LOGO_CID}>")
            logo.add_header("Content-Disposition", "inline", filename=os.path.basename(logo_path))
            email_message.attach(logo)

    return email_message.send(fail_silently=fail_silently)
