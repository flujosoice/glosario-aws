-- =============================================================================
-- may_qa_glosario — Aurora PostgreSQL — ROLLBACK
-- Ambiente: qa | Base: may_qa_glosario_db
-- Ejecutar como: master conectado a may_qa_glosario_db. Orden descendente; NUNCA contra Supabase
-- psql -v ON_ERROR_STOP=1 ... Generado por la skill aws-project-* (no editar a mano;
-- ajustar config.yaml y regenerar).
-- =============================================================================
\set ON_ERROR_STOP on
DO $do$
BEGIN
  IF current_database() <> 'may_qa_glosario_db' THEN
    RAISE EXCEPTION 'Rollback abortado: base actual % distinta de may_qa_glosario_db', current_database();
  END IF;
  IF EXISTS (SELECT 1 FROM pg_namespace WHERE nspname IN ('auth', 'storage', 'supabase_functions', 'realtime')) THEN
    RAISE EXCEPTION 'Rollback abortado: se detectaron esquemas de Supabase en la base actual.';
  END IF;
END
$do$;
BEGIN;
-- 0a. extensiones del aplicativo (la base es exclusiva del aplicativo; arrastran sus índices)
-- 0b. todo lo que pertenece al rol ddl del aplicativo: lo generado por la skill y lo agregado por
--     database/changes (incluida tbl_schema_changes) aunque dependa entre sí. Un objeto de OTRO
--     dueño que dependa de estos hace fallar el rollback (DROP OWNED no usa CASCADE).
DROP OWNED BY ddl_glosario;
-- 2. vistas materializadas y vistas
-- 3. FK
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_atributos_maestro DROP CONSTRAINT IF EXISTS fk_atributos_maestro_sincronizaciones;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_auditoria_terminos DROP CONSTRAINT IF EXISTS fk_auditoria_terminos_terminos;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_definicion_fragmentos DROP CONSTRAINT IF EXISTS fk_definicion_fragmentos_terminos;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_diccionario_softland DROP CONSTRAINT IF EXISTS fk_diccionario_softland_sincronizaciones;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_sugerencia_opciones DROP CONSTRAINT IF EXISTS fk_sugerencia_opciones_sugerencias_diccionario;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_sugerencias_diccionario DROP CONSTRAINT IF EXISTS fk_sugerencias_diccionario_terminos;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_campos_bd DROP CONSTRAINT IF EXISTS fk_termino_campos_bd_terminos;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_etiquetas DROP CONSTRAINT IF EXISTS fk_termino_etiquetas_etiquetas;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_etiquetas DROP CONSTRAINT IF EXISTS fk_termino_etiquetas_terminos;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_maestros DROP CONSTRAINT IF EXISTS fk_termino_maestros_maestros;
ALTER TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_maestros DROP CONSTRAINT IF EXISTS fk_termino_maestros_terminos;
-- 4. tablas (orden topológico inverso)
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_sugerencia_opciones;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_maestros;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_etiquetas;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_termino_campos_bd;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_sugerencias_diccionario;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_diccionario_softland;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_definicion_fragmentos;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_auditoria_terminos;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_atributos_maestro;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_terminos;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_sincronizaciones;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_maestros;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_llaves_acceso;
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_etiquetas;
-- 5. funciones
DROP TABLE IF EXISTS may_qa_glosario_sch_core.tbl_app_users;
DROP FUNCTION IF EXISTS may_qa_glosario_sch_core.fn_auth_uid();
DROP FUNCTION IF EXISTS may_qa_glosario_sch_core.fn_auth_role();
DROP FUNCTION IF EXISTS may_qa_glosario_sch_core.fn_auth_email();
DROP FUNCTION IF EXISTS may_qa_glosario_sch_core.fn_auth_jwt();
-- 6. secuencias y tipos
DROP TYPE IF EXISTS may_qa_glosario_sch_core.tipo_etiqueta;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.proposito_llave;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.origen_sincronizacion;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.estado_sincronizacion;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.estado_origen_termino;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.estado_coincidencia;
DROP TYPE IF EXISTS may_qa_glosario_sch_core.confianza_coincidencia;
-- 7. extensiones
-- 8. esquemas (RESTRICT: falla si quedan objetos no generados por esta skill)
DROP SCHEMA IF EXISTS may_qa_glosario_sch_core;
-- 9. privilegios y default privileges de los roles en esta base
DROP OWNED BY ro_glosario, rw_glosario, ddl_glosario, admin_glosario;
COMMIT;

-- 10. Base de datos, usuarios y roles: requiere conexión a 'postgres' y CONFIRMACIÓN HUMANA.
--     Descomentar el bloque y ejecutarlo aparte.
-- >>> MANUAL_BEGIN <<<
-- \connect postgres
-- DROP DATABASE IF EXISTS may_qa_glosario_db;
-- DROP ROLE IF EXISTS usr_glosario_dba;
-- DROP ROLE IF EXISTS usr_glosario_deploy;
-- DROP ROLE IF EXISTS usr_glosario_app;
-- DROP ROLE IF EXISTS usr_glosario_report;
-- REVOKE admin_glosario FROM CURRENT_USER;
-- DROP ROLE IF EXISTS admin_glosario;
-- DROP ROLE IF EXISTS ddl_glosario;
-- DROP ROLE IF EXISTS rw_glosario;
-- DROP ROLE IF EXISTS ro_glosario;
-- >>> MANUAL_END <<<

\echo 'Rollback de objetos completado.'
