"""Handlers HTTP del acceso (¿la llave del enlace abre la Administración?) y del health check."""

from __future__ import annotations

from entrypoints.lambda_handlers import container
from entrypoints.lambda_handlers.http_adapter import HttpRequest, HttpResponse, api_handler


@api_handler
def get_access_handler(request: HttpRequest):
    return container.get_access().execute(request.headers.get("authorization"))


@api_handler
def get_health_handler(request: HttpRequest):
    health = container.get_health().execute()
    return HttpResponse(200 if health["estado"] == "ok" else 503, health)
