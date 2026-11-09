"""Coincidencias del glosario con el Diccionario de datos de Softland."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime
from enum import StrEnum
from typing import Any
from uuid import UUID

from domain.entities.catalog import MAX_MASTER_LENGTH
from domain.entities.term import MAX_FIELD_LENGTH, MAX_SOFTLAND_LENGTH
from domain.exceptions import ValidationError

MIN_SEARCH_LENGTH = 2
MAX_SEARCH_LENGTH = 100


class MatchStatus(StrEnum):
    PENDING = "pendiente"
    APPLIED = "aplicada"
    DISCARDED = "descartada"


@dataclass(frozen=True)
class MatchOption:
    columna: str
    etiqueta: str
    tabla: str
    modulo: str
    descripcion: str
    n_tablas: int
    otras_tablas: tuple[str, ...]
    observacion: str = ""

    def to_dict(self) -> dict[str, Any]:
        return {
            "columna": self.columna,
            "etiqueta": self.etiqueta,
            "tabla": self.tabla,
            "modulo": self.modulo,
            "descripcion": self.descripcion,
            "nTablas": self.n_tablas,
            "otrasTablas": list(self.otras_tablas),
            "observacion": self.observacion,
        }


@dataclass(frozen=True)
class MatchChoice:
    columna: str
    tabla: str
    etiqueta: str
    maestro: str


@dataclass(frozen=True)
class DictionaryMatch:
    id: str
    termino_id: UUID
    termino: str
    confianza: str | None
    orden: int
    estado: MatchStatus
    maestro_sugerido: str
    opciones: tuple[MatchOption, ...]
    elegido: MatchChoice | None
    decidido_en: datetime | None
    decidido_por: str | None

    def to_dict(self) -> dict[str, Any]:
        elegido = self.elegido
        return {
            "id": self.id,
            "terminoId": self.termino_id,
            "termino": self.termino,
            "confianza": self.confianza,
            "orden": self.orden,
            "estado": self.estado,
            "maestroSugerido": self.maestro_sugerido,
            "opciones": [o.to_dict() for o in self.opciones],
            "elegido": None
            if elegido is None
            else {
                "columna": elegido.columna,
                "tabla": elegido.tabla,
                "etiqueta": elegido.etiqueta,
                "maestro": elegido.maestro,
            },
            "decididoEn": self.decidido_en,
            "decididoPor": self.decidido_por,
        }


def _field(raw: object, name: str, max_length: int) -> str:
    if raw is not None and not isinstance(raw, str):
        raise ValidationError(f"'{name}' debe ser texto.", details={"field": name})
    value = (raw or "").strip()
    if len(value) > max_length:
        raise ValidationError(f"'{name}' no puede superar {max_length} caracteres.", details={"field": name})
    return value


def parse_choice(body: dict[str, Any]) -> MatchChoice:
    columna = _field(body.get("columna"), "columna", MAX_FIELD_LENGTH)
    if not columna:
        raise ValidationError("Indica el Campo en Base de Datos.", details={"field": "columna"})
    return MatchChoice(
        columna=columna,
        tabla=_field(body.get("tabla"), "tabla", MAX_FIELD_LENGTH),
        etiqueta=_field(body.get("etiqueta"), "etiqueta", MAX_SOFTLAND_LENGTH),
        maestro=_field(body.get("maestro"), "maestro", MAX_MASTER_LENGTH),
    )


def normalize_search(raw: object) -> str:
    value = raw.strip() if isinstance(raw, str) else ""
    if len(value) < MIN_SEARCH_LENGTH:
        raise ValidationError(
            f"Escribe al menos {MIN_SEARCH_LENGTH} caracteres para buscar.", details={"field": "q"}
        )
    return value[:MAX_SEARCH_LENGTH]
