"""Reglas compartidas por los casos de uso: llaves de acceso y parámetros de ruta."""

from __future__ import annotations

from uuid import UUID

from application.ports.app_unit_of_work import AppUnitOfWork
from domain.entities.access import AccessGrant, AccessPurpose, extract_key, hash_key
from domain.exceptions import ForbiddenError, NotFoundError, UnauthorizedError, ValidationError


def find_grant(uow: AppUnitOfWork, authorization: str | None) -> AccessGrant | None:
    key = extract_key(authorization)
    return uow.access_keys.find_active(hash_key(key)) if key else None


def require_grant(uow: AppUnitOfWork, authorization: str | None, *purposes: AccessPurpose) -> AccessGrant:
    """Sin Cognito, la autorización es la llave: administración para Procesos, ingesta para n8n."""
    if extract_key(authorization) is None:
        raise UnauthorizedError("Falta la llave de acceso.")
    grant = find_grant(uow, authorization)
    if grant is None:
        raise UnauthorizedError("La llave de acceso no es válida o fue revocada.")
    if grant.purpose not in purposes:
        raise ForbiddenError("Esta llave no permite realizar esta acción.")
    return grant


def require_admin(uow: AppUnitOfWork, authorization: str | None) -> AccessGrant:
    return require_grant(uow, authorization, AccessPurpose.ADMIN)


def require_ingest(uow: AppUnitOfWork, authorization: str | None) -> AccessGrant:
    return require_grant(uow, authorization, AccessPurpose.INGEST)


def parse_uuid(raw: str, field: str, *, missing: str) -> UUID:
    """Un id mal formado se trata como inexistente (mismo mensaje que el 404)."""
    try:
        return UUID(str(raw))
    except ValueError as error:
        raise NotFoundError(missing, details={"field": field}) from error


def parse_id(raw: str, field: str, *, missing: str) -> int:
    try:
        value = int(str(raw))
    except ValueError as error:
        raise NotFoundError(missing, details={"field": field}) from error
    if value <= 0:
        raise NotFoundError(missing, details={"field": field})
    return value


def parse_limit(raw: int | None, *, default: int, maximum: int) -> int:
    if raw is None:
        return default
    if raw < 1 or raw > maximum:
        raise ValidationError(f"'limit' debe estar entre 1 y {maximum}.", details={"field": "limit"})
    return raw
