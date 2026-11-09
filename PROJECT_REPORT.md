# PROJECT REPORT — Glosario de Términos

**Estado: PROJECT COMPLETE**  
Generado: 2026-10-30T19:18:30+00:00 · Validación: 2026-10-30T19:18:29+00:00

## 1. Resumen

| Aspecto | Solución |
|---|---|
| Frontend | React vite + TypeScript, react-router · hosting amplify-static |
| API | API Gateway REST REGIONAL + 23 endpoints Lambda python3.13 (hexagonal) |
| Base de datos | Aurora PostgreSQL `may_dev_glosario_db` · 14 tablas, 0 vistas, 0 funciones |
| Auth | Amazon Cognito (grupos: procesos, consulta) |
| Requisitos | 15 en project-spec.yaml |
| Exposición | public — Sin Cognito por decisión del negocio: la app se embebe en el Portal Interno Mayoreo, que controla quién abre el enlace general (solo lectura) y el enlace de administración de Procesos. La API queda alcanzable desde internet sin sesión de usuario, por eso va con WAF (reglas administradas y límite de peticiones), CORS restringido al dominio de la app y llaves de acceso validadas en el backend para toda escritura (llave de administración) y para la ingesta de n8n (llave de ingesta). |

## 2. Criterios de finalización (16)

| # | Criterio | Estado |
|---|---|---|
| 1 | Especificación completa: project-spec con requisitos, modelo de datos fuente y esquema introspeccionado | OK |
| 2 | Manifest del proyecto revisado (sin borrador, endpoints y pantallas trazados a requisitos) | OK |
| 3 | Scripts Aurora completos por ambiente (provisioning, schema, validation, rollback, migration) | OK |
| 4 | SQL Aurora validado en PostgreSQL efímero (idempotente, TOTAL_FALTA=0, rollback limpio) | OK |
| 5 | Backend hexagonal: handlers y use cases existen; dependencias entre capas y SQL en su lugar | OK |
| 6 | Tests del backend en verde (unitarios con fakes e integración contra el esquema generado) | OK |
| 7 | Lint del backend limpio (ruff) | OK |
| 8 | Template SAM único y samconfig dev/qa/prod con tags y rutas por ambiente | OK |
| 9 | Template válido (cfn-lint y transformación SAM) | OK |
| 10 | IAM mínimo y resiliencia (sin wildcards salvo ENI; SQS con DLQ, reintentos, visibility e idempotencia) | OK |
| 11 | Frontend con arquitectura estándar (Page → Controller → Api → axiosApiGateway, naming y tamaños) | OK |
| 12 | Frontend compila, cumple Prettier y sus tests pasan | OK |
| 13 | Sin SDKs de BaaS ni accesos directos a datos desde el frontend (Supabase, Firebase) | OK |
| 14 | Sin secretos ni identificadores de ambiente hardcodeados | OK |
| 15 | Sin TODO/FIXME/pseudocódigo en el código generado | OK |
| 16 | Reporte final con matriz REQUISITO → DESTINO y solo pendientes de configuración | OK |

## 3. Matriz REQUISITO → DESTINO

### 3.1 Requisitos

| Requisito | Descripción | Endpoints | Use cases | Pantallas |
|---|---|---|---|---|
| RF-01 | Consultar el glosario | GET /terms → `ListTerms` | `ListTermsUseCase` | `/` |
| RF-02 | Buscar términos | GET /terms → `ListTerms` | `ListTermsUseCase` | `/` |
| RF-03 | Filtrar términos | GET /terms → `ListTerms`<br>GET /catalogs → `GetCatalogs` | `ListTermsUseCase`, `GetCatalogsUseCase` | `/` |
| RF-04 | Ver la ficha de un término | GET /terms → `ListTerms` | `ListTermsUseCase` | `/` |
| RF-05 | Entrar a la administración con el enlace de Procesos | GET /me → `GetAccess` | `GetAccessUseCase` | `/administracion` |
| RF-06 | Ver indicadores de administración | GET /admin/terms → `ListAdminTerms` | `ListAdminTermsUseCase` | `/administracion`, `/administracion/etiquetas`, `/administracion/maestros`, `/administracion/diccionario` |
| RF-07 | Crear y editar términos | GET /admin/terms → `ListAdminTerms`<br>POST /admin/terms → `CreateTerm`<br>PUT /admin/terms/{termId} → `UpdateTerm` | `ListAdminTermsUseCase`, `CreateTermUseCase`, `UpdateTermUseCase` | `/administracion` |
| RF-08 | Eliminar y restaurar términos | GET /admin/terms → `ListAdminTerms`<br>DELETE /admin/terms/{termId} → `DeleteTerm`<br>POST /admin/terms/{termId}/restore → `RestoreTerm` | `ListAdminTermsUseCase`, `DeleteTermUseCase`, `RestoreTermUseCase` | `/administracion` |
| RF-09 | Gestionar etiquetas | GET /catalogs → `GetCatalogs`<br>POST /admin/tags → `CreateTag`<br>DELETE /admin/tags/{tagId} → `DeleteTag` | `GetCatalogsUseCase`, `CreateTagUseCase`, `DeleteTagUseCase` | `/administracion/etiquetas` |
| RF-10 | Gestionar maestros | GET /catalogs → `GetCatalogs`<br>POST /admin/masters → `CreateMaster`<br>DELETE /admin/masters/{masterId} → `DeleteMaster` | `GetCatalogsUseCase`, `CreateMasterUseCase`, `DeleteMasterUseCase` | `/administracion/maestros` |
| RF-11 | Revisar coincidencias con el Diccionario de Softland | GET /admin/dictionary-matches → `ListDictionaryMatches`<br>POST /admin/dictionary-matches/{matchId}/apply → `ApplyDictionaryMatch`<br>POST /admin/dictionary-matches/{matchId}/discard → `DiscardDictionaryMatch`<br>POST /admin/dictionary-matches/{matchId}/reopen → `ReopenDictionaryMatch`<br>GET /admin/softland-dictionary → `SearchSoftlandDictionary` | `ListDictionaryMatchesUseCase`, `ApplyDictionaryMatchUseCase`, `DiscardDictionaryMatchUseCase`, `ReopenDictionaryMatchUseCase`, `SearchSoftlandDictionaryUseCase` | `/administracion/diccionario` |
| RF-12 | Sincronizar los Maestros de Artículos y de Clientes | POST /ingest/sync-runs → `StartSyncRun`<br>POST /ingest/sync-runs/{runId}/rows → `AppendSyncRows`<br>POST /ingest/sync-runs/{runId}/complete → `CompleteSyncRun`<br>POST /ingest/sync-runs/{runId}/fail → `FailSyncRun` | `StartSyncRunUseCase`, `AppendSyncRowsUseCase`, `CompleteSyncRunUseCase`, `FailSyncRunUseCase` | — |
| RF-13 | Sincronizar el Diccionario de Softland | GET /admin/softland-dictionary → `SearchSoftlandDictionary`<br>POST /ingest/sync-runs → `StartSyncRun`<br>POST /ingest/sync-runs/{runId}/rows → `AppendSyncRows`<br>POST /ingest/sync-runs/{runId}/complete → `CompleteSyncRun`<br>POST /ingest/sync-runs/{runId}/fail → `FailSyncRun` | `SearchSoftlandDictionaryUseCase`, `StartSyncRunUseCase`, `AppendSyncRowsUseCase`, `CompleteSyncRunUseCase`, `FailSyncRunUseCase` | — |
| RF-14 | Consultar la bitácora de sincronizaciones | GET /sync-runs → `ListSyncRuns` | `ListSyncRunsUseCase` | — |
| RF-15 | Verificar la salud del servicio | GET /health → `GetHealth` | `GetHealthUseCase` | — |

### 3.2 Endpoints

| Método | Ruta | Función Lambda | Handler | Auth |
|---|---|---|---|---|
| GET | /me | GetAccess | entrypoints.lambda_handlers.access.get_access_handler | none |
| GET | /health | GetHealth | entrypoints.lambda_handlers.access.get_health_handler | none |
| GET | /terms | ListTerms | entrypoints.lambda_handlers.glossary.list_terms_handler | none |
| GET | /catalogs | GetCatalogs | entrypoints.lambda_handlers.catalogs.get_catalogs_handler | none |
| GET | /admin/terms | ListAdminTerms | entrypoints.lambda_handlers.glossary.list_admin_terms_handler | none |
| POST | /admin/terms | CreateTerm | entrypoints.lambda_handlers.glossary.create_term_handler | none |
| PUT | /admin/terms/{termId} | UpdateTerm | entrypoints.lambda_handlers.glossary.update_term_handler | none |
| DELETE | /admin/terms/{termId} | DeleteTerm | entrypoints.lambda_handlers.glossary.delete_term_handler | none |
| POST | /admin/terms/{termId}/restore | RestoreTerm | entrypoints.lambda_handlers.glossary.restore_term_handler | none |
| POST | /admin/tags | CreateTag | entrypoints.lambda_handlers.catalogs.create_tag_handler | none |
| DELETE | /admin/tags/{tagId} | DeleteTag | entrypoints.lambda_handlers.catalogs.delete_tag_handler | none |
| POST | /admin/masters | CreateMaster | entrypoints.lambda_handlers.catalogs.create_master_handler | none |
| DELETE | /admin/masters/{masterId} | DeleteMaster | entrypoints.lambda_handlers.catalogs.delete_master_handler | none |
| GET | /admin/dictionary-matches | ListDictionaryMatches | entrypoints.lambda_handlers.dictionary.list_dictionary_matches_handler | none |
| POST | /admin/dictionary-matches/{matchId}/apply | ApplyDictionaryMatch | entrypoints.lambda_handlers.dictionary.apply_dictionary_match_handler | none |
| POST | /admin/dictionary-matches/{matchId}/discard | DiscardDictionaryMatch | entrypoints.lambda_handlers.dictionary.discard_dictionary_match_handler | none |
| POST | /admin/dictionary-matches/{matchId}/reopen | ReopenDictionaryMatch | entrypoints.lambda_handlers.dictionary.reopen_dictionary_match_handler | none |
| GET | /admin/softland-dictionary | SearchSoftlandDictionary | entrypoints.lambda_handlers.dictionary.search_softland_dictionary_handler | none |
| GET | /sync-runs | ListSyncRuns | entrypoints.lambda_handlers.sync.list_sync_runs_handler | none |
| POST | /ingest/sync-runs | StartSyncRun | entrypoints.lambda_handlers.sync.start_sync_run_handler | none |
| POST | /ingest/sync-runs/{runId}/rows | AppendSyncRows | entrypoints.lambda_handlers.sync.append_sync_rows_handler | none |
| POST | /ingest/sync-runs/{runId}/complete | CompleteSyncRun | entrypoints.lambda_handlers.sync.complete_sync_run_handler | none |
| POST | /ingest/sync-runs/{runId}/fail | FailSyncRun | entrypoints.lambda_handlers.sync.fail_sync_run_handler | none |

### 3.3 Objetos de base de datos

| Origen | Aurora | Tipo |
|---|---|---|
| public.atributos_maestro | may_dev_glosario_sch_core.tbl_atributos_maestro | table |
| public.auditoria_terminos | may_dev_glosario_sch_core.tbl_auditoria_terminos | table |
| public.definicion_fragmentos | may_dev_glosario_sch_core.tbl_definicion_fragmentos | table |
| public.diccionario_softland | may_dev_glosario_sch_core.tbl_diccionario_softland | table |
| public.etiquetas | may_dev_glosario_sch_core.tbl_etiquetas | table |
| public.llaves_acceso | may_dev_glosario_sch_core.tbl_llaves_acceso | table |
| public.maestros | may_dev_glosario_sch_core.tbl_maestros | table |
| public.sincronizaciones | may_dev_glosario_sch_core.tbl_sincronizaciones | table |
| public.sugerencia_opciones | may_dev_glosario_sch_core.tbl_sugerencia_opciones | table |
| public.sugerencias_diccionario | may_dev_glosario_sch_core.tbl_sugerencias_diccionario | table |
| public.termino_campos_bd | may_dev_glosario_sch_core.tbl_termino_campos_bd | table |
| public.termino_etiquetas | may_dev_glosario_sch_core.tbl_termino_etiquetas | table |
| public.termino_maestros | may_dev_glosario_sch_core.tbl_termino_maestros | table |
| public.terminos | may_dev_glosario_sch_core.tbl_terminos | table |
| auth.users | may_dev_glosario_sch_core.tbl_app_users | table |
| auth.uid() | fn_auth_uid() | auth helper |
| auth.role() | fn_auth_role() | auth helper |
| auth.email() | fn_auth_email() | auth helper |
| auth.jwt() | fn_auth_jwt() | auth helper |

Roles: `ro_glosario`, `rw_glosario`, `ddl_glosario`, `admin_glosario` · Usuarios: `usr_glosario_report`, `usr_glosario_app`, `usr_glosario_deploy`, `usr_glosario_dba` · search_path: `may_dev_glosario_sch_core`

### 3.4 Reglas de autorización

| Tabla | Regla | Comando | Condición | Se aplica en |
|---|---|---|---|---|
| terminos | todos leen los términos activos; solo Procesos crea, edita, elimina y restaura | ALL | lectura: eliminado_en IS NULL; escritura: llave de administración vigente | ListTermsUseCase (solo activos) y require_admin en ListAdminTerms/Create/Update/Delete/RestoreTermUseCase |
| etiquetas | todos leen; Procesos agrega y elimina solo las que no son base | ALL | escritura: llave de administración y es_base = false | GetCatalogsUseCase; require_admin + regla es_base en CreateTagUseCase/DeleteTagUseCase |
| maestros | todos leen; Procesos agrega y elimina solo agregados sin términos | ALL | escritura: llave de administración, es_base = false y sin términos | GetCatalogsUseCase; require_admin + reglas en CreateMasterUseCase/DeleteMasterUseCase |
| sugerencias_diccionario | solo Procesos revisa coincidencias y busca en el diccionario | ALL | llave de administración vigente | require_admin en los casos de uso de dictionary (List/Apply/Discard/Reopen/SearchSoftlandDictionary) |
| sincronizaciones | solo n8n con llave de ingesta registra cargas; Procesos o n8n consultan la bitácora | ALL | escritura: llave de ingesta; lectura: llave de administración o de ingesta | require_ingest en Start/Append/Complete/FailSyncRunUseCase; require_any en ListSyncRunsUseCase |
| llaves_acceso | nadie la lee ni escribe desde la API; las llaves se dan de alta por SQL (solo el hash) | ALL | solo búsqueda por hash dentro de AccessGuard | PostgresAccessKeyRepository.find_active (sin endpoints de gestión) |

### 3.5 Servicios

| Origen | Destino |
|---|---|
| Supabase Auth | Amazon Cognito User Pool + authorizer de API Gateway |
| pg_cron `expire-sync-runs` | EventBridge Scheduler cron(15 * * * ? *) → `ExpireStaleSyncRunsJob` |

## 4. Cambios estructurales, incompatibilidades y riesgos

**Cambios estructurales:** 
- Sin Cognito: dos enlaces (general y administración) embebidos en el Portal Interno Mayoreo; las escrituras se validan con llaves de acceso (hash SHA-256 en tbl_llaves_acceso) en lugar de grupos de Cognito
- Todos los endpoints van con Authorizer NONE + public_reason y exposure public para tener WAF; la autorización real está en los casos de uso (AccessGuard)
- GET /me devuelve {puedeAdministrar, etiqueta} según la llave enviada, en lugar de resolver un usuario de Cognito
- El esquema SQL Server del paquete (db/esquema.sql) se convirtió a PostgreSQL con etiquetas y maestros por id, campos BD por filas y borrado lógico con eliminado_en
- Datos iniciales: database/tools/generar_semilla.py → database/source/900_seed_glosario.sql → aurora_postgresql_data.sql por ambiente (export_data_sql.py)
- Ingesta de n8n por cargas: iniciar → lotes de filas → completar (cambia la versión vigente en una transacción) o fallar; las cargas en curso por más de 2 horas se marcan fallidas cada hora
- Eliminar una etiqueta agregada la quita también de los términos que la tenían (ON DELETE CASCADE)
- La plantilla mantiene shared/auth/cognito-auth.ts y la dependencia aws-amplify porque el validador del estándar las exige; la app no las importa

**Incompatibilidades:** ninguno.

**Riesgos:** 
- Quien tenga el enlace de administración (llave incluida) puede escribir: el Portal Interno Mayoreo debe mostrarlo solo a Procesos; las llaves se rotan revocándolas en tbl_llaves_acceso
- Corte final: hay que volver a exportar la base de claude.ai (49 coincidencias pendientes) y regenerar la semilla antes de producción
- El template estándar crea un User Pool de Cognito si no se pasa CognitoUserPoolArn; la app no lo usa
- El dominio del Portal Interno Mayoreo (frame-ancestors en amplify.yml y ALLOWED_ORIGINS) se confirma con Sistemas

## 5. Pendientes (solo configuración de ambiente)

- **dev** — crear parámetros SSM: `/dev/glosario/network/subnets` (VpcSubnetIds), `/dev/glosario/network/lambda-sg` (LambdaSecurityGroupId), `/dev/glosario/db/proxy-endpoint` (DbProxyEndpoint), `/dev/glosario/frontend/origin` (AllowedOrigins)
- **dev** — crear el secreto de Secrets Manager `/dev/glosario/db/app` con `username`/`password` del usuario `usr_<app>_app`
- **qa** — crear parámetros SSM: `/qa/glosario/network/subnets` (VpcSubnetIds), `/qa/glosario/network/lambda-sg` (LambdaSecurityGroupId), `/qa/glosario/db/proxy-endpoint` (DbProxyEndpoint), `/qa/glosario/frontend/origin` (AllowedOrigins)
- **qa** — crear el secreto de Secrets Manager `/qa/glosario/db/app` con `username`/`password` del usuario `usr_<app>_app`
- **prod** — crear parámetros SSM: `/prod/glosario/network/subnets` (VpcSubnetIds), `/prod/glosario/network/lambda-sg` (LambdaSecurityGroupId), `/prod/glosario/db/proxy-endpoint` (DbProxyEndpoint), `/prod/glosario/frontend/origin` (AllowedOrigins)
- **prod** — crear el secreto de Secrets Manager `/prod/glosario/db/app` con `username`/`password` del usuario `usr_<app>_app`
- Frontend — variables por ambiente en Amplify/pipeline: `VITE_API_BASE_URL`, `VITE_COGNITO_USER_POOL_ID`, `VITE_COGNITO_CLIENT_ID` (salidas del stack SAM)
- Base de datos — ejecutar provisioning con las 4 contraseñas por variable de psql (`-v pass_ro=... -v pass_rw=... -v pass_ddl=... -v pass_admin=...`), nunca en archivos
- Usuarios — crear los usuarios iniciales en Cognito y asignarlos a sus grupos (procesos, consulta)
- Amplify — regla de reescritura SPA: origen `</^[^.]+$|\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|woff2|ttf|map|json|webp)$)([^.]+$)/>` → `/index.html` (200)
- Opcional — `AlarmTopicArn` (SNS) en parameter_overrides para recibir las alarmas

## 6. Validaciones ejecutadas

| Criterio | Verificación | Estado | Detalle |
|---|---|---|---|
| C1 | project-spec.yaml con requisitos identificados | OK | 15 requisitos |
| C1 | Modelo de datos fuente aplicado e introspeccionado | OK |  |
| C2 | Manifest completo | OK |  |
| C2 | Cada regla de autorización tiene dónde se aplica (enforced_in) | OK |  |
| C2 | Cada requisito tiene endpoints o pantallas | OK |  |
| C2 | Sin errores pendientes declarados en el manifest | OK |  |
| C3 | Scripts Aurora por ambiente (dev, qa, prd) | OK |  |
| C3 | Objetos sin equivalente en Aurora documentados | OK |  |
| C4 | SQL en PostgreSQL efímero (idempotencia, validación, rollback) | OK | dev: PASSED; qa: PASSED; prd: PASSED |
| C8 | Un único template SAM parametrizado | OK |  |
| C8 | Template conforme al estándar (parámetros, runtime, logs) | OK |  |
| C5 | Estructura hexagonal del backend | OK |  |
| C5 | Handlers del manifest y del template implementados | OK | 24 handlers |
| C5 | Use cases del manifest implementados | OK | 23 use cases |
| C5 | Dependencias entre capas y handlers delgados | OK |  |
| C5 | SQL solo en adapters y con nombres de Aurora | OK |  |
| C6 | pytest (unitarios con fakes) | OK | 80 passed, 2 skipped in 0.25s |
| C6 | Cada módulo del manifest tiene tests unitarios | OK |  |
| C6 | pytest de integración contra el esquema generado (PG efímero) | OK | 4 passed in 0.41s |
| C7 | ruff check | OK |  |
| C8 | samconfig.toml dev/qa/prod con tags y rutas por ambiente | OK |  |
| C9 | cfn-lint | OK |  |
| C9 | Transformación SAM | OK | 108 recursos CloudFormation |
| C10 | IAM sin comodines (salvo ENI documentado) | OK |  |
| C10 | Colas SQS con los 4 controles del estándar | OK | sin colas (no aplica) |
| C11 | Capa compartida (gateway HTTP, auth, env) | OK |  |
| C11 | HTTP solo vía axiosApiGateway | OK |  |
| C11 | Módulos src/views con Page → Controller → Api | OK |  |
| C11 | Naming kebab-case (-page, use-*-controller, -api) | OK |  |
| C11 | Límites de tamaño de pages y secciones | OK |  |
| C11 | Componentes fuera de views/ ≤ 250 líneas | OK |  |
| C11 | Variables por ambiente y hosting | OK |  |
| C12 | Instalación y build del frontend | OK | install + build |
| C12 | Prettier | OK |  |
| C12 | Tests del frontend | OK | el proyecto no tiene tests (no aplica) |
| C13 | Cero referencias a Supabase en frontend y backend | OK |  |
| C14 | Sin secretos en código ni configuración | OK |  |
| C14 | Sin IDs/ARNs/endpoints de AWS hardcodeados | OK |  |
| C15 | Sin TODO/FIXME/pseudocódigo | OK |  |

## 7. Despliegue

```bash
# 1. Base de datos (por ambiente; desde database/ o database/environments/<amb>/)
psql "$ADMIN_URL/postgres" -v pass_ro=*** -v pass_rw=*** -v pass_ddl=*** -v pass_admin=*** \
     -f aurora_postgresql_provisioning.sql
psql "$ADMIN_URL/may_dev_glosario_db" -f aurora_postgresql_schema.sql
psql "$ADMIN_URL/may_dev_glosario_db" -f aurora_postgresql_data.sql             # datos del origen (re-ejecutable)
psql "$ADMIN_URL/may_dev_glosario_db" -At -f aurora_postgresql_validation.sql   # TOTAL_FALTA debe ser 0
# 2. Backend
cd backend && sam build && sam deploy --config-env dev   # qa / prod
# 3. Frontend: configurar variables por rama en Amplify (o build del Dockerfile) y desplegar
```

