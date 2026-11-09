# Ingesta desde n8n

Los Maestros de Artículos y Clientes (Google Sheets) y el Diccionario de datos de Softland llegan a
Aurora por la API de ingesta. AWS no se conecta a Google ni a Softland: n8n lee el origen y envía las
filas. Una conexión directa a Softland solo se habilita si la autoriza el Gerente de Sistemas.

## Autenticación

Cabecera `Authorization: Llave <llave de ingesta>`. La llave se crea con
`python database/tools/crear_llave.py --proposito ingesta --etiqueta "n8n"` y se guarda en las
credenciales de n8n. La llave de administración no sirve para la ingesta (403) ni al revés.

## Flujo de una carga

| Paso | Llamada | Cuerpo | Respuesta |
|---|---|---|---|
| 1. Iniciar | `POST /ingest/sync-runs` | `{"origen": "maestro_articulos" \| "maestro_clientes" \| "diccionario_softland", "filasEsperadas": 893}` | 201 con `id` de la carga |
| 2. Enviar lotes | `POST /ingest/sync-runs/{id}/rows` | `{"filas": [ ... ]}` (máximo 1.000 filas por lote) | `{"filasRecibidas": n}` |
| 3a. Completar | `POST /ingest/sync-runs/{id}/complete` | — | La carga pasa a ser la vigente |
| 3b. Si algo falla | `POST /ingest/sync-runs/{id}/fail` | `{"error": "motivo"}` | La carga queda fallida; lo vigente no cambia |

- `filasEsperadas` es opcional. Si se envía, completar exige que lleguen exactamente esas filas.
- Solo puede haber una carga en curso por origen (409 si se inicia otra). Una carga en curso por más
  de 2 horas se marca fallida automáticamente (job horario).
- Al completar, la carga anterior del mismo origen deja de ser vigente y sus filas se eliminan, en una
  sola transacción. La bitácora conserva todas las cargas.
- Programar los flujos dentro del horario de servicio de AWS (por defecto 5:00 a 17:00).

## Formato de las filas

Las claves pueden venir con los encabezados originales (como los entrega el nodo de Google Sheets o
la exportación del diccionario) o en snake_case: se normalizan quitando acentos y signos. Los valores
Sí/No/True/False pasan a booleano.

**Maestros** (`maestro_articulos`, `maestro_clientes`): Grupo, Atributo, Nombre técnico, Definición,
Empresas Aplica, Obligatorio, Validaciones y Reglas clave del atributo, Tipo de Dato, Fuente del dato,
Dominio / Valores permitidos, Valor por Default, Permite NULL, Condición NULL, Dptos. Consumidores
principales y las columnas de sistemas (Softland ERP, eFlow, AFV, Portal de Pedido, e-Commerce,
Catálogo Digital, PowerBI, Streamline), que se guardan como la lista de sistemas en True. Opcionales:
`hoja` (nombre de la pestaña, p. ej. "Tabla Asociada - Dirección de embarque") y `fila` (o `row_number`).
Cada fila necesita Atributo o Nombre técnico.

**Diccionario de Softland** (`diccionario_softland`): Esquema, Módulo, Tabla, Columna, Descripción,
Tipo Dato, Tamaño, Nulidad, Llave Primaria, Llave Foránea, Valor Default, Posibles Valores, Editable
procesos masivos, Editable primera vez, Modo case, Tipo máscara, Autocalculado, Visible, Sólo lectura,
Requerido, Mostrar como, Tipo consecutivo, Formato justificado, Valor etiqueta, Mostrar en F1. Cada fila
necesita Tabla y Columna. Unas 15.700 columnas: 16 lotes de 1.000.

## Bitácora

`GET /sync-runs?origen=<origen>&limit=20` con la llave de ingesta o la de administración: estado,
filas esperadas y recibidas, quién la inició, fechas y error.
