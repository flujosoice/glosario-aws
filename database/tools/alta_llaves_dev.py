"""Genera las llaves de administración e ingesta de dev y las da de alta en Aurora por el runner de BD.

Las llaves solo se escriben en glosario-aws/.env.llaves-dev (ignorado por git); en la base queda el SHA-256.
Uso (desde la raíz de glosario-aws, con .env.aws vigente y dentro del horario de servicio):
    py -3.11 database\\tools\\alta_llaves_dev.py
Requiere la skill aws-project-deployer en ~/.claude/skills. Revoca las llaves activas con la misma etiqueta antes de
crear las nuevas. Si falla la carga en Aurora, no se escribe el archivo y no queda nada dado de alta.
"""

import argparse
import hashlib
import secrets
import sys
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path.home() / ".claude/skills/aws-project-deployer/scripts"))
import deploy  # noqa: E402

ROOT = Path.cwd()
LLAVES = [("administracion", "Enlace Procesos (Portal Interno)"), ("ingesta", "n8n")]
SCHEMA = "may_dev_glosario_sch_core"

keys = [(p, e, secrets.token_urlsafe(32)) for p, e in LLAVES]
sql = ["BEGIN;"]
for proposito, etiqueta, key in keys:
    digest = hashlib.sha256(key.encode("utf-8")).hexdigest()
    sql.append(f"UPDATE {SCHEMA}.tbl_llaves_acceso SET activa = false, revocada_en = now() "
               f"WHERE etiqueta = '{etiqueta}' AND activa;")
    sql.append(f"INSERT INTO {SCHEMA}.tbl_llaves_acceso (proposito, etiqueta, hash_llave) "
               f"VALUES ('{proposito}', '{etiqueta}', '{digest}');")
sql.append(f"SELECT proposito, etiqueta, activa, creado_en FROM {SCHEMA}.tbl_llaves_acceso ORDER BY id;")
sql.append("COMMIT;")

original = deploy.Deployer.database_bundle


def bundle_con_llaves(self):
    path = original(self)
    with zipfile.ZipFile(path, "a", zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("changes_run/zzzz_alta_llaves.sql", "\n".join(sql) + "\n")
    return path


deploy.Deployer.database_bundle = bundle_con_llaves
args = argparse.Namespace(dry_run=False, no_data=True, approve=False, keep_running=True, allow_unvalidated=False)
d = deploy.Deployer(ROOT, "dev", args)
d.database()

amp = "https://dev.d11mn7uw1xww2a.amplifyapp.com"
lines = ["# Llaves de acceso dev (glosario). Guardarlas en el Portal / n8n y BORRAR este archivo.", ""]
for proposito, etiqueta, key in keys:
    lines.append(f"# {proposito} · {etiqueta}")
    lines.append(f"LLAVE_{proposito.upper()}={key}")
    if proposito == "administracion":
        lines.append(f"# enlace: {amp}/administracion#llave={key}")
    else:
        lines.append(f"# cabecera n8n: Authorization: Llave {key}")
    lines.append("")
(ROOT / ".env.llaves-dev").write_text("\n".join(lines), encoding="utf-8")
print("Llaves dadas de alta; archivo: .env.llaves-dev (no se imprime su contenido)")
