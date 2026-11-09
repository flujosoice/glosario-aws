"""Adapters PostgreSQL de llaves de acceso y términos (tbl_llaves_acceso, tbl_terminos y sus hijas)."""

from __future__ import annotations

from typing import Any
from uuid import UUID

import psycopg

from application.ports.glossary import AccessKeyRepository, TermRepository
from domain.entities.access import AccessGrant, AccessPurpose
from domain.entities.term import BdField, DefinitionFragment, TermDraft, TermView

_FIND_KEY_SQL = """
SELECT proposito::text AS proposito, etiqueta FROM tbl_llaves_acceso
WHERE hash_llave = %s AND activa AND revocada_en IS NULL
"""

_TERM_SELECT = """
SELECT t.id, t.termino, t.definicion, t.campo_softland, t.estado_origen::text AS estado_origen,
       t.es_nuevo, t.editado, (t.eliminado_en IS NOT NULL) AS eliminado, t.actualizado_en,
       COALESCE((SELECT json_agg(json_build_object('contexto', f.contexto, 'texto', f.texto) ORDER BY f.orden)
                 FROM tbl_definicion_fragmentos f WHERE f.termino_id = t.id), '[]'::json) AS fragmentos,
       COALESCE((SELECT array_agg(e.nombre ORDER BY te.orden, e.nombre)
                 FROM tbl_termino_etiquetas te JOIN tbl_etiquetas e ON e.id = te.etiqueta_id
                 WHERE te.termino_id = t.id), '{}'::text[]) AS etiquetas,
       COALESCE((SELECT json_agg(json_build_object('campo', c.campo, 'aplica_a', c.aplica_a) ORDER BY c.orden)
                 FROM tbl_termino_campos_bd c WHERE c.termino_id = t.id), '[]'::json) AS campos_bd,
       COALESCE((SELECT array_agg(m.nombre ORDER BY tm.orden, m.nombre)
                 FROM tbl_termino_maestros tm JOIN tbl_maestros m ON m.id = tm.maestro_id
                 WHERE tm.termino_id = t.id), '{}'::text[]) AS maestros
FROM tbl_terminos t
"""
_LIST_SQL = (
    _TERM_SELECT + "WHERE %(include_deleted)s OR t.eliminado_en IS NULL\nORDER BY lower(t.termino), t.id"
)
_GET_SQL = _TERM_SELECT + "WHERE t.id = %(id)s"

_CREATE_SQL = """
INSERT INTO tbl_terminos (termino, definicion, campo_softland, es_nuevo, actualizado_en)
VALUES (%s, %s, %s, true, now()) RETURNING id
"""
_UPDATE_SQL = """
UPDATE tbl_terminos
SET termino = %s, definicion = %s, campo_softland = %s, editado = %s, actualizado_en = now()
WHERE id = %s
"""
_SET_SOFTLAND_SQL = "UPDATE tbl_terminos SET campo_softland = %s, actualizado_en = now() WHERE id = %s"
_SET_DELETED_SQL = """
UPDATE tbl_terminos SET eliminado_en = CASE WHEN %s THEN now() ELSE NULL END, actualizado_en = now()
WHERE id = %s
"""
_DELETE_FRAGMENTS_SQL = "DELETE FROM tbl_definicion_fragmentos WHERE termino_id = %s"
_DELETE_TAGS_SQL = "DELETE FROM tbl_termino_etiquetas WHERE termino_id = %s"
_INSERT_TAG_SQL = "INSERT INTO tbl_termino_etiquetas (termino_id, etiqueta_id, orden) VALUES (%s, %s, %s)"
_DELETE_FIELDS_SQL = "DELETE FROM tbl_termino_campos_bd WHERE termino_id = %s"
_INSERT_FIELD_SQL = (
    "INSERT INTO tbl_termino_campos_bd (termino_id, orden, campo, aplica_a) VALUES (%s, %s, %s, %s)"
)
_DELETE_MASTERS_SQL = "DELETE FROM tbl_termino_maestros WHERE termino_id = %s"
_INSERT_MASTER_SQL = "INSERT INTO tbl_termino_maestros (termino_id, maestro_id, orden) VALUES (%s, %s, %s)"
_INSERT_AUDIT_SQL = """
INSERT INTO tbl_auditoria_terminos (termino_id, accion, campo, valor_anterior, valor_nuevo, hecho_por)
VALUES (%s, %s, %s, %s, %s, %s)
"""


class PostgresAccessKeyRepository(AccessKeyRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def find_active(self, key_hash: str) -> AccessGrant | None:
        with self._connection.cursor() as cursor:
            cursor.execute(_FIND_KEY_SQL, (key_hash,))
            row = cursor.fetchone()
        return AccessGrant(AccessPurpose(row["proposito"]), row["etiqueta"]) if row else None


def _term(row: dict[str, Any]) -> TermView:
    return TermView(
        id=row["id"],
        termino=row["termino"],
        definicion=row["definicion"],
        fragmentos=tuple(DefinitionFragment(f["contexto"], f["texto"]) for f in row["fragmentos"]),
        etiquetas=tuple(row["etiquetas"]),
        estado_origen=row["estado_origen"],
        campos_bd=tuple(BdField(c["campo"], c["aplica_a"]) for c in row["campos_bd"]),
        campo_softland=row["campo_softland"],
        maestros=tuple(row["maestros"]),
        es_nuevo=row["es_nuevo"],
        editado=row["editado"],
        eliminado=row["eliminado"],
        actualizado_en=row["actualizado_en"],
    )


class PostgresTermRepository(TermRepository):
    def __init__(self, connection: psycopg.Connection) -> None:
        self._connection = connection

    def list_all(self, *, include_deleted: bool) -> list[TermView]:
        with self._connection.cursor() as cursor:
            cursor.execute(_LIST_SQL, {"include_deleted": include_deleted})
            return [_term(row) for row in cursor.fetchall()]

    def get(self, term_id: UUID) -> TermView | None:
        with self._connection.cursor() as cursor:
            cursor.execute(_GET_SQL, {"id": term_id})
            row = cursor.fetchone()
        return _term(row) if row else None

    def create(self, draft: TermDraft, tag_ids: list[int], master_ids: list[int]) -> UUID:
        with self._connection.cursor() as cursor:
            cursor.execute(_CREATE_SQL, (draft.termino, draft.definicion, draft.campo_softland))
            term_id = cursor.fetchone()["id"]
        self._replace_children(term_id, tag_ids, draft.campos_bd, master_ids)
        return term_id

    def update(
        self,
        term_id: UUID,
        draft: TermDraft,
        tag_ids: list[int],
        master_ids: list[int],
        *,
        edited: bool,
        keep_fragments: bool,
    ) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(
                _UPDATE_SQL, (draft.termino, draft.definicion, draft.campo_softland, edited, term_id)
            )
            if not keep_fragments:
                cursor.execute(_DELETE_FRAGMENTS_SQL, (term_id,))
        self._replace_children(term_id, tag_ids, draft.campos_bd, master_ids)

    def set_fields(
        self, term_id: UUID, fields: tuple[BdField, ...], campo_softland: str, master_ids: list[int]
    ) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(_SET_SOFTLAND_SQL, (campo_softland, term_id))
            self._replace(
                cursor,
                _DELETE_FIELDS_SQL,
                _INSERT_FIELD_SQL,
                term_id,
                [(term_id, i, f.campo, f.aplica_a) for i, f in enumerate(fields)],
            )
            self._replace(
                cursor,
                _DELETE_MASTERS_SQL,
                _INSERT_MASTER_SQL,
                term_id,
                [(term_id, mid, i) for i, mid in enumerate(master_ids)],
            )

    def set_deleted(self, term_id: UUID, deleted: bool) -> None:
        with self._connection.cursor() as cursor:
            cursor.execute(_SET_DELETED_SQL, (deleted, term_id))

    def add_audit(
        self, term_id: UUID, action: str, changes: list[tuple[str, str | None, str]], by: str
    ) -> None:
        if not changes:
            return
        with self._connection.cursor() as cursor:
            cursor.executemany(
                _INSERT_AUDIT_SQL, [(term_id, action, f, old, new, by) for f, old, new in changes]
            )

    def _replace_children(
        self, term_id: UUID, tag_ids: list[int], fields: tuple[BdField, ...], master_ids: list[int]
    ) -> None:
        with self._connection.cursor() as cursor:
            self._replace(
                cursor,
                _DELETE_TAGS_SQL,
                _INSERT_TAG_SQL,
                term_id,
                [(term_id, tid, i) for i, tid in enumerate(tag_ids)],
            )
            self._replace(
                cursor,
                _DELETE_FIELDS_SQL,
                _INSERT_FIELD_SQL,
                term_id,
                [(term_id, i, f.campo, f.aplica_a) for i, f in enumerate(fields)],
            )
            self._replace(
                cursor,
                _DELETE_MASTERS_SQL,
                _INSERT_MASTER_SQL,
                term_id,
                [(term_id, mid, i) for i, mid in enumerate(master_ids)],
            )

    @staticmethod
    def _replace(
        cursor: psycopg.Cursor, delete_sql: str, insert_sql: str, term_id: UUID, rows: list[tuple]
    ) -> None:
        cursor.execute(delete_sql, (term_id,))
        if rows:
            cursor.executemany(insert_sql, rows)
