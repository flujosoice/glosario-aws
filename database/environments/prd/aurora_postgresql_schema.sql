-- =============================================================================
-- may_prd_glosario — Aurora PostgreSQL — SCHEMA
-- Ambiente: prd | Base: may_prd_glosario_db
-- Ejecutar como: master o usr_glosario_deploy conectado a may_prd_glosario_db
-- psql -v ON_ERROR_STOP=1 ... Generado por la skill aws-project-* (no editar a mano;
-- ajustar config.yaml y regenerar).
-- =============================================================================
\set ON_ERROR_STOP on
DO $do$
BEGIN
  IF current_database() <> 'may_prd_glosario_db' THEN
    RAISE EXCEPTION 'Base actual % distinta de la esperada may_prd_glosario_db', current_database();
  END IF;
  IF to_regclass('auth.users') IS NOT NULL THEN
    RAISE EXCEPTION 'Destino parece Supabase. Abortado.';
  END IF;
END
$do$;
BEGIN;
SET LOCAL ROLE ddl_glosario;
SET LOCAL search_path = may_prd_glosario_sch_core;
SET LOCAL check_function_bodies = off;

-- ---------------------------------------------------------------- tipos
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.confianza_coincidencia') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.confianza_coincidencia AS ENUM ('Alta', 'Media', 'Baja');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.estado_coincidencia') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.estado_coincidencia AS ENUM ('pendiente', 'aplicada', 'descartada');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.estado_origen_termino') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.estado_origen_termino AS ENUM ('fusionado', 'homonimo', 'dudoso', 'sinetiqueta');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.estado_sincronizacion') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.estado_sincronizacion AS ENUM ('en_curso', 'completada', 'fallida');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.origen_sincronizacion') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.origen_sincronizacion AS ENUM ('maestro_articulos', 'maestro_clientes', 'diccionario_softland');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.proposito_llave') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.proposito_llave AS ENUM ('administracion', 'ingesta');
  END IF;
END
$do$;
DO $do$
BEGIN
  IF to_regtype('may_prd_glosario_sch_core.tipo_etiqueta') IS NULL THEN
    CREATE TYPE may_prd_glosario_sch_core.tipo_etiqueta AS ENUM ('silo_sistema', 'rol_reporte_sim');
  END IF;
END
$do$;

-- ---------------------------------------------------------------- secuencias

-- ---------------------------------------------------------------- auth: espejo de usuarios + contexto
-- Reemplaza auth.users (Cognito es el IdP). El backend vincula cognito_sub en el primer login.
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_app_users (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  cognito_sub text,
  email text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT pk_app_users PRIMARY KEY (id),
  CONSTRAINT uq_app_users_cognito_sub UNIQUE (cognito_sub)
);
CREATE INDEX IF NOT EXISTS idx_app_users_email_expr ON may_prd_glosario_sch_core.tbl_app_users (lower(email));
-- Contexto de sesión por transacción (set_config(..., true)) fijado por PostgresUnitOfWork.
CREATE OR REPLACE FUNCTION may_prd_glosario_sch_core.fn_auth_uid() RETURNS uuid
  LANGUAGE sql STABLE PARALLEL SAFE AS $fn$SELECT nullif(current_setting('app.user_id', true), '')::uuid$fn$;
CREATE OR REPLACE FUNCTION may_prd_glosario_sch_core.fn_auth_role() RETURNS text
  LANGUAGE sql STABLE PARALLEL SAFE AS $fn$SELECT coalesce(nullif(current_setting('app.role', true), ''), 'anon')$fn$;
CREATE OR REPLACE FUNCTION may_prd_glosario_sch_core.fn_auth_email() RETURNS text
  LANGUAGE sql STABLE PARALLEL SAFE AS $fn$SELECT nullif(current_setting('app.email', true), '')$fn$;
CREATE OR REPLACE FUNCTION may_prd_glosario_sch_core.fn_auth_jwt() RETURNS jsonb
  LANGUAGE sql STABLE PARALLEL SAFE AS $fn$SELECT coalesce(nullif(current_setting('app.jwt_claims', true), ''), '{}')::jsonb$fn$;

-- ---------------------------------------------------------------- funciones (previas a tablas)
-- ---------------------------------------------------------------- tablas
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_etiquetas (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  nombre text NOT NULL,
  tipo tipo_etiqueta NOT NULL,
  es_base boolean DEFAULT false NOT NULL,
  creado_en timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_llaves_acceso (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  proposito proposito_llave NOT NULL,
  etiqueta text NOT NULL,
  hash_llave text NOT NULL,
  activa boolean DEFAULT true NOT NULL,
  creado_en timestamp with time zone DEFAULT now() NOT NULL,
  revocada_en timestamp with time zone
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_maestros (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  nombre text NOT NULL,
  es_base boolean DEFAULT false NOT NULL,
  creado_en timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_sincronizaciones (
  id uuid DEFAULT gen_random_uuid() NOT NULL,
  origen origen_sincronizacion NOT NULL,
  estado estado_sincronizacion DEFAULT 'en_curso'::estado_sincronizacion NOT NULL,
  es_vigente boolean DEFAULT false NOT NULL,
  filas_esperadas integer,
  filas_recibidas integer DEFAULT 0 NOT NULL,
  iniciada_por text NOT NULL,
  iniciada_en timestamp with time zone DEFAULT now() NOT NULL,
  finalizada_en timestamp with time zone,
  error text
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_terminos (
  id uuid DEFAULT gen_random_uuid() NOT NULL,
  termino text NOT NULL,
  definicion text DEFAULT ''::text NOT NULL,
  campo_softland text DEFAULT ''::text NOT NULL,
  estado_origen estado_origen_termino,
  nota_origen text,
  revisado boolean DEFAULT false NOT NULL,
  nota_decision text,
  es_nuevo boolean DEFAULT false NOT NULL,
  editado boolean DEFAULT false NOT NULL,
  eliminado_en timestamp with time zone,
  creado_en timestamp with time zone DEFAULT now() NOT NULL,
  actualizado_en timestamp with time zone
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_atributos_maestro (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  sincronizacion_id uuid NOT NULL,
  hoja text DEFAULT ''::text NOT NULL,
  fila integer NOT NULL,
  grupo text DEFAULT ''::text NOT NULL,
  atributo text DEFAULT ''::text NOT NULL,
  nombre_tecnico text DEFAULT ''::text NOT NULL,
  definicion text DEFAULT ''::text NOT NULL,
  empresas_aplica text DEFAULT ''::text NOT NULL,
  obligatorio boolean,
  validaciones text DEFAULT ''::text NOT NULL,
  tipo_dato text DEFAULT ''::text NOT NULL,
  fuente_dato text DEFAULT ''::text NOT NULL,
  dominio_valores text DEFAULT ''::text NOT NULL,
  valor_default text DEFAULT ''::text NOT NULL,
  permite_null text DEFAULT ''::text NOT NULL,
  condicion_null text DEFAULT ''::text NOT NULL,
  dptos_consumidores text DEFAULT ''::text NOT NULL,
  sistemas text[] DEFAULT '{}'::text[] NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_auditoria_terminos (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  termino_id uuid NOT NULL,
  accion text NOT NULL,
  campo text NOT NULL,
  valor_anterior text,
  valor_nuevo text,
  hecho_por text NOT NULL,
  creado_en timestamp with time zone DEFAULT now() NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_definicion_fragmentos (
  termino_id uuid NOT NULL,
  orden integer NOT NULL,
  contexto text NOT NULL,
  texto text NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_diccionario_softland (
  id bigint GENERATED ALWAYS AS IDENTITY (INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1 NO CYCLE) NOT NULL,
  sincronizacion_id uuid NOT NULL,
  esquema text DEFAULT ''::text NOT NULL,
  modulo text DEFAULT ''::text NOT NULL,
  tabla text NOT NULL,
  columna text NOT NULL,
  descripcion text DEFAULT ''::text NOT NULL,
  tipo_dato text DEFAULT ''::text NOT NULL,
  tamano text DEFAULT ''::text NOT NULL,
  permite_nulos boolean,
  llave_primaria boolean,
  llave_foranea boolean,
  valor_default text DEFAULT ''::text NOT NULL,
  posibles_valores text DEFAULT ''::text NOT NULL,
  editable_procesos_masivos boolean,
  editable_primera_vez boolean,
  modo_case text DEFAULT ''::text NOT NULL,
  tipo_mascara text DEFAULT ''::text NOT NULL,
  autocalculado boolean,
  visible boolean,
  solo_lectura boolean,
  requerido boolean,
  mostrar_como text DEFAULT ''::text NOT NULL,
  tipo_consecutivo text DEFAULT ''::text NOT NULL,
  formato_justificado text DEFAULT ''::text NOT NULL,
  valor_etiqueta text DEFAULT ''::text NOT NULL,
  mostrar_en_f1 boolean
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_sugerencias_diccionario (
  id text NOT NULL,
  termino_id uuid NOT NULL,
  confianza confianza_coincidencia,
  orden integer DEFAULT 0 NOT NULL,
  estado estado_coincidencia DEFAULT 'pendiente'::estado_coincidencia NOT NULL,
  maestro_sugerido text DEFAULT ''::text NOT NULL,
  elegido_columna text,
  elegido_tabla text,
  elegido_etiqueta text,
  elegido_maestro text,
  decidido_en timestamp with time zone,
  decidido_por text,
  fuente text DEFAULT ''::text NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_termino_campos_bd (
  termino_id uuid NOT NULL,
  orden integer NOT NULL,
  campo text NOT NULL,
  aplica_a text DEFAULT ''::text NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_termino_etiquetas (
  termino_id uuid NOT NULL,
  etiqueta_id bigint NOT NULL,
  orden integer DEFAULT 0 NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_termino_maestros (
  termino_id uuid NOT NULL,
  maestro_id bigint NOT NULL,
  orden integer DEFAULT 0 NOT NULL
);
CREATE TABLE IF NOT EXISTS may_prd_glosario_sch_core.tbl_sugerencia_opciones (
  sugerencia_id text NOT NULL,
  orden integer NOT NULL,
  columna text NOT NULL,
  etiqueta text DEFAULT ''::text NOT NULL,
  tabla text DEFAULT ''::text NOT NULL,
  modulo text DEFAULT ''::text NOT NULL,
  descripcion text DEFAULT ''::text NOT NULL,
  n_tablas integer DEFAULT 0 NOT NULL,
  otras_tablas text[] DEFAULT '{}'::text[] NOT NULL,
  observacion text DEFAULT ''::text NOT NULL
);

-- ---------------------------------------------------------------- constraints (PK/UQ/CK/EX → FK)
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_atributos_maestro'::regclass
                 AND conname = 'pk_atributos_maestro') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_atributos_maestro ADD CONSTRAINT pk_atributos_maestro PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_auditoria_terminos'::regclass
                 AND conname = 'pk_auditoria_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_auditoria_terminos ADD CONSTRAINT pk_auditoria_terminos PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_definicion_fragmentos'::regclass
                 AND conname = 'pk_definicion_fragmentos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_definicion_fragmentos ADD CONSTRAINT pk_definicion_fragmentos PRIMARY KEY (termino_id, orden);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_diccionario_softland'::regclass
                 AND conname = 'pk_diccionario_softland') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_diccionario_softland ADD CONSTRAINT pk_diccionario_softland PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_etiquetas'::regclass
                 AND conname = 'pk_etiquetas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_etiquetas ADD CONSTRAINT pk_etiquetas PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_llaves_acceso'::regclass
                 AND conname = 'pk_llaves_acceso') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_llaves_acceso ADD CONSTRAINT pk_llaves_acceso PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_maestros'::regclass
                 AND conname = 'pk_maestros') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_maestros ADD CONSTRAINT pk_maestros PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sincronizaciones'::regclass
                 AND conname = 'pk_sincronizaciones') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sincronizaciones ADD CONSTRAINT pk_sincronizaciones PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencia_opciones'::regclass
                 AND conname = 'pk_sugerencia_opciones') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencia_opciones ADD CONSTRAINT pk_sugerencia_opciones PRIMARY KEY (sugerencia_id, orden);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencias_diccionario'::regclass
                 AND conname = 'pk_sugerencias_diccionario') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencias_diccionario ADD CONSTRAINT pk_sugerencias_diccionario PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_campos_bd'::regclass
                 AND conname = 'pk_termino_campos_bd') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd ADD CONSTRAINT pk_termino_campos_bd PRIMARY KEY (termino_id, orden);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_etiquetas'::regclass
                 AND conname = 'pk_termino_etiquetas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_etiquetas ADD CONSTRAINT pk_termino_etiquetas PRIMARY KEY (termino_id, etiqueta_id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_maestros'::regclass
                 AND conname = 'pk_termino_maestros') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_maestros ADD CONSTRAINT pk_termino_maestros PRIMARY KEY (termino_id, maestro_id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_terminos'::regclass
                 AND conname = 'pk_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_terminos ADD CONSTRAINT pk_terminos PRIMARY KEY (id);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_llaves_acceso'::regclass
                 AND conname = 'uq_llaves_acceso_hash_llave') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_llaves_acceso ADD CONSTRAINT uq_llaves_acceso_hash_llave UNIQUE (hash_llave);
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_atributos_maestro'::regclass
                 AND conname = 'ck_atributos_maestro_fila') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_atributos_maestro ADD CONSTRAINT ck_atributos_maestro_fila CHECK ((fila >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_auditoria_terminos'::regclass
                 AND conname = 'ck_auditoria_terminos_accion') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_auditoria_terminos ADD CONSTRAINT ck_auditoria_terminos_accion CHECK ((accion = ANY (ARRAY['crear'::text, 'editar'::text, 'eliminar'::text, 'restaurar'::text, 'aplicar_coincidencia'::text])));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_definicion_fragmentos'::regclass
                 AND conname = 'ck_definicion_fragmentos_orden') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_definicion_fragmentos ADD CONSTRAINT ck_definicion_fragmentos_orden CHECK ((orden >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_diccionario_softland'::regclass
                 AND conname = 'ck_diccionario_softland_columna') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_diccionario_softland ADD CONSTRAINT ck_diccionario_softland_columna CHECK ((length(btrim(columna)) > 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_diccionario_softland'::regclass
                 AND conname = 'ck_diccionario_softland_tabla') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_diccionario_softland ADD CONSTRAINT ck_diccionario_softland_tabla CHECK ((length(btrim(tabla)) > 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_etiquetas'::regclass
                 AND conname = 'ck_etiquetas_nombre') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_etiquetas ADD CONSTRAINT ck_etiquetas_nombre CHECK (((length(btrim(nombre)) >= 1) AND (length(btrim(nombre)) <= 150)));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_llaves_acceso'::regclass
                 AND conname = 'ck_llaves_acceso_etiqueta') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_llaves_acceso ADD CONSTRAINT ck_llaves_acceso_etiqueta CHECK (((length(btrim(etiqueta)) >= 1) AND (length(btrim(etiqueta)) <= 100)));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_llaves_acceso'::regclass
                 AND conname = 'ck_llaves_acceso_hash_llave') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_llaves_acceso ADD CONSTRAINT ck_llaves_acceso_hash_llave CHECK ((hash_llave ~ '^[0-9a-f]{64}$'::text));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_maestros'::regclass
                 AND conname = 'ck_maestros_nombre') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_maestros ADD CONSTRAINT ck_maestros_nombre CHECK (((length(btrim(nombre)) >= 1) AND (length(btrim(nombre)) <= 100)));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sincronizaciones'::regclass
                 AND conname = 'ck_sincronizaciones_filas_esperadas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sincronizaciones ADD CONSTRAINT ck_sincronizaciones_filas_esperadas CHECK ((filas_esperadas >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sincronizaciones'::regclass
                 AND conname = 'ck_sincronizaciones_filas_recibidas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sincronizaciones ADD CONSTRAINT ck_sincronizaciones_filas_recibidas CHECK ((filas_recibidas >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencia_opciones'::regclass
                 AND conname = 'ck_sugerencia_opciones_n_tablas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencia_opciones ADD CONSTRAINT ck_sugerencia_opciones_n_tablas CHECK ((n_tablas >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencia_opciones'::regclass
                 AND conname = 'ck_sugerencia_opciones_orden') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencia_opciones ADD CONSTRAINT ck_sugerencia_opciones_orden CHECK ((orden >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencias_diccionario'::regclass
                 AND conname = 'ck_sugerencias_diccionario_id') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencias_diccionario ADD CONSTRAINT ck_sugerencias_diccionario_id CHECK ((id ~ '^s[0-9]{3,}$'::text));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_campos_bd'::regclass
                 AND conname = 'ck_termino_campos_bd_aplica_a') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd ADD CONSTRAINT ck_termino_campos_bd_aplica_a CHECK ((length(aplica_a) <= 200));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_campos_bd'::regclass
                 AND conname = 'ck_termino_campos_bd_campo') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd ADD CONSTRAINT ck_termino_campos_bd_campo CHECK (((length(btrim(campo)) >= 1) AND (length(btrim(campo)) <= 200)));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_campos_bd'::regclass
                 AND conname = 'ck_termino_campos_bd_orden') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd ADD CONSTRAINT ck_termino_campos_bd_orden CHECK ((orden >= 0));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_terminos'::regclass
                 AND conname = 'ck_terminos_campo_softland') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_terminos ADD CONSTRAINT ck_terminos_campo_softland CHECK ((length(campo_softland) <= 300));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_terminos'::regclass
                 AND conname = 'ck_terminos_termino') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_terminos ADD CONSTRAINT ck_terminos_termino CHECK (((length(btrim(termino)) >= 1) AND (length(btrim(termino)) <= 300)));
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_atributos_maestro'::regclass
                 AND conname = 'fk_atributos_maestro_sincronizaciones') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_atributos_maestro ADD CONSTRAINT fk_atributos_maestro_sincronizaciones FOREIGN KEY (sincronizacion_id) REFERENCES tbl_sincronizaciones(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_auditoria_terminos'::regclass
                 AND conname = 'fk_auditoria_terminos_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_auditoria_terminos ADD CONSTRAINT fk_auditoria_terminos_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_definicion_fragmentos'::regclass
                 AND conname = 'fk_definicion_fragmentos_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_definicion_fragmentos ADD CONSTRAINT fk_definicion_fragmentos_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_diccionario_softland'::regclass
                 AND conname = 'fk_diccionario_softland_sincronizaciones') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_diccionario_softland ADD CONSTRAINT fk_diccionario_softland_sincronizaciones FOREIGN KEY (sincronizacion_id) REFERENCES tbl_sincronizaciones(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencia_opciones'::regclass
                 AND conname = 'fk_sugerencia_opciones_sugerencias_diccionario') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencia_opciones ADD CONSTRAINT fk_sugerencia_opciones_sugerencias_diccionario FOREIGN KEY (sugerencia_id) REFERENCES tbl_sugerencias_diccionario(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_sugerencias_diccionario'::regclass
                 AND conname = 'fk_sugerencias_diccionario_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_sugerencias_diccionario ADD CONSTRAINT fk_sugerencias_diccionario_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_campos_bd'::regclass
                 AND conname = 'fk_termino_campos_bd_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd ADD CONSTRAINT fk_termino_campos_bd_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_etiquetas'::regclass
                 AND conname = 'fk_termino_etiquetas_etiquetas') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_etiquetas ADD CONSTRAINT fk_termino_etiquetas_etiquetas FOREIGN KEY (etiqueta_id) REFERENCES tbl_etiquetas(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_etiquetas'::regclass
                 AND conname = 'fk_termino_etiquetas_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_etiquetas ADD CONSTRAINT fk_termino_etiquetas_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_maestros'::regclass
                 AND conname = 'fk_termino_maestros_maestros') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_maestros ADD CONSTRAINT fk_termino_maestros_maestros FOREIGN KEY (maestro_id) REFERENCES tbl_maestros(id) ON DELETE RESTRICT;
  END IF;
END
$do$;
DO $do$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conrelid = 'may_prd_glosario_sch_core.tbl_termino_maestros'::regclass
                 AND conname = 'fk_termino_maestros_terminos') THEN
    ALTER TABLE may_prd_glosario_sch_core.tbl_termino_maestros ADD CONSTRAINT fk_termino_maestros_terminos FOREIGN KEY (termino_id) REFERENCES tbl_terminos(id) ON DELETE CASCADE;
  END IF;
END
$do$;

-- ---------------------------------------------------------------- índices
CREATE INDEX IF NOT EXISTS idx_atributos_maestro_sincronizacion_id_nombre_tecnico ON may_prd_glosario_sch_core.tbl_atributos_maestro USING btree (sincronizacion_id, nombre_tecnico);
CREATE INDEX IF NOT EXISTS idx_auditoria_terminos_termino_id_creado_en ON may_prd_glosario_sch_core.tbl_auditoria_terminos USING btree (termino_id, creado_en DESC);
CREATE INDEX IF NOT EXISTS idx_diccionario_softland_sincronizacion_id_columna ON may_prd_glosario_sch_core.tbl_diccionario_softland USING btree (sincronizacion_id, columna);
CREATE UNIQUE INDEX IF NOT EXISTS uidx_etiquetas_nombre_key ON may_prd_glosario_sch_core.tbl_etiquetas USING btree (lower(nombre));
CREATE UNIQUE INDEX IF NOT EXISTS uidx_maestros_nombre_key ON may_prd_glosario_sch_core.tbl_maestros USING btree (lower(nombre));
CREATE INDEX IF NOT EXISTS idx_sincronizaciones_origen_iniciada_en ON may_prd_glosario_sch_core.tbl_sincronizaciones USING btree (origen, iniciada_en DESC);
CREATE UNIQUE INDEX IF NOT EXISTS uidx_sincronizaciones_origen_partial ON may_prd_glosario_sch_core.tbl_sincronizaciones USING btree (origen) WHERE es_vigente;
CREATE INDEX IF NOT EXISTS idx_sugerencias_diccionario_estado_orden ON may_prd_glosario_sch_core.tbl_sugerencias_diccionario USING btree (estado, orden);
CREATE INDEX IF NOT EXISTS idx_sugerencias_diccionario_termino_id ON may_prd_glosario_sch_core.tbl_sugerencias_diccionario USING btree (termino_id);
CREATE INDEX IF NOT EXISTS idx_termino_etiquetas_etiqueta_id ON may_prd_glosario_sch_core.tbl_termino_etiquetas USING btree (etiqueta_id);
CREATE INDEX IF NOT EXISTS idx_termino_maestros_maestro_id ON may_prd_glosario_sch_core.tbl_termino_maestros USING btree (maestro_id);
CREATE INDEX IF NOT EXISTS idx_terminos_termino ON may_prd_glosario_sch_core.tbl_terminos USING btree (lower(termino));

-- ---------------------------------------------------------------- funciones (usan tipos de tabla)
-- ---------------------------------------------------------------- vistas y vistas materializadas

-- ---------------------------------------------------------------- índices de vistas materializadas

-- ---------------------------------------------------------------- triggers

-- RLS: rls_mode=backend → la autorización vive en los use cases (ver generation-report.json).

-- ---------------------------------------------------------------- comentarios
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_atributos_maestro IS 'Filas de las matrices Modelo de Atributos del Dato Maestro (ArtÃ­culos y Clientes)';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_auditoria_terminos IS 'Historial de cambios de los tÃ©rminos; hecho_por es la etiqueta de la llave usada';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_definicion_fragmentos IS 'DefiniciÃ³n por contexto de origen de los tÃ©rminos fusionados';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_diccionario_softland IS 'Columnas del Diccionario de datos de Softland sincronizadas por n8n';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_etiquetas IS 'Etiquetas de Silo / Sistema de Origen y de Rol en Reporte SIM. Las base no se eliminan';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_llaves_acceso IS 'Llaves del enlace de administraciÃ³n y de la ingesta de n8n. Solo se guarda el SHA-256';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_maestros IS 'Maestros de Datos (matrices de atributos). ArtÃ­culo y Cliente son base y no se eliminan';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_sincronizaciones IS 'BitÃ¡cora de cargas de n8n. Por origen solo una carga completada es la vigente';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_sugerencia_opciones IS 'Columnas candidatas del diccionario para cada coincidencia (hasta 6)';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_sugerencias_diccionario IS 'Coincidencias tÃ©rmino â†” columna del Diccionario de Softland revisadas por Procesos';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_termino_campos_bd IS 'Campo en Base de Datos: una fila por campo (varias si cambia por empresa o tabla)';
COMMENT ON TABLE may_prd_glosario_sch_core.tbl_terminos IS 'TÃ©rminos de negocio del glosario (borrado lÃ³gico con eliminado_en)';
COMMENT ON COLUMN may_prd_glosario_sch_core.tbl_terminos.es_nuevo IS 'true si el tÃ©rmino se creÃ³ desde AdministraciÃ³n';
COMMENT ON COLUMN may_prd_glosario_sch_core.tbl_terminos.editado IS 'true solo si Procesos cambiÃ³ el nombre, la definiciÃ³n o las etiquetas';

COMMIT;

\echo 'Esquema creado/actualizado.'
