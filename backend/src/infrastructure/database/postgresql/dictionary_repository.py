"""Adapters PostgreSQL de coincidencias (tbl_sugerencias_diccionario) y del Diccionario de Softland."""

from __future__ import annotations

import psycopg

from application.ports.glossary import DictionaryMatchRepository, SoftlandDictionaryRepository
from domain.entities.dictionary import DictionaryMatch, MatchChoice, MatchOption, MatchStatus

_MATCH_SELECT = """
SELECT s.id, s.termino_id, t.termino, s.confianza::text AS confianza, s.orden, s.estado::text AS estado,
       s.maestro_sugerido, s.elegido_columna, s.elegido_tabla, s.elegido_etiqueta, s.elegido_maestro,
       s.decidido_en, s.decidido_por,
       COALESCE((SELECT json_agg(json_build_object(
                   'columna', o.columna, 'etiqueta', o.etiqueta, 'tabla', o.tabla, 'modulo', o.modulo,
                   'descripcion', o.descripcion, 'n_tablas', o.n_tablas, 'otras_tablas', o.otras_tablas,
                   'observacion', o.observacion) ORDER BY o.orden)
                 FROM tbl_sugerencia_opciones o WHERE o.sugerencia_id = s.id), '[]'::json) AS opciones
FROM tbl_sugerencias_diccionario s
JOIN tbl_terminos t ON t.id = s.termino_id
"""
_LIST_SQL = _MATCH_SELECT + "ORDER BY s.orden, s.id"
_GET_SQL = _MATCH_SELECT + "WHERE s.id = %s"
_APPLY_SQL = """
UPDATE tbl_sugerencias_diccionario
SET estado = 'aplicada', elegido_columna = %s, elegido_tabla = %s, elegido_etiqueta = %s,
    elegido_maestro = %s,
    decidido_en = now(), decidido_por = %s
WHERE id = %s
"""
_DISCARD_SQL = """
UPDATE tbl_sugerencias_diccionario SET estado = 'descartada', decidido_en = now(), decidido_por = %s
WHERE id = %s
"""
_REOPEN_SQL = "UPDATE tbl_sugerencias_diccionario SET estado = 'pendiente' WHERE id = %s"

_SEARCH_SQL = r"""
WITH vigente AS (
  SELECT id FROM tbl_sincronizaciones WHERE origen = 'diccionario_softland' AND es_vigente
), hits AS (
  SELECT d.columna, d.tabla, d.modulo, d.valor_etiqueta, d.descripcion
  FROM tbl_diccionario_softland d JOIN vigente v ON v.id = d.sincronizacion_id
  WHERE d.columna ILIKE %(pattern)s OR d.valor_etiqueta ILIKE %(pattern)s OR d.descripcion ILIKE %(pattern)s
  ORDER BY (upper(d.columna) = upper(%(text)s)) DESC, d.columna, d.tabla
  LIMIT %(limit)s
), counts AS (
  SELECT d.columna, count(DISTINCT d.tabla) AS n_tablas, array_agg(DISTINCT d.tabla) AS tablas
  FROM tbl_diccionario_softland d JOIN vigente v ON v.id = d.sincronizacion_id
  WHERE d.columna IN (SELECT columna FROM hits)
  GROUP BY d.columna
)
SELECT h.columna, h.valor_etiqueta AS etiqueta, h.tabla, h.modulo, h.descripcion, c.n_tablas,
       array_remove(c.tablas, h.tabla) AS otras_tablas
FROM hits h JOIN counts c ON c.columna = h.columna
ORDER BY (upper(h.columna) = upper(%(text)s)) DESC, h.columna, h.tabla
"""


def _escape_like(text: str) -> str:
    return text.replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")


def _option(o: dict) -> MatchOption:
    return MatchOption(
        columna=o["columna"],
        etiqueta=o["etiqueta"],
        tabla=o["tabla"],
        modulo=o["modulo"],
        descripcion=o["descripcion"],
        n_tablas=int(o["n_tablas"]),
        otras_tablas=tuple(o["otras_tablas"] or ()),
        observacion=o.get("observacion") or "",
    )


def _match(row: dict) -> DictionaryMatch:
    estado = MatchStatus(row["estado"])
    elegido = (
        MatchChoice(
            row["elegido_columna"],
            row["elegido_tabla"] or "",
            row["elegido_etiqueta"] or "",
            row["elegido_maestro"] or "",
        )
        if row["elegido_columna"]
        else None
    )
    return DictionaryMatch(
        id=row["id"],
        termino_id=row["termino_id"],
        termino=row["termino"],
        confianza=row["confianza"],
        orden=row["orden"],
        estado=estado,
        maestro_sugerido=row["maestro_sugerido"],
        opciones=tuple(_option(o) for o in row["opciones"]),
        elegido=elegido,
        decidido_en=row["decidido_en"],
        decidido_por=row["decidido_por"],
    )


class PostgresDictionaryMatchRepository(DictionaryMatchRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def list_all(self) -> list[DictionaryMatch]:
        with self._connection.cursor() as cursor:
            cursor.execute(_LIST_SQL)
            return [_match(r) for r in cursor.fetchall()]

    def get(self, match_id: str) -> DictionaryMatch | None:
        with self._connection.cursor() as cursor:
            cursor.execute(_GET_SQL, (match_id,))
            row = cursor.fetchone()
        return _match(row) if row else None

    def mark_applied(self, match_id: str, choice: MatchChoice, by: str) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(
                _APPLY_SQL, (choice.columna, choice.tabla, choice.etiqueta, choice.maestro, by, match_id)
            )

    def mark_discarded(self, match_id: str, by: str) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(_DISCARD_SQL, (by, match_id))

    def reopen(self, match_id: str) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(_REOPEN_SQL, (match_id,))


class PostgresSoftlandDictionaryRepository(SoftlandDictionaryRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def search(self, text: str, limit: int) -> list[MatchOption]:
        params = {"pattern": f"%{_escape_like(text)}%", "text": text, "limit": limit}
        with self._connection.cursor() as cursor:
            cursor.execute(_SEARCH_SQL, params)
            return [_option(r) for r in cursor.fetchall()]
