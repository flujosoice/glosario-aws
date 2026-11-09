"""Ingesta de n8n por cargas (iniciar → lotes → completar o fallar) y bitácora de sincronizaciones."""

from __future__ import annotations

from collections.abc import Callable
from datetime import UTC, datetime, timedelta
from typing import Any

from application.ports.app_unit_of_work import AppUnitOfWork, UnitOfWorkFactory
from application.use_cases.common import parse_limit, parse_uuid, require_grant, require_ingest
from domain.entities.access import AccessPurpose
from domain.entities.sync import (
    STALE_AFTER_HOURS,
    SyncRun,
    SyncSource,
    SyncStatus,
    parse_expected_rows,
    parse_rows,
)
from domain.exceptions import BusinessRuleViolation, ConflictError, NotFoundError

RUN_NOT_FOUND = "La carga no existe."
MAX_ERROR_LENGTH = 2000


def require_running(uow: AppUnitOfWork, raw_run_id: str) -> SyncRun:
    run = uow.sync_runs.get(parse_uuid(raw_run_id, "runId", missing=RUN_NOT_FOUND))
    if run is None:
        raise NotFoundError(RUN_NOT_FOUND)
    if run.estado is not SyncStatus.RUNNING:
        raise BusinessRuleViolation(f"La carga ya está {run.estado.value}; inicia una nueva.")
    return run


class StartSyncRunUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, body: dict[str, Any]) -> dict[str, Any]:
        source = SyncSource.parse(body.get("origen"))
        expected = parse_expected_rows(body.get("filasEsperadas"))
        with self._uow_factory(None) as uow:
            grant = require_ingest(uow, authorization)
            running = uow.sync_runs.find_running(source)
            if running is not None:
                raise ConflictError(
                    "Ya hay una carga en curso de este origen. Complétala o márcala como fallida.",
                    details={"runId": str(running.id)},
                )
            run = uow.sync_runs.start(source, expected, grant.label)
            uow.commit()
        return run.to_dict()


class AppendSyncRowsUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_run_id: str, body: dict[str, Any]) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            require_ingest(uow, authorization)
            run = require_running(uow, raw_run_id)
            rows = parse_rows(run.origen, body.get("filas"))
            if run.filas_esperadas is not None and run.filas_recibidas + len(rows) > run.filas_esperadas:
                raise BusinessRuleViolation(
                    "El lote supera las filas esperadas de la carga.",
                    details={"filasEsperadas": run.filas_esperadas, "filasRecibidas": run.filas_recibidas},
                )
            total = uow.sync_runs.add_rows(run, rows)
            uow.commit()
        return {"runId": str(run.id), "filasRecibidas": total}


class CompleteSyncRunUseCase:
    """La carga pasa a ser la vigente en una transacción; si algo falla, lo vigente no cambia."""

    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(self, authorization: str | None, raw_run_id: str) -> dict[str, Any]:
        with self._uow_factory(None) as uow:
            require_ingest(uow, authorization)
            run = require_running(uow, raw_run_id)
            if run.filas_recibidas == 0:
                raise BusinessRuleViolation("La carga no tiene filas.")
            if run.filas_esperadas is not None and run.filas_recibidas != run.filas_esperadas:
                raise BusinessRuleViolation(
                    "La carga está incompleta.",
                    details={"filasEsperadas": run.filas_esperadas, "filasRecibidas": run.filas_recibidas},
                )
            completed = uow.sync_runs.complete(run.id)
            uow.commit()
        return completed.to_dict()


class FailSyncRunUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(
        self, authorization: str | None, raw_run_id: str, body: dict[str, Any] | None
    ) -> dict[str, Any]:
        reason = str((body or {}).get("error") or "").strip()[:MAX_ERROR_LENGTH] or "Cancelada por n8n."
        with self._uow_factory(None) as uow:
            require_ingest(uow, authorization)
            run = require_running(uow, raw_run_id)
            failed = uow.sync_runs.fail(run.id, reason)
            uow.commit()
        return failed.to_dict()


class ListSyncRunsUseCase:
    def __init__(self, uow_factory: UnitOfWorkFactory) -> None:
        self._uow_factory = uow_factory

    def execute(
        self, authorization: str | None, raw_source: str | None, limit: int | None
    ) -> list[dict[str, Any]]:
        source = SyncSource.parse(raw_source) if raw_source else None
        size = parse_limit(limit, default=20, maximum=100)
        with self._uow_factory(None) as uow:
            require_grant(uow, authorization, AccessPurpose.ADMIN, AccessPurpose.INGEST)
            return [r.to_dict() for r in uow.sync_runs.list_recent(source, size)]


class ExpireStaleSyncRunsUseCase:
    """Job horario: una carga que n8n dejó a medias no bloquea la siguiente."""

    def __init__(self, uow_factory: UnitOfWorkFactory, clock: Callable[[], datetime] | None = None) -> None:
        self._uow_factory = uow_factory
        self._clock = clock or (lambda: datetime.now(UTC))

    def execute(self) -> int:
        cutoff = self._clock() - timedelta(hours=STALE_AFTER_HOURS)
        with self._uow_factory(None) as uow:
            expired = uow.sync_runs.expire_running(
                cutoff, f"La carga no se completó en {STALE_AFTER_HOURS} horas."
            )
            uow.commit()
        return expired
