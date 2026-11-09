"""Adapter PostgreSQL de etiquetas y maestros (tbl_etiquetas, tbl_maestros)."""

from __future__ import annotations

import psycopg

from application.ports.glossary import CatalogRepository
from domain.entities.catalog import Master, Tag, TagType

_TAG_COLS = "id, nombre, tipo::text AS tipo, es_base"
_MASTER_COLS = "id, nombre, es_base"
_LIST_TAGS_SQL = f"SELECT {_TAG_COLS} FROM tbl_etiquetas ORDER BY tipo, lower(nombre)"
_LIST_MASTERS_SQL = f"SELECT {_MASTER_COLS} FROM tbl_maestros ORDER BY NOT es_base, id"
_FIND_TAG_SQL = f"SELECT {_TAG_COLS} FROM tbl_etiquetas WHERE id = %s"
_FIND_MASTER_SQL = f"SELECT {_MASTER_COLS} FROM tbl_maestros WHERE id = %s"
_TAGS_BY_NAME_SQL = f"SELECT {_TAG_COLS} FROM tbl_etiquetas WHERE lower(nombre) = ANY(%s)"
_MASTERS_BY_NAME_SQL = f"SELECT {_MASTER_COLS} FROM tbl_maestros WHERE lower(nombre) = ANY(%s)"
_CREATE_TAG_SQL = (
    f"INSERT INTO tbl_etiquetas (nombre, tipo) VALUES (%s, %s::tipo_etiqueta) RETURNING {_TAG_COLS}"
)
_CREATE_MASTER_SQL = f"INSERT INTO tbl_maestros (nombre) VALUES (%s) RETURNING {_MASTER_COLS}"
_DELETE_TAG_SQL = "DELETE FROM tbl_etiquetas WHERE id = %s"
_DELETE_MASTER_SQL = "DELETE FROM tbl_maestros WHERE id = %s"
_COUNT_MASTER_TERMS_SQL = "SELECT count(*) AS n FROM tbl_termino_maestros WHERE maestro_id = %s"


def _tag(row: dict) -> Tag:
    return Tag(row["id"], row["nombre"], TagType(row["tipo"]), row["es_base"])


def _master(row: dict) -> Master:
    return Master(row["id"], row["nombre"], row["es_base"])


class PostgresCatalogRepository(CatalogRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def _all(self, sql: str, params: tuple = ()) -> list[dict]:
        with self._connection.cursor() as cursor:
            cursor.execute(sql, params)
            return cursor.fetchall()

    def _one(self, sql: str, params: tuple) -> dict | None:
        with self._connection.cursor() as cursor:
            cursor.execute(sql, params)
            return cursor.fetchone()

    def list_tags(self) -> list[Tag]:
        return [_tag(r) for r in self._all(_LIST_TAGS_SQL)]

    def list_masters(self) -> list[Master]:
        return [_master(r) for r in self._all(_LIST_MASTERS_SQL)]

    def find_tag(self, tag_id: int) -> Tag | None:
        row = self._one(_FIND_TAG_SQL, (tag_id,))
        return _tag(row) if row else None

    def find_master(self, master_id: int) -> Master | None:
        row = self._one(_FIND_MASTER_SQL, (master_id,))
        return _master(row) if row else None

    def tags_by_name(self, names: tuple[str, ...]) -> dict[str, Tag]:
        if not names:
            return {}
        return {
            t.nombre.lower(): t
            for t in map(_tag, self._all(_TAGS_BY_NAME_SQL, ([n.lower() for n in names],)))
        }

    def masters_by_name(self, names: tuple[str, ...]) -> dict[str, Master]:
        if not names:
            return {}
        rows = self._all(_MASTERS_BY_NAME_SQL, ([n.lower() for n in names],))
        return {m.nombre.lower(): m for m in map(_master, rows)}

    def create_tag(self, nombre: str, tipo: TagType) -> Tag:
        return _tag(self._one(_CREATE_TAG_SQL, (nombre, tipo.value)))

    def delete_tag(self, tag_id: int) -> None:
        self._one_exec(_DELETE_TAG_SQL, (tag_id,))

    def create_master(self, nombre: str) -> Master:
        return _master(self._one(_CREATE_MASTER_SQL, (nombre,)))

    def count_master_terms(self, master_id: int) -> int:
        return int(self._one(_COUNT_MASTER_TERMS_SQL, (master_id,))["n"])

    def delete_master(self, master_id: int) -> None:
        self._one_exec(_DELETE_MASTER_SQL, (master_id,))

    def _one_exec(self, sql: str, params: tuple) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(sql, params)
