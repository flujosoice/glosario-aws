"""Repositories contra el esquema Aurora generado (tablas tbl_*, enums y search_path del usuario app)."""

import os
from datetime import UTC, datetime, timedelta
from uuid import uuid4

import pytest

pytestmark = pytest.mark.integration

DATABASE_URL = os.environ.get("TEST_DATABASE_URL")
if not DATABASE_URL:
    pytest.skip("TEST_DATABASE_URL no definida", allow_module_level=True)

import psycopg  # noqa: E402

from domain.entities.access import AccessPurpose, hash_key  # noqa: E402
from domain.entities.catalog import TagType  # noqa: E402
from domain.entities.dictionary import MatchChoice, MatchStatus  # noqa: E402
from domain.entities.sync import SyncSource, SyncStatus, parse_dictionary_row, parse_master_row  # noqa: E402
from domain.entities.term import BdField, TermDraft  # noqa: E402
from domain.exceptions import ConflictError  # noqa: E402
from infrastructure.database.postgresql.app_unit_of_work import AppPostgresUnitOfWork  # noqa: E402
from infrastructure.database.postgresql.connection import (  # noqa: E402
    PostgresConnectionFactory,
    StaticCredentials,
)
from shared.settings import DatabaseSettings  # noqa: E402

SUFFIX = uuid4().hex[:8]


@pytest.fixture(scope="module")
def factory():
    info = psycopg.conninfo.conninfo_to_dict(DATABASE_URL)
    settings = DatabaseSettings(
        secret_name="unused",
        name=info["dbname"],
        host=info.get("host", "localhost"),
        port=int(info.get("port", 5432)),
        sslmode="disable",
        connect_timeout=5,
        schemas=(),
    )
    return PostgresConnectionFactory(settings, StaticCredentials(info["user"], info.get("password", "")))


def uow(factory):
    return AppPostgresUnitOfWork(factory, None, role="service_role")


def test_access_keys_and_catalogs(factory):
    key = f"llave-integracion-{SUFFIX}-0123456789"
    with uow(factory) as u, u.connection.cursor() as cur:
        cur.execute(
            "INSERT INTO tbl_llaves_acceso (proposito, etiqueta, hash_llave) "
            "VALUES ('administracion', %s, %s)",
            (f"Prueba {SUFFIX}", hash_key(key)),
        )
        u.commit()
    with uow(factory) as u:
        grant = u.access_keys.find_active(hash_key(key))
        assert grant.purpose is AccessPurpose.ADMIN
        tag = u.catalogs.create_tag(f"Silo {SUFFIX}", TagType.ORIGIN)
        master = u.catalogs.create_master(f"Maestro {SUFFIX}")
        u.commit()
    with pytest.raises(ConflictError), uow(factory) as u:
        u.catalogs.create_tag(f"SILO {SUFFIX}", TagType.SIM)
    with uow(factory) as u:
        assert u.catalogs.tags_by_name((f"silo {SUFFIX}",))[f"silo {SUFFIX}"].id == tag.id
        assert u.catalogs.find_master(master.id).es_base is False
        assert u.catalogs.count_master_terms(master.id) == 0


def test_term_lifecycle_and_dictionary_match(factory):
    with uow(factory) as u:
        tag = u.catalogs.create_tag(f"Filtro {SUFFIX}", TagType.SIM)
        master = u.catalogs.create_master(f"Proveedor {SUFFIX}")
        draft = TermDraft(
            f"Término {SUFFIX}",
            "Definición",
            (tag.nombre,),
            (BdField("C4", "Cofersa"), BdField("C5", "Beval")),
            "Clase",
            (master.nombre,),
        )
        term_id = u.terms.create(draft, [tag.id], [master.id])
        u.terms.add_audit(term_id, "crear", [("termino", None, draft.termino)], "Prueba")
        with u.connection.cursor() as cur:
            cur.execute("INSERT INTO tbl_definicion_fragmentos VALUES (%s, 0, 'Ctx', 'Texto')", (term_id,))
            cur.execute(
                "INSERT INTO tbl_sugerencias_diccionario (id, termino_id, confianza, estado) "
                "VALUES (%s, %s, 'Alta', 'pendiente')",
                (f"s9{SUFFIX[:4].translate(str.maketrans('abcdef', '123456'))}", term_id),
            )
            cur.execute(
                "INSERT INTO tbl_sugerencia_opciones (sugerencia_id, orden, columna, otras_tablas) "
                "SELECT id, 0, 'COL_X', ARRAY['T2'] FROM tbl_sugerencias_diccionario WHERE termino_id = %s",
                (term_id,),
            )
        u.commit()
    with uow(factory) as u:
        term = u.terms.get(term_id)
        assert term.etiquetas == (tag.nombre,) and term.maestros == (master.nombre,)
        assert [f.aplica_a for f in term.campos_bd] == ["Cofersa", "Beval"]
        assert term.fragmentos[0].texto == "Texto" and term.es_nuevo
        assert u.catalogs.count_master_terms(master.id) == 1
        u.terms.update(term_id, draft, [tag.id], [master.id], edited=True, keep_fragments=False)
        u.terms.set_fields(term_id, (BdField("COL_X"),), "Etiqueta X", [master.id])
        u.terms.set_deleted(term_id, True)
        u.commit()
    with uow(factory) as u:
        term = u.terms.get(term_id)
        assert term.eliminado and term.editado and term.fragmentos == ()
        assert term.campos_bd == (BdField("COL_X"),) and term.campo_softland == "Etiqueta X"
        assert term_id not in {t.id for t in u.terms.list_all(include_deleted=False)}
        assert term_id in {t.id for t in u.terms.list_all(include_deleted=True)}
        match = next(m for m in u.matches.list_all() if m.termino_id == term_id)
        assert match.opciones[0].otras_tablas == ("T2",)
        u.matches.mark_applied(match.id, MatchChoice("COL_X", "T1", "Etiqueta X", master.nombre), "Prueba")
        u.commit()
    with uow(factory) as u:
        assert u.matches.get(match.id).estado is MatchStatus.APPLIED
        u.matches.reopen(match.id)
        u.catalogs.delete_tag(tag.id)
        u.commit()
    with uow(factory) as u:
        assert u.matches.get(match.id).elegido.columna == "COL_X"
        assert u.terms.get(term_id).etiquetas == ()


def test_sync_runs_switch_current_version_and_search(factory):
    row = parse_dictionary_row(
        {
            "Tabla": f"TABLA_{SUFFIX}",
            "Columna": f"COLUMNA_{SUFFIX}",
            "Valor etiqueta": "Etiqueta",
            "Nulidad": "Si",
        },
        0,
    )
    other = {**row, "tabla": f"OTRA_{SUFFIX}"}
    with uow(factory) as u:
        stale = u.sync_runs.find_running(SyncSource.SOFTLAND_DICTIONARY)
        if stale is not None:
            u.sync_runs.fail(stale.id, "limpieza de prueba")
        first = u.sync_runs.start(SyncSource.SOFTLAND_DICTIONARY, 2, "n8n")
        assert u.sync_runs.add_rows(first, [row, other]) == 2
        u.sync_runs.complete(first.id)
        u.commit()
    with uow(factory) as u:
        hits = u.softland.search(f"columna_{SUFFIX}", 10)
        assert {h.tabla for h in hits} == {f"TABLA_{SUFFIX}", f"OTRA_{SUFFIX}"} and hits[0].n_tablas == 2
        second = u.sync_runs.start(SyncSource.SOFTLAND_DICTIONARY, None, "n8n")
        u.sync_runs.add_rows(second, [row])
        done = u.sync_runs.complete(second.id)
        u.commit()
    assert done.es_vigente and done.estado is SyncStatus.COMPLETED
    with uow(factory) as u:
        assert u.sync_runs.get(first.id).es_vigente is False
        assert [h.tabla for h in u.softland.search(f"COLUMNA_{SUFFIX}", 10)] == [f"TABLA_{SUFFIX}"]
        master_run = u.sync_runs.start(SyncSource.MASTER_ITEMS, None, "n8n")
        u.sync_runs.add_rows(
            master_run, [parse_master_row({"Atributo": "Código", "Softland ERP": "True"}, 0)]
        )
        u.commit()
    with uow(factory) as u:
        assert u.sync_runs.expire_running(datetime.now(UTC) + timedelta(minutes=1), "vencida") >= 1
        assert u.sync_runs.get(master_run.id).estado is SyncStatus.FAILED
        assert u.sync_runs.list_recent(SyncSource.MASTER_ITEMS, 5)[0].id == master_run.id
        u.commit()
