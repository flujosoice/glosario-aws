"""Adapter PostgreSQL de las cargas de n8n (tbl_sincronizaciones y las tablas de filas de cada origen)."""

from __future__ import annotations

from datetime import datetime
from typing import Any
from uuid import UUID

import psycopg

from application.ports.glossary import SyncRunRepository
from domain.entities.sync import (
    DICTIONARY_BOOL_FIELDS,
    DICTIONARY_TEXT_FIELDS,
    MASTER_TEXT_FIELDS,
    SyncRun,
    SyncSource,
    SyncStatus,
)

_RUN_COLS = """id, origen::text AS origen, estado::text AS estado, es_vigente, filas_esperadas,
filas_recibidas,
iniciada_por, iniciada_en, finalizada_en, error"""
_START_SQL = f"""
INSERT INTO tbl_sincronizaciones (origen, filas_esperadas, iniciada_por)
VALUES (%s::origen_sincronizacion, %s, %s) RETURNING {_RUN_COLS}
"""
_GET_SQL = f"SELECT {_RUN_COLS} FROM tbl_sincronizaciones WHERE id = %s FOR UPDATE"
_RUNNING_SQL = f"""
SELECT {_RUN_COLS} FROM tbl_sincronizaciones WHERE origen = %s::origen_sincronizacion AND estado = 'en_curso'
ORDER BY iniciada_en DESC LIMIT 1
"""
_ADD_COUNT_SQL = """
UPDATE tbl_sincronizaciones SET filas_recibidas = filas_recibidas + %s WHERE id = %s
RETURNING filas_recibidas
"""
_MASTER_COLS = ("fila", *MASTER_TEXT_FIELDS, "obligatorio", "sistemas")
_DICTIONARY_COLS = (*DICTIONARY_TEXT_FIELDS, *DICTIONARY_BOOL_FIELDS)
_INSERT_MASTER_SQL = (
    f"INSERT INTO tbl_atributos_maestro (sincronizacion_id, {', '.join(_MASTER_COLS)}) "
    f"VALUES (%s, {', '.join(['%s'] * len(_MASTER_COLS))})"
)
_INSERT_DICTIONARY_SQL = (
    f"INSERT INTO tbl_diccionario_softland (sincronizacion_id, {', '.join(_DICTIONARY_COLS)}) "
    f"VALUES (%s, {', '.join(['%s'] * len(_DICTIONARY_COLS))})"
)
_PREVIOUS_SQL = """
SELECT id FROM tbl_sincronizaciones WHERE origen = %s::origen_sincronizacion AND es_vigente FOR UPDATE
"""
_UNSET_VIGENTE_SQL = "UPDATE tbl_sincronizaciones SET es_vigente = false WHERE id = %s"
_COMPLETE_SQL = f"""
UPDATE tbl_sincronizaciones SET estado = 'completada', es_vigente = true, finalizada_en = now(), error = NULL
WHERE id = %s RETURNING {_RUN_COLS}
"""
_FAIL_SQL = f"""
UPDATE tbl_sincronizaciones SET estado = 'fallida', finalizada_en = now(), error = %s
WHERE id = %s RETURNING {_RUN_COLS}
"""
_DELETE_ROWS_SQL = {
    True: "DELETE FROM tbl_atributos_maestro WHERE sincronizacion_id = %s",
    False: "DELETE FROM tbl_diccionario_softland WHERE sincronizacion_id = %s",
}
_RECENT_SQL = f"""
SELECT {_RUN_COLS} FROM tbl_sincronizaciones
WHERE %(origen)s::origen_sincronizacion IS NULL OR origen = %(origen)s::origen_sincronizacion
ORDER BY iniciada_en DESC LIMIT %(limit)s
"""
_EXPIRE_SQL = """
UPDATE tbl_sincronizaciones SET estado = 'fallida', finalizada_en = now(), error = %s
WHERE estado = 'en_curso' AND iniciada_en < %s RETURNING id, origen::text AS origen
"""


def _run(row: dict[str, Any]) -> SyncRun:
    return SyncRun(
        id=row["id"],
        origen=SyncSource(row["origen"]),
        estado=SyncStatus(row["estado"]),
        es_vigente=row["es_vigente"],
        filas_esperadas=row["filas_esperadas"],
        filas_recibidas=row["filas_recibidas"],
        iniciada_por=row["iniciada_por"],
        iniciada_en=row["iniciada_en"],
        finalizada_en=row["finalizada_en"],
        error=row["error"],
    )


class PostgresSyncRunRepository(SyncRunRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def _fetch_one(self, sql: str, params: tuple) -> dict[str, Any] | None:
        with self._connection.cursor() as cursor:
            cursor.execute(sql, params)
            return cursor.fetchone()

    def start(self, source: SyncSource, expected_rows: int | None, by: str) -> SyncRun:
        return _run(self._fetch_one(_START_SQL, (source.value, expected_rows, by)))

    def get(self, run_id: UUID) -> SyncRun | None:
        row = self._fetch_one(_GET_SQL, (run_id,))
        return _run(row) if row else None

    def find_running(self, source: SyncSource) -> SyncRun | None:
        row = self._fetch_one(_RUNNING_SQL, (source.value,))
        return _run(row) if row else None

    def add_rows(self, run: SyncRun, rows: list[dict[str, Any]]) -> int:
        sql, cols = (
            (_INSERT_MASTER_SQL, _MASTER_COLS)
            if run.origen.is_master
            else (_INSERT_DICTIONARY_SQL, _DICTIONARY_COLS)
        )
        with self._connection.cursor() as cursor:
            cursor.executemany(sql, [(run.id, *(row[c] for c in cols)) for row in rows])
        return int(self._fetch_one(_ADD_COUNT_SQL, (len(rows), run.id))["filas_recibidas"])

    def complete(self, run_id: UUID) -> SyncRun:
        run = self.get(run_id)
        with self._connection.cursor() as cursor:
            cursor.execute(_PREVIOUS_SQL, (run.origen.value,))
            for previous in cursor.fetchall():
                cursor.execute(_UNSET_VIGENTE_SQL, (previous["id"],))
                cursor.execute(_DELETE_ROWS_SQL[run.origen.is_master], (previous["id"],))
        return _run(self._fetch_one(_COMPLETE_SQL, (run_id,)))

    def fail(self, run_id: UUID, error: str) -> SyncRun:
        run = self.get(run_id)
        with self._connection.cursor() as cursor:
            cursor.execute(_DELETE_ROWS_SQL[run.origen.is_master], (run_id,))
        return _run(self._fetch_one(_FAIL_SQL, (error, run_id)))

    def list_recent(self, source: SyncSource | None, limit: int) -> list[SyncRun]:
        with self._connection.cursor() as cursor:
            cursor.execute(_RECENT_SQL, {"origen": source.value if source else None, "limit": limit})
            return [_run(r) for r in cursor.fetchall()]

    def expire_running(self, started_before: datetime, error: str) -> int:
        with self._connection.cursor() as cursor:
            cursor.execute(_EXPIRE_SQL, (error, started_before))
            expired = cursor.fetchall()
            for row in expired:
                cursor.execute(_DELETE_ROWS_SQL[SyncSource(row["origen"]).is_master], (row["id"],))
        return len(expired)
