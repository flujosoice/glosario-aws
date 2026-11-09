"""Cargas de n8n: Maestros de Artículos y Clientes (Google Sheets) y Diccionario de Softland.

Contrato de las filas: n8n puede enviar las claves con los encabezados originales de la hoja o del
diccionario ("Nombre técnico", "Valor etiqueta", "Sólo lectura"...) o ya en snake_case; se normalizan
quitando acentos y signos. Los valores Sí/No/True/False pasan a booleano.
"""

from __future__ import annotations

import re
import unicodedata
from dataclasses import dataclass
from datetime import datetime
from enum import StrEnum
from typing import Any
from uuid import UUID

from domain.exceptions import ValidationError

MAX_BATCH_ROWS = 1000
MAX_TEXT_LENGTH = 4000
STALE_AFTER_HOURS = 2


class SyncSource(StrEnum):
    MASTER_ITEMS = "maestro_articulos"
    MASTER_CUSTOMERS = "maestro_clientes"
    SOFTLAND_DICTIONARY = "diccionario_softland"

    @classmethod
    def parse(cls, raw: object) -> SyncSource:
        try:
            return cls(str(raw))
        except ValueError as error:
            raise ValidationError(
                "Origen de sincronización no válido.",
                details={"field": "origen", "allowed": [s.value for s in cls]},
            ) from error

    @property
    def is_master(self) -> bool:
        return self is not SyncSource.SOFTLAND_DICTIONARY


class SyncStatus(StrEnum):
    RUNNING = "en_curso"
    COMPLETED = "completada"
    FAILED = "fallida"


@dataclass(frozen=True)
class SyncRun:
    id: UUID
    origen: SyncSource
    estado: SyncStatus
    es_vigente: bool
    filas_esperadas: int | None
    filas_recibidas: int
    iniciada_por: str
    iniciada_en: datetime
    finalizada_en: datetime | None
    error: str | None

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "origen": self.origen,
            "estado": self.estado,
            "esVigente": self.es_vigente,
            "filasEsperadas": self.filas_esperadas,
            "filasRecibidas": self.filas_recibidas,
            "iniciadaPor": self.iniciada_por,
            "iniciadaEn": self.iniciada_en,
            "finalizadaEn": self.finalizada_en,
            "error": self.error,
        }


MASTER_TEXT_FIELDS = (
    "hoja",
    "grupo",
    "atributo",
    "nombre_tecnico",
    "definicion",
    "empresas_aplica",
    "validaciones",
    "tipo_dato",
    "fuente_dato",
    "dominio_valores",
    "valor_default",
    "permite_null",
    "condicion_null",
    "dptos_consumidores",
)
MASTER_ALIASES = {
    "validaciones_y_reglas_clave_del_atributo": "validaciones",
    "validaciones_y_reglas_clave": "validaciones",
    "tipo_de_dato": "tipo_dato",
    "fuente_del_dato": "fuente_dato",
    "dominio_valores_permitidos": "dominio_valores",
    "valor_por_default": "valor_default",
    "dptos_consumidores_principales": "dptos_consumidores",
    "row_number": "fila",
}
SYSTEMS = {
    "softland_erp": "Softland ERP",
    "eflow": "eFlow",
    "afv": "AFV",
    "portal_de_pedido": "Portal de Pedido",
    "e_commerce": "e-Commerce",
    "catalogo_digital": "Catálogo Digital",
    "powerbi": "PowerBI",
    "streamline": "Streamline",
}

DICTIONARY_TEXT_FIELDS = (
    "esquema",
    "modulo",
    "tabla",
    "columna",
    "descripcion",
    "tipo_dato",
    "tamano",
    "valor_default",
    "posibles_valores",
    "modo_case",
    "tipo_mascara",
    "mostrar_como",
    "tipo_consecutivo",
    "formato_justificado",
    "valor_etiqueta",
)
DICTIONARY_BOOL_FIELDS = (
    "permite_nulos",
    "llave_primaria",
    "llave_foranea",
    "editable_procesos_masivos",
    "editable_primera_vez",
    "autocalculado",
    "visible",
    "solo_lectura",
    "requerido",
    "mostrar_en_f1",
)
DICTIONARY_ALIASES = {"nulidad": "permite_nulos"}


def normalize_key(raw: str) -> str:
    text = unicodedata.normalize("NFKD", str(raw)).encode("ascii", "ignore").decode("ascii").lower()
    return re.sub(r"[^a-z0-9]+", "_", text).strip("_")


def parse_bool(raw: object) -> bool | None:
    if isinstance(raw, bool):
        return raw
    text = normalize_key(str(raw)) if raw is not None else ""
    if text in ("si", "true", "1", "yes", "verdadero", "x"):
        return True
    if text in ("no", "false", "0", "falso"):
        return False
    return None


def _clean_text(raw: object) -> str:
    if raw is None or isinstance(raw, bool):
        return "" if raw is None else ("Sí" if raw else "No")
    text = str(raw).strip()
    return "" if text in ("''", '""') else text[:MAX_TEXT_LENGTH]


def _normalized(row: object, aliases: dict[str, str], index: int) -> dict[str, Any]:
    if not isinstance(row, dict):
        raise ValidationError(f"La fila {index + 1} no es un objeto.", details={"row": index})
    out: dict[str, Any] = {}
    for key, value in row.items():
        name = normalize_key(key)
        out[aliases.get(name, name)] = value
    return out


def parse_master_row(row: object, index: int) -> dict[str, Any]:
    data = _normalized(row, MASTER_ALIASES, index)
    parsed: dict[str, Any] = {name: _clean_text(data.get(name)) for name in MASTER_TEXT_FIELDS}
    if not (parsed["atributo"] or parsed["nombre_tecnico"]):
        raise ValidationError(
            f"La fila {index + 1} no tiene Atributo ni Nombre técnico.", details={"row": index}
        )
    try:
        parsed["fila"] = max(int(data.get("fila", index)), 0)
    except (TypeError, ValueError) as error:
        raise ValidationError(
            f"La fila {index + 1} tiene un número de fila inválido.", details={"row": index}
        ) from error
    parsed["obligatorio"] = parse_bool(data.get("obligatorio"))
    explicit = data.get("sistemas")
    systems = [str(s).strip() for s in explicit if str(s).strip()] if isinstance(explicit, list) else []
    systems += [label for key, label in SYSTEMS.items() if parse_bool(data.get(key)) and label not in systems]
    parsed["sistemas"] = systems
    return parsed


def parse_dictionary_row(row: object, index: int) -> dict[str, Any]:
    data = _normalized(row, DICTIONARY_ALIASES, index)
    parsed: dict[str, Any] = {name: _clean_text(data.get(name)) for name in DICTIONARY_TEXT_FIELDS}
    if not parsed["tabla"] or not parsed["columna"]:
        raise ValidationError(f"La fila {index + 1} no tiene Tabla y Columna.", details={"row": index})
    parsed.update({name: parse_bool(data.get(name)) for name in DICTIONARY_BOOL_FIELDS})
    return parsed


def parse_rows(source: SyncSource, raw: object) -> list[dict[str, Any]]:
    if not isinstance(raw, list) or not raw:
        raise ValidationError("'filas' debe ser una lista con al menos una fila.", details={"field": "filas"})
    if len(raw) > MAX_BATCH_ROWS:
        raise ValidationError(
            f"Envía como máximo {MAX_BATCH_ROWS} filas por lote.",
            details={"field": "filas", "max": MAX_BATCH_ROWS},
        )
    parser = parse_master_row if source.is_master else parse_dictionary_row
    return [parser(row, i) for i, row in enumerate(raw)]


def parse_expected_rows(raw: object) -> int | None:
    if raw in (None, ""):
        return None
    if isinstance(raw, bool) or not isinstance(raw, int) or raw < 0:
        raise ValidationError(
            "'filasEsperadas' debe ser un entero >= 0.", details={"field": "filasEsperadas"}
        )
    return raw
