"""Casos de uso de etiquetas y maestros (pestañas Etiquetas y Maestros de Administración)."""

from __future__ import annotations

from typing import Any

from application.ports.app_unit_of_work import UnitOfWorkFactory
from application.use_cases.common import parse_id, require_admin
from domain.entities.catalog import MAX_MASTER_LENGTH, MAX_TAG_LENGTH, TagType, normalize_name
from domain.exceptions import BusinessRuleViolation, ConflictError, NotFoundError

TAG_NOT_FOUND = "La etiqueta no existe."
MASTER_NOT_FOUND = "El maestro no existe."


class GetCatalogsUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            return {
                "etiquetas": [t.to_dict() for t in uow.catalogs.list_tags()],
                "maestros": [m.to_dict() for m in uow.catalogs.list_masters()],
            }


class CreateTagUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, body: dict[str, Any]) -> dict[str, Any]:
        nombre = normalize_name(body.get("nombre"), "nombre", MAX_TAG_LENGTH)
        tipo = TagType.parse(body.get("tipo"))
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            if uow.catalogs.tags_by_name((nombre,)):
                raise ConflictError("Ya existe una etiqueta con ese nombre.")
            tag = uow.catalogs.create_tag(nombre, tipo)
            uow.commit()
        return tag.to_dict()


class DeleteTagUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_tag_id: str) -> None:
        tag_id = parse_id(raw_tag_id, "tagId", missing=TAG_NOT_FOUND)
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            tag = uow.catalogs.find_tag(tag_id)
            if tag is None:
                raise NotFoundError(TAG_NOT_FOUND)
            if tag.es_base:
                raise BusinessRuleViolation("Las etiquetas base no se pueden eliminar.")
            uow.catalogs.delete_tag(tag_id)
            uow.commit()


class CreateMasterUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, body: dict[str, Any]) -> dict[str, Any]:
        nombre = normalize_name(body.get("nombre"), "nombre", MAX_MASTER_LENGTH)
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            if uow.catalogs.masters_by_name((nombre,)):
                raise ConflictError("Ya existe un maestro con ese nombre.")
            master = uow.catalogs.create_master(nombre)
            uow.commit()
        return master.to_dict()


class DeleteMasterUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_master_id: str) -> None:
        master_id = parse_id(raw_master_id, "masterId", missing=MASTER_NOT_FOUND)
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            master = uow.catalogs.find_master(master_id)
            if master is None:
                raise NotFoundError(MASTER_NOT_FOUND)
            if master.es_base:
                raise BusinessRuleViolation("Artículo y Cliente son maestros base y no se pueden eliminar.")
            if uow.catalogs.count_master_terms(master_id):
                raise BusinessRuleViolation("No se puede eliminar: el maestro tiene términos asignados.")
            uow.catalogs.delete_master(master_id)
            uow.commit()
