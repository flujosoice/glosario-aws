"""Ports de persistencia del glosario: llaves de acceso, términos, catálogos, diccionario y cargas."""

from __future__ import annotations

from abc import ABC, abstractmethod
from datetime import datetime
from typing import Any
from uuid import UUID

from domain.entities.access import AccessGrant
from domain.entities.catalog import Master, Tag, TagType
from domain.entities.dictionary import DictionaryMatch, MatchChoice, MatchOption
from domain.entities.sync import SyncRun, SyncSource
from domain.entities.term import BdField, TermDraft, TermView


class AccessKeyRepository(ABC):
    @abstractmethod
    def find_active(self, key_hash: str) -> AccessGrant | None:
        """Llave vigente (activa y sin revocar) con ese SHA-256."""


class TermRepository(ABC):
    @abstractmethod
    def list_all(self, *, include_deleted: bool) -> list[TermView]:
        """Términos ordenados por nombre (sin distinguir mayúsculas)."""

    @abstractmethod
    def get(self, term_id: UUID) -> TermView | None: ...

    @abstractmethod
    def create(self, draft: TermDraft, tag_ids: list[int], master_ids: list[int]) -> UUID: ...

    @abstractmethod
    def update(
        self,
        term_id: UUID,
        draft: TermDraft,
        tag_ids: list[int],
        master_ids: list[int],
        *,
        edited: bool,
        keep_fragments: bool,
    ) -> None: ...

    @abstractmethod
    def set_fields(
        self, term_id: UUID, fields: tuple[BdField, ...], campo_softland: str, master_ids: list[int]
    ) -> None:
        """Reemplaza Campo BD, Campo Softland y maestros sin marcar el término como editado."""

    @abstractmethod
    def set_deleted(self, term_id: UUID, deleted: bool) -> None: ...

    @abstractmethod
    def add_audit(
        self, term_id: UUID, action: str, changes: list[tuple[str, str | None, str]], by: str
    ) -> None: ...


class CatalogRepository(ABC):
    @abstractmethod
    def list_tags(self) -> list[Tag]: ...

    @abstractmethod
    def list_masters(self) -> list[Master]: ...

    @abstractmethod
    def find_tag(self, tag_id: int) -> Tag | None: ...

    @abstractmethod
    def find_master(self, master_id: int) -> Master | None: ...

    @abstractmethod
    def tags_by_name(self, names: tuple[str, ...]) -> dict[str, Tag]:
        """Etiquetas existentes indexadas por nombre en minúsculas."""

    @abstractmethod
    def masters_by_name(self, names: tuple[str, ...]) -> dict[str, Master]:
        """Maestros existentes indexados por nombre en minúsculas."""

    @abstractmethod
    def create_tag(self, nombre: str, tipo: TagType) -> Tag:
        """Nombre repetido (sin distinguir mayúsculas) → ConflictError."""

    @abstractmethod
    def delete_tag(self, tag_id: int) -> None:
        """La etiqueta se quita también de los términos que la tenían."""

    @abstractmethod
    def create_master(self, nombre: str) -> Master:
        """Nombre repetido (sin distinguir mayúsculas) → ConflictError."""

    @abstractmethod
    def count_master_terms(self, master_id: int) -> int: ...

    @abstractmethod
    def delete_master(self, master_id: int) -> None: ...


class DictionaryMatchRepository(ABC):
    @abstractmethod
    def list_all(self) -> list[DictionaryMatch]:
        """Coincidencias en orden de revisión con sus opciones."""

    @abstractmethod
    def get(self, match_id: str) -> DictionaryMatch | None: ...

    @abstractmethod
    def mark_applied(self, match_id: str, choice: MatchChoice, by: str) -> None: ...

    @abstractmethod
    def mark_discarded(self, match_id: str, by: str) -> None: ...

    @abstractmethod
    def reopen(self, match_id: str) -> None:
        """Vuelve a pendiente sin tocar lo ya aplicado al término."""


class SoftlandDictionaryRepository(ABC):
    @abstractmethod
    def search(self, text: str, limit: int) -> list[MatchOption]:
        """Columnas del diccionario vigente cuyo nombre, etiqueta o descripción contiene el texto."""


class SyncRunRepository(ABC):
    @abstractmethod
    def start(self, source: SyncSource, expected_rows: int | None, by: str) -> SyncRun: ...

    @abstractmethod
    def get(self, run_id: UUID) -> SyncRun | None: ...

    @abstractmethod
    def find_running(self, source: SyncSource) -> SyncRun | None: ...

    @abstractmethod
    def add_rows(self, run: SyncRun, rows: list[dict[str, Any]]) -> int:
        """Guarda las filas del lote y devuelve el total recibido de la carga."""

    @abstractmethod
    def complete(self, run_id: UUID) -> SyncRun:
        """La carga pasa a ser la vigente de su origen; las filas de la anterior se eliminan."""

    @abstractmethod
    def fail(self, run_id: UUID, error: str) -> SyncRun:
        """Marca la carga como fallida y elimina sus filas; lo vigente no cambia."""

    @abstractmethod
    def list_recent(self, source: SyncSource | None, limit: int) -> list[SyncRun]: ...

    @abstractmethod
    def expire_running(self, started_before: datetime, error: str) -> int:
        """Marca como fallidas las cargas en curso iniciadas antes de la fecha; devuelve cuántas."""
