"""Revisión de coincidencias con el Diccionario de Softland (nada se aplica sin Procesos)."""

from __future__ import annotations

import re
from dataclasses import replace
from typing import Any

from application.ports.app_unit_of_work import AppUnitOfWork, UnitOfWorkFactory
from application.use_cases.common import parse_limit, require_admin
from application.use_cases.glossary import require_term
from domain.entities.dictionary import DictionaryMatch, MatchStatus, normalize_search, parse_choice
from domain.entities.term import BdField, TermDraft, audit_changes
from domain.exceptions import BusinessRuleViolation, NotFoundError

MATCH_NOT_FOUND = "La coincidencia no existe."
_MATCH_ID = re.compile(r"^s[0-9]{3,}$")


def require_match(uow: AppUnitOfWork, raw_match_id: str) -> DictionaryMatch:
    match = uow.matches.get(raw_match_id) if _MATCH_ID.match(str(raw_match_id)) else None
    if match is None:
        raise NotFoundError(MATCH_NOT_FOUND)
    return match


def require_pending(match: DictionaryMatch) -> None:
    if match.estado is not MatchStatus.PENDING:
        raise BusinessRuleViolation(
            "La coincidencia ya fue decidida. Vuelve a ponerla en pendiente para cambiarla."
        )


class ListDictionaryMatchesUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None) -> list[dict[str, Any]]:
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            return [m.to_dict() for m in uow.matches.list_all()]


class ApplyDictionaryMatchUseCase:
    """Escribe Campo BD, Campo Softland y Maestro en el término y marca la coincidencia: una transacción."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_match_id: str, body: dict[str, Any]) -> dict[str, Any]:
        choice = parse_choice(body)
        with self._uow_factory(None) as uow:
            grant = require_admin(uow, authorization)
            match = require_match(uow, raw_match_id)
            require_pending(match)
            term = require_term(uow, match.termino_id)
            master_names = list(term.maestros)
            if choice.maestro:
                existing = uow.catalogs.masters_by_name((choice.maestro,)).get(choice.maestro.lower())
                master = existing or uow.catalogs.create_master(choice.maestro)
                choice = replace(choice, maestro=master.nombre)
                if master.nombre.lower() not in {n.lower() for n in master_names}:
                    master_names.append(master.nombre)
            masters = uow.catalogs.masters_by_name(tuple(master_names))
            fields = (BdField(choice.columna),)
            uow.terms.set_fields(
                term.id, fields, choice.etiqueta, [masters[n.lower()].id for n in master_names]
            )
            draft = TermDraft(
                term.termino, term.definicion, term.etiquetas, fields, choice.etiqueta, tuple(master_names)
            )
            uow.terms.add_audit(term.id, "aplicar_coincidencia", audit_changes(term, draft), grant.label)
            uow.matches.mark_applied(match.id, choice, grant.label)
            result = {
                "coincidencia": require_match(uow, match.id).to_dict(),
                "termino": require_term(uow, term.id).admin_dict(),
            }
            uow.commit()
        return result


class DiscardDictionaryMatchUseCase:
    """Descartar no toca el término."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_match_id: str) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            grant = require_admin(uow, authorization)
            match = require_match(uow, raw_match_id)
            require_pending(match)
            uow.matches.mark_discarded(match.id, grant.label)
            result = require_match(uow, match.id).to_dict()
            uow.commit()
        return result


class ReopenDictionaryMatchUseCase:
    """Volver a pendiente: no borra lo que ya se aplicó al término."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_match_id: str) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            match = require_match(uow, raw_match_id)
            if match.estado is not MatchStatus.PENDING:
                uow.matches.reopen(match.id)
            result = require_match(uow, match.id).to_dict()
            uow.commit()
        return result


class SearchSoftlandDictionaryUseCase:
    """Busca más columnas candidatas en la carga vigente del Diccionario de Softland en Aurora."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(
        self, authorization: str | None, raw_text: str | None, limit: int | None
    ) -> list[dict[str, Any]]:
        text = normalize_search(raw_text)
        size = parse_limit(limit, default=20, maximum=50)
        with self._uow_factory(None) as uow:
            require_admin(uow, authorization)
            return [o.to_dict() for o in uow.softland.search(text, size)]
