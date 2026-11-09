from datetime import UTC, datetime, timedelta
from uuid import uuid4

import pytest

from application.use_cases.sync import (
    AppendSyncRowsUseCase,
    CompleteSyncRunUseCase,
    ExpireStaleSyncRunsUseCase,
    FailSyncRunUseCase,
    ListSyncRunsUseCase,
    StartSyncRunUseCase,
)
from domain.entities.sync import parse_bool, parse_dictionary_row, parse_master_row
from domain.exceptions import (
    BusinessRuleViolation,
    ConflictError,
    ForbiddenError,
    NotFoundError,
    ValidationError,
)
from fakes.fake_app_unit_of_work import ADMIN_KEY, INGEST_KEY, FakeAppUnitOfWork, auth

KEY = auth(INGEST_KEY)
SHEET_ROW = {
    "Grupo": "General",
    "Atributo": "Código",
    "Nombre técnico": "ARTICULO",
    "Definición ": "Id",
    "Obligatorio": "True",
    "Softland ERP": True,
    "eFlow": "False",
    "PowerBI": "TRUE",
    "row_number": 2,
}
DICT_ROW = {
    "Esquema": "CIA",
    "Módulo": "CI",
    "Tabla": "ARTICULO",
    "Columna": "CLASIFICACION_1",
    "Nulidad": "Si",
    "Llave Primaria": "No",
    "Valor etiqueta": "Clasificación 1",
    "Sólo lectura": "No",
    "Tamaño": 12,
}


def test_row_parsers_accept_original_headers():
    row = parse_master_row(SHEET_ROW, 0)
    assert row["nombre_tecnico"] == "ARTICULO" and row["definicion"] == "Id" and row["fila"] == 2
    assert row["obligatorio"] is True and row["sistemas"] == ["Softland ERP", "PowerBI"]
    entry = parse_dictionary_row(DICT_ROW, 0)
    assert (
        entry["modulo"] == "CI" and entry["valor_etiqueta"] == "Clasificación 1" and entry["tamano"] == "12"
    )
    assert (
        entry["permite_nulos"] is True and entry["llave_primaria"] is False and entry["solo_lectura"] is False
    )
    assert parse_bool("Sí") is True and parse_bool("") is None
    with pytest.raises(ValidationError):
        parse_dictionary_row({"Tabla": "X"}, 3)


def test_full_load_replaces_current_version():
    uow = FakeAppUnitOfWork()
    start, append, complete = (
        StartSyncRunUseCase(uow.factory),
        AppendSyncRowsUseCase(uow.factory),
        CompleteSyncRunUseCase(uow.factory),
    )
    first = start.execute(KEY, {"origen": "maestro_articulos", "filasEsperadas": 2})
    assert append.execute(KEY, str(first["id"]), {"filas": [SHEET_ROW]})["filasRecibidas"] == 1
    with pytest.raises(BusinessRuleViolation, match="incompleta"):
        complete.execute(KEY, str(first["id"]))
    append.execute(KEY, str(first["id"]), {"filas": [SHEET_ROW]})
    assert complete.execute(KEY, str(first["id"]))["esVigente"] is True
    second = start.execute(KEY, {"origen": "maestro_articulos"})
    append.execute(KEY, str(second["id"]), {"filas": [SHEET_ROW]})
    complete.execute(KEY, str(second["id"]))
    assert uow.sync_runs.runs[first["id"]].es_vigente is False and uow.sync_runs.rows[first["id"]] == []
    with pytest.raises(BusinessRuleViolation):
        append.execute(KEY, str(second["id"]), {"filas": [SHEET_ROW]})


def test_start_rules_and_keys():
    uow = FakeAppUnitOfWork()
    start = StartSyncRunUseCase(uow.factory)
    start.execute(KEY, {"origen": "diccionario_softland"})
    with pytest.raises(ConflictError):
        start.execute(KEY, {"origen": "diccionario_softland"})
    with pytest.raises(ValidationError):
        start.execute(KEY, {"origen": "otro"})
    with pytest.raises(ForbiddenError):
        start.execute(auth(ADMIN_KEY), {"origen": "maestro_clientes"})


def test_append_validates_batch_and_expected_rows():
    uow = FakeAppUnitOfWork()
    run = StartSyncRunUseCase(uow.factory).execute(
        KEY, {"origen": "diccionario_softland", "filasEsperadas": 1}
    )
    append = AppendSyncRowsUseCase(uow.factory)
    with pytest.raises(ValidationError):
        append.execute(KEY, str(run["id"]), {"filas": []})
    with pytest.raises(BusinessRuleViolation):
        append.execute(KEY, str(run["id"]), {"filas": [DICT_ROW, DICT_ROW]})
    with pytest.raises(NotFoundError):
        append.execute(KEY, str(uuid4()), {"filas": [DICT_ROW]})
    with pytest.raises(BusinessRuleViolation, match="no tiene filas"):
        CompleteSyncRunUseCase(uow.factory).execute(KEY, str(run["id"]))


def test_fail_list_and_expire():
    uow = FakeAppUnitOfWork()
    run = StartSyncRunUseCase(uow.factory).execute(KEY, {"origen": "maestro_clientes"})
    failed = FailSyncRunUseCase(uow.factory).execute(KEY, str(run["id"]), {"error": "Hoja vacía"})
    assert failed["estado"] == "fallida" and failed["error"] == "Hoja vacía"
    stale = StartSyncRunUseCase(uow.factory).execute(KEY, {"origen": "maestro_clientes"})
    later = lambda: datetime.now(UTC) + timedelta(hours=3)  # noqa: E731
    assert ExpireStaleSyncRunsUseCase(uow.factory, clock=later).execute() == 1
    assert uow.sync_runs.runs[stale["id"]].estado.value == "fallida"
    runs = ListSyncRunsUseCase(uow.factory).execute(auth(ADMIN_KEY), "maestro_clientes", None)
    assert len(runs) == 2
    assert ListSyncRunsUseCase(uow.factory).execute(KEY, None, 1)[0]["origen"] == "maestro_clientes"
