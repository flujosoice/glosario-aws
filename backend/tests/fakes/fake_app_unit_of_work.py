"""Fakes en memoria del glosario para tests unitarios de casos de uso (mismas reglas que la base)."""

from __future__ import annotations

from dataclasses import replace
from datetime import UTC, datetime
from typing import Any
from uuid import UUID, uuid4

from application.ports.glossary import (
    AccessKeyRepository,
    CatalogRepository,
    DictionaryMatchRepository,
    SoftlandDictionaryRepository,
    SyncRunRepository,
    TermRepository,
)
from domain.entities.access import AccessGrant, AccessPurpose, hash_key
from domain.entities.catalog import Master, Tag, TagType
from domain.entities.dictionary import DictionaryMatch, MatchChoice, MatchOption, MatchStatus
from domain.entities.sync import SyncRun, SyncSource, SyncStatus
from domain.entities.term import BdField, TermDraft, TermView
from domain.exceptions import ConflictError
from fakes.fake_unit_of_work import FakeUnitOfWork

ADMIN_KEY = "llave-admin-procesos-0123456789"
INGEST_KEY = "llave-ingesta-n8n-0123456789abc"


def auth(key: str) -> str:
    return f"Llave {key}"


class FakeAccessKeys(AccessKeyRepository):
    def __init__(self) -> None:
        self.keys = {
            hash_key(ADMIN_KEY): AccessGrant(AccessPurpose.ADMIN, "Enlace Procesos"),
            hash_key(INGEST_KEY): AccessGrant(AccessPurpose.INGEST, "n8n"),
        }

    def find_active(self, key_hash: str) -> AccessGrant | None:
        return self.keys.get(key_hash)


class FakeCatalogs(CatalogRepository):
    def __init__(self) -> None:
        self.tags: dict[int, Tag] = {}
        self.masters: dict[int, Master] = {}
        self.term_masters: dict[int, int] = {}
        for name, tipo in (
            ("Silo Ventas", TagType.ORIGIN),
            ("Softland", TagType.ORIGIN),
            ("Filtro Venta", TagType.SIM),
        ):
            self._add_tag(name, tipo, True)
        for name in ("Artículo", "Cliente"):
            self._add_master(name, True)

    def _add_tag(self, nombre: str, tipo: TagType, es_base: bool) -> Tag:
        tag = Tag(max(self.tags, default=0) + 1, nombre, tipo, es_base)
        self.tags[tag.id] = tag
        return tag

    def _add_master(self, nombre: str, es_base: bool) -> Master:
        master = Master(max(self.masters, default=0) + 1, nombre, es_base)
        self.masters[master.id] = master
        return master

    def list_tags(self) -> list[Tag]:
        return sorted(self.tags.values(), key=lambda t: (t.tipo, t.nombre.lower()))

    def list_masters(self) -> list[Master]:
        return sorted(self.masters.values(), key=lambda m: (not m.es_base, m.id))

    def find_tag(self, tag_id: int) -> Tag | None:
        return self.tags.get(tag_id)

    def find_master(self, master_id: int) -> Master | None:
        return self.masters.get(master_id)

    def tags_by_name(self, names: tuple[str, ...]) -> dict[str, Tag]:
        wanted = {n.lower() for n in names}
        return {t.nombre.lower(): t for t in self.tags.values() if t.nombre.lower() in wanted}

    def masters_by_name(self, names: tuple[str, ...]) -> dict[str, Master]:
        wanted = {n.lower() for n in names}
        return {m.nombre.lower(): m for m in self.masters.values() if m.nombre.lower() in wanted}

    def create_tag(self, nombre: str, tipo: TagType) -> Tag:
        if self.tags_by_name((nombre,)):
            raise ConflictError("El registro ya existe.")
        return self._add_tag(nombre, tipo, False)

    def delete_tag(self, tag_id: int) -> None:
        self.tags.pop(tag_id, None)

    def create_master(self, nombre: str) -> Master:
        if self.masters_by_name((nombre,)):
            raise ConflictError("El registro ya existe.")
        return self._add_master(nombre, False)

    def count_master_terms(self, master_id: int) -> int:
        return self.term_masters.get(master_id, 0)

    def delete_master(self, master_id: int) -> None:
        self.masters.pop(master_id, None)


class FakeTerms(TermRepository):
    def __init__(self, catalogs: FakeCatalogs) -> None:
        self._catalogs = catalogs
        self.rows: dict[UUID, TermView] = {}
        self.audit: list[tuple[UUID, str, str, str | None, str, str]] = []

    def add(self, termino: str, **extra: Any) -> TermView:
        term = TermView(
            id=uuid4(),
            termino=termino,
            definicion=extra.get("definicion", ""),
            fragmentos=extra.get("fragmentos", ()),
            etiquetas=extra.get("etiquetas", ()),
            estado_origen=extra.get("estado_origen"),
            campos_bd=extra.get("campos_bd", ()),
            campo_softland=extra.get("campo_softland", ""),
            maestros=extra.get("maestros", ()),
            es_nuevo=False,
            editado=False,
            eliminado=extra.get("eliminado", False),
            actualizado_en=None,
        )
        self.rows[term.id] = term
        return term

    def list_all(self, *, include_deleted: bool) -> list[TermView]:
        rows = [t for t in self.rows.values() if include_deleted or not t.eliminado]
        return sorted(rows, key=lambda t: t.termino.lower())

    def get(self, term_id: UUID) -> TermView | None:
        return self.rows.get(term_id)

    def _names(self, tag_ids: list[int], master_ids: list[int]) -> tuple[tuple[str, ...], tuple[str, ...]]:
        return (
            tuple(self._catalogs.tags[i].nombre for i in tag_ids),
            tuple(self._catalogs.masters[i].nombre for i in master_ids),
        )

    def create(self, draft: TermDraft, tag_ids: list[int], master_ids: list[int]) -> UUID:
        tags, masters = self._names(tag_ids, master_ids)
        term = self.add(
            draft.termino,
            definicion=draft.definicion,
            etiquetas=tags,
            campos_bd=draft.campos_bd,
            campo_softland=draft.campo_softland,
            maestros=masters,
        )
        self.rows[term.id] = replace(term, es_nuevo=True, actualizado_en=datetime.now(UTC))
        return term.id

    def update(self, term_id, draft, tag_ids, master_ids, *, edited, keep_fragments) -> None:
        tags, masters = self._names(tag_ids, master_ids)
        current = self.rows[term_id]
        self.rows[term_id] = replace(
            current,
            termino=draft.termino,
            definicion=draft.definicion,
            etiquetas=tags,
            campos_bd=draft.campos_bd,
            campo_softland=draft.campo_softland,
            maestros=masters,
            editado=edited,
            fragmentos=current.fragmentos if keep_fragments else (),
            actualizado_en=datetime.now(UTC),
        )

    def set_fields(
        self, term_id: UUID, fields: tuple[BdField, ...], campo_softland: str, master_ids: list[int]
    ) -> None:
        _, masters = self._names([], master_ids)
        self.rows[term_id] = replace(
            self.rows[term_id], campos_bd=fields, campo_softland=campo_softland, maestros=masters
        )

    def set_deleted(self, term_id: UUID, deleted: bool) -> None:
        self.rows[term_id] = replace(self.rows[term_id], eliminado=deleted)

    def add_audit(self, term_id, action, changes, by) -> None:
        self.audit += [(term_id, action, f, old, new, by) for f, old, new in changes]


class FakeMatches(DictionaryMatchRepository):
    def __init__(self, terms: FakeTerms) -> None:
        self._terms = terms
        self.rows: dict[str, DictionaryMatch] = {}

    def add(
        self, match_id: str, term: TermView, options: tuple[MatchOption, ...], suggested: str = ""
    ) -> None:
        self.rows[match_id] = DictionaryMatch(
            match_id,
            term.id,
            term.termino,
            "Alta",
            len(self.rows),
            MatchStatus.PENDING,
            suggested,
            options,
            None,
            None,
            None,
        )

    def list_all(self) -> list[DictionaryMatch]:
        return sorted(self.rows.values(), key=lambda m: (m.orden, m.id))

    def get(self, match_id: str) -> DictionaryMatch | None:
        return self.rows.get(match_id)

    def mark_applied(self, match_id: str, choice: MatchChoice, by: str) -> None:
        self.rows[match_id] = replace(
            self.rows[match_id],
            estado=MatchStatus.APPLIED,
            elegido=choice,
            decidido_en=datetime.now(UTC),
            decidido_por=by,
        )

    def mark_discarded(self, match_id: str, by: str) -> None:
        self.rows[match_id] = replace(
            self.rows[match_id], estado=MatchStatus.DISCARDED, decidido_en=datetime.now(UTC), decidido_por=by
        )

    def reopen(self, match_id: str) -> None:
        self.rows[match_id] = replace(self.rows[match_id], estado=MatchStatus.PENDING)


class FakeSoftland(SoftlandDictionaryRepository):
    def __init__(self) -> None:
        self.columns: list[MatchOption] = []

    def search(self, text: str, limit: int) -> list[MatchOption]:
        needle = text.lower()
        hits = [c for c in self.columns if needle in f"{c.columna} {c.etiqueta} {c.descripcion}".lower()]
        return hits[:limit]


class FakeSyncRuns(SyncRunRepository):
    def __init__(self) -> None:
        self.runs: dict[UUID, SyncRun] = {}
        self.rows: dict[UUID, list[dict[str, Any]]] = {}

    def start(self, source: SyncSource, expected_rows: int | None, by: str) -> SyncRun:
        run = SyncRun(
            uuid4(), source, SyncStatus.RUNNING, False, expected_rows, 0, by, datetime.now(UTC), None, None
        )
        self.runs[run.id] = run
        self.rows[run.id] = []
        return run

    def get(self, run_id: UUID) -> SyncRun | None:
        return self.runs.get(run_id)

    def find_running(self, source: SyncSource) -> SyncRun | None:
        return next(
            (r for r in self.runs.values() if r.origen is source and r.estado is SyncStatus.RUNNING), None
        )

    def add_rows(self, run: SyncRun, rows: list[dict[str, Any]]) -> int:
        self.rows[run.id] += rows
        self.runs[run.id] = replace(self.runs[run.id], filas_recibidas=len(self.rows[run.id]))
        return len(self.rows[run.id])

    def complete(self, run_id: UUID) -> SyncRun:
        origen = self.runs[run_id].origen
        for other in list(self.runs.values()):
            if other.origen is origen and other.es_vigente:
                self.runs[other.id] = replace(other, es_vigente=False)
                self.rows[other.id] = []
        self.runs[run_id] = replace(
            self.runs[run_id], estado=SyncStatus.COMPLETED, es_vigente=True, finalizada_en=datetime.now(UTC)
        )
        return self.runs[run_id]

    def fail(self, run_id: UUID, error: str) -> SyncRun:
        self.rows[run_id] = []
        self.runs[run_id] = replace(
            self.runs[run_id], estado=SyncStatus.FAILED, error=error, finalizada_en=datetime.now(UTC)
        )
        return self.runs[run_id]

    def list_recent(self, source: SyncSource | None, limit: int) -> list[SyncRun]:
        runs = [r for r in self.runs.values() if source is None or r.origen is source]
        return sorted(runs, key=lambda r: r.iniciada_en, reverse=True)[:limit]

    def expire_running(self, started_before: datetime, error: str) -> int:
        stale = [
            r for r in self.runs.values() if r.estado is SyncStatus.RUNNING and r.iniciada_en < started_before
        ]
        for run in stale:
            self.fail(run.id, error)
        return len(stale)


class FakeAppUnitOfWork(FakeUnitOfWork):
    """Comparte el estado entre transacciones, como una base real."""

    def __init__(self) -> None:
        super().__init__()
        self.access_keys = FakeAccessKeys()
        self.catalogs = FakeCatalogs()
        self.terms = FakeTerms(self.catalogs)
        self.matches = FakeMatches(self.terms)
        self.softland = FakeSoftland()
        self.sync_runs = FakeSyncRuns()

    def factory(self, principal=None) -> FakeAppUnitOfWork:
        return self
