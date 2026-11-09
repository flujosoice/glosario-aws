"""Handlers HTTP de la ingesta de n8n, la bitácora y el job que vence cargas abandonadas."""

from __future__ import annotations

from typing import Any

from entrypoints.lambda_handlers import container
from entrypoints.lambda_handlers.http_adapter import HttpRequest, api_handler, created
from shared.logging import get_logger

_logger = get_logger("sync")


def _key(request: HttpRequest) -> str | None:
    return request.headers.get("authorization")


@api_handler
def list_sync_runs_handler(request: HttpRequest):
    return container.list_sync_runs().execute(
        _key(request), request.query_str("origen"), request.query_int("limit")
    )


@api_handler
def start_sync_run_handler(request: HttpRequest):
    return created(container.start_sync_run().execute(_key(request), request.json_body()))


@api_handler
def append_sync_rows_handler(request: HttpRequest):
    return container.append_sync_rows().execute(
        _key(request), request.path_param("runId"), request.json_body()
    )


@api_handler
def complete_sync_run_handler(request: HttpRequest):
    return container.complete_sync_run().execute(_key(request), request.path_param("runId"))


@api_handler
def fail_sync_run_handler(request: HttpRequest):
    body = request.json() if request.raw_body else None
    return container.fail_sync_run().execute(
        _key(request), request.path_param("runId"), body if isinstance(body, dict) else None
    )


def expire_stale_sync_runs_handler(event: dict[str, Any], context: Any = None) -> dict[str, int]:
    expired = container.expire_stale_sync_runs().execute()
    _logger.info("expired stale sync runs", extra={"expired": expired})
    return {"expired": expired}
