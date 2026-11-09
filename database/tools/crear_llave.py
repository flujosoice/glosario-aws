#!/usr/bin/env python3
"""Genera una llave de acceso nueva y el SQL para darla de alta (en la base solo queda el SHA-256).

    python database/tools/crear_llave.py --proposito administracion --etiqueta "Enlace Procesos"
    python database/tools/crear_llave.py --proposito ingesta --etiqueta "n8n"

Imprime la llave UNA sola vez: guárdela en el Portal Interno Mayoreo (enlace de administración
https://<app>/administracion#llave=<llave>) o en las credenciales de n8n (cabecera Authorization: Llave <llave>).
El SQL se ejecuta con el usuario de despliegue en la base del ambiente. Para revocar una llave:
UPDATE tbl_llaves_acceso SET activa = false, revocada_en = now() WHERE etiqueta = '<etiqueta>';
"""

from __future__ import annotations

import argparse
import hashlib
import secrets


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--proposito", choices=("administracion", "ingesta"), required=True)
    parser.add_argument("--etiqueta", required=True, help="Quién usa la llave (queda en la auditoría)")
    args = parser.parse_args()
    key = secrets.token_urlsafe(32)
    digest = hashlib.sha256(key.encode("utf-8")).hexdigest()
    label = args.etiqueta.replace("'", "''")
    print(f"Llave (guárdela ahora, no se vuelve a mostrar): {key}\n")
    print("INSERT INTO tbl_llaves_acceso (proposito, etiqueta, hash_llave)")
    print(f"VALUES ('{args.proposito}', '{label}', '{digest}');")


if __name__ == "__main__":
    main()
