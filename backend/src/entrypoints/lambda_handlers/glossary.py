"""Handlers HTTP de los términos (consulta pública y administración de Procesos)."""

from __future__ import annotations

from entrypoints.lambda_handlers import container
from entrypoints.lambda_handlers.http_adapter import HttpRequest, api_handler, created


def _key(request: HttpRequest) -> str | None:
    return request.headers.get("authorization")


@api_handler
def list_terms_handler(request: HttpRequest):
    return container.list_terms().execute()


@api_handler
def list_admin_terms_handler(request: HttpRequest):
    return container.list_admin_terms().execute(_key(request))


@api_handler
def create_term_handler(request: HttpRequest):
    return created(container.create_term().execute(_key(request), request.json_body()))


@api_handler
def update_term_handler(request: HttpRequest):
    return container.update_term().execute(_key(request), request.path_param("termId"), request.json_body())


@api_handler
def delete_term_handler(request: HttpRequest):
    return container.delete_term().execute(_key(request), request.path_param("termId"))


@api_handler
def restore_term_handler(request: HttpRequest):
    return container.restore_term().execute(_key(request), request.path_param("termId"))
