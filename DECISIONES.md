# DECISIONES — Glosario de Términos Mayoreo en AWS

Este documento registra las decisiones de diseño del proyecto y cómo dieron forma a la herramienta. Está pensado para el próximo desarrollador. Lo escribí el **10/11/2026** a partir de:
- la conversación de trabajo,
- el cronograma (`../Cronograma_Glosario_AWS.pdf`),
- `PROJECT_REPORT.md`, `CHANGELOG.md` y `docs/`,
- el código.

Lo que no pude respaldar con evidencia está marcado **[sin verificar]**. El estado actual del proyecto está en [HANDOFF.md](HANDOFF.md).

## 1. Resumen

La forma actual del glosario la definieron sobre todo cuatro decisiones:

1. **El estándar Intelix:** React en Amplify, Lambdas Python hexagonales detrás de API Gateway, Aurora PostgreSQL y una sola plantilla SAM para dev, QA y prod.
2. **No usar inicio de sesión.** La app se abre desde dos enlaces del Portal Interno Mayoreo. Por eso no hay Cognito: la API es pública para leer y exige **llaves de acceso** para escribir y para la ingesta. En la base solo se guarda el SHA-256 de cada llave, y el WAF, CORS y la auditoría compensan la falta de sesión.
3. **AWS no se conecta a Google ni a Softland.** **n8n** lee las matrices de Google Sheets y el diccionario de Softland y los envía a una API de ingesta por lotes. Esa API reemplaza la versión vigente en una sola transacción y deja todo en una bitácora. Se dejó de usar Excel como fuente.
4. **Costo bajo:** horario de servicio de 05:00 a 17:00 hora de Costa Rica, Aurora Serverless v2 y RDS Proxy solo en prod.

Encima de eso hubo ajustes técnicos: la región us-west-2, Aurora 16.15 y las correcciones que pidió el certificador de Intelix.

## 2. Registro de decisiones

En orden de la más antigua a la más reciente. "Usuario" es el responsable del proyecto en Mayoreo, que tomó las decisiones en la conversación de trabajo.

### D01 — Construir con el estándar Intelix
- **Fecha:** 21/10/2026 (cronograma, "Decisiones de arquitectura").
- **Decisión:** el frontend es React + Vite + TypeScript y conserva la interfaz actual. El backend son Lambdas Python 3.13 con arquitectura hexagonal detrás de API Gateway REST. La base es Aurora PostgreSQL. Una sola plantilla SAM con `samconfig` para dev, QA y prod. El frontend se publica en Amplify Hosting.
- **Contexto:** el glosario vivía en claude.ai con datos en Excel. Para llegar a QA y prod, Mayoreo exige el estándar de Intelix.
- **Alternativas:** dejarlo en claude.ai, o usar otro stack. Ninguna se evaluó a fondo: el estándar es obligatorio.
- **Por qué:** es requisito de la organización para QA y prod.
- **Quién:** Departamento de Procesos (cronograma) y el usuario.
- **Impacto:**
  - Datos y esquema: nombres Intelix (`may_<amb>_glosario_db`, esquema `may_<amb>_glosario_sch_core`, prefijo `tbl_`), cuatro roles y cuatro usuarios de base.
  - Arquitectura: 24 Lambdas en capas `domain`, `application`, `infrastructure` y `entrypoints`.
  - Interfaz: el patrón Page → Controller → Api → `axiosApiGateway`.
- **Estado:** vigente.

### D02 — Sin Cognito: dos enlaces del Portal Interno y llaves de acceso
- **Fecha:** 21/10/2026 (cronograma: "Dos enlaces, sin Cognito"). El ADR es del 09/11/2026.
- **Decisión:**
  - Un enlace general de solo lectura y un enlace de administración para Procesos, ambos embebidos en el Portal Interno Mayoreo.
  - Las escrituras exigen una **llave de administración**, que viaja en el fragmento `#llave=` del enlace.
  - La ingesta exige una **llave de ingesta** propia.
- **Contexto:** el Portal ya decide quién ve cada enlace y el negocio no quiere un segundo inicio de sesión. n8n necesita escribir sin un usuario humano.
- **Alternativas:**
  - Cognito con un usuario por persona.
  - Federar Cognito con el proveedor de identidad del Portal: depende de Sistemas y no cabía en tres semanas.
  - API privada: no es viable sin VPN.
  
  Están en `docs/adr/0001-acceso-sin-cognito.md`.
- **Por qué:** es lo que pidió el negocio y no duplica el control de acceso que ya hace el Portal.
- **Quién:** el negocio y Procesos (cronograma). **Falta la aprobación de Arquitectura Intelix**, porque el ADR está en estado *propuesto*.
- **Impacto:**
  - Seguridad: la API es pública. Se compensa con:
    - WAF: reglas administradas y límite de peticiones por IP.
    - CORS restringido.
    - CSP.
    - Llaves guardadas como SHA-256.
    - 403 cruzado: cada propósito rechaza la llave del otro.
    - Auditoría con la etiqueta de la llave.
  - Datos: la tabla `tbl_llaves_acceso` (propósito, etiqueta, hash, activa, revocada_en).
  - Interfaz: `/administracion` sin una llave válida vuelve a la vista normal, y la vista normal no muestra ningún enlace a la administración.
  - Certificación: el certificador se corre con `--exposicion publica`.
  - La plantilla de plataforma todavía crea un user pool de Cognito que no se usa.
- **Estado:** vigente. La aprobación de Arquitectura está pendiente.

### D03 — Datos por n8n hacia una API de ingesta, no por Excel
- **Fecha:** 21/10/2026 (cronograma: "Sincronización con n8n").
- **Decisión:**
  - Los Maestros de Artículos y Clientes (Google Sheets) y el Diccionario de Softland llegan a Aurora por flujos n8n programados.
  - Los flujos usan una API con este ciclo: iniciar la carga, enviar lotes de hasta 1.000 filas, completar o marcar fallida.
  - Al completar, la carga reemplaza la versión vigente en una sola transacción. Cada carga queda en una bitácora.
- **Contexto:** Excel era una fuente manual y desactualizada. AWS no debe conectarse a Google ni a Softland.
- **Alternativas:** una **sincronización directa**, con una Lambda programada que lee la API de Google Sheets. En el cronograma figura como "por evaluar" y nunca se decidió (ver D-P1).
- **Por qué:** n8n ya es la herramienta de integración de Mayoreo y mantiene a AWS sin credenciales de Google ni de Softland **[sin verificar que n8n sea el estándar corporativo]**.
- **Quién:** Procesos (cronograma) y el usuario, que el 10/11 confirmó n8n como la opción idónea.
- **Impacto:**
  - Datos: tablas `tbl_sincronizaciones`, `tbl_atributos_maestro` y `tbl_diccionario_softland`, todas atadas a una carga vigente.
  - Arquitectura: endpoints `/ingest/sync-runs*`, un job horario que expira las cargas a medias (2 h) y una sola carga en curso por origen (409 si se inicia otra).
  - Los términos **no** se sincronizan: vienen de la migración desde claude.ai y se editan en la Administración.
- **Estado:** vigente. Los flujos están creados en `integraciones/n8n/` y todavía no se probaron en un n8n real.

### D04 — Sin conexión directa de AWS a Softland
- **Fecha:** 21/10/2026 (cronograma: "Softland, sin conexión directa").
- **Decisión:** AWS no se conecta a la base de Softland. Una conexión directa solo se habilita si la autoriza José Luis, Gerente de Sistemas.
- **Contexto:** Softland es el ERP. Abrirlo desde la nube implica riesgo y requiere autorización.
- **Alternativas:** una conexión directa desde una Lambda en la VPC. Queda condicionada a la autorización.
- **Por qué:** es una política de Sistemas.
- **Quién:** José Luis (Sistemas).
- **Impacto:**
  - Integración: el flujo del Diccionario lee una vista de solo lectura desde n8n.
  - La consulta del flujo propone el nombre `glosario.vw_diccionario_datos`, que es una **propuesta**; Sistemas define el nombre real.
  - Novedad del 10/11 (seguimiento de la sesión coordinadora): Giovanni Perez (Sistemas) encontró dónde está el diccionario en Softland. **Falta verificar que exista en la réplica que usa n8n [sin verificar]**.
- **Estado:** vigente.

### D05 — Horario de servicio de 05:00 a 17:00 hora de Costa Rica
- **Fecha:** 30/10/2026. El cronograma pedía confirmarlo a más tardar ese día.
- **Decisión:**
  - Todos los ambientes funcionan de 05:00 a 17:00, todos los días.
  - Aurora arranca a las 04:45.
  - Fuera de horario, las Lambdas quedan en concurrencia 0 y Aurora se detiene.
- **Contexto:** bajar costos en un uso que es solo en horario laboral.
- **Alternativas:** servicio 24/7, o solo de lunes a viernes. La opción de lunes a viernes existe en la configuración y no se usó.
- **Por qué:** el uso es en horario laboral y el costo baja a la mitad.
- **Quién:** el usuario, que eligió "5:00–17:00 Costa Rica".
- **Impacto:**
  - Arquitectura: la Lambda `ServiceHours` y tres schedules de EventBridge.
  - Fuera de horario la API responde 503.
  - **Los flujos n8n se programan dentro del horario:** Maestros de lunes a viernes a las 06:00 y Diccionario los lunes a las 05:30.
- **Estado:** vigente.

### D06 — CORS y CSP aceptan `*.mayoreo.biz`
- **Fecha:** 30/10/2026.
- **Decisión:** se permite cualquier subdominio de `mayoreo.biz` mientras Sistemas no confirma el dominio del Portal Interno.
- **Contexto:** el dominio del Portal debía estar el 27/10 y no llegó.
- **Alternativas:** fijar un dominio exacto, que no se conocía.
- **Por qué:** no bloquear el despliegue de dev.
- **Quién:** el usuario, que respondió "*.mayoreo.biz sirve".
- **Impacto:** seguridad. Es más amplio de lo ideal y conviene cerrarlo al dominio exacto antes de prod.
- **Estado:** vigente, como medida provisional.

### D07 — Desplegar en la región us-west-2
- **Fecha:** 30/10/2026.
- **Decisión:** todo lo de dev se despliega en us-west-2, aunque el inicio de sesión de AWS SSO es en us-east-1.
- **Contexto:** decisión de la cuenta sandbox `331384579644`, con el rol `CP-MAYOREO-SANBOX`.
- **Alternativas:** us-east-1.
- **Por qué:** lo decidió el usuario **[el motivo de fondo no está documentado]**.
- **Quién:** el usuario.
- **Impacto:**
  - `aws_region: us-west-2` en `project-spec.yaml` y `project-manifest.yaml`.
  - CSP de `frontend/amplify.yml` limitada a `*.execute-api.us-west-2.amazonaws.com`.
  - Forzó a fijar la versión de Aurora (D08).
- **Estado:** vigente para dev. La región de QA y prod depende de su cuenta (D-P4).

### D08 — Aurora PostgreSQL 16.15
- **Fecha:** 30/10/2026.
- **Decisión:** se fija `db_engine_version: '16.15'` en dev, QA y prod.
- **Contexto:** el primer despliegue falló con "Cannot find version 16.6 for aurora-postgresql", porque esa versión no existe en us-west-2.
- **Alternativas:** dejar que el deployer resuelva la versión menor más reciente de la 16. Esa función se agregó a la skill, pero se prefirió fijar la versión.
- **Por qué:** que la versión no cambie sola entre despliegues.
- **Quién:** decisión técnica, aceptada por el usuario cuando pidió "ajusta el skill".
- **Impacto:** `deploy/config.yaml`. Además, la skill de despliegue ahora valida la versión antes de desplegar.
- **Estado:** vigente.

### D09 — RDS Proxy solo en producción
- **Fecha:** 30/10/2026. Es el valor por defecto del deployer.
- **Decisión:** `use_rds_proxy: true` solo en prod; en dev y QA las Lambdas se conectan directo a Aurora.
- **Contexto:** RDS Proxy cuesta unos 87 USD al mes, aunque el servicio esté apagado, y dev y QA tienen poca concurrencia.
- **Alternativas:** usar el proxy en todos los ambientes.
- **Por qué:** costo.
- **Quién:** valor por defecto del estándar de despliegue **[sin verificar que alguien lo haya validado explícitamente]**.
- **Impacto:** arquitectura. En prod el endpoint de la base es el del proxy, publicado en el SSM `/<amb>/glosario/db/proxy-endpoint`. Prod tiene además hasta 8 ACU, contra 2 en dev y QA.
- **Estado:** vigente.

### D10 — Una VPC propia por ambiente
- **Fecha:** 30/10/2026.
- **Decisión:** cada ambiente crea su propia VPC: 10.40.0.0/16 para dev, 10.41.0.0/16 para QA y 10.42.0.0/16 para prod. Cada una tiene un NAT Gateway.
- **Contexto:** no había una VPC compartida disponible.
- **Alternativas:** `create_network: false` para usar una VPC existente. Sería más barato, pero no había una VPC a mano.
- **Por qué:** no había una VPC compartida disponible.
- **Quién:** valor por defecto del deployer **[sin verificar]**.
- **Impacto:** el costo fijo del NAT es de unos 32 USD al mes por ambiente, aunque el servicio esté apagado.
- **Estado:** vigente.

### D11 — Corregir las brechas del certificador Intelix
- **Fecha:** 30/10/2026.
- **Decisión:**
  - **INFRA4:** el rol de las Lambdas usa la política administrada `AWSLambdaVPCAccessExecutionRole`, en lugar de una declaración con `Resource '*'`.
  - **DEVOPS3:** se agrega `GET /health`, que responde 200 si Aurora contesta y 503 si no, sin filtrar el error. Es el requisito RF-15.
  - **COD6:** cobertura con pytest-cov y `fail_under = 80`. La cobertura medida fue de 92 % (`backend/coverage.xml`).
- **Contexto:** el certificador daba **No apto** (59 % y 56 %).
- **Alternativas:** pedir excepciones a Intelix.
- **Por qué:** pasar la compuerta de QA sin excepciones evitables.
- **Quién:** el usuario, que respondió "Sí, corrígelas".
- **Impacto:**
  - IAM: el arreglo se hizo en el generador de la plantilla (`generate_sam.py`) de las tres skills.
  - API: un endpoint público nuevo.
  - Tests: `tests/unit/test_handlers.py`.
  - El certificador pasó a **Apto, 96 %** (30/10 y 09/11).
- **Estado:** vigente.

### D12 — R2 del certificador se trata como falso positivo
- **Fecha:** 30/10/2026. Se reconfirmó el 09/11.
- **Decisión:** R2 ("posible SQL concatenado") no se corrige: se documenta y se explica en la revisión.
- **Contexto:** la regla marca los marcadores `%(nombre)s` de psycopg 3, que son consultas parametrizadas, y cualquier `+` en archivos con `from __future__`. El 09/11 la marcó en `domain/entities/sync.py`, que no contiene SQL: ahí el `+` es una suma de listas de Python.
- **Alternativas:** reescribir el código para esquivar el regex, lo que lo empeoraría.
- **Por qué:** no existe la vulnerabilidad. Todo el SQL está en los adapters y es parametrizado.
- **Quién:** decisión técnica, registrada en el CHANGELOG y en la memoria del proyecto. **Falta que Intelix la acepte**.
- **Impacto:** la puntuación de seguridad queda en 89 %, sin hallazgos críticos.
- **Estado:** vigente.

### D13 — AI-DLC v2 no es obligatorio
- **Fecha:** 30/10/2026.
- **Decisión:** no se sigue el flujo AI-DLC v2 de Intelix. Al adoptar intelix-cli el 09/11 se usó `--skip-aidlc`.
- **Contexto:** el proyecto ya estaba especificado y construido con las skills de AWS.
- **Alternativas:** adoptar AI-DLC completo.
- **Por qué:** el usuario indicó que no es obligatorio.
- **Quién:** el usuario.
- **Impacto:** el repo tiene `.intelix/`, las skills y los docs de Intelix, pero no el estado de AI-DLC activo.
- **Estado:** vigente.

### D14 — QA y prod siguen el flujo GitLab de Intelix
- **Fecha:** 30/10/2026. Se confirmó el 09/11.
- **Decisión:**
  - Ramas `develop` → dev, `qa` → QA y `master` → prod, con tag `vX.Y.Z`.
  - Merge requests con al menos una aprobación. El de `qa` lo aprueban Calidad o Arquitectura.
  - Conventional Commits en español.
  - Despliegue con `sam deploy --config-env <amb>`.
- **Contexto:** `docs/estrategia-control-versiones.md` y `docs/guia-nuevo-proyecto-lider.md` de intelix-cli.
- **Alternativas:** desplegar QA directamente con el deployer, como se hizo en dev.
- **Por qué:** es requisito de Intelix.
- **Quién:** el usuario e Intelix.
- **Impacto:**
  - 09/11: se adoptó intelix-cli en el repo (`.gitlab-ci.yml`, plantillas de issues y merge requests, certificador en `scripts/verificacion/`).
  - **Hoy el repo está en GitHub (`flujosoice/glosario-aws`, rama `main`) y no en `git.intelix.biz`** (D-P5).
  - El pipeline de Intelix no despliega la plataforma (VPC, Aurora, Amplify, runner), solo la API.
- **Estado:** vigente. La implementación está pendiente: hay que crear el repo en GitLab y sus ramas.

### D15 — Solo se despliega con el deployer; prod exige confirmación
- **Fecha:** 30/10/2026.
- **Decisión:**
  - Nada se crea a mano en la consola de AWS.
  - Las credenciales viven solo en `.env.aws` y nunca se imprimen.
  - Prod exige `--approve`.
  - No se borran pilas ni datos.
- **Contexto:** reglas del estándar de despliegue.
- **Alternativas:** ninguna se evaluó.
- **Por qué:** lograr ambientes reproducibles y evitar fugas de credenciales.
- **Quién:** el usuario y las reglas de la skill.
- **Impacto:**
  - Todo queda en `deploy/config.yaml` y en las pilas `<amb>-glosario-platform` y `<amb>-glosario-api`.
  - Las credenciales SSO son temporales: se vuelven a copiar cuando vencen.
- **Estado:** vigente.

### D16 — Cuerpos grandes en el WAF solo para los lotes de ingesta
- **Fecha:** 09/11/2026.
- **Decisión:**
  - La regla administrada `SizeRestrictions_BODY` pasa a modo *Count*.
  - Una regla propia, `BodySizeLimit`, bloquea los cuerpos de más de 8 KB en toda la API **salvo** en `/ingest/sync-runs/{runId}/rows`.
  - Ese endpoint se marca con `large_body: true` en el manifest.
- **Contexto:** el primer lote de la carga del Diccionario, de unos 650 KB, recibió 403 del WAF.
- **Alternativas:**
  - Lotes de menos de 8 KB, unas 10 filas, lo que daría más de 1.500 peticiones por carga.
  - Quitar la regla en toda la API.
- **Por qué:** mantiene la protección en el resto de la API y deja los lotes de 1.000 filas, que siguen limitados por la llave de ingesta y por el máximo de filas.
- **Quién:** decisión técnica, en la sesión del 09/11.
- **Impacto:**
  - Seguridad: verificado que un POST de 12 KB a `/admin/terms` sigue en 403.
  - El cambio está en el generador de la plantilla, así que se conserva al regenerarla.
- **Estado:** vigente.

### D17 — Cargador por archivo como respaldo de n8n
- **Fecha:** 09/11/2026.
- **Decisión:** `integraciones/cargar_origen.py` carga un origen desde un `.xls`, `.xlsx`, `.csv` o `.json`, con el mismo contrato que n8n.
- **Contexto:** n8n y el acceso a Softland no estaban disponibles, y el hito de la semana 2 estaba atrasado.
- **Alternativas:** esperar a n8n.
- **Por qué:** permite la primera carga, probar un ambiente y tener un plan B. Con él se cargaron en dev las **15.656 columnas** del Diccionario desde `Diccionario de datos.xls`.
- **Quién:** el usuario, que pidió "crea lo necesario para el n8n".
- **Impacto:** la opción `--dry-run` valida las filas con el mismo parser del backend.
- **Estado:** vigente.

### D18 — Diseño de los flujos n8n
- **Fecha:** 09/11/2026.
- **Decisión:**
  - Un sub-flujo común, "Enviar carga", que hace el inicio, los lotes y el cierre, y marca la carga como fallida si algo sale mal.
  - El flujo de Maestros lee **todas las pestañas** de cada matriz que tengan columnas "Atributo" o "Nombre técnico", y anota la pestaña y la fila.
  - El flujo del Diccionario lee una vista de SQL Server.
  - Los lotes no se reintentan solos, porque reintentar duplicaría filas.
- **Contexto:** la matriz de Artículos tiene tres pestañas, y una de ellas ("Validaciones y Reglas…") tiene otra estructura.
- **Alternativas:** un nodo Code que haga las peticiones HTTP. Se descartó porque no puede usar las credenciales de n8n.
- **Por qué:** credenciales fuera del código y un comportamiento seguro ante fallos, porque lo vigente no cambia.
- **Quién:** decisión técnica.
- **Impacto:** los flujos están en `integraciones/n8n/*.json` y la instalación en su README.
- **Estado:** vigente. Falta probarlos en un n8n real.

### D19 — Llaves sin vencimiento, con rotación manual
- **Fecha:** 09/11/2026.
- **Decisión:** las llaves no vencen solas. Rotar una llave es generar una nueva con la misma etiqueta, lo que revoca la anterior, y entregarla.
- **Contexto:** pregunta del usuario sobre cómo se refrescan las llaves.
- **Alternativas:** una fecha de vencimiento por llave y un script de rotación. Requiere un cambio en la base y en el backend.
- **Por qué:** es suficiente para el uso actual.
- **Quién:** el usuario, que respondió "Así está bien".
- **Impacto:** no hubo cambio de código. Las llaves se generan con `database/tools/crear_llave.py` y `alta_llaves_dev.py`.
- **Estado:** vigente.

### D20 — QA no va en la cuenta sandbox
- **Fecha:** 09/11/2026.
- **Decisión:** se espera la cuenta y las credenciales de QA, en lugar de desplegar QA en la cuenta sandbox `331384579644`.
- **Contexto:** el hito de QA (06/11) estaba atrasado y existía la opción de usar la sandbox.
- **Alternativas:** desplegar QA ya en la sandbox con el deployer.
- **Por qué:** lo decidió el usuario ("Esperar cuenta QA").
- **Quién:** el usuario.
- **Impacto:** QA queda bloqueado por la cuenta (D-P4).
- **Estado:** vigente.

## 3. Cómo se refleja hoy en el código

| Decisión | Dónde se ve |
|---|---|
| D01 Estándar Intelix | `backend/src/{domain,application,infrastructure,entrypoints}`; `backend/template.yaml` y `samconfig.toml`; `frontend/src/views/*` (Page/Controller/Api); `database/` (scripts por ambiente) |
| D02 Sin Cognito y llaves | `frontend/src/shared/access/access-key.ts` (lee `#llave=` y la guarda en sessionStorage); `frontend/src/views/access/components/require-admin.tsx`; `backend/src/application/use_cases/common.py` (`require_admin`, `require_ingest`, `require_grant`); `backend/src/infrastructure/database/postgresql/term_repository.py` (busca por hash); `database/tools/crear_llave.py`; `docs/adr/0001-acceso-sin-cognito.md` |
| D03 Ingesta n8n | `backend/src/domain/entities/sync.py` (contrato y normalización de filas); `backend/src/application/use_cases/sync.py`; `backend/src/infrastructure/database/postgresql/sync_run_repository.py`; `docs/ingesta-n8n.md` |
| D04 Sin conexión a Softland | `integraciones/n8n/glosario-sync-diccionario-softland.json` (consulta a la vista); `backend/src/infrastructure/database/postgresql/dictionary_repository.py` (lee la carga vigente) |
| D05 Horario de servicio | `deploy/config.yaml` → `service_hours`; schedules `dev-glosario-service-{warmup,start,stop}` |
| D06 CORS y CSP | `frontend/amplify.yml` (CSP); parámetro `AllowedOrigins` en `backend/template.yaml` |
| D07, D08, D09, D10 Infraestructura | `deploy/config.yaml` (CIDR, `use_rds_proxy`, capacidad, `db_engine_version`); `project-spec.yaml` y `project-manifest.yaml` (`aws_region`) |
| D11 Certificación | `backend/src/application/use_cases/access.py` (`GetHealthUseCase`); `backend/tests/unit/test_handlers.py`; `backend/pyproject.toml` (cobertura); `backend/coverage.xml`; `docs/certificaciones/` |
| D16 WAF | `project-manifest.yaml` (`large_body: true` en el endpoint `/rows`); recurso `ApiWebAcl` de `backend/template.yaml` (regla `BodySizeLimit`) |
| D17 y D18 Integraciones | `integraciones/cargar_origen.py`; `integraciones/n8n/` |
| D14 GitLab Intelix | `.gitlab-ci.yml`, `.gitlab/`, `.intelix/`, `scripts/verificacion/` |

## 4. Decisiones pendientes

Cada una de estas cambia el diseño según cómo se responda.

- **D-P1 · ¿n8n o sincronización directa?** Si se elige una Lambda que lea Google Sheets, hay que:
  - guardar credenciales de Google en Secrets Manager,
  - crear un schedule nuevo,
  - y dejar n8n solo para Softland.
  
  Hoy todo está hecho para n8n, y el usuario lo considera la opción idónea.
- **D-P2 · ¿Para qué se usan los atributos de los Maestros?** Se sincronizan a `tbl_atributos_maestro`, pero **hoy ninguna pantalla ni caso de uso los lee**. Hay tres opciones:
  - consultarlos en la Administración,
  - proponer el Campo BD ("Nombre técnico") y el Campo Softland ("Atributo") al editar un término,
  - o validar los términos contra ellos.
  
  Cualquiera de las tres agrega endpoints y pantallas. Hay que definirlo con Procesos antes de la aceptación.
- **D-P3 · ¿Qué vista de Softland lee n8n, y existe en la réplica?** Giovanni Perez ubicó el diccionario. Falta saber:
  - si está en la réplica que usa n8n,
  - con qué nombre de vista,
  - y con qué usuario de solo lectura.
  
  Según la respuesta, se ajusta el `SELECT` del flujo.
- **D-P4 · ¿Qué cuenta y región usa QA y prod?** De eso dependen:
  - las credenciales del pipeline,
  - si se repite us-west-2 y la versión 16.15,
  - y los CIDR, si se comparte red.
- **D-P5 · ¿Dónde queda el repositorio?** Hoy está en GitHub (`flujosoice/glosario-aws`, `main`). Intelix exige `git.intelix.biz` con `develop`, `qa` y `master` protegidas. Hay que definir si GitHub queda como espejo o se retira.
- **D-P6 · ¿El pipeline despliega también la plataforma?** El pipeline de Intelix solo corre `sam deploy`. Las opciones son:
  - correr `deploy.py platform` a mano una vez por ambiente,
  - o agregar un job al pipeline.
- **D-P7 · ¿Qué dominio exacto tiene el Portal Interno?** Con la respuesta se cierran CORS y CSP, que hoy aceptan `*.mayoreo.biz` (D06).
- **D-P8 · ¿Se quita el user pool de Cognito que no se usa?** Quitarlo no tiene efecto funcional. Es una limpieza que se puede hacer junto con la aprobación del ADR.
- **D-P9 · ¿Hace falta trazabilidad por persona?** Si Arquitectura o Procesos la piden, se emite una llave por persona sin cambiar código, o se pasa a federación con el Portal (D02).
- **D-P10 · ¿Se cargan las fuentes de Google?** Hoy la CSP las bloquea y la app usa la fuente del sistema. Las opciones son permitirlas en `amplify.yml` o incluirlas en el build.
- **D-P11 · ¿Se mantiene la salida a prod del 13/11?** Con QA bloqueado por la cuenta y n8n sin probar, la fecha está en riesgo.
