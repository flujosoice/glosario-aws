"""Llaves de acceso: reemplazan a Cognito (la app no tiene usuarios).

El enlace de administración y los flujos de n8n envían ``Authorization: Llave <valor>``. Solo se
guarda el SHA-256 de cada llave; la etiqueta de la llave identifica quién hizo un cambio.
"""

from __future__ import annotations

import hashlib
from dataclasses import dataclass
from enum import StrEnum

MIN_KEY_LENGTH = 24
_SCHEMES = ("llave", "bearer")


class AccessPurpose(StrEnum):
    ADMIN = "administracion"
    INGEST = "ingesta"


@dataclass(frozen=True)
class AccessGrant:
    purpose: AccessPurpose
    label: str


def extract_key(authorization: str | None) -> str | None:
    """Valor de la llave desde la cabecera Authorization (``Llave x`` o ``Bearer x``)."""
    raw = (authorization or "").strip()
    if not raw:
        return None
    scheme, _, value = raw.partition(" ")
    if value and scheme.lower() in _SCHEMES:
        raw = value.strip()
    return raw if len(raw) >= MIN_KEY_LENGTH else None


def hash_key(key: str) -> str:
    return hashlib.sha256(key.encode("utf-8")).hexdigest()
