import pytest

from application.use_cases.access import GetAccessUseCase, GetHealthUseCase
from application.use_cases.common import require_admin, require_ingest
from domain.entities.access import extract_key, hash_key
from domain.exceptions import ForbiddenError, UnauthorizedError
from fakes.fake_app_unit_of_work import ADMIN_KEY, INGEST_KEY, FakeAppUnitOfWork, auth


def test_extract_key_accepts_llave_and_bearer_and_rejects_short_values():
    assert extract_key(f"Llave {ADMIN_KEY}") == ADMIN_KEY
    assert extract_key(f"Bearer {ADMIN_KEY}") == ADMIN_KEY
    assert extract_key(ADMIN_KEY) == ADMIN_KEY
    assert extract_key("Llave corta") is None
    assert extract_key(None) is None
    assert len(hash_key(ADMIN_KEY)) == 64


def test_get_access_only_opens_administration_with_admin_key():
    uow = FakeAppUnitOfWork()
    use_case = GetAccessUseCase(uow.factory)
    assert use_case.execute(auth(ADMIN_KEY)) == {"puedeAdministrar": True, "etiqueta": "Enlace Procesos"}
    assert use_case.execute(auth(INGEST_KEY)) == {"puedeAdministrar": False, "etiqueta": None}
    assert use_case.execute(None) == {"puedeAdministrar": False, "etiqueta": None}
    assert use_case.execute(auth("x" * 40)) == {"puedeAdministrar": False, "etiqueta": None}


def test_health_reports_ok_when_the_database_answers():
    uow = FakeAppUnitOfWork()
    assert GetHealthUseCase(uow.factory).execute() == {"estado": "ok", "baseDeDatos": "ok"}


def test_health_reports_degraded_without_leaking_the_error():
    def unreachable(principal=None):
        raise ConnectionError("password authentication failed for user usr_glosario_app")

    assert GetHealthUseCase(unreachable).execute() == {"estado": "degradado", "baseDeDatos": "sin conexión"}


def test_require_admin_and_ingest_reject_missing_invalid_and_wrong_purpose():
    uow = FakeAppUnitOfWork()
    with pytest.raises(UnauthorizedError):
        require_admin(uow, None)
    with pytest.raises(UnauthorizedError):
        require_admin(uow, auth("y" * 40))
    with pytest.raises(ForbiddenError):
        require_admin(uow, auth(INGEST_KEY))
    with pytest.raises(ForbiddenError):
        require_ingest(uow, auth(ADMIN_KEY))
    assert require_ingest(uow, auth(INGEST_KEY)).label == "n8n"
