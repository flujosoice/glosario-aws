"""Composition root: arma casos de uso con sus adapters. Todo perezoso (se crea en el primer uso)."""

from __future__ import annotations

from application.dto.principal import Principal
from application.use_cases.access import GetAccessUseCase, GetHealthUseCase
from application.use_cases.catalogs import (
    CreateMasterUseCase,
    CreateTagUseCase,
    DeleteMasterUseCase,
    DeleteTagUseCase,
    GetCatalogsUseCase,
)
from application.use_cases.dictionary import (
    ApplyDictionaryMatchUseCase,
    DiscardDictionaryMatchUseCase,
    ListDictionaryMatchesUseCase,
    ReopenDictionaryMatchUseCase,
    SearchSoftlandDictionaryUseCase,
)
from application.use_cases.glossary import (
    CreateTermUseCase,
    DeleteTermUseCase,
    ListAdminTermsUseCase,
    ListTermsUseCase,
    RestoreTermUseCase,
    UpdateTermUseCase,
)
from application.use_cases.sync import (
    AppendSyncRowsUseCase,
    CompleteSyncRunUseCase,
    ExpireStaleSyncRunsUseCase,
    FailSyncRunUseCase,
    ListSyncRunsUseCase,
    StartSyncRunUseCase,
)
from entrypoints.lambda_handlers.bootstrap import connection_factory
from infrastructure.database.postgresql.app_unit_of_work import AppPostgresUnitOfWork


def uow_factory(principal: Principal | None = None) -> AppPostgresUnitOfWork:
    # Sin Cognito no hay principal: la autorización la hacen los casos de uso con la llave de acceso.
    return AppPostgresUnitOfWork(connection_factory(), principal, role="service_role")


def get_access() -> GetAccessUseCase:
    return GetAccessUseCase(uow_factory)


def get_health() -> GetHealthUseCase:
    return GetHealthUseCase(uow_factory)


def list_terms() -> ListTermsUseCase:
    return ListTermsUseCase(uow_factory)


def list_admin_terms() -> ListAdminTermsUseCase:
    return ListAdminTermsUseCase(uow_factory)


def create_term() -> CreateTermUseCase:
    return CreateTermUseCase(uow_factory)


def update_term() -> UpdateTermUseCase:
    return UpdateTermUseCase(uow_factory)


def delete_term() -> DeleteTermUseCase:
    return DeleteTermUseCase(uow_factory)


def restore_term() -> RestoreTermUseCase:
    return RestoreTermUseCase(uow_factory)


def get_catalogs() -> GetCatalogsUseCase:
    return GetCatalogsUseCase(uow_factory)


def create_tag() -> CreateTagUseCase:
    return CreateTagUseCase(uow_factory)


def delete_tag() -> DeleteTagUseCase:
    return DeleteTagUseCase(uow_factory)


def create_master() -> CreateMasterUseCase:
    return CreateMasterUseCase(uow_factory)


def delete_master() -> DeleteMasterUseCase:
    return DeleteMasterUseCase(uow_factory)


def list_dictionary_matches() -> ListDictionaryMatchesUseCase:
    return ListDictionaryMatchesUseCase(uow_factory)


def apply_dictionary_match() -> ApplyDictionaryMatchUseCase:
    return ApplyDictionaryMatchUseCase(uow_factory)


def discard_dictionary_match() -> DiscardDictionaryMatchUseCase:
    return DiscardDictionaryMatchUseCase(uow_factory)


def reopen_dictionary_match() -> ReopenDictionaryMatchUseCase:
    return ReopenDictionaryMatchUseCase(uow_factory)


def search_softland_dictionary() -> SearchSoftlandDictionaryUseCase:
    return SearchSoftlandDictionaryUseCase(uow_factory)


def list_sync_runs() -> ListSyncRunsUseCase:
    return ListSyncRunsUseCase(uow_factory)


def start_sync_run() -> StartSyncRunUseCase:
    return StartSyncRunUseCase(uow_factory)


def append_sync_rows() -> AppendSyncRowsUseCase:
    return AppendSyncRowsUseCase(uow_factory)


def complete_sync_run() -> CompleteSyncRunUseCase:
    return CompleteSyncRunUseCase(uow_factory)


def fail_sync_run() -> FailSyncRunUseCase:
    return FailSyncRunUseCase(uow_factory)


def expire_stale_sync_runs() -> ExpireStaleSyncRunsUseCase:
    return ExpireStaleSyncRunsUseCase(uow_factory)
