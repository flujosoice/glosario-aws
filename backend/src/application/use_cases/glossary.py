"""Casos de uso de los términos: consulta pública y administración de Procesos."""

from __future__ import annotations

from typing import Any
from uuid import UUID

from application.ports.app_unit_of_work import AppUnitOfWork, UnitOfWorkFactory
from application.use_cases.common import parse_uuid, require_admin
from domain.entities.term import TermDraft, TermView, audit_changes, content_changed, parse_term_draft
from domain.exceptions import NotFoundError, ValidationError

TERM_NOT_FOUND = "El término no existe."


def catalog_ids(
    uow: AppUnitOfWork, tags: tuple[str, ...], masters: tuple[str, ...]
) -> tuple[list[int], list[int]]:
    """Ids de las etiquetas y maestros del formulario; un nombre desconocido es un error de datos."""
    found_tags = uow.catalogs.tags_by_name(tags)
    found_masters = uow.catalogs.masters_by_name(masters)
    for name in tags:
        if name.lower() not in found_tags:
            raise ValidationError(f"La etiqueta '{name}' no existe.", details={"field": "etiquetas"})
    for name in masters:
        if name.lower() not in found_masters:
            raise ValidationError(f"El maestro '{name}' no existe.", details={"field": "maestros"})
    return [found_tags[n.lower()].id for n in tags], [found_masters[n.lower()].id for n in masters]


def require_term(uow: AppUnitOfWork, term_id: UUID) -> TermView:
    term = uow.terms.get(term_id)
    if term is None:
        raise NotFoundError(TERM_NOT_FOUND)
    return term


class ListTermsUseCase:
    """Enlace general: solo términos activos y sin datos de administración."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self) -> list[dict[str, Any]]:
        with self._uow_factory(None) as uow:
            return [t.public_dict() for t in uow.terms.list_all(include_deleted=False)]


class ListAdminTermsUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None) -> list[dict[str, Any]]:
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            return [t.admin_dict() for t in uow.terms.list_all(include_deleted=True)]


class CreateTermUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, body: dict[str, Any]) -> dict[str, Any]:
        draft = parse_term_draft(body)
        with self._uow_factory(None) as uow:
            grant = require_admin(uow, authorization)
            tag_ids, master_ids = catalog_ids(uow, draft.etiquetas, draft.maestros)
            term_id = uow.terms.create(draft, tag_ids, master_ids)
            uow.terms.add_audit(term_id, "crear", audit_changes(None, draft), grant.label)
            created = require_term(uow, term_id)
            uow.commit()
        return created.admin_dict()


class UpdateTermUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_term_id: str, body: dict[str, Any]) -> dict[str, Any]:
        term_id = parse_uuid(raw_term_id, "termId", missing=TERM_NOT_FOUND)
        draft: TermDraft = parse_term_draft(body)
        with self._uow_factory(None) as uow:
            grant = require_admin(uow, authorization)
            current = require_term(uow, term_id)
            tag_ids, master_ids = catalog_ids(uow, draft.etiquetas, draft.maestros)
            uow.terms.update(
                term_id,
                draft,
                tag_ids,
                master_ids,
                edited=current.editado or content_changed(current, draft),
                keep_fragments=current.definicion == draft.definicion,
            )
            changes = audit_changes(current, draft)
            if changes:
                uow.terms.add_audit(term_id, "editar", changes, grant.label)
            updated = require_term(uow, term_id)
            uow.commit()
        return updated.admin_dict()


class _SetDeletedUseCase:
    deleted: bool
    action: str

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_term_id: str) -> dict[str, Any]:
        term_id = parse_uuid(raw_term_id, "termId", missing=TERM_NOT_FOUND)
        with self._uow_factory(None) as uow:
            grant = require_admin(uow, authorization)
            current = require_term(uow, term_id)
            if current.eliminado != self.deleted:
                uow.terms.set_deleted(term_id, self.deleted)
                uow.terms.add_audit(
                    term_id,
                    self.action,
                    [("eliminado", str(current.eliminado).lower(), str(self.deleted).lower())],
                    grant.label,
                )
            result = require_term(uow, term_id)
            uow.commit()
        return result.admin_dict()


class DeleteTermUseCase(_SetDeletedUseCase):
    """Borrado lógico: el término deja de verse en el enlace general y puede restaurarse."""

    deleted = True
    action = "eliminar"


class RestoreTermUseCase(_SetDeletedUseCase):
    deleted = False
    action = "restaurar"
