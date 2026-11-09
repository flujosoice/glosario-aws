"""Handlers HTTP de la revisión del Diccionario de Softland."""

from __future__ import annotations

from entrypoints.lambda_handlers import container
from entrypoints.lambda_handlers.http_adapter import HttpRequest, api_handler


def _key(request: HttpRequest) -> str | None:
    return request.headers.get("authorization")


@api_handler
def list_dictionary_matches_handler(request: HttpRequest):
    return container.list_dictionary_matches().execute(_key(request))


@api_handler
def apply_dictionary_match_handler(request: HttpRequest):
    return container.apply_dictionary_match().execute(
        _key(request), request.path_param("matchId"), request.json_body()
    )


@api_handler
def discard_dictionary_match_handler(request: HttpRequest):
    return container.discard_dictionary_match().execute(_key(request), request.path_param("matchId"))


@api_handler
def reopen_dictionary_match_handler(request: HttpRequest):
    return container.reopen_dictionary_match().execute(_key(request), request.path_param("matchId"))


@api_handler
def search_softland_dictionary_handler(request: HttpRequest):
    return container.search_softland_dictionary().execute(
        _key(request), request.query_str("q"), request.query_int("limit")
    )
