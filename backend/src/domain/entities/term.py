"""Término del glosario y reglas de edición de Procesos."""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime
from typing import Any
from uuid import UUID

from domain.exceptions import ValidationError

MAX_TERM_LENGTH = 300
MAX_FIELD_LENGTH = 200
MAX_SOFTLAND_LENGTH = 300
MAX_DEFINITION_LENGTH = 10000


@dataclass(frozen=True)
class BdField:
    campo: str
    aplica_a: str = ""

    def to_dict(self) -> dict[str, str]:
        return {"campo": self.campo, "aplicaA": self.aplica_a}


@dataclass(frozen=True)
class DefinitionFragment:
    contexto: str
    texto: str


@dataclass(frozen=True)
class TermView:
    id: UUID
    termino: str
    definicion: str
    fragmentos: tuple[DefinitionFragment, ...]
    etiquetas: tuple[str, ...]
    estado_origen: str | None
    campos_bd: tuple[BdField, ...]
    campo_softland: str
    maestros: tuple[str, ...]
    es_nuevo: bool
    editado: bool
    eliminado: bool
    actualizado_en: datetime | None

    @property
    def has_fields(self) -> bool:
        return bool(self.campos_bd or self.campo_softland.strip())

    def public_dict(self) -> dict[str, Any]:
        """Lo que ve cualquiera con el enlace general: sin 'Editado' ni datos de administración."""
        return {
            "id": self.id,
            "termino": self.termino,
            "definicion": self.definicion,
            "fragmentos": [{"contexto": f.contexto, "texto": f.texto} for f in self.fragmentos],
            "etiquetas": list(self.etiquetas),
            "estadoOrigen": self.estado_origen,
            "camposBd": [c.to_dict() for c in self.campos_bd],
            "campoSoftland": self.campo_softland,
            "maestros": list(self.maestros),
            "esNuevo": self.es_nuevo,
        }

    def admin_dict(self) -> dict[str, Any]:
        return {
            **self.public_dict(),
            "editado": self.editado,
            "eliminado": self.eliminado,
            "actualizadoEn": self.actualizado_en,
        }


@dataclass(frozen=True)
class TermDraft:
    """Datos validados del formulario de Administración."""

    termino: str
    definicion: str
    etiquetas: tuple[str, ...]
    campos_bd: tuple[BdField, ...]
    campo_softland: str
    maestros: tuple[str, ...] = field(default_factory=tuple)


def _text(raw: object, name: str, max_length: int, *, required: bool = False) -> str:
    if raw is not None and not isinstance(raw, str):
        raise ValidationError(f"'{name}' debe ser texto.", details={"field": name})
    value = (raw or "").strip()
    if required and not value:
        raise ValidationError("El término no puede estar vacío.", details={"field": name})
    if len(value) > max_length:
        raise ValidationError(f"'{name}' no puede superar {max_length} caracteres.", details={"field": name})
    return value


def _names(raw: object, name: str) -> tuple[str, ...]:
    if raw is None:
        return ()
    if not isinstance(raw, list) or not all(isinstance(x, str) for x in raw):
        raise ValidationError(f"'{name}' debe ser una lista de textos.", details={"field": name})
    seen: dict[str, str] = {}
    for item in raw:
        value = item.strip()
        if value and value.lower() not in seen:
            seen[value.lower()] = value
    return tuple(seen.values())


def parse_bd_fields(raw: object) -> tuple[BdField, ...]:
    if raw is None:
        return ()
    if not isinstance(raw, list):
        raise ValidationError("'camposBd' debe ser una lista.", details={"field": "camposBd"})
    rows: list[BdField] = []
    for item in raw:
        if not isinstance(item, dict):
            raise ValidationError(
                "Cada Campo en Base de Datos debe ser un objeto.", details={"field": "camposBd"}
            )
        campo = _text(item.get("campo"), "campo", MAX_FIELD_LENGTH)
        aplica_a = _text(item.get("aplicaA"), "aplicaA", MAX_FIELD_LENGTH)
        if campo:
            rows.append(BdField(campo, aplica_a))
    if len(rows) > 1 and any(not r.aplica_a for r in rows):
        raise ValidationError(
            "Indica a qué empresa o tabla aplica cada Campo en Base de Datos.", details={"field": "camposBd"}
        )
    return tuple(rows)


def parse_term_draft(body: dict[str, Any]) -> TermDraft:
    return TermDraft(
        termino=_text(body.get("termino"), "termino", MAX_TERM_LENGTH, required=True),
        definicion=_text(body.get("definicion"), "definicion", MAX_DEFINITION_LENGTH),
        etiquetas=_names(body.get("etiquetas"), "etiquetas"),
        campos_bd=parse_bd_fields(body.get("camposBd")),
        campo_softland=_text(body.get("campoSoftland"), "campoSoftland", MAX_SOFTLAND_LENGTH),
        maestros=_names(body.get("maestros"), "maestros"),
    )


def content_changed(current: TermView, draft: TermDraft) -> bool:
    """Regla de Procesos: 'Editado' solo si cambia el nombre, la definición o las etiquetas."""
    return (
        current.termino != draft.termino
        or current.definicion != draft.definicion
        or set(current.etiquetas) != set(draft.etiquetas)
    )


def format_bd_fields(fields: tuple[BdField, ...]) -> str:
    """Forma histórica del glosario: ``CAMPO`` o ``CAMPO_A (Aplica a) / CAMPO_B (Aplica a)``."""
    if len(fields) == 1 and not fields[0].aplica_a:
        return fields[0].campo
    return " / ".join(f"{f.campo} ({f.aplica_a})" for f in fields)


def audit_changes(current: TermView | None, draft: TermDraft) -> list[tuple[str, str | None, str]]:
    """(campo, valor_anterior, valor_nuevo) de lo que cambia; todo es nuevo si no hay término previo."""
    pairs = [
        ("termino", current.termino if current else None, draft.termino),
        ("definicion", current.definicion if current else None, draft.definicion),
        (
            "etiquetas",
            ", ".join(sorted(current.etiquetas)) if current else None,
            ", ".join(sorted(draft.etiquetas)),
        ),
        (
            "campo_bd",
            format_bd_fields(current.campos_bd) if current else None,
            format_bd_fields(draft.campos_bd),
        ),
        ("campo_softland", current.campo_softland if current else None, draft.campo_softland),
        (
            "maestros",
            ", ".join(sorted(current.maestros)) if current else None,
            ", ".join(sorted(draft.maestros)),
        ),
    ]
    return [(name, old, new) for name, old, new in pairs if old != new and (current or new)]
