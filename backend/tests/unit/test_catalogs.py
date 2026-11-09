import pytest

from application.use_cases.catalogs import (
    CreateMasterUseCase,
    CreateTagUseCase,
    DeleteMasterUseCase,
    DeleteTagUseCase,
    GetCatalogsUseCase,
)
from domain.exceptions import (
    BusinessRuleViolation,
    ConflictError,
    NotFoundError,
    UnauthorizedError,
    ValidationError,
)
from fakes.fake_app_unit_of_work import ADMIN_KEY, FakeAppUnitOfWork, auth

KEY = auth(ADMIN_KEY)


def test_get_catalogs_is_public():
    catalogs = GetCatalogsUseCase(FakeAppUnitOfWork().factory).execute()
    assert [m["nombre"] for m in catalogs["maestros"]] == ["Artículo", "Cliente"]
    assert {t["tipo"] for t in catalogs["etiquetas"]} == {"silo_sistema", "rol_reporte_sim"}


def test_create_tag_rules():
    uow = FakeAppUnitOfWork()
    use_case = CreateTagUseCase(uow.factory)
    tag = use_case.execute(KEY, {"nombre": " Silo Finanzas ", "tipo": "silo_sistema"})
    assert tag["nombre"] == "Silo Finanzas" and tag["esBase"] is False
    with pytest.raises(ConflictError):
        use_case.execute(KEY, {"nombre": "silo finanzas", "tipo": "rol_reporte_sim"})
    with pytest.raises(ValidationError):
        use_case.execute(KEY, {"nombre": "Otra", "tipo": "otro"})
    with pytest.raises(UnauthorizedError):
        use_case.execute(None, {"nombre": "Otra", "tipo": "silo_sistema"})


def test_delete_tag_only_non_base():
    uow = FakeAppUnitOfWork()
    created = CreateTagUseCase(uow.factory).execute(KEY, {"nombre": "Nueva", "tipo": "silo_sistema"})
    use_case = DeleteTagUseCase(uow.factory)
    with pytest.raises(BusinessRuleViolation):
        use_case.execute(KEY, "1")
    use_case.execute(KEY, str(created["id"]))
    assert created["id"] not in uow.catalogs.tags
    with pytest.raises(NotFoundError):
        use_case.execute(KEY, "abc")


def test_masters_base_and_with_terms_cannot_be_deleted():
    uow = FakeAppUnitOfWork()
    proveedor = CreateMasterUseCase(uow.factory).execute(KEY, {"nombre": "Proveedor"})
    with pytest.raises(ConflictError):
        CreateMasterUseCase(uow.factory).execute(KEY, {"nombre": "PROVEEDOR"})
    use_case = DeleteMasterUseCase(uow.factory)
    with pytest.raises(BusinessRuleViolation, match="base"):
        use_case.execute(KEY, "1")
    uow.catalogs.term_masters[proveedor["id"]] = 2
    with pytest.raises(BusinessRuleViolation, match="términos"):
        use_case.execute(KEY, str(proveedor["id"]))
    uow.catalogs.term_masters[proveedor["id"]] = 0
    use_case.execute(KEY, str(proveedor["id"]))
    assert proveedor["id"] not in uow.catalogs.masters
