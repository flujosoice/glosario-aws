"""Etiquetas y Maestros de Datos del glosario."""

from __future__ import annotations

from dataclasses import dataclass
from enum import StrEnum
from typing import Any

from domain.exceptions import ValidationError

MAX_TAG_LENGTH = 150
MAX_MASTER_LENGTH = 100


class TagType(StrEnum):
    ORIGIN = "silo_sistema"
    SIM = "rol_reporte_sim"

    @classmethod
    def parse(cls, raw: object) -> TagType:
        try:
            return cls(str(raw))
        except ValueError as error:
            raise ValidationError(
                "Tipo de etiqueta no válido.", details={"field": "tipo", "allowed": [t.value for t in cls]}
            ) from error


@dataclass(frozen=True)
class Tag:
    id: int
    nombre: str
    tipo: TagType
    es_base: bool

    def to_dict(self) -> dict[str, Any]:
        return {"id": self.id, "nombre": self.nombre, "tipo": self.tipo, "esBase": self.es_base}


@dataclass(frozen=True)
class Master:
    id: int
    nombre: str
    es_base: bool

    def to_dict(self) -> dict[str, Any]:
        return {"id": self.id, "nombre": self.nombre, "esBase": self.es_base}


def normalize_name(raw: object, field: str, max_length: int) -> str:
    value = raw.strip() if isinstance(raw, str) else ""
    if not value:
        raise ValidationError("Escribe un nombre.", details={"field": field})
    if len(value) > max_length:
        raise ValidationError(
            f"El nombre no puede superar {max_length} caracteres.", details={"field": field}
        )
    return value
