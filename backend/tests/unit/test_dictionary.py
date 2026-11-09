import pytest

from application.use_cases.dictionary import (
    ApplyDictionaryMatchUseCase,
    DiscardDictionaryMatchUseCase,
    ListDictionaryMatchesUseCase,
    ReopenDictionaryMatchUseCase,
    SearchSoftlandDictionaryUseCase,
)
from domain.entities.dictionary import MatchOption
from domain.entities.term import BdField
from domain.exceptions import BusinessRuleViolation, ForbiddenError, NotFoundError, ValidationError
from fakes.fake_app_unit_of_work import ADMIN_KEY, INGEST_KEY, FakeAppUnitOfWork, auth

KEY = auth(ADMIN_KEY)
OPTION = MatchOption(
    "CATEGORIA_PROVEED", "Categoría Proveedor", "CATEGORIA_PROVEED", "AS", "Nombre", 2, ("GLOBALES",)
)


@pytest.fixture
def world():
    uow = FakeAppUnitOfWork()
    term = uow.terms.add("Categoría Proveedor", campos_bd=(BdField("VIEJO"),), maestros=("Artículo",))
    uow.matches.add("s000", term, (OPTION,), "Proveedor")
    return uow, term


def test_list_matches_requires_admin_key(world):
    uow, _ = world
    with pytest.raises(ForbiddenError):
        ListDictionaryMatchesUseCase(uow.factory).execute(auth(INGEST_KEY))
    matches = ListDictionaryMatchesUseCase(uow.factory).execute(KEY)
    assert matches[0]["opciones"][0]["nTablas"] == 2 and matches[0]["estado"] == "pendiente"


def test_apply_writes_term_fields_creates_master_and_marks_match(world):
    uow, term = world
    result = ApplyDictionaryMatchUseCase(uow.factory).execute(
        KEY,
        "s000",
        {
            "columna": "CATEGORIA_PROVEED",
            "tabla": "CATEGORIA_PROVEED",
            "etiqueta": "Categoría Proveedor",
            "maestro": "proveedor",
        },
    )
    assert result["coincidencia"]["estado"] == "aplicada"
    assert result["coincidencia"]["elegido"]["maestro"] == "proveedor"
    assert result["termino"]["camposBd"] == [{"campo": "CATEGORIA_PROVEED", "aplicaA": ""}]
    assert result["termino"]["maestros"] == ["Artículo", "proveedor"]
    assert result["termino"]["editado"] is False
    assert {a[2] for a in uow.terms.audit} == {"campo_bd", "campo_softland", "maestros"}
    with pytest.raises(BusinessRuleViolation):
        ApplyDictionaryMatchUseCase(uow.factory).execute(KEY, "s000", {"columna": "X"})


def test_apply_reuses_existing_master_case_insensitive(world):
    uow, _ = world
    result = ApplyDictionaryMatchUseCase(uow.factory).execute(
        KEY, "s000", {"columna": "C", "maestro": "artículo"}
    )
    assert result["termino"]["maestros"] == ["Artículo"]
    assert len(uow.catalogs.masters) == 2


def test_apply_requires_column_and_existing_match(world):
    uow, _ = world
    with pytest.raises(ValidationError):
        ApplyDictionaryMatchUseCase(uow.factory).execute(KEY, "s000", {"columna": "  "})
    with pytest.raises(NotFoundError):
        ApplyDictionaryMatchUseCase(uow.factory).execute(KEY, "s999", {"columna": "X"})
    with pytest.raises(NotFoundError):
        ApplyDictionaryMatchUseCase(uow.factory).execute(KEY, "drop table", {"columna": "X"})


def test_discard_and_reopen_do_not_touch_term(world):
    uow, term = world
    assert DiscardDictionaryMatchUseCase(uow.factory).execute(KEY, "s000")["estado"] == "descartada"
    assert uow.terms.rows[term.id].campos_bd == (BdField("VIEJO"),)
    assert ReopenDictionaryMatchUseCase(uow.factory).execute(KEY, "s000")["estado"] == "pendiente"
    assert ReopenDictionaryMatchUseCase(uow.factory).execute(KEY, "s000")["estado"] == "pendiente"


def test_search_softland_dictionary(world):
    uow, _ = world
    uow.softland.columns = [OPTION]
    use_case = SearchSoftlandDictionaryUseCase(uow.factory)
    assert use_case.execute(KEY, "proveed", None)[0]["columna"] == "CATEGORIA_PROVEED"
    with pytest.raises(ValidationError):
        use_case.execute(KEY, "a", None)
    with pytest.raises(ValidationError):
        use_case.execute(KEY, "proveed", 500)
