-- Modelo de datos fuente del Glosario de Términos (PostgreSQL estándar, nombres de negocio).
-- generate_aurora_sql.py aplica el naming Intelix (tbl_, fn_, idx_, ...), roles y esquemas por ambiente.
-- Convertido desde glosario-terminos-mayoreo/db/esquema.sql (SQL Server) y ampliado con las tablas
-- sincronizadas por n8n (maestros y diccionario de Softland), la bitácora de cargas y las llaves de acceso.
-- La app no tiene usuarios (sin Cognito): quien hace un cambio se registra con la etiqueta de su llave.

CREATE TYPE tipo_etiqueta AS ENUM ('silo_sistema', 'rol_reporte_sim');
CREATE TYPE estado_origen_termino AS ENUM ('fusionado', 'homonimo', 'dudoso', 'sinetiqueta');
CREATE TYPE confianza_coincidencia AS ENUM ('Alta', 'Media', 'Baja');
CREATE TYPE estado_coincidencia AS ENUM ('pendiente', 'aplicada', 'descartada');
CREATE TYPE proposito_llave AS ENUM ('administracion', 'ingesta');
CREATE TYPE origen_sincronizacion AS ENUM ('maestro_articulos', 'maestro_clientes', 'diccionario_softland');
CREATE TYPE estado_sincronizacion AS ENUM ('en_curso', 'completada', 'fallida');

-- ---------------------------------------------------------------- catálogos

CREATE TABLE maestros (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre text NOT NULL CHECK (length(btrim(nombre)) BETWEEN 1 AND 100),
  es_base boolean NOT NULL DEFAULT false,
  creado_en timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX maestros_nombre_key ON maestros (lower(nombre));
COMMENT ON TABLE maestros IS 'Maestros de Datos (matrices de atributos). Artículo y Cliente son base y no se eliminan';

CREATE TABLE etiquetas (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nombre text NOT NULL CHECK (length(btrim(nombre)) BETWEEN 1 AND 150),
  tipo tipo_etiqueta NOT NULL,
  es_base boolean NOT NULL DEFAULT false,
  creado_en timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX etiquetas_nombre_key ON etiquetas (lower(nombre));
COMMENT ON TABLE etiquetas IS 'Etiquetas de Silo / Sistema de Origen y de Rol en Reporte SIM. Las base no se eliminan';

-- ---------------------------------------------------------------- términos

CREATE TABLE terminos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  termino text NOT NULL CHECK (length(btrim(termino)) BETWEEN 1 AND 300),
  definicion text NOT NULL DEFAULT '',
  campo_softland text NOT NULL DEFAULT '' CHECK (length(campo_softland) <= 300),
  estado_origen estado_origen_termino,
  nota_origen text,
  revisado boolean NOT NULL DEFAULT false,
  nota_decision text,
  es_nuevo boolean NOT NULL DEFAULT false,
  editado boolean NOT NULL DEFAULT false,
  eliminado_en timestamptz,
  creado_en timestamptz NOT NULL DEFAULT now(),
  actualizado_en timestamptz
);
CREATE INDEX terminos_termino_idx ON terminos (lower(termino));
COMMENT ON TABLE terminos IS 'Términos de negocio del glosario (borrado lógico con eliminado_en)';
COMMENT ON COLUMN terminos.editado IS 'true solo si Procesos cambió el nombre, la definición o las etiquetas';
COMMENT ON COLUMN terminos.es_nuevo IS 'true si el término se creó desde Administración';

CREATE TABLE termino_campos_bd (
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  orden integer NOT NULL CHECK (orden >= 0),
  campo text NOT NULL CHECK (length(btrim(campo)) BETWEEN 1 AND 200),
  aplica_a text NOT NULL DEFAULT '' CHECK (length(aplica_a) <= 200),
  PRIMARY KEY (termino_id, orden)
);
COMMENT ON TABLE termino_campos_bd IS 'Campo en Base de Datos: una fila por campo (varias si cambia por empresa o tabla)';

CREATE TABLE definicion_fragmentos (
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  orden integer NOT NULL CHECK (orden >= 0),
  contexto text NOT NULL,
  texto text NOT NULL,
  PRIMARY KEY (termino_id, orden)
);
COMMENT ON TABLE definicion_fragmentos IS 'Definición por contexto de origen de los términos fusionados';

CREATE TABLE termino_etiquetas (
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  etiqueta_id bigint NOT NULL REFERENCES etiquetas (id) ON DELETE CASCADE,
  orden integer NOT NULL DEFAULT 0,
  PRIMARY KEY (termino_id, etiqueta_id)
);
CREATE INDEX termino_etiquetas_etiqueta_idx ON termino_etiquetas (etiqueta_id);

CREATE TABLE termino_maestros (
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  maestro_id bigint NOT NULL REFERENCES maestros (id) ON DELETE RESTRICT,
  orden integer NOT NULL DEFAULT 0,
  PRIMARY KEY (termino_id, maestro_id)
);
CREATE INDEX termino_maestros_maestro_idx ON termino_maestros (maestro_id);

CREATE TABLE auditoria_terminos (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  accion text NOT NULL CHECK (accion IN ('crear', 'editar', 'eliminar', 'restaurar', 'aplicar_coincidencia')),
  campo text NOT NULL,
  valor_anterior text,
  valor_nuevo text,
  hecho_por text NOT NULL,
  creado_en timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX auditoria_terminos_termino_idx ON auditoria_terminos (termino_id, creado_en DESC);
COMMENT ON TABLE auditoria_terminos IS 'Historial de cambios de los términos; hecho_por es la etiqueta de la llave usada';

-- ---------------------------------------------------------------- coincidencias con el diccionario de Softland

CREATE TABLE sugerencias_diccionario (
  id text PRIMARY KEY CHECK (id ~ '^s[0-9]{3,}$'),
  termino_id uuid NOT NULL REFERENCES terminos (id) ON DELETE CASCADE,
  confianza confianza_coincidencia,
  orden integer NOT NULL DEFAULT 0,
  estado estado_coincidencia NOT NULL DEFAULT 'pendiente',
  maestro_sugerido text NOT NULL DEFAULT '',
  elegido_columna text,
  elegido_tabla text,
  elegido_etiqueta text,
  elegido_maestro text,
  decidido_en timestamptz,
  decidido_por text,
  fuente text NOT NULL DEFAULT ''
);
CREATE INDEX sugerencias_diccionario_estado_idx ON sugerencias_diccionario (estado, orden);
CREATE INDEX sugerencias_diccionario_termino_idx ON sugerencias_diccionario (termino_id);
COMMENT ON TABLE sugerencias_diccionario IS 'Coincidencias término ↔ columna del Diccionario de Softland revisadas por Procesos';

CREATE TABLE sugerencia_opciones (
  sugerencia_id text NOT NULL REFERENCES sugerencias_diccionario (id) ON DELETE CASCADE,
  orden integer NOT NULL CHECK (orden >= 0),
  columna text NOT NULL,
  etiqueta text NOT NULL DEFAULT '',
  tabla text NOT NULL DEFAULT '',
  modulo text NOT NULL DEFAULT '',
  descripcion text NOT NULL DEFAULT '',
  n_tablas integer NOT NULL DEFAULT 0 CHECK (n_tablas >= 0),
  otras_tablas text[] NOT NULL DEFAULT '{}',
  observacion text NOT NULL DEFAULT '',
  PRIMARY KEY (sugerencia_id, orden)
);
COMMENT ON TABLE sugerencia_opciones IS 'Columnas candidatas del diccionario para cada coincidencia (hasta 6)';

-- ---------------------------------------------------------------- llaves de acceso (sin Cognito)

CREATE TABLE llaves_acceso (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  proposito proposito_llave NOT NULL,
  etiqueta text NOT NULL CHECK (length(btrim(etiqueta)) BETWEEN 1 AND 100),
  hash_llave text NOT NULL CHECK (hash_llave ~ '^[0-9a-f]{64}$'),
  activa boolean NOT NULL DEFAULT true,
  creado_en timestamptz NOT NULL DEFAULT now(),
  revocada_en timestamptz,
  CONSTRAINT llaves_acceso_hash_key UNIQUE (hash_llave)
);
COMMENT ON TABLE llaves_acceso IS 'Llaves del enlace de administración y de la ingesta de n8n. Solo se guarda el SHA-256';

-- ---------------------------------------------------------------- sincronizaciones de n8n

CREATE TABLE sincronizaciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  origen origen_sincronizacion NOT NULL,
  estado estado_sincronizacion NOT NULL DEFAULT 'en_curso',
  es_vigente boolean NOT NULL DEFAULT false,
  filas_esperadas integer CHECK (filas_esperadas >= 0),
  filas_recibidas integer NOT NULL DEFAULT 0 CHECK (filas_recibidas >= 0),
  iniciada_por text NOT NULL,
  iniciada_en timestamptz NOT NULL DEFAULT now(),
  finalizada_en timestamptz,
  error text
);
CREATE INDEX sincronizaciones_origen_idx ON sincronizaciones (origen, iniciada_en DESC);
CREATE UNIQUE INDEX sincronizaciones_vigente_key ON sincronizaciones (origen) WHERE es_vigente;
COMMENT ON TABLE sincronizaciones IS 'Bitácora de cargas de n8n. Por origen solo una carga completada es la vigente';

CREATE TABLE atributos_maestro (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  sincronizacion_id uuid NOT NULL REFERENCES sincronizaciones (id) ON DELETE CASCADE,
  hoja text NOT NULL DEFAULT '',
  fila integer NOT NULL CHECK (fila >= 0),
  grupo text NOT NULL DEFAULT '',
  atributo text NOT NULL DEFAULT '',
  nombre_tecnico text NOT NULL DEFAULT '',
  definicion text NOT NULL DEFAULT '',
  empresas_aplica text NOT NULL DEFAULT '',
  obligatorio boolean,
  validaciones text NOT NULL DEFAULT '',
  tipo_dato text NOT NULL DEFAULT '',
  fuente_dato text NOT NULL DEFAULT '',
  dominio_valores text NOT NULL DEFAULT '',
  valor_default text NOT NULL DEFAULT '',
  permite_null text NOT NULL DEFAULT '',
  condicion_null text NOT NULL DEFAULT '',
  dptos_consumidores text NOT NULL DEFAULT '',
  sistemas text[] NOT NULL DEFAULT '{}'
);
CREATE INDEX atributos_maestro_sincronizacion_idx ON atributos_maestro (sincronizacion_id, nombre_tecnico);
COMMENT ON TABLE atributos_maestro IS 'Filas de las matrices Modelo de Atributos del Dato Maestro (Artículos y Clientes)';

CREATE TABLE diccionario_softland (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  sincronizacion_id uuid NOT NULL REFERENCES sincronizaciones (id) ON DELETE CASCADE,
  esquema text NOT NULL DEFAULT '',
  modulo text NOT NULL DEFAULT '',
  tabla text NOT NULL CHECK (length(btrim(tabla)) > 0),
  columna text NOT NULL CHECK (length(btrim(columna)) > 0),
  descripcion text NOT NULL DEFAULT '',
  tipo_dato text NOT NULL DEFAULT '',
  tamano text NOT NULL DEFAULT '',
  permite_nulos boolean,
  llave_primaria boolean,
  llave_foranea boolean,
  valor_default text NOT NULL DEFAULT '',
  posibles_valores text NOT NULL DEFAULT '',
  editable_procesos_masivos boolean,
  editable_primera_vez boolean,
  modo_case text NOT NULL DEFAULT '',
  tipo_mascara text NOT NULL DEFAULT '',
  autocalculado boolean,
  visible boolean,
  solo_lectura boolean,
  requerido boolean,
  mostrar_como text NOT NULL DEFAULT '',
  tipo_consecutivo text NOT NULL DEFAULT '',
  formato_justificado text NOT NULL DEFAULT '',
  valor_etiqueta text NOT NULL DEFAULT '',
  mostrar_en_f1 boolean
);
CREATE INDEX diccionario_softland_columna_idx ON diccionario_softland (sincronizacion_id, columna);
COMMENT ON TABLE diccionario_softland IS 'Columnas del Diccionario de datos de Softland sincronizadas por n8n';
