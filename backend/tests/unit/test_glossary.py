from uuid import uuid4

import pytest

from application.use_cases.glossary import (
    CreateTermUseCase,
    DeleteTermUseCase,
    ListAdminTermsUseCase,
    ListTermsUseCase,
    RestoreTermUseCase,
    UpdateTermUseCase,
)
from domain.entities.term import BdField, DefinitionFragment, format_bd_fields
from domain.exceptions import NotFoundError, UnauthorizedError, ValidationError
from fakes.fake_app_unit_of_work import ADMIN_KEY, FakeAppUnitOfWork, auth

KEY = auth(ADMIN_KEY)


@pytest.fixture
def uow():
    world = FakeAppUnitOfWork()
    world.terms.add("Zona", etiquetas=("Silo Ventas",))
    world.terms.add(
        "Artículo",
        definicion="Código",
        etiquetas=("Softland",),
        campos_bd=(BdField("ARTICULO"),),
        campo_softland="Artículo",
        maestros=("Artículo",),
        fragmentos=(DefinitionFragment("Reporte SIM", "Código"),),
    )
    world.terms.add("Borrado", eliminado=True)
    return world


def test_public_list_hides_deleted_terms_and_admin_fields(uow):
    terms = ListTermsUseCase(uow.factory).execute()
    assert [t["termino"] for t in terms] == ["Artículo", "Zona"]
    assert "editado" not in terms[0] and "eliminado" not in terms[0]
    assert terms[0]["camposBd"] == [{"campo": "ARTICULO", "aplicaA": ""}]


def test_admin_list_requires_key_and_includes_deleted(uow):
    with pytest.raises(UnauthorizedError):
        ListAdminTermsUseCase(uow.factory).execute(None)
    terms = ListAdminTermsUseCase(uow.factory).execute(KEY)
    assert {t["termino"]: t["eliminado"] for t in terms}["Borrado"] is True


def test_create_term_validates_and_audits(uow):
    body = {
        "termino": "  Ruta ",
        "definicion": "Recorrido",
        "etiquetas": ["silo ventas"],
        "camposBd": [{"campo": "RUTA", "aplicaA": "Clientes"}, {"campo": "RUTA", "aplicaA": "Embarque"}],
        "campoSoftland": "Ruta",
        "maestros": ["Cliente"],
    }
    term = CreateTermUseCase(uow.factory).execute(KEY, body)
    assert term["termino"] == "Ruta" and term["esNuevo"] is True and term["editado"] is False
    assert term["etiquetas"] == ["Silo Ventas"] and term["maestros"] == ["Cliente"]
    assert {a[2] for a in uow.terms.audit} >= {"termino", "campo_bd", "maestros"}
    assert all(a[5] == "Enlace Procesos" for a in uow.terms.audit)


@pytest.mark.parametrize(
    ("body", "message"),
    [
        ({"termino": "  "}, "vacío"),
        ({"termino": "X", "camposBd": [{"campo": "A"}, {"campo": "B", "aplicaA": "Beval"}]}, "aplica"),
        ({"termino": "X", "etiquetas": ["No existe"]}, "etiqueta"),
        ({"termino": "X", "maestros": ["Proveedor"]}, "maestro"),
    ],
)
def test_create_term_rejects_invalid_data(uow, body, message):
    with pytest.raises(ValidationError, match=message):
        CreateTermUseCase(uow.factory).execute(KEY, body)


def test_update_marks_edited_only_when_name_definition_or_tags_change(uow):
    term = next(t for t in uow.terms.rows.values() if t.termino == "Artículo")
    use_case = UpdateTermUseCase(uow.factory)
    base = {
        "termino": "Artículo",
        "definicion": "Código",
        "etiquetas": ["Softland"],
        "maestros": ["Artículo"],
    }
    result = use_case.execute(
        KEY, str(term.id), {**base, "camposBd": [{"campo": "U_ART"}], "campoSoftland": "Art"}
    )
    assert result["editado"] is False and result["camposBd"] == [{"campo": "U_ART", "aplicaA": ""}]
    assert uow.terms.rows[term.id].fragmentos, "sin cambio de definición se conservan los fragmentos"
    result = use_case.execute(KEY, str(term.id), {**base, "definicion": "Código único"})
    assert result["editado"] is True and result["fragmentos"] == []
    with pytest.raises(NotFoundError):
        use_case.execute(KEY, str(uuid4()), base)
    with pytest.raises(NotFoundError):
        use_case.execute(KEY, "no-es-un-id", base)


def test_delete_and_restore_are_soft_and_idempotent(uow):
    term = next(t for t in uow.terms.rows.values() if t.termino == "Zona")
    assert DeleteTermUseCase(uow.factory).execute(KEY, str(term.id))["eliminado"] is True
    DeleteTermUseCase(uow.factory).execute(KEY, str(term.id))
    assert [a[1] for a in uow.terms.audit] == ["eliminar"]
    assert "Zona" not in [t["termino"] for t in ListTermsUseCase(uow.factory).execute()]
    assert RestoreTermUseCase(uow.factory).execute(KEY, str(term.id))["eliminado"] is False


def test_format_bd_fields_keeps_historic_shape():
    assert format_bd_fields((BdField("U_MARCA"),)) == "U_MARCA"
    assert format_bd_fields((BdField("C4", "Cofersa"), BdField("C5", "Beval"))) == "C4 (Cofersa) / C5 (Beval)"
    assert format_bd_fields(()) == ""
