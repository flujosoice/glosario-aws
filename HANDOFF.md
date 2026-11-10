# HANDOFF — Glosario de Términos Mayoreo en AWS

Documento de entrega para el próximo desarrollador. Escrito el **09/11/2026** a partir de lo que hay en disco y en AWS ese día.

> El registro completo de decisiones de diseño, con su contexto, sus alternativas y su impacto, está en [DECISIONES.md](DECISIONES.md).

En cada dato se indica cómo se obtuvo:
- **[verificado]**: lo revisé el 09/11 en disco o en AWS.
- **[del 30/10]**: viene del reporte de despliegue de ese día; hoy no se pudo volver a comprobar porque las credenciales SSO están vencidas.
- **[sin verificar]**: lo dice la conversación o el cronograma, pero no hay evidencia en disco.

---

## 1. Resumen

El **Glosario de Términos** es la app del Departamento de **Procesos** de Mayoreo para consultar las definiciones de los términos de negocio. Muestra para cada término sus etiquetas, sus maestros (Artículos, Clientes) y los campos de Softland con los que se relaciona.

Hoy existe como app en claude.ai, con datos en Excel. Este proyecto la migra a AWS con el estándar **Intelix**.

**Estado general:** el glosario funciona en **dev** desde el 30/10. Las llaves de acceso todavía no existen, así que nadie puede administrar ni sincronizar. Faltan los flujos n8n y no se ha desplegado en QA ni en prod. El cronograma va atrasado: la semana 2 terminó sin su hito.

## 2. Ubicaciones y enlaces

| Qué | Dónde |
|---|---|
| Carpeta raíz | `C:\Users\cagonzalez\Documents\Respaldar\Actual\Procesos\GlosarioActualizado\` |
| Proyecto AWS (el que se despliega) | `GlosarioActualizado\glosario-aws\` |
| App original de claude.ai y sus datos | `GlosarioActualizado\glosario-terminos-mayoreo\` (tiene `LEEME.md`, `CLAUDE.md`, `app/`, `datos/`, `db/`, `src/`) |
| Cronograma | `GlosarioActualizado\Cronograma_Glosario_AWS.pdf` y `.pptx` |
| Diccionario de datos de Softland (fuente) | `GlosarioActualizado\Diccionario de datos.xls` |
| Clon del repo de estándares Intelix | `C:\Users\cagonzalez\Documents\Respaldar\intelix-cli\` **[verificado]** |
| Repo Intelix (origen) | https://git.intelix.biz/grupomayoreo/clientegrupomayoreo/intelix-cli (privado, solo con VPN o red Intelix) |
| Repo git del glosario | https://github.com/flujosoice/glosario-aws (rama `main`), creado el 09/11/2026 con el contenido de `glosario-aws\`. Identidad local `Flujos-OIC <flujosoic@mayoreo.biz>`. Este repo es provisional: el estándar Intelix pide además el repo en GitLab `git.intelix.biz` con ramas `develop`/`qa`/`master` (ver §5 y §10). `glosario-terminos-mayoreo\` sigue sin estar en git. |
| Cuenta AWS | `331384579644`, rol SSO `CP-MAYOREO-SANBOX` (sandbox) |
| Región | **us-west-2** para todo lo desplegado. El login de AWS SSO es en us-east-1. |
| Frontend dev (Amplify) | https://dev.d11mn7uw1xww2a.amplifyapp.com **[del 30/10]** |
| Administración dev | `https://dev.d11mn7uw1xww2a.amplifyapp.com/administracion#llave=<llave de administración>`. Todavía no hay llave. |
| API dev | https://t7xjnt2v5e.execute-api.us-west-2.amazonaws.com/dev. Salud en `/health`. **[del 30/10]** |
| Documento de accesos | Claude Doc "Glosario de Términos · Accesos dev": https://claude.ai/artifact/PtMxmFr9d5a6PEwvG3uxsA |

**Recursos AWS de dev [del 30/10]:**
- Pilas: `dev-glosario-platform` y `dev-glosario-api`.
- Amplify App `d11mn7uw1xww2a`, rama `dev`.
- API Gateway `t7xjnt2v5e`.
- Aurora: cluster `dev-glosario-aurora`, base `may_dev_glosario_db`, esquema `may_dev_glosario_sch_core`.
- CodeBuild `dev-glosario-db-runner`, el runner que ejecuta SQL dentro de la VPC.
- VPC `vpc-01297543a77e95ee0`.
- Secretos `/dev/glosario/db/{app,deploy,dba,report}`.
- Schedules `dev-glosario-service-{warmup,start,stop}`.
- User pool de Cognito `us-west-2_K5hKEDcVC`: lo crea la plantilla, pero la app no lo usa.

## 3. Arquitectura y stack

```
Portal Interno Mayoreo ──(enlace general / enlace admin #llave=…)──► Amplify (React + Vite + TS)
                                                                         │ HTTPS
                                                                         ▼
n8n (Sheets / Softland) ──Authorization: Llave <ingesta>──► API Gateway REST + WAF ──► 24 Lambdas Python 3.13 (hexagonal)
                                                                                           │ VPC privada
                                                                                           ▼
                                                                         Aurora PostgreSQL Serverless v2 (16.15)
```

- **Frontend** `glosario-aws/frontend/`
  - React + Vite + TypeScript, con el patrón Intelix Page → Controller → Api → `axiosApiGateway`.
  - Pantallas: `/` (consulta), `/administracion`, `/administracion/etiquetas`, `/administracion/maestros` y `/administracion/diccionario`.
  - Se hospeda en Amplify; `amplify.yml` define headers y CSP.
- **Backend** `glosario-aws/backend/`
  - Arquitectura hexagonal: `src/domain`, `src/application/use_cases`, `src/infrastructure/database/postgresql` y `src/entrypoints/lambda_handlers`.
  - El cableado está en `entrypoints/lambda_handlers/container.py`.
  - Hay 23 endpoints más `/health`; la lista completa está en `PROJECT_REPORT.md` §3.2.
  - Un solo `template.yaml` de SAM, con `samconfig.toml` para dev, qa y prod.
- **Base de datos** `glosario-aws/database/`
  - Scripts por ambiente: provisioning, schema, validation, rollback y data. dev está en la raíz; qa y prd en `environments/`.
  - Tiene 14 tablas (`tbl_terminos`, `tbl_etiquetas`, `tbl_maestros`, `tbl_diccionario_softland`, `tbl_sincronizaciones`, `tbl_llaves_acceso`, etc.).
  - Roles `ro_/rw_/ddl_/admin_glosario` y usuarios `usr_glosario_{report,app,deploy,dba}`.
- **Acceso: sin Cognito**, por decisión del negocio (ver §11).
  - Las lecturas son públicas, protegidas por WAF y CORS.
  - Para escribir se necesita una **llave de administración**, que viaja en el fragmento `#llave=` del enlace.
  - La ingesta usa una **llave de ingesta** en la cabecera `Authorization: Llave …`.
  - En `tbl_llaves_acceso` solo se guarda el SHA-256 de cada llave.
- **Ingesta (n8n)**
  - Endpoints:
    - `POST /ingest/sync-runs` (inicia una carga)
    - `.../rows` (lotes de hasta 1.000 filas)
    - `.../complete`
    - `.../fail`
  - Orígenes: `maestro_articulos`, `maestro_clientes` y `diccionario_softland`. El diccionario tiene unas 15.700 columnas, o sea unos 16 lotes.
  - Contrato completo en `glosario-aws/docs/ingesta-n8n.md`.
- **Horario de servicio:**
  - Una Lambda y tres schedules de EventBridge.
  - Aurora se enciende a las 04:45 y las Lambdas a las 05:00.
  - A las 17:00 las Lambdas pasan a concurrencia 0 y Aurora se detiene.
  - Zona horaria America/Costa_Rica, todos los días.
- **Archivos clave de `glosario-aws/`:**
  - `project-spec.yaml`: los requisitos RF-01 a RF-15.
  - `project-manifest.yaml`: endpoints, pantallas y reglas.
  - `PROJECT_REPORT.md`: matriz requisito → implementación y validaciones.
  - `CHANGELOG.md`.
  - `deploy/config.yaml`: red, Aurora y horario por ambiente.
  - `deploy/DEPLOY_dev.md`.
  - `.discovery/final-status.json`: la compuerta del deployer.

## 4. Cómo correrlo en local

**Requisitos:**
- Python 3.11 o superior; las Lambdas corren en 3.13.
- Node 20 o superior.
- PostgreSQL 16 local, solo para las pruebas de integración.
- AWS CLI y SAM CLI, solo para desplegar a mano.
- Las skills `aws-project-*` en `~/.claude/skills/`.

**Backend** (desde `glosario-aws/backend`):
```bash
py -3.11 -m pip install -r requirements-dev.txt
py -3.11 -m pytest                      # unitarios con fakes
py -3.11 -m pytest --cov --cov-report=xml   # cobertura (COD6); necesita TEST_DATABASE_URL para llegar a ~92 %
py -3.11 -m ruff check src tests
```

**Variables (solo los nombres):**

| Variable | Dónde vive |
|---|---|
| `TEST_DATABASE_URL` | Variable de entorno local para la integración. Apunta a un Postgres efímero. |
| `DB_NAME`, `DB_PROXY_ENDPOINT`, `DB_SECRET_NAME` | Obligatorias en la Lambda. Las inyecta SAM desde SSM y la pila de plataforma. |
| `DB_PORT`, `DB_SSLMODE`, `DB_CONNECT_TIMEOUT`, `ENVIRONMENT`, `SERVICE_NAME`, `LOG_LEVEL`, `SECRET_CACHE_TTL_SECONDS` | Opcionales en la Lambda. |

**Frontend** (desde `glosario-aws/frontend`):
```bash
npm ci
npm run dev        # requiere frontend/.env con las variables de .env.example
npm run build
```

**Variables del frontend** (`frontend/.env.example`; son públicas y nunca llevan secretos):
- `VITE_API_BASE_URL`: la salida `ApiUrl` de la pila SAM.
- `VITE_APP_EXPOSURE=public`.
- `VITE_REALTIME_ENABLED=false`.

**Validación completa** (SQL en Postgres efímero, cfn-lint, tests y build):
- Se corre con el script `validate` de la skill `aws-project-creator` o `aws-project-maintainer`.
- Debe terminar con `PROJECT COMPLETE` en `.discovery/final-status.json`.

## 5. Despliegue

**Dev.** Se despliega con la skill `aws-project-deployer`:
```bash
py -3.11 %USERPROFILE%\.claude\skills\aws-project-deployer\scripts\aws_connect.py check      # valida .env.aws
py -3.11 %USERPROFILE%\.claude\skills\aws-project-deployer\scripts\deploy.py all --env dev    # plataforma → BD → backend → frontend → horario
```
- Subcomandos: `platform`, `database`, `backend`, `frontend` y `hours --action status|start|stop`.
- Opciones: `--no-data` para no recargar datos y `--keep-running` para no apagar los servicios fuera de horario.
- prod exige `--approve`.
- El reporte de cada despliegue queda en `deploy/DEPLOY_<amb>.md`.
- El despliegue de dev del 30/10 terminó bien y tardó unos 17 min.

**QA y prod siguen el estándar Intelix** (detalle en el clon `intelix-cli`):
- Ramas `develop` → dev, `qa` → QA y `master` → prod, con tag `vX.Y.Z`.
- Merge requests con al menos 1 aprobación.
- Conventional Commits en español.
- El pipeline despliega con `sam deploy --config-env <amb>`. La infraestructura de plataforma (VPC, Aurora y Amplify) la crea `deploy.py platform`.
- AIDLC v2 no es obligatorio en este proyecto.

**Certificador Intelix:**
```bash
node C:\Users\cagonzalez\Documents\Respaldar\intelix-cli\templates\scripts\verificacion\analizador.js --proyecto glosario-aws --exposicion publica --alcance completo
```
- Da "Apto" con 85 % o más y 0 hallazgos críticos.
- El 30/10 dio **Apto 96 %** para QA y para prod.
- Solo queda abierto **R2**, que es un falso positivo (ver §12).
- COD6 exige `backend/coverage.xml` y DEVOPS3 exige el health check; ambos están resueltos.
- Además del certificador hace falta la firma de una persona (Arquitectura o Calidad).

**Horario de servicio:**
- Funciona de 05:00 a 17:00 hora de Costa Rica, todos los días; se configura en `deploy/config.yaml` → `service_hours`.
- Fuera de horario la API responde 503 y el front muestra error. **Las pruebas y los flujos n8n deben correr dentro del horario.**

**Configuración por ambiente** (`deploy/config.yaml`):

| Ambiente | Red | RDS Proxy | Aurora |
|---|---|---|---|
| dev | VPC propia 10.40.0.0/16 | No | 16.15 |
| qa | VPC propia 10.41.0.0/16 | No | 16.15 |
| prod | VPC propia 10.42.0.0/16 | Sí | 16.15, capacidad máxima 8 ACU |

## 6. Credenciales y accesos necesarios

| Acceso | Para qué | A quién pedirlo |
|---|---|---|
| AWS SSO, cuenta 331384579644, rol CP-MAYOREO-SANBOX | Desplegar y operar dev | Sistemas. Las credenciales son temporales: se copian del portal SSO a `glosario-aws/.env.aws` (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`, `AWS_REGION=us-west-2`). Vencen en horas y hay que volver a copiarlas. |
| Cuenta y credenciales para QA/prod | Pipeline de GitLab | **Pregunta abierta** (§9) |
| VPN o red Intelix | Clonar `intelix-cli` y usar el GitLab `git.intelix.biz` | Líder de Intelix o Sistemas |
| Instancia n8n y credenciales de Google Sheets | Flujos de Maestros | Sistemas |
| Lectura del Diccionario de Softland desde n8n | Flujo del Diccionario | José Luis, Gerente de Sistemas |
| Llave de administración y llave de ingesta | Enlace de Procesos y n8n | Se generan con `glosario-aws/database/tools/crear_llave.py`. Ese script imprime la llave una vez y el INSERT con su SHA-256; el INSERT se corre por el runner de BD porque Aurora es privada. |

Nunca se suben a git `.env.aws`, `.env.*` ni las llaves; `.gitignore` ya los excluye.

## 7. Trabajo realizado en las últimas 2 semanas

| Fecha | Qué se hizo |
|---|---|
| 21/10 | Análisis de la app original y del Excel. Se armaron el cronograma (PDF/PPTX) y `glosario-aws`. |
| 21/10 | `aws-project-creator` generó spec, manifest, scripts Aurora para 3 ambientes, backend hexagonal, frontend, SAM y el contrato de ingesta n8n (`docs/ingesta-n8n.md`). |
| 30/10 | Se clonó `intelix-cli` y se corrió el certificador: **No apto** (59 % y 56 %). |
| 30/10 | Brechas corregidas: INFRA4 (política administrada para la VPC en lugar de `Resource '*'`), DEVOPS3 (nuevo `GET /health`, RF-15), COD6 (pytest-cov con `fail_under=80`; cobertura 92 %, en `coverage.xml`) y tests de handlers de punta a punta. Resultado: **Apto 96 %**. |
| 30/10 | Se cambió la región a us-west-2. |
| 30/10 | El primer despliegue falló porque Aurora 16.6 no existe en us-west-2. Se fijó la versión 16.15. |
| 30/10 | **Despliegue de dev completo**: plataforma, BD con datos (TOTAL_FALTA=0), backend, frontend y horario. |
| 30/10 | Mejoras en las skills (`~/.claude/skills/aws-project-*`): `generate_sam.py` (política de VPC administrada), `deploy.py` (resuelve sola la versión de Aurora disponible), `pg_sandbox.py` (cuelgue de `pg_ctl` en Windows), `validate_migration.py` (`npm.cmd` en Windows). |
| 30/10 | Se creó el Claude Doc de accesos de dev. |
| 03/11 | Revisión del cronograma y próximos pasos. Al intentar generar las llaves de dev, el **token SSO estaba vencido**. Quedó listo un script de alta automática, que no se ejecutó. |
| 04/11 – 09/11 | Sin trabajo registrado en esta carpeta: ningún archivo cambió después del 30/10 **[verificado]**. |

## 8. Estado actual frente al cronograma

El cronograma va del 26/10 al 13/11 en 3 semanas. Hoy, 09/11, es el primer día de la semana 3.

| Semana / actividad | Estado |
|---|---|
| **S1 · Construcción y dev (hito 30/10)** | **Hecho** **[del 30/10]**. Hoy no se pudo comprobar en AWS. |
| S2 · Evaluar sincronización directa Sheets ↔ AWS | Sin decisión. La opción prevista es n8n. |
| S2 · Flujo n8n de Maestros | **No hecho.** La API de ingesta está lista en dev. Faltan la instancia n8n con credenciales de Sheets **[sin verificar]** y la llave de ingesta. |
| S2 · Flujo n8n del Diccionario Softland | **No hecho.** Depende de que José Luis autorice el acceso **[sin verificar]**. |
| S2 · Diccionario Softland leído desde Aurora | Código listo: la pantalla `/administracion/diccionario` lee de Aurora. Falta la primera carga real por n8n. |
| S2 · Despliegue en QA (hito 06/11) | **No hecho.** Faltan el repo en GitLab, el pipeline, las credenciales de QA y el ADR de la excepción sin Cognito. El certificador ya da Apto. |
| S3 · Pruebas internas, aceptación con Procesos (09–11/11), ajustes, corte de datos (12/11), prod (13/11) | Sin empezar. **Con lo que falta, la salida a prod del 13/11 está en riesgo.** |

**Verificado el 09/11:**
- Los archivos y su contenido.
- No hay repo git.
- `intelix-cli` está en `Respaldar\intelix-cli`.
- No existe ningún archivo de llaves generadas.
- Las credenciales de `.env.aws` son inválidas (`InvalidClientTokenId`).

**No verificado:** el estado actual de las pilas en AWS, la salud de la API y los datos en Aurora.

## 9. Requerimientos pendientes

Funcionales y operativos:
1. Generar y dar de alta la **llave de administración** (para el Portal) y la **llave de ingesta** (para n8n) en dev. Luego repetirlo en QA y prod.
2. **Flujo n8n de Maestros** de Artículos y de Clientes (desde Google Sheets).
3. **Flujo n8n del Diccionario Softland** (unas 15.700 filas en 16 lotes).
4. **Corte final de datos:** volver a exportar desde el glosario de claude.ai el día del corte. Procesos congela los cambios el 12/11. En la carga inicial quedaron **49 coincidencias con el diccionario sin revisar**.
5. **Embebido en el Portal Interno Mayoreo:** el enlace general y el de administración.
6. **QA y prod:** repo en GitLab con ramas protegidas, pipeline, despliegue y certificación con firma de una persona.
7. **ADR de la excepción sin Cognito**, firmado por Arquitectura.

Preguntas abiertas:
- ¿Sistemas ya entregó la instancia n8n y las credenciales de Google Sheets?
- ¿José Luis autorizó la lectura del Diccionario de Softland desde n8n?
- ¿Se descarta la sincronización directa (una Lambda que lea Sheets) y se usa n8n?
- ¿QA y prod van en la cuenta sandbox `331384579644` o en otra cuenta? ¿Con qué credenciales despliega el pipeline?
- ¿Quién crea el repo en `git.intelix.biz`: el desarrollador o el líder de Intelix? ¿En qué grupo?
- ¿Cuál es el dominio definitivo del Portal Interno? Hoy CORS y CSP aceptan `*.mayoreo.biz`, y falta que Sistemas lo confirme.
- ¿Se quita de la plantilla el user pool de Cognito que no se usa, o se deja?
- ¿Se mueve la fecha de prod del 13/11, dado el atraso de la semana 2?
- El clon `intelix-cli` cambió de lugar: antes estaba dentro de `GlosarioActualizado`. ¿Cuál es la ubicación definitiva?

## 10. Próximos pasos priorizados

1. **Renovar las credenciales SSO** en `glosario-aws/.env.aws` y correr `aws_connect.py check` y `deploy.py hours --action status --env dev` para confirmar que dev sigue en pie.
2. **Generar las llaves de dev** y darlas de alta por el runner de BD.
   - Script listo en `glosario-aws\database\tools\alta_llaves_dev.py`, versionado desde el 09/11. Se corre desde la raíz de `glosario-aws` con `py -3.11 database\tools\alta_llaves_dev.py`.
   - Lo que hace: genera las llaves, agrega un `changes_run/zzzz_alta_llaves.sql` al bundle del deployer y escribe las llaves en `glosario-aws/.env.llaves-dev`, que git ignora.
   - Después hay que probar `/me` con la llave de administración y `POST /ingest/sync-runs` con la de ingesta.
3. **Crear el repo en GitLab Intelix**: el código ya está en git y en GitHub (`flujosoice/glosario-aws`, desde el 09/11). Falta agregar el remoto de GitLab, crear las ramas `develop`, `qa` y `master` protegidas y hacer push (necesita la VPN).
4. **Flujos n8n**: primero Maestros, luego el Diccionario. Hacer la primera carga en dev y revisar la bitácora en `GET /sync-runs`.
5. **QA**: escribir el ADR sin Cognito, definir cuenta y credenciales, `deploy.py platform --env qa`, pipeline con `sam deploy --config-env qa`, generar llaves de QA, certificar y conseguir la aprobación del merge request.
6. **Aceptación con Procesos en QA**, ajustes, corte final de datos y **prod** con `--approve` y tag `v1.0.0`.
7. Entregar a Sistemas los dos enlaces para el Portal y actualizar el Claude Doc de accesos.

## 11. Decisiones tomadas y por qué

Esta tabla es un resumen. El detalle de cada decisión (fecha, alternativas, quién la tomó, impacto y estado) y las decisiones pendientes están en [DECISIONES.md](DECISIONES.md).

| Decisión | Motivo |
|---|---|
| Estándar Intelix (React/Vite/TS, Lambda Python 3.13 hexagonal, Aurora, SAM, Amplify) | Requisito de la organización para QA y prod |
| **Sin Cognito**: dos enlaces (general y administración) embebidos en el Portal Interno, más llaves de acceso validadas en el backend | Decisión del negocio. El Portal ya controla quién entra. Para compensar hay WAF, CORS restringido, llaves guardadas como SHA-256 y escrituras auditadas. **Requiere un ADR.** |
| Datos por **n8n** a la API de ingesta, no por Excel | Se deja de usar Excel como fuente. La sincronización directa por Lambda quedó como alternativa por evaluar. |
| **AWS no se conecta directamente a Softland** | Solo se habilita si lo autoriza José Luis, Gerente de Sistemas |
| Región **us-west-2** (el login es en us-east-1) | Decisión del usuario del 30/10 |
| Aurora **16.15** fijada | 16.6 no existe en us-west-2. El deployer ahora resuelve la versión, pero se dejó fijada para que no cambie sola. |
| Horario 05:00–17:00 Costa Rica, arranque 04:45 | Bajar costos. Lo confirmó el usuario. |
| CORS y CSP con `*.mayoreo.biz` | Dominio del Portal sin confirmar todavía |
| RDS Proxy solo en prod | Cuesta unos 87 USD/mes y no hace falta en dev ni QA |
| No dar R2 por corregido: se documenta como falso positivo | El SQL ya es parametrizado (psycopg 3) |
| AIDLC v2 no se usa | No es obligatorio según el usuario |

## 12. Trampas conocidas

- **Credenciales SSO temporales:**
  - `ExpiredToken` o `InvalidClientTokenId` significa que hay que volver a copiarlas del portal SSO a `.env.aws`.
  - El archivo no se imprime ni se pasan las claves por línea de comandos.
  - Al copiar, revisar que `AWS_REGION` siga en `us-west-2`.
- **Windows y empaquetado del backend:** pip falla con `--user` + `--target`. Se arregla exportando `PIP_USER=0` antes de empaquetar.
- **Windows y cfn-lint "no instalado":** agregar al `PATH` la carpeta `Scripts` del Python 3.11 de usuario (`%APPDATA%\Python\Python311\Scripts`).
- **Windows y npm:** `subprocess` no encuentra `npm` sin `.cmd`. Ya está corregido en `validate_migration.py` de la skill maintainer.
- **Windows y Postgres efímero que se cuelga:** `pg_ctl start` hereda los pipes. Está corregido en el `pg_sandbox.py` de la skill maintainer, no en las otras skills.
- **R2 del certificador (SQL concatenado) es un falso positivo:** el regex marca los `%(nombre)s` de psycopg 3 y cualquier `+` en archivos que empiezan con `from __future__`. Hay que explicarlo en la revisión de Intelix.
- **Aurora y versiones retiradas por región:** "Cannot find version X for aurora-postgresql". Ajustar `db_engine_version` en `deploy/config.yaml`.
- **Pila en `ROLLBACK_COMPLETE`:** el deployer la borra y la recrea en el siguiente intento, siempre que esté vacía.
- **Fuera de horario:**
  - La API devuelve 503 y Aurora está detenida.
  - Para trabajar fuera de horario: `deploy.py hours --action start --env dev`.
  - Para desplegar sin que se apague al terminar: `--keep-running`.
- **Validación de los handlers:** los endpoints protegidos devuelven **400 antes que 401** si el cuerpo es inválido, porque la validación va antes de la autenticación. Está cubierto en los tests.
- **Cobertura:** sin `TEST_DATABASE_URL` los tests de integración se saltan y la cobertura baja de 80 %, con lo que falla `fail_under`.
- **Las llaves no se recuperan:** en la base solo queda el hash. Si se pierde una, se revoca (`UPDATE … SET activa=false, revocada_en=now()`) y se genera otra.
- **Aurora es privada:** cualquier SQL contra la base pasa por el CodeBuild `dev-glosario-db-runner`. No hay acceso directo.
- **Test preexistente roto:** `test_maintainer` de la skill tiene una prueba de orden de timestamps que falla en Windows. No tiene que ver con este proyecto.

## 13. Personas involucradas y quién valida qué

| Persona o área | Rol |
|---|---|
| ccampo@mayoreo.biz | Desarrollador del proyecto hasta esta entrega |
| Departamento de **Procesos** | Dueño funcional. Valida la aceptación (09–11/11), congela cambios el día del corte (12/11) y usa el enlace de administración. |
| **Sistemas** | Credenciales AWS, dominio del Portal Interno, instancia n8n y credenciales de Google Sheets |
| **José Luis**, Gerente de Sistemas | Autoriza la lectura del Diccionario de Softland y cualquier conexión directa a Softland |
| **Intelix** (líder, Arquitectura, Calidad) | Dueños del estándar y de GitLab. Aprueban los merge requests a `qa` y `master`, firman la certificación y el ADR sin Cognito. **Nombres por confirmar.** |
