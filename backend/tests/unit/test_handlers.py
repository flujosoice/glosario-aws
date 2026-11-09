"""Handlers HTTP de punta a punta (evento API Gateway → container → caso de uso) sobre el fake."""

import json
from uuid import uuid4

import pytest

from entrypoints.lambda_handlers import access, catalogs, container, dictionary, glossary, sync
from fakes.fake_app_unit_of_work import ADMIN_KEY, INGEST_KEY, FakeAppUnitOfWork, auth

ORIGIN = "https://glosario.mayoreo.biz"
TERM_ID = str(uuid4())


@pytest.fixture(autouse=True)
def fake_uow(monkeypatch):
    from shared import settings

    monkeypatch.setenv("ALLOWED_ORIGINS", ORIGIN)
    settings.get_settings.cache_clear()
    uow = FakeAppUnitOfWork()
    monkeypatch.setattr(container, "uow_factory", uow.factory)
    yield uow
    settings.get_settings.cache_clear()


def _event(method="GET", key=None, path_params=None, query=None, body=None):
    headers = {"Origin": ORIGIN}
    if key:
        headers["Authorization"] = auth(key)
    return {
        "httpMethod": method,
        "path": "/",
        "resource": "/",
        "pathParameters": path_params,
        "queryStringParameters": query,
        "headers": headers,
        "body": None if body is None else json.dumps(body),
        "requestContext": {"requestId": "req-test"},
    }


def _call(handler, **kwargs):
    response = handler(_event(**kwargs))
    return response["statusCode"], json.loads(response["body"]) if response["body"] else None


def test_public_reads_answer_without_key():
    status, body = _call(glossary.list_terms_handler)
    assert status == 200
    status, _ = _call(catalogs.get_catalogs_handler)
    assert status == 200
    assert _call(access.get_access_handler) == (200, {"puedeAdministrar": False, "etiqueta": None})


def test_health_is_200_when_the_database_answers_and_503_when_not(monkeypatch):
    assert _call(access.get_health_handler) == (200, {"estado": "ok", "baseDeDatos": "ok"})

    def unreachable(principal=None):
        raise ConnectionError("sin red hacia Aurora")

    monkeypatch.setattr(container, "uow_factory", unreachable)
    assert _call(access.get_health_handler) == (503, {"estado": "degradado", "baseDeDatos": "sin conexión"})


@pytest.mark.parametrize(
    ("handler", "kwargs"),
    [
        (glossary.list_admin_terms_handler, {}),
        (glossary.create_term_handler, {"method": "POST", "body": {"nombre": "x"}}),
        (glossary.update_term_handler, {"method": "PUT", "path_params": {"termId": TERM_ID}, "body": {}}),
        (glossary.delete_term_handler, {"method": "DELETE", "path_params": {"termId": TERM_ID}}),
        (glossary.restore_term_handler, {"method": "POST", "path_params": {"termId": TERM_ID}}),
        (catalogs.create_tag_handler, {"method": "POST", "body": {"nombre": "x"}}),
        (catalogs.delete_tag_handler, {"method": "DELETE", "path_params": {"tagId": "1"}}),
        (catalogs.create_master_handler, {"method": "POST", "body": {"nombre": "x"}}),
        (catalogs.delete_master_handler, {"method": "DELETE", "path_params": {"masterId": "1"}}),
        (dictionary.list_dictionary_matches_handler, {}),
        (
            dictionary.apply_dictionary_match_handler,
            {"method": "POST", "path_params": {"matchId": "m"}, "body": {}},
        ),
        (dictionary.discard_dictionary_match_handler, {"method": "POST", "path_params": {"matchId": "m"}}),
        (dictionary.reopen_dictionary_match_handler, {"method": "POST", "path_params": {"matchId": "m"}}),
        (dictionary.search_softland_dictionary_handler, {"query": {"q": "cliente"}}),
        (sync.list_sync_runs_handler, {}),
        (sync.start_sync_run_handler, {"method": "POST", "body": {"origen": "x"}}),
        (sync.append_sync_rows_handler, {"method": "POST", "path_params": {"runId": "r"}, "body": {}}),
        (sync.complete_sync_run_handler, {"method": "POST", "path_params": {"runId": "r"}}),
        (sync.fail_sync_run_handler, {"method": "POST", "path_params": {"runId": "r"}}),
    ],
)
def test_protected_endpoints_reject_requests_without_key(fake_uow, handler, kwargs):
    # Algunos casos de uso validan el cuerpo antes que la llave (400); en ningún caso se escribe nada.
    before = (len(fake_uow.terms.rows), len(fake_uow.catalogs.tags), len(fake_uow.sync_runs.runs))
    status, body = _call(handler, **kwargs)
    assert status in (400, 401)
    assert body["error"]["code"]
    assert (len(fake_uow.terms.rows), len(fake_uow.catalogs.tags), len(fake_uow.sync_runs.runs)) == before


def test_admin_key_reads_administration_and_ingest_key_is_forbidden_there():
    status, _ = _call(glossary.list_admin_terms_handler, key=ADMIN_KEY)
    assert status == 200
    status, _ = _call(dictionary.list_dictionary_matches_handler, key=ADMIN_KEY)
    assert status == 200
    status, _ = _call(dictionary.search_softland_dictionary_handler, key=ADMIN_KEY, query={"q": "cliente"})
    assert status == 200
    status, _ = _call(sync.list_sync_runs_handler, key=INGEST_KEY, query={"limit": "5"})
    assert status == 200
    status, _ = _call(glossary.list_admin_terms_handler, key=INGEST_KEY)
    assert status == 403


def test_expire_stale_sync_runs_job_reports_how_many_expired():
    assert sync.expire_stale_sync_runs_handler({}, None) == {"expired": 0}
