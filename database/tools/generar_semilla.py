#!/usr/bin/env python3
"""Genera database/source/900_seed_glosario.sql con el estado del glosario exportado de claude.ai.

Entrada (carpeta datos/ del paquete glosario-terminos-mayoreo):
    glosario_consolidado.json      términos con todos los cambios (fuente de verdad)
    sugerencias_diccionario.json   coincidencias con el Diccionario de Softland y su decisión
    catalogos.json                 etiquetas por tipo, maestros y maestros base

    python database/tools/generar_semilla.py --datos ../glosario-terminos-mayoreo/datos

El SQL usa los nombres del modelo fuente; export_data_sql.py --source sandbox lo convierte en
aurora_postgresql_data.sql por ambiente. Es re-ejecutable (ON CONFLICT DO NOTHING).
Para el corte final: volver a exportar la base de claude.ai, regenerar datos/ y repetir.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "database" / "source" / "900_seed_glosario.sql"
SIM_PREFIXES = ("Dimensión ", "Filtro ", "Indicador ")
ESTADOS_ORIGEN = {"fusionado", "homonimo", "dudoso", "sinetiqueta"}
BATCH = 200


def lit(value: Any) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, list):
        return "ARRAY[" + ", ".join(lit(str(v)) for v in value) + "]::text[]" if value else "'{}'::text[]"
    return "'" + str(value).replace("'", "''") + "'"


def ts(value: str | None) -> str:
    return f"{lit(value)}::timestamptz" if value else "NULL"


def insert(table: str, columns: list[str], rows: list[list[str]], conflict: str = "DO NOTHING") -> list[str]:
    out: list[str] = []
    for start in range(0, len(rows), BATCH):
        chunk = rows[start : start + BATCH]
        values = ",\n".join("  (" + ", ".join(r) + ")" for r in chunk)
        out.append(f"INSERT INTO {table} ({', '.join(columns)}) VALUES\n{values}\nON CONFLICT {conflict};")
    return out


def insert_by_name(table: str, columns: list[str], catalog: str, alias: str, rows: list[list[str]]) -> list[str]:
    """Inserta (termino_id, <catálogo>_id, orden) resolviendo el id del catálogo por nombre."""
    out: list[str] = []
    for start in range(0, len(rows), BATCH):
        chunk = rows[start : start + BATCH]
        values = ",\n".join("  (" + ", ".join(r) + ")" for r in chunk)
        out.append(
            f"INSERT INTO {table} ({', '.join(columns)})\n"
            f"SELECT v.termino_id::uuid, {alias}.id, v.orden\n"
            f"FROM (VALUES\n{values}\n) AS v (termino_id, nombre, orden)\n"
            f"JOIN {catalog} {alias} ON {alias}.nombre = v.nombre\n"
            "ON CONFLICT DO NOTHING;"
        )
    return out


def build(datos: Path) -> str:
    terminos = json.loads((datos / "glosario_consolidado.json").read_text(encoding="utf-8"))
    sugerencias = json.loads((datos / "sugerencias_diccionario.json").read_text(encoding="utf-8"))
    catalogos = json.loads((datos / "catalogos.json").read_text(encoding="utf-8"))

    base_origen = list(catalogos.get("silo_sistema_origen") or [])
    base_sim = list(catalogos.get("rol_reporte_sim") or [])
    etiquetas: dict[str, tuple[str, bool]] = {}
    for nombre in base_origen:
        etiquetas[nombre] = ("silo_sistema", True)
    for nombre in base_sim:
        etiquetas[nombre] = ("rol_reporte_sim", True)
    for t in terminos:
        for nombre in (t.get("silo_sistema_origen") or []) + (t.get("rol_reporte_sim") or []):
            if nombre not in etiquetas:
                tipo = "rol_reporte_sim" if nombre.startswith(SIM_PREFIXES) else "silo_sistema"
                etiquetas[nombre] = (tipo, False)

    maestros_base = set(catalogos.get("maestros_base") or [])
    maestros = list(catalogos.get("maestros") or [])
    for t in terminos:
        for m in t.get("maestro_origen") or []:
            if m not in maestros:
                maestros.append(m)

    sql: list[str] = [
        "-- Datos del glosario al corte de claude.ai (generado por database/tools/generar_semilla.py; no editar).",
        f"-- {len(terminos)} términos, {len(etiquetas)} etiquetas, {len(maestros)} maestros, "
        f"{len(sugerencias)} coincidencias del diccionario.",
        "",
    ]
    sql += insert("maestros", ["nombre", "es_base"], [[lit(m), lit(m in maestros_base)] for m in maestros])
    sql += insert("etiquetas", ["nombre", "tipo", "es_base"],
                  [[lit(n), f"{lit(tipo)}::tipo_etiqueta", lit(base)] for n, (tipo, base) in etiquetas.items()])

    term_rows, campo_rows, frag_rows, tag_rows, mae_rows = [], [], [], [], []
    for t in terminos:
        estado = t.get("estado_origen") or None
        term_rows.append([
            f"{lit(t['id'])}::uuid", lit(t["termino"]), lit(t.get("definicion") or ""),
            lit(t.get("campo_softland") or ""),
            f"{lit(estado)}::estado_origen_termino" if estado in ESTADOS_ORIGEN else "NULL",
            lit(t.get("nota_origen") or None), lit(bool(t.get("revisado"))), lit(t.get("nota_decision") or None),
            lit(bool(t.get("es_nuevo"))), lit(bool(t.get("editado"))),
            ts(t.get("actualizado_en")) if t.get("eliminado") else "NULL", ts(t.get("actualizado_en")),
        ])
        for i, c in enumerate(t.get("campos_base_datos_detalle") or []):
            if (c.get("campo") or "").strip():
                campo_rows.append([f"{lit(t['id'])}::uuid", lit(i), lit(c["campo"].strip()), lit((c.get("aplica_a") or "").strip())])
        for i, f in enumerate(t.get("fragmentos_definicion") or []):
            frag_rows.append([f"{lit(t['id'])}::uuid", lit(i), lit(f.get("contexto") or ""), lit(f.get("texto") or "")])
        for i, nombre in enumerate((t.get("silo_sistema_origen") or []) + (t.get("rol_reporte_sim") or [])):
            tag_rows.append([lit(t["id"]), lit(nombre), lit(i)])
        for i, m in enumerate(t.get("maestro_origen") or []):
            mae_rows.append([lit(t["id"]), lit(m), lit(i)])

    sql += insert("terminos", ["id", "termino", "definicion", "campo_softland", "estado_origen", "nota_origen", "revisado",
                               "nota_decision", "es_nuevo", "editado", "eliminado_en", "actualizado_en"], term_rows)
    sql += insert("termino_campos_bd", ["termino_id", "orden", "campo", "aplica_a"], campo_rows)
    sql += insert("definicion_fragmentos", ["termino_id", "orden", "contexto", "texto"], frag_rows)
    sql += insert_by_name("termino_etiquetas", ["termino_id", "etiqueta_id", "orden"], "etiquetas", "e", tag_rows)
    sql += insert_by_name("termino_maestros", ["termino_id", "maestro_id", "orden"], "maestros", "m", mae_rows)

    sug_rows, opt_rows = [], []
    for sid, s in sorted(sugerencias.items()):
        elegido = s.get("elegido") or {}
        estado = s.get("estado") or "pendiente"
        sug_rows.append([
            lit(sid), f"{lit(s['term_id'])}::uuid",
            f"{lit(s['conf'])}::confianza_coincidencia" if s.get("conf") in ("Alta", "Media", "Baja") else "NULL",
            lit(int(s.get("orden") or 0)), f"{lit(estado)}::estado_coincidencia", lit(s.get("maestro_sugerido") or ""),
            lit(elegido.get("columna") or None), lit(elegido.get("tabla") or None), lit(elegido.get("etiqueta") or None),
            lit(elegido.get("maestro") or None), ts(s.get("decidido")),
            lit("Procesos (claude.ai)") if estado != "pendiente" else "NULL", lit(s.get("fuente") or ""),
        ])
        for i, o in enumerate(s.get("opciones") or []):
            opt_rows.append([
                lit(sid), lit(i), lit(o.get("columna") or ""), lit(o.get("etiqueta") or ""), lit(o.get("tabla") or ""),
                lit(o.get("modulo") or ""), lit(o.get("descripcion") or ""), lit(int(o.get("ntablas") or 0)),
                lit(list(o.get("otras_tablas") or [])), lit(o.get("obs") or ""),
            ])
    sql += insert("sugerencias_diccionario", ["id", "termino_id", "confianza", "orden", "estado", "maestro_sugerido",
                                              "elegido_columna", "elegido_tabla", "elegido_etiqueta", "elegido_maestro",
                                              "decidido_en", "decidido_por", "fuente"], sug_rows)
    sql += insert("sugerencia_opciones", ["sugerencia_id", "orden", "columna", "etiqueta", "tabla", "modulo", "descripcion",
                                          "n_tablas", "otras_tablas", "observacion"], opt_rows)
    return "\n\n".join(sql) + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--datos", type=Path, default=ROOT.parent / "glosario-terminos-mayoreo" / "datos")
    parser.add_argument("--out", type=Path, default=OUT)
    args = parser.parse_args()
    args.out.write_text(build(args.datos), encoding="utf-8", newline="\n")
    print(f"escrito {args.out}")


if __name__ == "__main__":
    main()
