"""Handlers HTTP de etiquetas y maestros."""

from __future__ import annotations

from entrypoints.lambda_handlers import container
from entrypoints.lambda_handlers.http_adapter import HttpRequest, api_handler, created


def _key(request: HttpRequest) -> str | None:
    return request.headers.get("authorization")


@api_handler
def get_catalogs_handler(request: HttpRequest):
    return container.get_catalogs().execute()


@api_handler
def create_tag_handler(request: HttpRequest):
    return created(container.create_tag().execute(_key(request), request.json_body()))


@api_handler
def delete_tag_handler(request: HttpRequest):
    container.delete_tag().execute(_key(request), request.path_param("tagId"))


@api_handler
def create_master_handler(request: HttpRequest):
    return created(container.create_master().execute(_key(request), request.json_body()))


@api_handler
def delete_master_handler(request: HttpRequest):
    container.delete_master().execute(_key(request), request.path_param("masterId"))
