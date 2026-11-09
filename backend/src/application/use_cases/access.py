"""Acceso a la administración: el enlace de Procesos trae una llave; el general no."""

from __future__ import annotations

import logging
from typing import Any

from application.ports.app_unit_of_work import UnitOfWorkFactory
from application.use_cases.common import find_grant
from domain.entities.access import AccessPurpose

_logger = logging.getLogger(__name__)


class GetAccessUseCase:
    """GET /me: indica si la llave enviada abre la sección Administración · Procesos."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            grant = find_grant(uow, authorization)
        can_admin = grant is not None and grant.purpose is AccessPurpose.ADMIN
        return {"puedeAdministrar": can_admin, "etiqueta": grant.label if can_admin else None}


class GetHealthUseCase:
    """GET /health: abrir la transacción ya consulta Aurora (contexto de sesión), así se verifica la base."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self) -> dict[str, Any]:
        try:
            with self._uow_factory(None):
                pass
        except Exception:  # el detalle va al log, nunca a la respuesta pública
            _logger.exception("health check: la base de datos no responde")
            return {"estado": "degradado", "baseDeDatos": "sin conexión"}
        return {"estado": "ok", "baseDeDatos": "ok"}
