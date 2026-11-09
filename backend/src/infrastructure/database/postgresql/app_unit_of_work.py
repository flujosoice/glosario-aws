"""UnitOfWork de la aplicación: arma los repositories sobre la conexión de la transacción."""

from __future__ import annotations

import psycopg

from infrastructure.database.postgresql.catalog_repository import PostgresCatalogRepository
from infrastructure.database.postgresql.dictionary_repository import (
    PostgresDictionaryMatchRepository,
    PostgresSoftlandDictionaryRepository,
)
from infrastructure.database.postgresql.sync_run_repository import PostgresSyncRunRepository
from infrastructure.database.postgresql.term_repository import (
    PostgresAccessKeyRepository,
    PostgresTermRepository,
)
from infrastructure.database.postgresql.unit_of_work import PostgresUnitOfWork


class AppPostgresUnitOfWork(PostgresUnitOfWork):
    def _build_repositories(self, connection: psycopg.Connection) -> None:
        self.access_keys = PostgresAccessKeyRepository(connection)
        self.terms = PostgresTermRepository(connection)
        self.catalogs = PostgresCatalogRepository(connection)
        self.matches = PostgresDictionaryMatchRepository(connection)
        self.softland = PostgresSoftlandDictionaryRepository(connection)
        self.sync_runs = PostgresSyncRunRepository(connection)
