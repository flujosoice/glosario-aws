\set ON_ERROR_STOP on
-- Datos iniciales para may_qa_glosario_db (origen: semillas de database\source). Generado por la skill; no editar a mano.
-- Ejecutar DESPUÉS de aurora_postgresql_schema.sql, como master, sobre la base del aplicativo.
-- Re-ejecutable: las filas existentes (misma clave) se conservan.
BEGIN;
-- public.etiquetas → may_qa_glosario_sch_core.tbl_etiquetas (24 filas)
CREATE TEMP TABLE _stg_tbl_etiquetas (LIKE may_qa_glosario_sch_core.tbl_etiquetas) ON COMMIT DROP;
COPY _stg_tbl_etiquetas (id, nombre, tipo, es_base, creado_en) FROM stdin;
1	Eprac	silo_sistema	t	2026-10-21 17:37:23.612869+00
2	Integridad de Datos	silo_sistema	t	2026-10-21 17:37:23.612869+00
3	Kaizen	silo_sistema	t	2026-10-21 17:37:23.612869+00
4	Reporte SIM	silo_sistema	t	2026-10-21 17:37:23.612869+00
5	Silo Compras	silo_sistema	t	2026-10-21 17:37:23.612869+00
6	Silo Control	silo_sistema	t	2026-10-21 17:37:23.612869+00
7	Silo Logística	silo_sistema	t	2026-10-21 17:37:23.612869+00
8	Silo Mercadeo	silo_sistema	t	2026-10-21 17:37:23.612869+00
9	Silo Personal	silo_sistema	t	2026-10-21 17:37:23.612869+00
10	Silo Procesos	silo_sistema	t	2026-10-21 17:37:23.612869+00
11	Silo Sistemas	silo_sistema	t	2026-10-21 17:37:23.612869+00
12	Silo Ventas	silo_sistema	t	2026-10-21 17:37:23.612869+00
13	Softland	silo_sistema	t	2026-10-21 17:37:23.612869+00
14	Dimensión Compras	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
15	Dimensión Finanzas	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
16	Dimensión Personal	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
17	Dimensión Ventas	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
18	Filtro Compra	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
19	Filtro Logística	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
20	Filtro Venta	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
21	Indicador Compra	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
22	Indicador Control	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
23	Indicador Personal	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
24	Indicador Venta	rol_reporte_sim	t	2026-10-21 17:37:23.612869+00
\.
INSERT INTO may_qa_glosario_sch_core.tbl_etiquetas (id, nombre, tipo, es_base, creado_en) OVERRIDING SYSTEM VALUE SELECT id, nombre, tipo, es_base, creado_en FROM _stg_tbl_etiquetas ON CONFLICT DO NOTHING;
SELECT setval(s, GREATEST(m, 1), m IS NOT NULL) FROM (SELECT pg_get_serial_sequence('may_qa_glosario_sch_core.tbl_etiquetas', 'id') AS s, (SELECT max(id) FROM may_qa_glosario_sch_core.tbl_etiquetas) AS m) x WHERE s IS NOT NULL;
-- public.maestros → may_qa_glosario_sch_core.tbl_maestros (4 filas)
CREATE TEMP TABLE _stg_tbl_maestros (LIKE may_qa_glosario_sch_core.tbl_maestros) ON COMMIT DROP;
COPY _stg_tbl_maestros (id, nombre, es_base, creado_en) FROM stdin;
1	Artículo	t	2026-10-21 17:37:23.610082+00
2	Cliente	t	2026-10-21 17:37:23.610082+00
3	Proveedor	f	2026-10-21 17:37:23.610082+00
4	Empleado	f	2026-10-21 17:37:23.610082+00
\.
INSERT INTO may_qa_glosario_sch_core.tbl_maestros (id, nombre, es_base, creado_en) OVERRIDING SYSTEM VALUE SELECT id, nombre, es_base, creado_en FROM _stg_tbl_maestros ON CONFLICT DO NOTHING;
SELECT setval(s, GREATEST(m, 1), m IS NOT NULL) FROM (SELECT pg_get_serial_sequence('may_qa_glosario_sch_core.tbl_maestros', 'id') AS s, (SELECT max(id) FROM may_qa_glosario_sch_core.tbl_maestros) AS m) x WHERE s IS NOT NULL;
-- public.terminos → may_qa_glosario_sch_core.tbl_terminos (1246 filas)
CREATE TEMP TABLE _stg_tbl_terminos (LIKE may_qa_glosario_sch_core.tbl_terminos) ON COMMIT DROP;
COPY _stg_tbl_terminos (id, termino, definicion, campo_softland, estado_origen, nota_origen, revisado, nota_decision, es_nuevo, editado, eliminado_en, creado_en, actualizado_en) FROM stdin;
4979eb1c-3073-408c-8303-21e288e292aa	 Algoritmos de extracción (E-Flow)	 Lógica del WMS que determina qué ubicaciones y qué productos se deben extraer para cumplir pedidos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
ae0a4ed4-a3dd-4b6d-957e-9cdc19d695f1	 Alisto (Picking)	 Proceso de preparar los pedidos de los clientes, seleccionando y organizando productos según la orden		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
eb2aacb7-f805-47fc-bdb0-fb3d8fe72c6b	 Alisto batch (por lotes)	 Método de preparación en el que se agrupan varias órdenes para optimizar recorridos y tiempos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
89af55eb-9c33-4cbb-a251-b2548b8a693e	 Asignación de viaje	 Vinculación de la carga con chofer, vehículo, ruta y hora de salida para garantizar trazabilidad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f69f1e62-c818-4c57-ba7a-cafc356bed17	 Capacidad	 Es la medida del volumen máximo de recursos que una instalación, vehículo o proceso puede manejar en un periodo determinado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
99c5eedb-aad8-422f-9d85-208ef594ed9d	 Certificación de alisto	 Punto de control que valida que un pedido esté completo y correcto antes del despacho		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
9fd66c8f-8752-42ea-a733-17f96207133b	 Chequeo	 Verificación física y documental de mercancías para asegurar cantidad, estado y exactitud		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
3e946d3d-b212-47ff-ad7d-e3903d3f5110	 Consolidación	 Agrupación de productos por cliente o pedido antes del despacho, evitando mezclas entre clientes		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
dd628283-d383-46ed-adf2-99fc052ffc24	 Control de Inventarios	 Supervisión y conteo de existencias en el CEDI para garantizar exactitud y disponibilidad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
69e6a98c-97b2-4d72-8700-669697c81dd7	 Desconsolidación	 Separación de cargas consolidadas para su distribución individual		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6dd8d1ea-c987-4da3-86d4-533d5e718643	 Despacho	 Preparación y salida de pedidos desde el CEDI hacia el cliente		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:20.411+00
33703e15-f853-4b8c-a737-b2247db621ba	 Eficiencia	 Capacidad de alcanzar un resultado con el mínimo uso de recursos, manteniendo la calidad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
bd18cd20-f053-4ac5-bd1c-3eeb28fec53e	 Etiquetado de pallets	 Asignación de códigos y rótulos únicos a cada pallet para garantizar trazabilidad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
7f77a437-5fd2-4454-97f2-74965041220a	 Fulfillment	 Es el proceso logístico integral que abarca la preparación y entrega de pedidos de clientes, desde la recepción de la orden y el almacenamiento de productos hasta su empaquetado, envío y distribución final		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
403dfab9-0c64-4e98-a2a8-5c8c19d275f5	 Gestión de inconsistencias	 Registro y resolución de diferencias detectadas entre lo recibido, lo registrado y lo esperado en el sistema		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
e19a0033-a0db-4eb9-8981-7989df88dc92	 GTP (gestión total de productividad)	 Es un modelo integral de indicadores de desempeño que mide de forma sistemática la productividad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4fc7c8a4-e653-4a44-bc96-b345fe6b5de4	 Handheld	 Dispositivo portátil conectado al WMS que permite escanear productos y registrar operaciones sin errores manuales		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:35.826+00
12f5ca55-df15-406d-b846-79284591a0f7	 Inbound	 Logística de entrada, relacionada con el transporte y almacenamiento		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
10603b47-ba82-4cdf-92b9-7f5bc92fa9fd	 Logística Inversa (devoluciones)	 Procesos para recibir productos devueltos, defectuosos o sobrantes y darles el tratamiento adecuado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a211a5ee-112b-41c8-be70-7e26535b1cd6	 Mínimos y máximos	 Niveles de control de inventario que activan reposición (mínimo) o previenen sobrestock (máximo)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
059a95df-72a9-47f0-93e2-373bf725ff13	 Outbound	 Todas las actividades relacionadas con la distribución y entrega de productos terminados a los clientes finales, incluyendo la preparación de pedidos, el embalaje, el transporte, la gestión de envíos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
250d9de4-4429-4bde-ad83-7e9fc0037b59	 Pallet máster	 Pallet consolidado que agrupa varios pedidos o cargas de un cliente para transporte		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
46238357-6cbc-4703-8246-1e9043e86635	 Pick-to-Belt	 Acción donde el asistente de logística recoge y coloca en una banda/contenedor intermedio		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
571c5523-7328-4269-8d86-4668415e9131	 Pick-to-Order	 Acción donde el asistente de logística recoge y arma directamente un pedido		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
0f773c04-e1ab-49e7-ab6e-cf3853ddfa91	 Pick-to-Put	 Acción donde el asistente de logística recoge en lote y clasifica en compartimentos para consolidar varios pedidos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
51af7f43-1f3c-4c6c-adfe-62e8b7afa033	 Productividad	 Se refiere a la cantidad de pedidos entregados por hora, los vehículos que circulan por día, o los productos procesados por empleado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
dfc67e4c-c2bc-4862-aa58-d7937c50b123	 Putaway	 Proceso logístico de mover mercancías, una vez recibidas en un almacén, desde el área de recepción a sus ubicaciones de almacenamiento designadas		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a3b3c87e-a9b3-43b4-a3d2-21c466b5b530	 Reposición	 Traslado automático de inventario desde reserva hacia zonas de picking cuando el stock llega al mínimo		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
379a7b64-aacd-4991-9b26-bdecadb6cb08	 SEL (servicios estratégicos locales)	 categoría del Régimen de Zonas Francas en Costa Rica que permite a empresas, como operadores 3PL, brindar servicios logísticos y de apoyo con beneficios fiscales y aduaneros		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b261db36-61be-47bd-bc5b-e3ca037f4af0	 SIO (Sistema de información de OLO)	 Es una plataforma interna que centraliza y gestiona la información de la empresa para facilitar el control de procesos y la toma de decisiones		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d9d3b2fc-44ec-44ea-b1ff-72b9a00e0666	 SLA (Service level agreement)	 Acuerdo de nivel de servicio donde se establecen metas específicas para el cumpliento de los acuerdos de servicio con los clientes		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
11d77557-7489-4621-ae5d-ec2eb5ace5b1	 TI-HI	 Estándar logístico que define cuántas cajas por piso (TI) y cuántos pisos por pallet (HI), optimizando espacio y estabilidad		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4226625f-a0ca-462f-a0f8-a52f66b576c2	 Tipos de recepción	 Modalidades de ingreso de mercancía, como compra/importación, libre, cross docking o devoluciones		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4d497265-29ad-4b68-9098-bf95b247b3f9	 TMC (transport management system)	 Software de gestión de transportes que planifica, ejecuta y optimiza los movimientos de mercancías, permitiendo controlar rutas, costos, flota y entregas para mejorar la eficiencia y el servicio al cliente		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
0b52d8a5-5a05-48cf-864b-67f4b79b20ff	 Torre de Control	 Sistema centralizado de monitoreo en tiempo real que coordina y optimiza todas las operaciones del CEDI, como una torre aérea		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
20b1f6b0-da8c-4dbc-96ae-ba1952df2e58	 Transporte	 Movilización de mercancías desde/hacia el CEDI hasta el cliente o punto de distribución		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
57bb491a-3485-4619-81fe-588070d2474d	 Valor Agregado	 Servicios extra como etiquetado, reempaque, kits o control de calidad que complementan la operación básica		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
3395e5f6-ef7c-46ae-b921-4e5561e90c1c	 WMS (warehouse management system)	 Sistema de Gestión de Almacenes, es un software que optimiza todas las operaciones dentro de un almacén o centro de distribución, desde la recepción de productos hasta su envío		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
c41a9032-721e-456f-86c0-2ef40f404df4	 Zona de cuarentena	 Espacio destinado a productos en revisión o pendientes de aprobación		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
90db3b92-aff4-4484-87be-2f9b2df5eb35	 Zona de picking	 Área de preparación de pedidos con productos listos para alisto		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
55b87d9c-7ad7-4644-992d-a60c84d49bb0	 Zona de reserva	 Área de almacenamiento profundo, normalmente por pallet completo		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
88d06b11-4229-4fac-b068-a3c1886d6097	 Zona Franca	 Régimen especial donde OLO opera parte de su logística, con control aduanero y beneficios fiscales		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4971f6f4-dfb3-43e6-8480-957adf39b36d	Abono extraordinario	Se refiere a los abonos extras que hagan los clientes a sus deudas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
327bf95c-9219-4ab4-a4ef-42639cf87597	Acceso	Derecho o permiso que tiene un usuario para entrar a un sistema o consultar datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b97abec6-a176-413f-a520-a5b9d3aaa76b	Accidente	Hecho no premeditado del cual resulta un daño considerable. Es una ocurrencia en una serie de hechos que, en general y sin intención, produce lesión corporal, muerte o daño material.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f0a0efcd-68b1-49fa-bcad-7c737f2dd2d1	Accidente laboral	Evento no planeado que resulta en daño o enfermedad para los colaboradores durante el desempeño de sus tareas laborales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2b4dc552-f196-463e-b340-24b8fddb74cd	Acciones de preparación de pedidos	Tareas que eflow WMS crea automáticamente después de generar órdenes de expedición, basándose en las ubicaciones con mercadería disponible para su extracción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
137fea0e-0bcb-48fd-9686-cd51884d30af	Acción correctiva	Medida tomada para eliminar la causa de una no conformidad detectada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
55f7d2ad-b94f-4da6-9daf-917100539ed6	Acción de personal	Documentos que registran y establecen los movimientos del empleado, ya sea por abandono temporal del puesto o bien, por cambio de puesto o terminación de labores.	Número Acción	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:46.418+00
84ade85b-710b-4699-8fe4-7edd6581425b	Acción de trabajo	Tarea generada por el sistema para preparar artículos según la orden de expedición.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
71337e1f-db49-4c60-9f08-10d4dcf220a2	Acción preventiva	Medida implementada para evitar que ocurra una no conformidad potencial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
e7c5727d-900e-470b-b2bf-8911299aa58f	Acta de finiquito	Documento que deja constancia de la terminación de la relación laboral y el acuerdo mutuo sobre los pagos pendientes (liquidación final). Sinónimo de "Acuerdo de Cese" o "Finiquito".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4a62a163-f307-46c2-8b9f-dd456bb3c7a1	Actividad	 Corresponde a un subnivel del proceso que será utilizado o no, según se requiera para el entendimiento del mismo. (múltiples tareas, múltiples agentes, paralelas o secuenciales). 	Actividad Económica SGRL	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:47.756+00
560ba3fb-0a79-4ae8-b895-0b93684a02dd	Activos	Recursos económicos controlados por la empresa como resultado de eventos pasados, de los cuales se espera obtener beneficios económicos futuros. Se clasifican en Activos Corrientes y Activos No Corrientes.	Activo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:38:37.245+00
7ab3d352-4745-4dc0-b321-f40d02a1d394	Adelanto	Proceso mediante el cual se realiza un avance de efectivo a la caja chica. El detalle de su ejecución se presenta en la sección "Adelanto Caja Chica" en la página 75.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:49.085+00
4155f205-171c-42b4-9932-a93231a5aa90	Aftermarket	Mercado de autopartes no originales, pero compatibles con los vehículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6da8ca0b-007c-4287-8442-5f5e3becb0ae	AFV	Aplicación móvil de la fuerza de ventas		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
eee64272-fb29-4353-a8cd-919f802951ca	Agente	Vendedores o cobradores que realizan preventa y / o cobros.	AGENTE	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:48:50.292+00
c3f3471e-c75d-4565-9727-6ee9da50914b	Agrupación	Conjunto de clientes agrupados que poseen el mismo nombre y diferentes razones sociales.	Agrupación	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-09-25 13:37:33+00
9dbb7635-04f1-4372-8ed2-81d17ae8a4cc	Ajuste contable	Modificación de un asiento contable, realizada para corregir errores, registrar transacciones omitidas o reconocer ingresos y gastos en el período correcto (devengo).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
8b5298f2-f783-446b-82e5-f421d21a032b	Ajuste de inventario	Modificación de cantidades de inventario existentes, ya sea por entrada o salida, desde una ubicación específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
41ecc608-60ba-4bf2-a2ff-fd5f4fafb8cc	Ajuste de saldos	Transacción administrativa que modifica saldos de clientes, generalmente por montos inmateriales o diferencias cambiarias, que no justifica la emisión de un documento fiscal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
afb9bd4a-79e4-4c99-bb1c-935d5686f8e1	Ajustes de precios	Se refiere a la ejecución, análisis y validación de las modificaciones en los precios de artículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
348e8b8f-aa77-4e3c-b176-383088f58812	Alcance	 Establecer el cubrimiento y propósito del documento. Debe indicar tanto las áreas como las situaciones donde el documento debe ser usado, además de indicar sus excepciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4c2736f3-5f41-4ab7-8ed5-0e51af7ebcf6	Alfanumérico	Carácter que puede corresponder a cualquier dígito o letra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2773e9f0-b2f4-46ef-8f0d-a38b17576969	Algoritmo	Conjunto de pasos o instrucciones que una computadora sigue para resolver un problema, como una receta de cocina.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f5f7de91-0abc-49ae-957d-44769bb90c86	Algoritmo genético	Técnica inspirada en la evolución natural que sirve para encontrar soluciones a problemas complejos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
bd94cf74-4ba3-41d9-bcbf-cc51580fd3f6	Alias	Se refiere al nombre o identificador alternativo que se le asigna a un cliente.	Alias	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-09-25 13:37:33+00
527ac1f6-2acc-48e5-954c-bc4dccd32cb1	Almacenaje	Los procesos relacionados con el almacenamiento de artículos y su funcionalidad en el módulo eflow WMS, incluyendo movimientos en el dispositivo de radio frecuencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2c803123-f70f-4ca0-99b4-7e2e2be342d2	Almacenamientos	Son estructuras físicas donde se guarda la mercadería. Se configuran con información general, composición (columnas, niveles, posiciones), situación y coordenadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
5543bcb4-54ba-4306-8f68-99c585fd811e	Almacén	 También conocido como Centro de Distribución (CEDI), es una instalación o espacio que sirve para ubicar materiales y productos con la función de coordinar los desequilibrios entre la oferta y demanda 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
bf7cc120-47d7-459e-bc81-c59f8c56a567	Alta en el seguro social	Proceso de inscripción de un nuevo empleado en el sistema de seguridad social (caja de seguro de salud, pensiones, etc.) del país correspondiente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f72c4bef-78d9-4c9a-959a-9d39384bf8cc	AMEF	 Análisis de Modo y Efecto de Falla. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
7836196b-26d6-49f1-8415-f4e6152aff40	Amortización fija	Tipo de condición de pago en el que para todas las cuotas, el monto que se amortiza al principal es siempre el mismo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
84eda7b2-8ba6-441a-a404-ce6bc8f06b00	AMP	Unidad de intensidad de corriente eléctrica		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1a86f0a1-8368-4954-8b9c-1394edd8dc22	Analítica	Uso de datos para identificar patrones y ayudar a tomar mejores decisiones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
91a349d6-1753-473f-83a5-476a238c3e6a	Andón	Herramienta de gestión visual, cuyo origen proviene del término japonés "lámpara". Comúnmente, los andones son luces que se colocan en máquinas o líneas de producción para indicar el estado de las operaciones y notificar a la gerencia, el personal de mantenimiento y otros trabajadores. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
38a9a6ac-b761-4c81-ab82-51ba5e6a76d9	Anexo	 Documento que presenta información referencial como complemento de un macroproceso, proceso, actividad o tarea específica. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
ea677fc7-f5f7-4737-a4ea-611b8915d33a	Cat- Marca	Es la categoría en la cual el proveedor clasifica el producto.	Cat-Marca	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 19:30:00+00
9aab3557-cb41-4944-b553-52beae877422	Anexo de deposito	Comprobante que entrega el asesor de ventas por medio del AFV al depositar en cuentas bancarias de la compañía el efectivo recaudado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
54054d6a-a5c8-4b93-9438-5797875bc6c4	Antenas de radio frecuencia	 Equipos encargados de emitir señal de Recepción a las pocket RF para el uso del sistema eflow WMS. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
acafd1f1-2e19-4d9b-952a-52dc430e7d3e	Anticipos a proveedores	Pagos realizados a un proveedor antes de la recepción de los bienes o la factura correspondiente. Se registra como un activo (un derecho a recibir un bien/servicio) hasta que se aplica a la factura final.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
10b71976-93a5-40b0-be8a-c841c006c3bc	Antigüedad empresa	Tiempo total que un colaborador ha laborado para la empresa de forma ininterrumpida o acumulada, incluso si ha habido reingresos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
9b5576bd-8e4c-4ae7-8f1b-84913db15d84	Antigüedad organización	Tiempo que un colaborador ha permanecido en su puesto actual o dentro de la misma área o estructura organizacional, sin cambios significativos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a4a9bde8-e65e-4fbf-9d65-e28147834458	Antivirus	Programa que detecta y elimina virus o programas maliciosos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2a8fabee-9893-4414-8201-a19a4532aa39	ANUL (anuladas)	Tareas que, por motivos operativos, no deben ejecutarse.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
5f862776-ad73-43c2-9421-fca1b36b2a58	Análisis de Escenarios	Metodología de simulación que permite evaluar el impacto de diferentes variables (optimistas o pesimistas) en los niveles de inventario y flujo de caja, facilitando la creación de planes de contingencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b29d596a-40c6-496d-b2a5-fe322cd0abef	APE	Error porcentual absoluto entre la demanda real y el pronóstico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
912f0772-34a9-45a0-ae87-59b5d610cc15	Apilador / montacarguista	Operador de equipos de manejo de materiales (montacargas, apiladores) que requiere certificación interna.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	Aplicaciones	Es el concepto comercial en Mayoreo Autopartes que reúne los tipos de transportes.	APLICACIONES	homonimo	Se separó de un término homónimo compartido con: Movilidad (Personal).	t	\N	f	t	\N	2026-10-21 17:37:23.615483+00	2026-09-30 19:30:00+00
fd94e0a3-32d5-46df-9298-53696467dd83	Aplicación	El uso principal o la función prevista de un artículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2a343c49-9dad-45eb-8d03-8774e1ce7aaf	Aplicación al mayor	Proceso del ERP que traslada los registros de transacciones (asientos) desde el libro diario al libro mayor, actualizando los saldos de cada cuenta contable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
25248767-700c-4654-a976-db862eb0ce44	Aplicación de documento	Proceso de vincular un pago o nota de crédito a su factura o documento de origen correspondiente, saldando o reduciendo la deuda pendiente. Es un paso clave en la gestión de cuentas por cobrar y pagar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
26e00352-72ab-4d3b-91a2-f47d84317719	Aplicar	Sinónimo de mayorizar.	Aplicar	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:49:20.62+00
3ec20b94-cf26-40e8-b433-1906e6ca413e	Aporte	Es un rubro utilizado dentro de los conceptos como una variable, que no afecta directamente al salario, pero lo toma como referencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
87800534-77b4-414f-b091-aa5607cd0d27	Aprendiz	Persona que recibe formación teórica y práctica en un oficio o actividad, bajo la modalidad de contrato de aprendizaje. Regulado por leyes específicas de formación profesional en cada país (Ley de Juventud en Colombia, Ley Orgánica del Trabajo en Venezuela, etc.).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
0ee617ed-1696-43fd-895c-605a8a26e129	Aprendizaje no supervisado	El sistema aprende encontrando patrones por sí mismo, sin ejemplos previos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f38f1048-cffd-4a64-8548-e39493039fbe	Aprendizaje por refuerzo	El sistema aprende probando acciones y recibiendo “premios” o “castigos” (ej. un robot que aprende a caminar).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
7bfb10f8-b734-4a58-811e-a40701388542	Aprendizaje supervisado	El sistema aprende usando ejemplos ya clasificados (ej. fotos marcadas como “gato” o “perro”).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
edb5b7ad-3403-41a4-9652-ee13584e82e8	Aprobación	Validación formal de un documento o proceso por parte de los responsables.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
5735cb7c-5b72-4b58-8ed8-137a62e8c356	ARA	Accesorios y repuestos automotrices		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f4bddfde-e390-4564-b6ce-4e5f02076e0f	Arancel	Impuesto que se debe pagar sobre un artículo extranjero, debido al ingreso del mismo al país.	Arancel	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-09-25 13:37:33+00
4354b86f-2813-4ba5-b49f-82af8445d0c4	Archivado	Almacenamiento de documentos para fines históricos, legales o de consulta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b83b9a9b-1527-4cdb-b58b-db2508b1806a	Archivo BMP	Archivo cuyo contenido puede verse como una matriz M de dimensiones mxn, donde la entrada M[i,j] tiene como valores {0,1} y representan una imagen gráfica. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
cd487562-3733-4006-9e1c-f08b487a11dc	Archivo PBIX	Archivo nativo de Power BI que guarda tanto los datos como las visualizaciones creadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
804708fe-b877-4ab1-b7e3-b3158d6b3e23	Arqueo	Proceso mediante el cual se ejecuta un recuento de los movimientos efectuados en la caja chica. El detalle de su ejecución se presenta en la sección "Arqueo de Caja Chica" en la página 63.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
56be082e-6f8c-4781-bd9c-9a5ffde9398b	Arquitectura de procesos	 Proporciona un lenguaje común (BPMN) para que los involucrados se puedan comunicar de forma clara y a su vez puedan divulgar los procesos. Dentro de la Arquitectura de Procesos tenemos los niveles de comprensión. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
882266a0-81c4-4129-8c43-3022046461a0	Arquitectura de software	La manera en que se diseña y organiza una aplicación para que funcione de forma correcta y ordenada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
54dd51b5-de9c-47a7-ac8f-db288aa0d235	Articulo	Reporte SIM – Dimensión Compras: Dimensión que muestra el código y descripción de los articulos de la compañía. Reporte SIM – Filtro Compra: Permite seleccionar el código y descripción de uno o varios artículos en específico.	Artículo	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:38:51.612+00
9cb95e2f-92a6-412d-8cfb-9ef066b35505	Artículo	Elemento esencial del inventario. Los artículos son las unidades mínimas almacenadas en bodega y sobre los cuales se realizan las transacciones de compra.	Artículo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:38:55.262+00
c93e35b5-1596-4903-9f97-9c7408942fa6	Artículo Complementario (J)	Repuestos que no forman parte del surtido regular y se usan para reparaciones en talleres de servicio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
14626fcc-a1a3-4473-ae01-70bb1034a059	Artículo Dummy	Código y descripción genéricos de producto creados temporalmente en el ERP para presupuestar, planificar o registrar operaciones comerciales cuando el artículo o SKU definitivo aún no ha sido identificado o dado de alta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
3b664f51-9504-4c3d-8648-e395adc4a6bc	Artículo en buen estado	Es un artículo que, hecha la revisión correspondiente, cuenta con las condiciones apropiadas para su comercialización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a610d962-5a08-4d9c-ae48-b89670ffff8c	Artículo en el que no aplica la garantía	Es un artículo que por su condición o por política de proveedor no se reconocerá como garantía. El artículo no cuenta con las condiciones apropiadas para su comercialización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6efeaa8c-1c50-4f58-97ae-179de8cd4d1a	Artículo en garantía	El producto presenta defecto de fábrica, se encuentra dentro del periodo de garantía de la marca y no requiere revisión por el taller de servicios.	Artículo garantía	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:49:29.83+00
2b7d3243-d267-4cac-beb1-09152cbe4dee	Artículo en garantía de taller	El producto se encuentra dentro del periodo de garantía de la marca y sí requiere revisión por el taller de servicios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a09a1469-5bab-42b5-a0cc-06067c6ba4fc	Artículo en garantía por medio de descuento	Es un artículo cuya garantía es reconocida por medio de un descuento por parte del proveedor o una reserva del área comercial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
653a0477-80fd-4bca-b3ce-51a5f971e212	Artículo en garantía por medio de nota crédito	Es un artículo que el proveedor sí reconoce como garantía, no necesita una revisión previa y su forma de reconocer la misma es por medio de la aplicación de una nota de crédito. El artículo no cuenta con las condiciones apropiadas para su comercialización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
38bdd1c5-9bd5-4205-adbc-704f5d4ab0cf	Artículo para evaluación proveedor	Es un artículo que pertenece a una marca o proveedor que por su política, realiza una revisión del mismo antes de decidir si lo reconoce como garantía. El artículo no cuenta con las condiciones apropiadas para su comercialización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	Artículos	Indicador que contabiliza la cartera de artículos para un periodo determinado.	Artículo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:38:57.092+00
fba042dc-2d2b-491a-b46c-d41e951877e1	Artículos alternos	Artículos que pueden sustituir a otros, presentando características similares.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
3159cadb-3c1f-4240-ba03-f33ac4230f1d	Artículos Básicos (F)	Los siguientes 800 artículos contados después de los doble básicos que generan la mayor cantidad de ventas para la empresa, evaluados en cantidades y precio durante un año.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
c59aa0f2-9f8d-4051-9fdc-0a6b50f6410c	Artículos Complementarios (H-K-M)	Artículos que complementan el surtido de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
28113b90-b7a1-429c-be22-5518ab989f0f	Artículos de importación	Artículos a los que se les debe asignar un código arancelario único antes de emitir la orden de compra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b1bed8c4-6aee-4d53-b558-63cc28972c4c	Artículos Descontinuados (E)	Artículos bloqueados o por eliminar del surtido de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
c6f44a66-9dc9-4ccb-ac1d-db808c93c4a9	Artículos Doble Básicos (D)	Los siguientes 200 artículos contados después de los triple básicos que generan la mayor cantidad de ventas para la empresa, evaluados en cantidades y precio durante un año.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
99c392dc-9ebe-4146-8ce4-8ed54c796cf6	Artículos Mercadeo y Suministros (S)	Suministros de Oficina y Material POP.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
45160c14-dc31-4bb1-99dd-6e2c91add35f	Artículos Nuevos (N)	Artículos que se incluyen por primera vez en el surtido de la empresa y una vez transcurridos seis meses desde la primera venta pasan a clasificarse según los criterios definidos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
fa84ce89-acef-43d3-9293-f3c1399e71bc	Artículos Ocasionales (L)	Artículos que se adquieren para promociones determinadas, solo por una vez.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d85c6ec7-3e47-49a0-a942-98707878afc7	Artículos Pedido Especial (P)	Artículos que no poseen inventario. Se almacenan en el Centro de Distribución o se despachan directo del proveedor una vez el cliente realiza la compra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
9a90766b-0366-4b29-b599-7b92e6a21bf7	Artículos por desarrollar (X)	Este término se atribuye a los artículos creados en el ERP para soportar los procesos de proyección de presupuesto y planificación. Su clasificación BDF es X.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b876a0e1-cfd5-45fd-ba9f-1663cfa6d889	Artículos Suspendidos (Z)	Artículos suspendidos por reducción de inventario o faltante temporal del proveedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a921fe06-9e53-4444-9175-c29a6318ae3c	Artículos Temporada (T)	Se compran para épocas determinadas todos los años.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b5767fac-92f3-40c0-afc5-6d9001fabf61	Artículos Triple Básicos (B)	Los primero 50 artículos que generan la mayor cantidad de ventas para la empresa, evaluados en cantidades y precio durante un año.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6c659bc6-b43d-4cb5-9ecd-e138e7a6693b	Ascenso	Movimiento vertical ascendente de un colaborador a un puesto de mayor responsabilidad, jerarquía y remuneración.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
80593ba1-d3a3-4974-9b4e-cd65ee946439	Asesor	Refleja el nombre de los Asesores de ventas activos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6405d99e-e7a4-4715-9ed0-e52dbce7e0d1	Asesor de televentas	Realiza la gestión de ventas de forma remota por teléfono para la comercialización de productos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
869ee472-863c-4dcb-b31b-f0235b82349d	Asesor de ventas	Es un profesional estratégico que no solo se encarga de vender, sino también de construir y mantener relaciones con los clientes, actuando como un consultor y un embajador de la marca.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4a43bcfb-60e4-4479-a0d5-1dc339273837	Asiento	Registro formal de una transacción financiera en los libros contables. Cada asiento afecta al menos a dos cuentas (un débito y un crédito) y es la unidad básica para la construcción de los estados financieros.	Asiento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:39:02.557+00
f93401a7-54f4-4662-baa2-966397d42e30	Asignación de expedición	Proceso de vincular una expedición con una unidad de transporte específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1978b6b0-0816-4c06-bd15-c3e9386e33fe	Asignación de seguridad	Proceso de vincular perfiles con permisos específicos en módulos del sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
82bd6a08-78d7-4497-b821-99a36656151d	Asignación expedición camión	Proceso mediante el cual se debe asignar una expedición a una unidad de transporte para poder realizar la carga del camión.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
ddcf1d3a-f07d-46f8-aec9-e58dc3205f6d	ATEN (atendiéndose)	Tareas que los recursos están preparando en el momento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2d44a9ce-0df7-43cb-8d0c-04ee5bb1e93b	Atributos	Las características específicas o propiedades de un artículo que ayudan a definirlo y distinguirlo de otros productos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:49:32.409+00
9b87f39f-5941-49a0-87b4-11632ba76e49	Atributos cualitativos del artículo	Permiten definir el valor cualitativo de la característica de calidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
18a6320b-1473-4455-b202-dcd495003009	Atributos de colaboradores	Conjunto de competencias, habilidades, conocimientos y comportamientos evaluados en el colaborador, utilizados como insumo para la retroalimentación y la toma de decisiones de desarrollo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
98e6b0b2-ec51-441d-80fb-81bc7f12f514	Audiencia	es el grupo de personas que es más probable que se interese en adquirir tu producto, servicio o en interactuar con el contenido de tu marca. Es el público al que se dirigen todas las estrategias de comunicación y publicidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4ceed903-7f8b-4034-8e8e-128ee1450007	Auditoría	Proceso sistemático de revisión y verificación de los registros contables y procesos operativos para asegurar su exactitud, cumplimiento con las normativas y eficiencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
63080814-630d-4ae7-9395-573b5578b3f1	Auditoría de normas	Evaluación formal del cumplimiento y aplicación de las normas documentadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f80a6a04-52a4-44c5-bd0b-a6fc6a74ff5a	Auditoría de procesos	Evaluación sistemática para verificar el cumplimiento, eficacia y mejora de los procesos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a363100e-663f-4ef8-a904-f1b582375527	Auditoría de sistemas	Revisión para verificar si los sistemas funcionan bien, son seguros y cumplen con lo esperado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
fb77f861-4e2b-4d7c-9e53-a631238d5a35	Auditoría externa	Auditoría realizada por una firma independiente para emitir una opinión objetiva sobre la razonabilidad de los estados financieros. Es clave para la confianza de inversores y bancos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
a4917d57-5278-4ac4-87cb-a568130bc23f	Auditoría interna	Actividad independiente dentro de la organización, diseñada para evaluar y mejorar la eficacia de los procesos de gestión de riesgos, control y gobierno corporativo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
7aed4c7e-5620-4074-92a3-92047ca70a08	Ausentismo	Frecuencia o duración del tiempo de trabajo en el que un empleado está ausente de su puesto, ya sea por enfermedad, permisos o razones no justificadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
29cf6716-ca3d-4f5e-8b72-9e11e3bccfe5	Autenticación	Proceso de verificar la identidad de un usuario (ej. ingresar usuario y contraseña).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
336bd53a-c95e-456f-818e-5cc33f33b62d	Autoevaluación de normas	Revisión interna realizada por colaboradores para verificar el cumplimiento de las normas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
20f292a0-beba-4ead-a70d-d38444529da7	Autoparte	Pieza o conjunto de piezas que forman parte de un vehículo, ya sean mecánicas, eléctricas, de seguridad o estéticas		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
93580ff2-6b41-4396-806f-149537b08b3e	Avalúo	Informe que detalla la antigüedad de los saldos de la cartera de clientes (cuentas por cobrar), clasificando la deuda en vencida y por vencer. Es una herramienta crucial para evaluar el riesgo crediticio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f8df2642-33c5-49a6-9c31-35a616cd8e33	Backup (respaldo)	Copia de seguridad de la información que permite recuperarla en caso de borrado o daño (ej. un archivo guardado en la nube como copia).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
09e66518-a81f-4ef4-86cb-a2e1cb7774a7	Balance de situación	Un estado de la posición financiera de una empresa en un instante de tiempo que muestra los activos y los pasivos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
05ad0b8d-df30-4865-be8a-6900a32388c5	Balance general	Informe financiero que actúa como una "fotografía" de la salud financiera de la empresa en un momento específico. Detalla los activos, pasivos y el patrimonio neto, basado en la ecuación contable:		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
677a7bac-6a56-4edc-abe5-7048966181b5	Banner	En marketing, un banner es un formato publicitario que se utiliza para promocionar una marca, producto o servicio en Internet. Se trata de una pieza gráfica o multimedia (como una imagen, animación o video) que se coloca estratégicamente en una página web con el objetivo de atraer la atención del usuario y dirigir tráfico hacia el sitio web del anunciante.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
12e41012-b323-413c-ad9d-515079a5e992	Banque	Formato de archivo específico (.bak) utilizado para la transmisión de extractos bancarios al sistema de gestión de tesorería XRT.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
6779a7de-acd0-4eb3-b57c-814a06eb3164	Base de datos	Conjunto estructurado de datos almacenados de forma sistemática para su posterior recuperación, análisis y transmisión. A diferencia de un reporte estático, una base de datos permite la manipulación dinámica de la información mediante herramientas de BI.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
978bbf94-9f13-42c2-b58c-ecaba813d23f	BDF	Reporte SIM – Dimensión Compras: Refleja la clasificación de los artículos de acuerdo a la nomenclatura BDF. Reporte SIM – Filtro Compra: Permite seleccionar una o mas clasificaciones BDF de articulos.	BDF	fusionado	Fusionado a partir de 2 filas originales.	t	Se registran ambos campos técnicos porque varían según la empresa.	f	f	\N	2026-10-21 17:37:23.615483+00	2026-09-28 16:00:00+00
7f8e0077-9350-4e58-a59e-69a86f6ae61b	Benchmarking	Comparación de procesos con los de otras organizaciones para identificar mejores prácticas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
322927ed-2f94-40d6-b731-3bcf52815d50	Beneficiario	En el módulo de Caja Chica es la persona a nombre de quien se registrará el vale.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:49:37.546+00
eef1c009-d23a-4b45-abe2-799efc9f3062	Beneficio	Es una remuneración que el empleado recibe por su trabajo. Es un flujo positivo del salario de un empleado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
374800bb-e35a-4b3f-8380-5dd9a56d431e	BI (Business Intelligence)/ Inteligencia de Negocios	Conjunto de metodologías, aplicaciones y tecnologías que permiten reunir, depurar y transformar datos estructurados en información accionable. Su propósito es facilitar la toma de decisiones estratégicas mediante el análisis retrospectivo y predictivo de la operación corporativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
9048360b-7b3f-4d02-b4b3-61e130370c58	Big data	Conjuntos muy grandes de información que requieren herramientas especiales para ser analizados (ej. datos de redes sociales).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
694e0029-10e1-4af3-a090-a0816f46c95b	Bitácora	Registro estructurado de decisiones, alertas y comentarios clave del proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1888ecb9-cfa8-45dd-abba-e5df45dae7a1	Bizagi	 Herramienta aprobada para la documentación de los procesos de las compañías de la Organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
0d4fb517-1f2f-4022-b87e-507e8b6b854d	Bloques de texto	es un componente o elemento de diseño que agrupa un conjunto de palabras, frases o párrafos con un propósito específico dentro de una página web, un correo electrónico, una landing page o cualquier otro formato digital.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
e6e40aa1-3a74-441e-9eed-439505447e28	Boceto	es una representación visual preliminar, rápida y esquemática de una idea o concepto. Es el primer paso en el proceso creativo, ya sea en el arte, el diseño, la arquitectura o incluso en la publicidad y el marketing.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	Bodega	Softland: Instalaciones físicas donde se almacenan las materias primas, los productos terminados y los suministros relacionados con la empresa. La definición de privilegios por usuario para cada bodega se realiza en el módulo de Administración del Sistema. Reporte SIM – Dimensión Ventas: Muestra las bodegas que conforman los almacenes de las compañías.	Bodega	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:39:09.269+00
3d9bc66c-3e85-4635-b05e-43acf096c125	Bodega comercial	Bodega que contiene el inventario disponible para la venta		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
c4e11d09-6085-44b2-aec7-a52604e6aea8	Bodega consignación	Bodega que contiene el inventario que se recibe por medio de consignación		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
319219ff-0102-4acb-aa78-2f8167eed6f2	Bodega dañado	Bodega que contiene el inventario proveniente de la bodega de garantías que se ha decidido sea destruido por medio de rebaja cero		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
e6d10ea0-5797-477d-b8c5-5f7464dc464a	Bodega garantías	Bodega que contiene el inventario no disponible para la venta debido a que la mercancía se encuentra dañada o averiada y está pendiente de la validación de la garantía		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
385f0450-0b1b-46d1-9ca5-8485ac76f5ef	Bodega mercadeo	Bodega que contiene el inventario de regalías y materiales de mercadeo		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1ad2abd1-55e0-4e2d-a840-cf2ce5766928	Bodega suministro	Bodega que contiene el inventario de suministros para consumo propio de la empresa		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
8cb331b0-6765-46ff-9e18-ec417f56e3be	Bodega taller/laboratorio	Bodega que contiene el inventario de repuestos para Taller		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1ab74e29-b076-4683-995d-aaf066a55bf3	Bonificaciones	Valor total de bonificaciones o descuentos aplicados a la venta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
f6ae7d9c-ddb4-47a7-b5c0-124b45c6e2f3	Bono	Compensación económica adicional al salario base, usualmente asociada al cumplimiento de metas, resultados, productividad o para ocasiones especiales (bono navideño, de vacaciones, etc.). En Venezuela se le conoce comúnmente como "Utilidades".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
2c4bffe8-885d-4d9d-8240-cad82991c026	Bono de alimentación	Beneficio no salarial que se otorga a los empleados para cubrir parcial o totalmente sus gastos de alimentación. Muy común en Venezuela y de aplicación en ciertos sectores en Colombia. En Costa Rica existe la figura del "Aguinaldo" que es diferente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
c8fc44e8-574f-40f0-885c-dc318e3fce9f	Booleano	Tipo de dato que solo puede admitir uno de dos valores posibles: Verdadero (True) o Falso (False). Se utiliza para indicadores de estado binario (ej. Facturado: Sí/No, Entregado: Sí/No).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
1ed78209-8954-47d5-ae1a-bf29a656c0ab	BPA	 Business Process Architecture. Es una visión general del negocio. Es una herramienta de comunicación (Comerciales, Técnicos y Modeladores). Muestra la secuencia lógica del flujo de Procesos de la Organización y sus relaciones. Facilita el entendimiento de la conexión entre los objetivos o plan estratégico y la cadena de valor del Negocio. Representa lo que se hace. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d4a11ae2-2b86-4ab2-acd6-56fc286e30d6	BPM	 Business Process Management. Es un conjunto de herramientas, tecnologías, técnicas, métodos y disciplinas de gestión para la identificación, modelización, análisis, ejecución, control y mejora de los procesos de negocio. Las mejoras incluyen tanto cambios de mejora continua como cambios radicales. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
cae3b7db-ac82-4be4-9a27-8989ba4fd4d6	BPMN	 Business Process Modeling Notation es una notación gráfica que describe los procesos de un Negocio. Es un lenguaje común para que la comunicación de los procesos sea de forma clara, completa y eficiente. Ha sido diseñado para coordinar la secuencia de los procesos y los mensajes que fluyen entre los participantes de las diferentes tareas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
78d65aca-aeec-4ced-8d66-6f77d25c834d	Branding	El proceso de crear y gestionar una marca. Esto incluye el logo, los colores, la voz y la estrategia de comunicación para generar una percepción positiva y coherente en la mente del consumidor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
8d3bd529-aa4b-4771-af0b-6a9d1e43f0a8	Brief	En marketing, un brief es un documento conciso y claro que sirve como hoja de ruta para un proyecto. Su principal objetivo es comunicar de manera efectiva las necesidades, metas y expectativas de un cliente a un equipo de marketing, una agencia o un profesional independiente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
99940ac2-aad5-434a-ac7c-1fc8b51d9504	Business Blueprint	Documento de referencia del proyecto que recoge el alcance, las funcionalidades, la gobernanza, las reglas de negocio, la arquitectura conceptual y los criterios de aceptación. Es la línea base del proyecto una vez firmado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
4d952bd5-aa10-432a-8c50-dfeceba06263	Buyer persona	En marketing, un buyer persona es una representación semi-ficticia y detallada de tu cliente ideal. A diferencia del "público objetivo", que es una descripción amplia y demográfica		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
b045f075-a27d-44d9-8b06-ed3a16d1dc15	Cabecera de la recepción	Indica la información general de la orden de recibo y la información necesaria para el control de la mercadería en el almacén.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d8de4c4d-ad7e-4aa5-ba1b-12934411d19f	Cadena de Texto	Tipo de dato compuesto por caracteres que pueden incluir letras, números, espacios y símbolos. Se utiliza para descripciones, nombres o códigos que no requieren cálculos matemáticos (ej. Nombres de clientes, SKUs, observaciones).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
cdbdf3f6-82b3-4e54-bf7e-c7afa108fcc7	Caja	 Se refiere a la denominación utilizada para referirnos a un macroproceso, proceso, una actividad o una tarea que se encuentra diagramado. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	2026-10-02 01:49:40.552+00
d54b84b3-37ee-411d-98cd-c6acd0c6e641	Campaña	es un conjunto de acciones y esfuerzos coordinados que una empresa realiza durante un período de tiempo determinado para alcanzar un objetivo específico. Es una iniciativa estratégica y planificada, a menudo con un mensaje central o un tema unificador, que se ejecuta a través de diversos canales de comunicación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
63d3eb0a-0cfe-46d0-9755-ae2b044003d4	Campo calculado	Silo Sistemas: Unidad mínima de información que compone un registro. En una estructura de datos, corresponde a las columnas y representa un atributo específico (ej. Fecha, Monto, SKU). Silo Sistemas: Columna creada a partir de una fórmula para mostrar información derivada de los datos originales.		dudoso	Las dos filas originales compartían término y etiqueta (Silo Sistemas), pero una definición describía “Campo” en general y la otra sí describía “Campo calculado”. Se conservó la definición correcta para el término; “Campo” no existe como término aparte en el glosario y podría agregarse.	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
8dfc0f6d-ea80-4325-9aa1-0a3f5aa29129	Canales de ventas	Representan los puntos de contacto donde los clientes pueden descubrir, evaluar y comprar nuestros productos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
88744fcc-cb27-4602-aa4b-fce0149a7e0d	Cantidad de empaque	La cantidad de cajas teóricas de un artículo en una ubicación específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
d61cc8d9-82ea-4b05-87c7-5b29107b0fa0	Cantidad días pedidos	Número de días con pedido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.615483+00	\N
61868244-4edd-4e3f-ba94-a52acf3a2b2a	Cantidad pedido	Conteo de pedidos generados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
60003f55-6cee-4784-a1e0-51be7d4b8c5c	Capa de costo	Cuando se utiliza el tipo de costeo UEPS o PEPS, el sistema permite un infinito número de capas de costo por cada ingreso al inventario. Cada capa representa un ingreso, y en cada una de ellas se guarda la información de la cantidad original ingresada, la cantidad restante (después de hacer consumos), el costo unitario y el costo total.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
44365b45-4db2-4853-9b36-cae664e3ce77	Capital de trabajo	Métrica de liquidez que representa los recursos que necesita la empresa para sus operaciones diarias. Se calcula como		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
af3168a4-867d-4f30-b78c-17fb7b564add	Capital intelectual	Conocimiento y experiencia documentada que permanece en la empresa como activo estratégico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
305e0d18-6827-46eb-8a1e-9da8f7a851f5	Captura fotográfica	Registro visual de condiciones del producto durante la recepción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f510e273-6f65-45c9-88c3-c2cd16c8942e	Carga a piso / a piso	Tipo de estiba que corresponde a la modalidad de transporte y almacenamiento en la que la mercancía se coloca directamente sobre el piso del vehículo, contenedor o bodega, sin utilizar pallets, estibas ni ningún otro tipo de plataforma de soporte intermedia.\nNombre Internacional Oficial: Floor Loaded Cargo / Loose Loaded		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
71c524f2-85b9-4064-b658-88ccd225b167	Carga camión rf	Proceso de carga de camión que se realiza utilizando el dispositivo de radio frecuencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
719cfe41-ac48-44da-a550-56f665c0c231	Cargo	Conjunto de funciones, responsabilidades y deberes asignados a un empleado. Sinónimo de "Puesto de Trabajo".	Cargo del Contacto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 19:30:00+00
2ea5bcba-ba7a-4354-be1f-b7d168d9cc05	Cartera (Clientes)	Conjunto de clientes que debe ser mantenido al día por el departamento de Operaciones y Administración de Ventas.		homonimo	Se separó de un término homónimo compartido con: Cartera (Cuentas por Cobrar).	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:05:00+00
74da4cc1-da25-4776-930a-4f5fe6cb584f	Cartera (Cuentas por Cobrar)	Silo Control: El valor total de las deudas que los clientes tienen con la empresa en una fecha determinada. Su análisis por antigüedad de saldos es fundamental para gestionar el riesgo de incobrabilidad. Reporte SIM – Indicador Venta: Sumatoria del total de las Cuentas por Cobrar, es decir el monto total de dinero que los clientes le deben a la compañía.		homonimo	Se separó de un término homónimo compartido con: Cartera (Clientes).	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:05:00+00
cad059d2-b187-4d74-804c-3a9b94c3fe34	Cartera >30	Es la sumatoria de la deuda por cobrar a más de 30 días		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
96cea58c-9c9c-4bae-9bab-b10ab037649f	Casos contables	Particularidades que se pueden presentar para un Evento Contable determinado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
672bb14a-6d84-48da-bb59-1f4a1f582315	Categoría	Reporte SIM – Dimensión Compras: Muestra las categorias creadas para segmentar los artículos. Reporte SIM – Dimensión Ventas: Una categoría es una clasificación o grupo que se utiliza para agrupar elementos que comparten características o propiedades comunes. Reporte SIM – Filtro Compra: Permite seleccionar una o mas categorias especificas de los articulos. Silo Compras: Una clasificación dentro de un grupo, donde cada grupo debe contener un rango de 10 a 30 categorías. Los nombres de categorías deben ser descritos en singular, en mayúsculas y sin acento, y no deben llevar conectores. Es la clasificación más general de un producto.	Categoria	fusionado	Fusionado a partir de 4 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
54c95665-119b-4a6d-a401-7a7f3d1abc29	Categoría cliente	Reporte SIM – Filtro Venta: Permite seleccionar una o mas categorias de clientes. Reporte SIM – Dimensión Ventas: Muestra la clasificación que se utiliza para agrupar a los clientes de la compañía.	Categoría	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
e36e4409-2f84-4cd7-be22-0488fa92b308	Categoría Proveedor	Clasificación que el proveedor asigna al producto según su propio criterio comercial, independiente de la categoría interna definida por la empresa.	Categoría Proveedor	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:34:54.63+00
86af93da-172d-4768-ac54-9501cf94ded7	Catálogo de promociones	Vista consolidada de todas las promociones del sistema, con filtros de búsqueda por estado, tipo, vigencia, canal, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
62bd4b73-155a-4da3-ab84-a656a26931bb	Causas comunes	En control de calidad, fuente inherente de variación que es 1. aleatoria, 2. siempre presente y 3. afecta todos los resultados del proceso. La causa común suele atribuirse a un elemento del sistema que solo la gerencia puede corregir. También se denomina causa asignable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
272f5e2a-23c1-406b-b04a-02f5b147fb2e	CCA	 Customer Consulting Application. Portal de consulta web integrado a eflow WMS. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
260eda61-b279-49e9-aba7-fc748b824f77	CEDI	Centro de Distribución. Área operativa crítica donde se realizan actividades de almacenamiento, picking, empaque y despacho, que requiere estrictos protocolos de seguridad y uso de EPP.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
c4ed6b87-b155-4324-b142-422bfc746f46	Centro de costo	Unidad organizativa (departamento, proyecto, etc.) a la que se le asignan costos y gastos para un mejor control y análisis de la estructura de costos de la empresa.	Centro de Costo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:39:22.833+00
e41c3b16-7eca-4119-8883-0200ba956f05	Centro de Costos		Centro de Costo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:39:24.532+00
03d966f9-539b-4c8e-a9da-1136e069f191	CEO	Es el líder que traza el rumbo para que el equipo de mercadeo pueda ejecutar las acciones. La relación entre ambos es crucial: un CEO visionario y un equipo de mercadeo que lo entiende bien pueden crear una marca poderosa y exitosa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ff6a102a-a7aa-4c34-8703-b578b0c6046a	Certificación interna	Proceso mediante el cual la empresa valida que un colaborador cumple con los estándares requeridos para operar equipos o desempeñar funciones específicas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5f87cf47-1635-44d0-b71d-a05348599d25	Cesantías	Prestación social a la que tiene derecho el empleado en Colombia, que consiste en un ahorro forzoso para su protección en caso de quedar desempleado. Equivalente aproximado a la "Prestación de Antigüedad" en Venezuela y a la "Cesantía" en Costa Rica, aunque los regímenes de cálculo y pago son diferentes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e795b72b-63aa-45b9-919b-f823fc02ef1c	CFR	(Cost and Freight - Costo y flete (puerto de destino convenido)). El vendedor se hace cargo de todos los costos, incluido el transporte principal, hasta que la mercancía llegue al puerto de destino. Sin embargo, el riesgo se transfiere al comprador en el momento que la mercancía se encuentra cargada en el buque, en el país de origen.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
b1def5e6-ec46-49a0-a66f-9bda9573169c	Chatbot	Programa que conversa con los usuarios de forma automática, como los asistentes en páginas web.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5a923afb-d8c5-4573-89a2-2b9df9d8fc55	Check box	Especie de "interruptor" que habilita o deshabilita una opción asociada. ​ Este interruptor se puede activar con el ratón, presionando el botón izquierdo con su cursor sobre el recuadro, o bien, con el teclado cuando la opción esté encerrada en un recuadro punteado. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
0cf63b13-f647-47d2-881f-bd33faff13c5	Check list	Tipo de marca que se utiliza para seleccionar una casilla con múltiples opciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
1d938d02-ff4b-4f95-a708-8b3177860dbc	Cheque	Documento de débito por medio del cual es posible pagar documentos pendientes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5b7846a7-7b7a-4c42-ba7a-3e28d87135f6	Ciclo de vida del software	Etapas por las que pasa un sistema: análisis, desarrollo, pruebas, implementación y mantenimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
6c4e9190-a7a5-44d5-af4f-66a392445986	Ciclo PDCA (ciclo de deming)	El ciclo de Deming, o ciclo PDCA (también conocido como ciclo PDSA), es un modelo de mejora continua de la calidad que consiste en una secuencia lógica de cuatro pasos repetitivos para la mejora continua y el aprendizaje: Planificar, Hacer, Estudiar (Verificar) y Actuar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
4a780c50-d29a-4e4e-90de-40c5474c0ea6	Ciclo PHVA	Metodología de mejora continua: Planificar, Hacer, Verificar, Actuar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
603a8209-c844-4453-a939-b380a9c9a20e	Cierre de orden	Finalización del proceso de recepción y envío de datos al ERP.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
8984ea5e-3b2f-48ca-a47d-28d73bbb1046	Cierre de orden de recepción	El paso final para dar por recibido el documento y proceder con el envío de información vía interfaz al ERP.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
44a65f9d-d5b0-4b81-91b2-66b8ddc35ce0	Cierre forzado	Finalización manual del proceso de carga cuando hay pendientes, requiere autorización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ab148210-e1d1-4dc0-a11b-fd0b1b3c9808	CIF	(Costo, Seguro, Flete). Es el valor aduanero que representa la base para el cálculo de todos los impuestos asociados a la importación. Se calcula sumando el costo, el seguro, el flete internacional y los gastos incurridos desde el origen hasta la llegada al puerto de embarque.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
cd331226-cd6b-48fc-b64b-33cc66061965	Cinco S (5S)	5S es una herramienta sencilla para organizar su lugar de trabajo de forma limpia, eficiente y segura, mejorando así su productividad, la gestión visual y garantizando la introducción del trabajo estandarizado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
6ad2327c-5e6b-4b06-9ff6-0c9f452d8787	CIP	(Carriage and Insurance Paid (To) - Transporte y seguro pagados hasta (lugar de destino convenido)). El vendedor se hace cargo de todos los costos, incluidos el transporte principal y el seguro, hasta que la mercancía llegue al punto convenido en el país de destino. Aunque el seguro lo ha contratado el vendedor, el beneficiario del seguro es el comprador.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5cb30859-86f6-40d1-a06f-9918cfbd4636	Clasificaciones adicionales del artículo	Información que sirve para establecer una búsqueda más rápida y exacta de los diferentes artículos del inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
722d3b03-deef-42a7-b4d1-daa174746cf1	Clasificaciones del artículo	Son posibles subdivisiones para cada tipo de clasificación de artículos. El sistema permite un máximo de seis clasificaciones por artículo, y los nombres de estas se definen en la sección de Parámetros del Módulo.	Clasificación Artículo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:49:51.537+00
a77bf089-5051-464f-980b-2ca54ee4a309	Incidencia	Problema o error que ocurre en un sistema y que debe ser atendido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
24f73744-0786-43d7-9418-00c3828a43f7	Clasificación BDF	Un sistema para clasificar artículos según su tipo: N (Nuevo), L (Ocasional) o P (Pedido Especial).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
879bc3e2-1f38-4aec-8cfe-a1fb6c4ade57	Clasificación de información	Categorización del contenido documental según su nivel de sensibilidad: restringida, interna o pública.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
2da438cf-e4ff-42ab-9d96-330753c41554	Cliente	Silo Ventas: Persona natural o jurídica, debidamente registrada que realiza transacciones sobre los bienes comercializados. Reporte SIM – Dimensión Ventas: Muestra los clientes que adquieren los productos y servicios de la organización.	Cliente	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:39:28.79+00
5e111960-30c1-4a79-9448-aade3eac7166	Cliente corporativo	Cliente que trabaja bajo una jerarquía organizacional donde se tiene un único cliente principal llamado Corporación o Matriz de Corporación y otros múltiples asociados a ésta, llamados sucursales.	Otros — Corporación	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 19:30:00+00
6fead420-048f-4f17-954f-51943ec68902	Cliente Dummy	Registro genérico y temporal en el ERP utilizado para presupuestar y registrar operaciones cuando no se dispone de clientes reales identificados, permitiendo consolidar transacciones iniciales que, posteriormente, se reasignarán a los clientes definitivos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
fbee7bc3-bb79-4855-8cbc-f9222628459a	Cliente espejo	Se refiere a una réplica de un cliente existente, que comparte sus mismos atributos. El propósito es permitir una diferenciación y gestión independiente entre portafolios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
0d52f24a-ba82-4396-9c81-bdc0e8eb6d64	Cliente externo	Un usuario final que adquiere los productos o servicios de una empresa, pero no es empleado ni forma parte de la organización. El objetivo de las empresas de clase mundial es deleitar continuamente a este cliente, creando así un creciente afecto por sus productos y servicios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
1c0e85be-4f10-415d-b081-463cc96a0a78	Cliente interno	Cualquier miembro de una organización que depende de la ayuda de otro para cumplir con sus tareas laborales, como un representante de ventas que necesita ayuda de un representante de servicio al cliente para realizar un pedido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
082cd402-ffff-4ba0-a019-121120dc9f14	Cliente registro	Cliente donde se registra una transacción, ya sea propia o de otra entidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5f0c90f2-00c8-47a4-9361-44d8db8d4cc1	Cliente reporte	También es llamado cliente origen y representa la entidad que generó la transacción.	Cliente Reporte	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:49:53.429+00
144b0c7c-b38a-493e-9942-b17d79a296c7	Cliente sucursal	Cliente que pertenece a un esquema organizacional y que depende directamente de un cliente corporación, el cliente sucursal no puede tener asociado alguna otra subsidiaria solamente existe una relación uno a uno con la corporación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
075f07d5-10ab-4417-8c6b-6f2b0d5c3f6a	Clientes	Total cartera de clientes actual.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
80f860f9-c5ab-484d-945b-711b4b0cb293	Clientes activados	Todos los clientes con una venta superior a 0.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
00e5d40b-cda2-486d-954d-afb6bdfb1363	Clientes activados %	Representa el índice o tasa de activación de clientes		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
97035dc3-536f-4b5c-afc3-4be86d60f3c2	Clientes bloqueados	Es un cliente al que se le ha restringido la posibilidad de realizar ciertas transacciones, como crear nuevos pedidos o facturas. Este bloqueo puede ser temporal o permanente, y las razones para aplicarlo pueden variar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
1f819569-19c1-4ab0-8a10-cf930aa5fe9c	Clientes Inactivos	Representa el número de clientes inactivos. Aclara que un "cliente inactivo" no es un cliente que ha dejado de serlo por completo, sino uno que está en un estado de inactividad dentro de la base de clientes activos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:05.94+00
db79e919-4abc-40a3-9c79-425c100615fc	Clima	Es una métrica cuantitativa que mide la percepción colectiva de los colaboradores respecto a su ambiente de trabajo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
8c755284-5b00-48d9-ac26-4e2cf6b03c73	Clima organizacional	Percepción colectiva y subjetiva de los colaboradores sobre el ambiente de trabajo, las relaciones interpersonales y las condiciones laborales en un momento dado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
3226b77f-59ce-48e8-8ef0-a4e880a67727	Cloud computing	Servicios de almacenamiento y programas que funcionan en internet en lugar de instalarse en la computadora (ej. Google Drive, OneDrive).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ba0b37d4-e3a7-4f6f-9964-0f2ade015909	Cláusula	Una disposición o condición específica dentro de un contrato que define derechos u obligaciones de las partes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
0103ffea-8643-4a5f-90aa-2bbd33b4e12b	Cláusula de confidencialidad	Acuerdo incluido en el contrato de trabajo por el cual el empleado se compromete a no divulgar información sensible o propietaria de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
0591371a-b0a6-4c2d-bb15-a45a1e3ff5b7	CMYK	es un modelo de color que se utiliza principalmente en la impresión de materiales físicos. Es un acrónimo de los cuatro colores de tinta que se usan para crear la mayoría de los colores impresos: C = Cian (un azul verdoso), M = Magenta (un rojo purpúreo), Y = Yellow (Amarillo), K = Key (Negro)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
bbb04904-62a7-4425-b4e6-872b97e1a99d	Cobro	Monto de cobranza realizada por vendedor distribuida por artículo.	COBRO	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:07.525+00
705656df-3e02-4d5d-b5e3-03ab5c140722	Colaborador	Silo Personal: Persona que trabaja en la empresa y está sujeta a sus normas y políticas. Reporte SIM – Dimensión Personal: Refleja a todas las personas que presta sus servicios para la compañía, contribuyendo al logro de sus objetivos y metas.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
6393a36f-6089-4e04-88ad-29c364e11735	Colaboradores	Es un indicador de capacidad y tamaño de la fuerza laboral que representa el número total de personas que tienen una relación laboral activa con la organización en un momento específico en el tiempo (una fecha de corte).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
383c1915-433a-4bd6-8f7e-10f6b6290fed	Colaboradores %	Es un indicador de composición o distribución que se utiliza para medir la proporción o el peso que un subgrupo específico de colaboradores representa dentro del total de la fuerza laboral de la organización. Expresa el tamaño de una parte en relación con el todo en forma de porcentaje.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
52b95173-f65c-4f6a-98c0-c3e473e46798	Color	Describe el color principal del producto. Si un artículo tiene dos o más colores, se mencionan todos. Si el color no es una característica esencial para la venta, no se incluye en la descripción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:08.961+00
0f871c56-32d1-4abd-9dce-682d15668aa6	Combinación	Ordenaciones de elementos en un conjunto donde no importa el orden de estos elementos, las selecciones de los objetos se llaman combinaciones, donde abc es igual que bca.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:10.366+00
99f2e0b3-21cf-4ecc-bae8-092d688c8631	Combo	Silo Compras / Silo Mercadeo: Se refiere a una oferta que agrupa varios productos, a menudo a un precio reducido, para incentivar la compra. Los productos en un combo no necesariamente se utilizan juntos, pero se venden como un paquete promocional.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
9049f3f5-3d13-4812-ab89-541d77b5598c	Combo box	Especie de "lista" que muestra los posibles valores que puede tomar la opción asociada a un campo. Este interruptor se puede activar con el teclado cuando la opción esté encerrada en un recuadro punteado, utilizando las flechas para desplazarse a través de él.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
cdfa5be7-46d7-4bdc-9a71-01e855bbb05c	Comité de aprobación	Es el equipo que evalúa y aprueba las solicitudes de inclusión de nuevos productos y proveedores en el sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
16fc7bbc-3f7e-4892-b6a7-54f1c26ce748	Comité de Control de Cambios (CCB)	Instancia formal para la revisión y aprobación de modificaciones al alcance del proyecto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ea7736ed-3a99-4c6f-ba05-89a975c2be5d	Comité de salud ocupacional	Grupo conformado por representantes de la empresa y de los empleados, encargado de promover la seguridad y salud en el trabajo. Su nombre y conformación puede variar ligeramente (Copaso en Colombia, Comité de Seguridad y Salud Laboral en Venezuela).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
57bc8c06-7952-4fdd-9b1e-9b1df66d925d	Compañía	 Entidad propietaria de los catálogos, documentos e inventarios que se gestionan en el almacén. 	Compañía	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:39:44.984+00
33c7f3e2-e555-4574-a7b9-0b8603f8304f	Compensación	Aportaciones que confiere la organización a cada persona a cambio de su trabajo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
468bdddc-ce8a-4022-b9e0-01620617e70a	Competencias organizacionales	Conjunto de conocimientos, habilidades, destrezas y actitudes que un empleado aplica para desempeñar exitosamente sus funciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
a883cf3b-21da-4f0d-9fe8-a920991ae397	Componentes	Estos son partes o submontajes que se encuentran listos para ir al montaje final del producto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ca726239-15d9-4409-bab1-a67871704628	Composición	es la organización y disposición de los elementos visuales dentro de un espacio o formato. Es el arte de colocar y relacionar objetos, formas, colores, líneas y texturas de manera armónica y equilibrada para crear una imagen atractiva y con un propósito.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
6b728f4d-aa09-4823-b33e-392edd58f23f	Comprador	Empleado encargado de crear y dar seguimiento de las órdenes de compra enviadas a los proveedores de la empresa		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
18e70aa5-6cc9-4d00-928c-1dd9746aa36a	Compras	Sumatoria del monto liquidado de los embarques en moneda local y dólar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
950aed9e-4739-4f2d-8ea6-21609a741d09	Conceptos	En cualquier sistema de nómina existen rubros que se le pagan al empleado, rubros que se le deducen, y rubros que no afectan el pago neto del empleado, pero que se toman en cuenta para efectos de previsiones o aportes patronales. Para agrupar estos rubros se utiliza el término concepto; dentro del sistema, la forma de calcular cada concepto es configurable mediante una fórmula algebraica.	Concepto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:39:49.11+00
0e165717-a0d2-4d87-bc84-d3902e499e14	Conciliación bancaria	Proceso crítico de control que consiste en comparar los registros contables internos (Saldo en Libros) con los extractos bancarios externos (Saldo en Bancos) para identificar, explicar y corregir cualquier discrepancia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
b278c633-65a3-4efa-be40-90630bb20b54	Conciliación de cobranzas	Proceso específico de validación en Sage XRT que consiste en hacer coincidir los recibos de cobro generados internamente con los depósitos y transferencias reflejados en los extractos bancarios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
45acdd76-b08b-425b-a3fa-4b917679313e	Conciliado en firme	Indica que la conciliación entre los documentos del sistema y los reportados por el banco ha sido satisfactoria por lo que la conciliación ha sido aprobada. Debemos recordar que un documento aprobado no puede ser modificado en la base de datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
4515e60e-c9dd-498a-bc76-f8e8cc4333e5	Conciliado temporal	Indica que el documento se encuentra en el estado de cuenta del banco, pero aún no ha sido aprobado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ddd900c6-fe56-4687-9883-859f9bc66e65	Condiciones comerciales de compra	Conjunto de acuerdos comerciales negociados entre la empresa y el proveedor de un bien o servicio. Incluye aspectos como descuentos, días de crédito, rebajas, condiciones de despacho, garantías y formas de pago.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ab24f441-88fa-41c4-bd75-329d26c1d2fc	Condición de pago	Define la forma en que deberá ser cancelado un documento de débito, ya sea al contado o al crédito. La condición de pago involucra un descuento por pronto pago y una tasa de interés involucrada en el período de crédito.	Condición de Pago	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-25 13:37:33+00
1369e5d7-4baa-497e-9b55-4162184d69e9	Configuración general	Sección del sistema donde se definen parámetros globales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
cab3e766-3cf9-49d9-8ca7-c1ca9099a170	Confirmación	Validación de que el contenedor está en condiciones para ser recibido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
b206bd39-864d-44aa-b0df-c337a15e8b4c	Conflicto	Situación en la que dos o más promociones coinciden en vigencia, canal, audiencia y artículos, generando incompatibilidad según las políticas definidas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
35b0dfde-ef5a-46f7-9ff1-5d1e554aa3ab	Consecutivos	Un número consecutivo que se generará automáticamente una vez que el usuario defina el tipo de consecutivo, lo que permite controlar las transacciones de inventario. El manejo del código del artículo tiene una condición especial si los artículos utilizan consecutivos definidos en Administración del Sistema.	Consecutivo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:35:31.286+00
b183ec05-17f7-4a10-b775-88b74fa2d50b	Consulta (query)	Proceso para obtener y transformar datos desde una fuente específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
7add3bb1-6d86-48a2-861a-ccb64935d6c0	Contabilidad	Sistema de control y registro de los gastos, ingresos y demás operaciones económicas que realiza una empresa, con el fin de extraer información financiera útil para la toma de decisiones.	CONTABILIDAD	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:40:30.013+00
8e7065db-72cb-4ad1-9e1c-f29e8c4d0689	Contenedor (en recepción)	Un identificador de la orden, puede ser la unidad de transporte o un dígito verificador. Se usa para diferenciar órdenes cuando se recibe más de una por muelle.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
76beeb7b-72e2-4e80-9ba7-d34d4e8c649a	Conteo	Registro de cantidades físicas por ubicación, artículo, lote y fecha de vencimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
c9fec659-9f86-4173-a3f1-55e87865dc1f	Conteo cíclico	Consiste en hacer inventarios con una muestra de elementos específicos en intervalos regulares, de modo que los registros sean verificados periódica y parcialmente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
334d1c95-f825-4b1c-a563-8586e21810f1	Conteo por ubicación	Se denomina conteo por barrido y esto quiere decir que se va contando la mercancía de acuerdo a su ubicación geográfica dentro del almacén, contando todo lo que se observe en el pasillo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
3a18157e-34fe-4016-817e-6493357fb901	Contratación outsourcing	Modalidad mediante la cual la empresa contrata a un tercero (empresa externa) para que gestione la nómina y la administración de un grupo de empleados, quienes prestan servicios para la empresa usuaria. Sujeta a regulaciones estrictas en los tres países.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
3afffc20-7aaf-4afa-a52c-9d515c9e42bc	Contratista	Personal temporal o asignado a proyectos específicos, como mantenimiento o construcción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
df2a5f2b-824b-4b7e-aae4-8daa90fd06fd	Contrato	Acuerdo legal, oral o escrito, entre dos o más partes que genera derechos y obligaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:11.742+00
973acff1-3e05-4f31-9bbc-ca10695b97ef	Contrato de trabajo a término fijo	Contrato laboral que se celebra por un tiempo determinado, previamente establecido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
d03373dd-300f-4b90-91bc-2d703eb78740	Contrato de trabajo a término indefinido	Contrato laboral que no tiene una fecha de finalización definida.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
7b5dd10b-a062-4a38-9515-2bce4124176a	Costos por omisión	Métodos de costeo que se definen por omisión para cada artículo para medir el rendimiento de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f22bccba-178e-4b14-885d-4446ab180ab0	Contribución	Silo Control: Resultado de restar el costo de la mercancía vendida (CMV) a las ventas netas. Refleja el ingreso disponible para cubrir gastos operativos y generar utilidad. Reporte SIM – Indicador Compra: Esta fórmula calcula la ganancia inicial de la compañía. Simplemente, resta el costo directo de lo que vendiste (el costo de venta) de los ingresos totales que generaste (la venta neta).		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
e38f6dbc-02b8-4bb7-b680-a96cf071ae57	Contribución con rebates			\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ce8663c7-7119-49ae-b7fa-b4648099110e	Contribución total			\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
16fb12bd-227c-4bd9-847f-6468b69c2452	Contribución vacacional	Cada uno de los factores que inciden en la cantidad de días de vacaciones que le corresponden a un empleado por derecho por el tiempo laborado, que pueden responder tanto a disposiciones legales como a políticas particulares de empresa. Un grupo de contribuciones vacacionales define un régimen vacacional en el mismo sentido en que un grupo de conceptos define una nómina o planilla.	Contribución Vacacional	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:35:46.846+00
f5758307-f729-434e-91e5-dc43078f083a	Control bancario	Módulo del ERP que permite registrar, controlar y conciliar las transacciones realizadas en las cuentas bancarias de la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f2c756e9-b874-42d6-8c46-031770b8675f	Control de calidad	Punto de control obligatorio que debe aprobarse antes de que el dato pase a la siguiente etapa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
93bdb177-e62d-42d3-940f-286e686ae424	Control de calidad de todo el grupo (GWQC)	Un sistema de interacción continua entre todos los elementos, incluidos los proveedores, responsables de lograr la mejora continua de la calidad de los productos y servicios que satisfacen la demanda de los clientes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
4026eda0-a294-40a8-bfb6-483c1dee1099	Control de calidad no estadístico	La mayor parte del control de calidad no es estadística, en particular la parte relacionada con los recursos humanos. Sus elementos son la autodisciplina, la moral, la comunicación, las relaciones humanas y la estandarización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e01a16ac-bd20-4758-be74-2d8940e536ee	Control de cambios del documento	 Espacio donde se registra la historia de los cambios realizados a un documento, detallando fechas, revisiones y cambios realizados. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
eb1b8021-aa99-40f8-b41f-69ed1bace4c6	Control de localizaciones	Establece si el sistema considerará la ubicación de los artículos en distintas localizaciones dentro de una misma bodega.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
a0f9be39-5579-4d4c-8169-e7110e5c37ed	Control de lotes	Se basa en el registro y seguimiento de las fechas de entrada, cuarentena, salida de inventario y vencimiento de los mismos. Permite la restricción de transacciones de artículos de un lote específico que no cumplan los requerimientos establecidos. Se establece desde la definición de compañías en el módulo de Administración del Sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ecf3d1db-fe84-4af7-a79f-20e490f20a6e	Control de misión (control obeya)	La palabra japonesa Obeya significa “gran sala visual”, también conocida como Sala de Control de Misión: Son espacios donde se realiza la gestión de proyectos (Mejora Continua).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
2024f4b3-e234-4ad7-a6d8-cf4e28a14e00	Control de números de serie	Si está configurado, los números de serie de los artículos que ingresan serán registrados y se contará con funcionalidad de consulta y reporte de existencias con detalle por números de serie.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
355f6560-e2b5-47b3-90f0-68b0034ca979	Control de recibo de materiales (CRM)	Es un consecutivo que se asigna a los documentos de embarque cuando se aplican al inventario para establecer el orden en que los artículos y sus correspondientes lotes ingresan al mismo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ca94e7f4-96c1-44f4-8010-a4e346db6efd	Control de variabilidad	Un concepto KAIZEN™ que a menudo se llama Pregunta por qué cinco veces porque busca a través de preguntas curiosas llegar a la causa raíz de un problema para que el problema pueda eliminarse de una vez por todas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
fd3df67a-afc5-4ee5-9f6b-0673ed26bcff	Control estadístico de calidad (SQC)	El uso de herramientas estadísticas (diagramas de Pareto, histogramas, diagramas de causa y efecto, etc.) para asegurar que las máquinas están dentro de tolerancias aceptables, o para solucionar problemas de calidad mediante el uso de herramientas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
b0608711-832b-4136-9926-1664648eafda	Conversión	Determina si la conversión de moneda debe hacerse de moneda funcional a dólares, de dólares a local o no debe hacerse. ​ Debe tenerse en cuenta que esto es para la versión del sistema con FASB-52.	Conversión	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:13.052+00
f1fff8b7-81c8-42c2-a0c2-bbb63b3c7bf5	Corrida BDF	Proceso automatizado que se ejecuta para realizar la clasificación de artículos de acuerdo a los criterios establecidos por la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f4bc020f-47da-4882-8dfd-76a2dc01ad52	Costeo estándar	El costo estándar se refiere al costo que define arbitrariamente el usuario del sistema. Este costo deberá actualizarse periódicamente y de manera manual.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
d235eeb7-1583-4219-9655-0beaf8be8e54	Costeo PEPS	Método que supone para los propósitos de costeo que las unidades adquiridas de último se encuentran todavía en inventario. Los costos iniciales se consideran como los costos de las mercaderías vendidas. En otras palabras, supone que los artículos que ingresan al inventario de primero son los que salen de primero del inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5d0244cf-913a-4c85-b5cd-1ffc7e0ce587	Costeo promedio	Este método supone que todos los artículos disponibles para la venta durante un período están mejor representados por un promedio ponderado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
976003fe-736b-4507-acbc-7a0f0f31a988	Costeo UEPS	Método que supone que las unidades adquiridas primero son las que se mantienen en inventario. Así, los costos de inventario, más recientes o últimos, se consideran los costos de las mercaderías vendidas. La intención es correlacionar los costos más recientes con las ventas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
9c20735f-ee7e-463d-b36b-869290a8aad2	Costo	Es el valor de adquisición de un artículo, que incluye todos los costos asociados imputables al mismo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:50:22.017+00
b17781fb-cfe5-4eb1-b101-62195c2e5178	Costo (plan semestral)	Corresponde al costo directo de adquisición de la mercancía que se ha presupuestado vender durante el semestre.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
7dde307a-6882-47d7-8f30-c27f0d1817a9	Costo comparativo	Tipo de costo utilizado para realizar estudios comparativos.	Costo Comparativo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:35:56.998+00
53a2eb25-c882-4aa3-9e0f-f32e35942fc7	Costo de venta	Costo del articulo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e39b995d-285c-445c-b64e-f11a2cfdfe8b	Costo de ventas	Cuenta y centro de costo en el cual se asignarán los rubros asociados con los costos incurridos al vender los artículos de inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
133e4395-58f4-47b5-9ce9-cd6f06c076b2	Costo fiscal	Tipo de costo para reportes fiscales.	Costo Fiscal	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:36:03.605+00
36354a95-28a0-4189-9a22-50a936a0ae06	Costo para el cálculo del precio de venta	El costo utilizado para determinar el precio de venta, que se actualiza en la lista de precios base. Los parámetros para este cálculo pueden ser el último costo, el costo del producto o el costo del mercado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
6f2f49ef-c124-4cf2-89dc-25a9236aeb0f	Costo Producto	Hace referencia al costo de adquisición de la mercancía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e1b3d41c-2d75-497a-8534-fd57328e3d19	Cotización	Un documento que se puede generar para un cliente y que no representa un compromiso de compra, se puede convertir en un pedido		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
54ed1074-b921-4d12-ad95-15d3ce274024	CPT	(Carriage Paid To - Transporte pagado hasta (lugar de destino convenido)). El vendedor se hace cargo de todos los costos, incluido el transporte principal, hasta que la mercancía llegue al punto convenido en el país de destino. Sin embargo, el riesgo se transfiere al comprador en el momento de la entrega de la mercancía al transportista dentro del país de origen. Si se utilizan varios transportistas para llegar a destino, el riesgo se transmite cuando la mercancía se haya entregado al primero .		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
c38af7b3-cd0f-4616-805f-18e34ff1fe1f	Creación	Etapa inicial del ciclo de vida documental donde se redacta el contenido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
d937d1eb-72b1-4715-9bb7-3e32cc63da0e	CREE	Tipo de impuesto utilizado en Colombia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
33a985f1-dd16-4c84-af75-bd3a3b0f086c	Cross Docking	Eprac: Corresponde al flujo directo de mercancía a través de una instalación, de muelle de recepción al muelle de expedición, eliminando la necesidad de almacenamiento y alisto. Silo Logística: Transferencia directa de mercancías de un transporte a otro, sin almacenar en el almacén.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-28 16:00:00+00
bdc5f517-6576-48c9-83e6-86472237bc3e	Crédito	Es definido también como Haber . Mercancías o beneficios entregados en una transacción u operación, un asiento (o entrada) o pase de asientos a los libros de contabilidad, que registra la eliminación o disminución de una partida de activo o de un gasto, o la creación o aumento de un pasivo, de una cuenta de valuación, de una partida de capital neto (o contable) o de ingresos o productos. Es un asiento en el lado derecho de una cuenta, representa la cantidad así registrada.	Crédito	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-03 10:43:31.66+00
bd8aca7f-665a-43e8-909e-82db8e4aac43	CTA (call to action)	es una instrucción o un mensaje diseñado para provocar una respuesta inmediata en el público. Su propósito es guiar al usuario para que realice una acción específica y deseada, que generalmente se alinea con los objetivos del negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
bf257244-c945-414c-98b5-4d5b8157e7c9	Cuadricula	es una estructura de líneas horizontales y verticales que se utiliza como guía para organizar los elementos de una composición. Funciona como una herramienta invisible que ayuda a los diseñadores a alinear, distribuir y equilibrar el texto, las imágenes y otros elementos visuales de manera coherente y ordenada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
462c0879-e6ab-4ed0-8e31-0db2e60c26e3	Cuarentena	Período de tiempo en que el artículo debe permanecer en la bodega sin poder ser utilizado para participar en alguna transacción de inventario. La cuarentena se utiliza para aquellos artículos que requieren adquirir alguna característica después de finalizada su producción, y que sin ésta no pueden definirse como disponibles en el inventario. Generalmente se aplica sobre artículos de tipo perecederos, sin embargo puede generalizarse a cualquier artículo, si así se requiere.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
46b31ab9-da76-477a-a5eb-b150802e7bf3	Cuello de botella	 Se refiere a aquellas operaciones que se ejecutan que fluyen a un ritmo constante hasta que se presenta algún obstáculo que ralentiza todo o parte del proceso. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
862dc68e-cacb-4638-b856-e6306b2a6bd6	Cuenta 133	Denominación interna para la cuenta contable de "Fondos por depositar", donde se registra temporalmente el efectivo recaudado por la fuerza de ventas antes de ser depositado en el banco.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
d60645c0-90b1-486a-80b8-60ac9cf94877	Cuenta activa	Cuenta bancaria que tiene frecuentes movimientos de entrada y salida de dinero.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f3e0961e-aadd-4be1-882b-34341aca2e61	Cuenta bancaria	Representa el código de identificación asignado por una entidad financiera a una persona, empresa o entidad jurídica bajo el cual se registran todas las transacciones bancarias de una empresa, expresadas en forma de cargos y abonos.	Cuenta Bancaria	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-03 10:42:46.945+00
e6d6c25a-ad48-459e-ab2f-2a5dd81365c3	Cuenta bloqueada	Indica si la cuenta acepta o no movimientos contables. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
6f3df057-63d5-4fbb-890a-117be5f2ded4	Cuenta contable	Unidad básica de registro que clasifica y agrupa transacciones de la misma naturaleza (ej. "Efectivo", "Ventas", "Cuentas por Pagar"). Su correcta asignación es fundamental para la integridad de la información financiera.	Cuenta Contable	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:41:28.032+00
605759ec-39fe-433f-8d95-91927a559ddf	Cuenta de anticipos de clientes	La cuenta de Anticipos de Clientes representa los anticipos (adelantos de dinero) realizados por los clientes de la empresa para la compra de bienes, por ejemplo materias primas, o servicios. Por lo tanto, corresponde a un Pasivo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
74d0f881-372f-4387-bc53-7dd2986aa52a	Cuenta de clientes	En la cuenta de Clientes se registran las ventas a crédito, que la compañía realiza a sus clientes. Por lo tanto, corresponde a un Activo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
c6a2c8d2-c803-4903-8679-93f05c4534e7	Cuenta de gasto	Cuenta contable que registra los desembolsos necesarios para mantener las operaciones de la empresa, como salarios, alquileres o servicios.	Cuenta Gasto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-03 10:43:33.198+00
5236dfee-a646-43b0-8bcc-5664e5c6b012	Cuenta de ingreso	Cuenta contable que registra los ingresos generados por la actividad principal de la empresa, como la venta de bienes o servicios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
27f4e7a0-f6dd-469c-ac58-2f9a1287e624	Cuenta de orden	Cuenta contable que se utiliza temporalmente para cargar los montos debidos a una transacción contable, que posteriormente se ubicarán en las cuentas contables que corresponden.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
835209c9-22d5-4a3a-aadf-8b652ff67a50	Cuenta inactiva	Cuenta con escaso o nulo movimiento. El saldo puede ser siempre el mismo, debido a que no se han efectuado depósitos ni retiros de la cuenta durante un periodo prolongado de tiempo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
22ae1a63-d8ec-40d4-8f71-9c2d5bbee91d	Cuenta padre	Cuenta de primer nivel, que contiene una serie de subcuentas específicas donde se detallan los cambios en un activo o pasivo particular, se expresa según su número de cuenta al tener los niveles inferiores en cero.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
35e93f64-8590-4225-bed0-0fd6d7e972af	Cuentas	Campo en la ventana de artículo donde se indica el tipo de cuenta contable.	Cuentas	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-25 13:37:33+00
971dac8b-8470-42a0-ac8e-8f90a0c86a40	Cuentas contables	Las cuentas contables se utilizan para definir los rubros que son involucrados en una transacción. ​ El sistema permite la definición del patrón de cuentas contables según las necesidades de la empresa. ​ Las cuentas están definidas y agrupadas según su código bajo una cuenta padre que englobará las subcuentas hasta llegar a los movimientos propios de cada una. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
09b5e32d-2d1b-4da0-a9d9-0143dff54bc5	Cuentas contables (de artículos)	Opciones donde se definen las cuentas contables que serán asociadas a cada artículo en el inventario. Estas permiten realizar los asientos contables e integrar los movimientos de Control de Inventario con el módulo de Contabilidad General. Incluyen cuentas de inventario, variación de costo, faltante en inventario físico, sobrante en inventario físico y vencimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
dc6d69af-9a09-4be2-b81c-e17a7c8dbc94	Cuentas por cobrar	Un Abono, Crédito o Haber representa una disminución en una cuenta de activo o un aumento en una cuenta de pasivo o de capital.	Cuenta Cuentas por Cobrar	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:41:32.214+00
d5157c64-ba43-4814-8c6b-8a2944308847	Cuentas por Pagar	Suma total de las deudas de la empresa con sus proveedores.	Cuenta Cuentas por Pagar	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:41:33.54+00
5cda38cb-b0fe-4960-bf63-7da9a0ced869	Cuentas por Pagar (CP)	Área y módulo del ERP responsables de gestionar todas las obligaciones de pago de la empresa con sus proveedores y acreedores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
9b274939-d392-4fbc-8878-94fec95b8b9e	Cuentas por Pagar Vencida	Suma total de las deudas a proveedores que ya han excedido su fecha de vencimiento		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
34a88758-5698-4039-98f4-23b87ab87848	Cultura kaizen	Una cultura organizacional basada en tres principios: Proceso y Resultados, Pensamiento Sistémico y Sin Juicios ni Culpabilización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
87496a44-e516-468c-89ff-61c11af5e955	Cultura organizacional	Conjunto de valores, creencias, comportamientos y normas compartidos que caracterizan a la empresa y guían la forma de trabajar de sus miembros.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
0dbe7b2d-e08b-4963-aa57-c2f9ebdd8bdf	Cump ppto venta %	El porcentaje que representa la venta neta real en relación con la meta de ventas establecida.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
5656db19-0b32-436f-baf7-0444c551a3c4	Cumplimiento	Se refiere a la responsabilidad de roles como el Gerente de Compras, Gerencia de Ventas y Especialista Comercial de Compras de asegurar que se cumplan los requisitos para la inclusión de nuevos productos y proveedores. También implica garantizar que los nuevos productos y proveedores se alineen con la estrategia comercial y las necesidades del mercado, y supervisar el balance del surtido y la operación sostenible de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
30d3c72f-bda2-4a51-991b-4b6c4383c3f7	Cuota fija	Tipo de condición de pago en el que todas las cuotas son por el mismo monto, pero el monto que se amortiza al principal y los intereses que se calculan para cada cuota varían.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ac4b7888-0097-4c41-b069-a2b7080bb6a2	Curvas	es una herramienta visual que permite a las empresas entender el comportamiento del consumidor, la vida de sus productos y cómo deben adaptar sus estrategias para tener éxito.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
d5f87625-e16c-48bd-872d-3e7cbd2b5105	Custodio del dato	Rol responsable de asegurar la calidad, estandarización y cumplimiento de las normas definidas por el dueño del dato.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
7e778586-c998-454b-8d13-df5ebfa34842	Custodio técnico	Rol técnico responsable del almacenamiento, seguridad, transporte y disponibilidad del dato en los sistemas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
cc5c217e-72fe-4bf0-9377-9290487c98df	Customer journey	Es el camino completo que recorre una persona desde que tiene su primer contacto con tu marca hasta que se convierte en un cliente fiel. Es una representación del proceso de compra, desde el descubrimiento inicial de la necesidad o del producto hasta la compra y la post-compra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
ab1115fd-0473-4a60-81f5-21fc7bdee866	Cálculo vacacional	Proceso completo periódico de actualización de la cantidad de días de vacaciones pendientes de goce de los empleados de una organización, que inicia con el establecimiento de los parámetros generales de configuración, hasta la aplicación en firme del nuevo cálculo de días acumulados de vacaciones de los empleados. Un cálculo vacacional está conformado por información general que define los parámetros y condiciones del cálculo así como por información detallada por empleado con los resultados particulares obtenidos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:36:31.936+00
b68235a5-b85d-437a-b219-6522feb9132d	Código arancelario	Un código específico de producto que se encuentra en el Sistema Armonizado (SA), mantenido por la Organización Mundial de Aduanas (OMA). Este código se utiliza para calcular impuestos y asegura una clasificación uniforme de los productos en todo el mundo. Su longitud puede variar de 8 a 12 dígitos, y cuantos más dígitos tenga, más específico es el producto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
a0a8426e-68d0-4ea8-aa47-f4a4dfcbb616	Código Cabys	Catálogo de Bienes y Servicios. Es un sistema obligatorio en Costa Rica, creado por el BCCR y el Ministerio de Hacienda, que asigna un código numérico único de hasta 13 dígitos a cada producto o servicio comercializado, para estandarizar su clasificación en facturas electrónicas y mejorar el control fiscal, la generación de estadísticas y la identificación de impuestos diferenciados. 	Código Cabys	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-25 13:37:33+00
cc88857b-05ee-4333-8514-838320775f60	Código de artículo	Identificador único asignado a cada producto dentro del sistema.	Código	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 19:30:00+00
3b052d4d-96c6-4b18-87aa-16a203a6103f	Código de barra	Un identificador numérico o alfanumérico que permite identificar un artículo para el control de inventario, punto de venta y seguimiento en la cadena de suministro.	Código barras	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-03 10:43:35.847+00
bb8f6d12-4f68-4335-a7dd-c111f4baad28	Código de barras unidad almacen	En este campo se ingresa el código de barras utilizado para el almacenamiento.	Código de barras unidad de almacen	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-25 14:07:00+00
8b0d67eb-c048-4412-be6c-87b3f57a0e89	Código de barras unidad detalle	En este campo se ingresa el código de barras utilizado para la venta.	Código de barras unidad de detalles	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-25 14:07:00+00
8d3e85b7-3149-4c8b-8f0c-669420e6bff8	Código de cliente	Identificador numérico único asignado a cada cliente en el sistema para garantizar la correcta imputación de transacciones y seguimiento.	Código del cliente	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 20:00:00+00
bb1e3383-e848-4dfb-89ba-5e099b43a263	Código de cuenta	Patrón de números que identifica cuenta contable. El formato de la cuenta se establece en la opción de Administración en el menú principal. ​ Al crear una cuenta se debe considerar que los niveles superiores del patrón deben definirse antes que los menores. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
968e71bc-13de-45ba-9dbc-438bc52c2110	Código de documento	Identificador único que permite rastrear y controlar un documento.	Código Documento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-10-02 01:41:37.05+00
a6e95ec5-23e6-48b6-afae-52190c043859	Código de paquete	Identifica el paquete por medio de una secuencia de caracteres única definida por el usuario. ​ Este código no puede ser cambiado. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
7bfbc5cf-4bbd-4bc9-b39a-1236ac629940	Código de proveedor	Identificador numérico único asignado a cada proveedor en el sistema para una correcta gestión de las cuentas por pagar y el historial de compras.	Código Proveedor	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	2026-09-30 19:30:00+00
9ed439d3-0d03-40ef-958e-bd84eddda054	Código lester	Número de referencia automotriz de un componente eléctrico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
f58a1fba-6b4b-4e99-9390-0181ca7ac57b	Código M	Lenguaje de programación que se usa dentro de Power Query para definir transformaciones de datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
2b759da7-f87b-4cda-8d20-15d739e44f5b	Código OEM	Es el código asignado por el fabricante a un componente que forma parte de un vehículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
fb2a3361-e143-4f6c-ac25-931c77dc9727	Códigos	Son los artículos que se encuentran dentro de las subcategorías. Cada subcategoría debe contener un rango de 10 a 30 códigos y vender al menos $1,000 al mes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
bba202e3-b0ee-4fef-8def-d64f73014f59	D.E.P.	Abreviatura de "Depósito". Transacción financiera que consiste en la entrega de efectivo o cheques a una entidad bancaria para abonar a una cuenta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
60727b9b-2dd2-45ce-b5e4-24ef68316e73	Dantotsu	El concepto de Benchmarking se basa en la palabra japonesa Dantotsu que significa lo mejor de lo mejor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e3a21df6-499a-40f0-b2e9-9b14e8729186	Físico unidades	Cantidad física de unidades contabilizadas en una ubicación específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
63cedff9-3000-465f-bf3f-76b39fba8dd0	DAP	(Delivered At Place - Entregado en un punto (lugar de destino convenido)). El vendedor se hace cargo de todos los costos, incluidos el transporte principal y el seguro (que no es obligatorio), pero no de los costos asociados a la importación, hasta que la mercancía se ponga a disposición del comprador en un vehículo listo para ser descargado. También asume los riesgos hasta ese momento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
b02f6d0b-5952-4f01-b2e2-d3c6d26192ae	Dashboard	Panel visual interactivo que muestra indicadores clave (KPIs), gráficos y métricas en un solo lugar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
114a8191-e796-4e32-b7d1-050e32d626a2	DAT	(Delivered At Terminal - Entregado en terminal (puerto de destino convenido)). El vendedor se hace cargo de todos los costos, incluidos el transporte principal y el seguro (que no es obligatorio), hasta que la mercancía es descargada en la terminal convenida. También asume los riesgos hasta ese momento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
debab99f-9abd-46a7-90c8-848575d80f14	Data mining (minería de datos)	Proceso de encontrar patrones o tendencias en grandes volúmenes de datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
fb404425-9f5b-4d1a-98de-b3fcfe886e9d	Dato	Elemento básico de información, por ejemplo: “23”, “Ana”, “CR”.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
a518ba93-e044-430b-8a3a-6c8699a1a361	Dato dummy	Registro maestro genérico y temporal en el ERP utilizado como comodín para procesar transacciones, presupuestos o pruebas cuando el dato real definitivo aún no está identificado o disponible.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
bfd3ae97-aa4b-4e0b-83b2-5b057b36e8ec	Dato maestro de artículo	Registro único que representa un producto, conteniendo sus atributos esenciales de identificación, logística, comercial y financiera.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
65f7df2c-9d44-4e67-a5dd-9042deacf1d4	Dato nulo	Dato que indica ausencia de valor o información desconocida en un campo. Técnicamente, un valor nulo no equivale a cero (0), sino a la inexistencia de registro para dicho atributo. Este a diferencia de 0 no impacta en cálculos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
e2e1d54a-5e08-488b-8529-1afc7202f867	DAX (data analysis expressions)	Lenguaje usado en Power BI para crear medidas y cálculos avanzados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
761955ec-8af4-4ffb-9dfe-ee8b86b2c317	DDP	(Delivered Duty Paid - Entregado con derechos pagados (lugar de destino convenido)). El vendedor paga todos los gastos hasta dejar la mercancía en el punto convenido en el país de destino. El comprador no realiza ningún tipo de trámite. Los gastos de aduana de importación son asumidos por el vendedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.622938+00	\N
75f88e1b-531f-4ecd-8424-f1c5fe55c4a1	Debito	Es definido también como Deber. Mercancías o beneficios recibidos de una transacción u operación; un asiento (o entrada) o pase de asientos a los libros de contabilidad, que registra la creación o el aumento de una partida de activo o de un gasto, o la reducción o eliminación de una partida de pasivo, de una cuenta de valuación (crédito) o de una partida de capital neto (o contable) o de ingresos (o productos).	Débito	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:12.909+00
57b8b668-f908-466b-af54-1e86c3f560f7	Declaración fiscal	Documento oficial presentado ante la autoridad tributaria donde se reportan los ingresos y gastos para calcular los impuestos a pagar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e7700a11-52c5-43d7-9287-0e675e2538d4	Deducción	Es una disminución que se realiza al salario del empleado. Es un flujo negativo del salario de un empleado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c9fc606a-da62-4019-8c89-5fbbf977ca4c	Deep learning (aprendizaje profundo)	Forma avanzada de aprendizaje automático que usa redes neuronales para reconocer patrones complejos (ej. reconocer rostros en fotos).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
066c5e98-90ad-41a9-aa93-332b3648af95	Default	Concepto que define la asignación de un valor por defecto o rebote.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b2a30de1-7207-469e-99dc-abaadd43919c	Defecto de fábrica	Una imperfección en el producto que puede ser motivo de devolución, siempre y cuando esté cubierto por la política de garantía del proveedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
5bbd0de8-cf4a-487e-99a3-4fc127b4292e	Demanda (legal)	Reclamo o petición formal presentada ante un tribunal para iniciar un proceso judicial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
59a49b15-f234-491f-8349-493ae498b8fc	Departamento	Softland: Unidad funcional de la empresa, en la cual se agrupan las actividades que son semejantes y están relacionadas lógicamente entre sí. El departamento representa la estructura formal de la organización tal como aparecería en un organigrama. Reporte SIM – Dimensión Personal: Muestra las sub divisiones que existen dentreo de las areas de la compañia.	Departamento	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:36:44.548+00
d4ade745-ca07-4e69-8a5a-45bf37868fd4	Departamento de control	Departamento con la misión de articular el crecimiento rentable del negocio a través de la inteligencia financiera, una cultura de eficiencia y un sólido ambiente de control.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
66db2076-eb9b-45d7-b230-4a6aa148eed3	Deposito	Se refiere a una transacción que permite al cliente pagar documentos pendientes por medio de un depósito del monto parcial o total del documento a una cuenta bancaria de la compañía. Este pago se debe realizar directamente, es decir, el cliente debe realizar un depósito en la entidad bancaria donde la empresa tiene su cuenta. En este caso no es preciso que el cliente tenga cuentas bancarias en la misma entidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:26.959+00
59f44e56-9e9a-4117-b1b2-251221005813	Depreciación	Gasto contable que distribuye el costo de un activo tangible (ej. vehículo, maquinaria) a lo largo de su vida útil, para reflejar su desgaste o pérdida de valor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:29.391+00
2901df4f-ee6d-4718-97e0-eb24b3c4383c	Depuración de surtido	Proceso que consiste en identificar, evaluar y eliminar productos de un catálogo que ya no son rentables, relevantes o que no se ajustan a la estrategia comercial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c8209fc3-250b-4d29-a7f9-1dbd80b21768	Derecho de retracto	El cliente puede cancelar el pedido previo a la entrega y tiene derecho al retracto de pedido bajo las restricciones indicadas en la presente norma.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
0878e7eb-d429-450f-b086-b131057ff6c9	Descripciones de cargo	Documento que detalla funciones, responsabilidades y requisitos de cada puesto en la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
288b6d35-b029-4286-b7b8-6f551ae22360	Descripción de cargo	Documento formal que detalla las funciones, responsabilidades, objetivos, competencias requeridas y relaciones jerárquicas de un cargo específico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9dc7b33d-dd2c-42ed-b0ca-f63e2cb240b2	Descripción de cuenta	Patrón de caracteres alfanuméricos que distinguen de una manera menos determinante la cuenta. ​ Por así decirlo, es el nombre de la cuenta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:34.356+00
8914816b-4626-4599-877f-98ca1af1f052	Descripción del artículo	El nombre comercial del artículo, seguido de sus atributos más importantes y finalizando con la marca comercial.	Descripción	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-28 00:00:00+00
aaafac17-d36f-43a6-b714-761900be9270	Descuento	Es un valor porcentual que disminuye el precio de venta de un producto.	Descuento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-25 13:37:33+00
11fc47a9-1e3c-4662-8385-3d03cb1ec7e4	Descuento en línea	Porcentaje que se rebaja al comprador por cada línea de pedido, en una orden de compra. El porcentaje del descuento en línea podría ser diferente para cada artículo solicitado.	Descuento por Línea	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:39.491+00
162fe414-c107-43ab-885b-84ca3e97dc49	Descuento por forma de pago	Reducción de precio concedida al cliente en función del método de pago utilizado, incluso si no liquida la totalidad de la deuda.	Descuentos Forma de Pago	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-30 19:30:00+00
08a9a1ab-f0b0-45b2-ac66-fdf8201610da	Descuento por pronto pago	Incentivo ofrecido a los clientes por pagar una factura antes de la fecha de vencimiento establecida.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:41.514+00
1a5dcb7f-befc-438d-ba7a-c0ec8b56b4b8	Deserción	Es un métrica de personal que mide el porcentaje de colaboradores que abandonan una organización durante un período de tiempo determinado (mes, trimestre, año).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
317b035d-d9b8-4321-bc8c-1d3b8fbab970	Deserción %	Es un métrica de personal que mide el porcentaje de colaboradores que abandonan una organización durante un período de tiempo determinado (mes, trimestre, año).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b211eb53-647e-4878-b400-197a85c1c4e0	Despacho directo	Se modifica una expedición con este tipo de carga y la carga se realiza directamente desde el desktop, sin usar la RF.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
76ca5da9-aba5-4cfa-a754-691f8804bc6c	Despacho múltiple	El operario usa la RF para leer el código de barras del total de artículos de cada bulto a despachar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
047b171d-3c49-4e6d-ba08-23dcac7c1cc5	Despacho por palet	Se realiza mediante la RF, cargando por palet completo asumiendo que se cargó todo el pedido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
5eb8ce30-1e0c-449d-9590-0f9326474ff2	Despacho único	El operario debe de hacer uso de la RF, este tipo de despacho consiste en leer el código de barras de cada bulto e indicar la cantidad que se va a despachar		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
5ba1a453-95ed-4981-bcb8-0dbe7a325995	Despido	Terminación de la relación laboral por iniciativa del empleador. Puede ser con o sin justa causa (improcedente), lo que afecta directamente al pago de indemnizaciones y prestaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
8988aa0b-14cb-4955-96ca-1cfb9a37244f	Despliegue de la función de calidad	Un sistema mediante el cual los requisitos del cliente, conocidos como características de calidad reales, se traducen en características de diseño, conocidas como características de contraparte, y luego se implementan en subsistemas como componentes, piezas y procesos de producción para desarrollar nuevos productos diseñados con precisión para satisfacer las necesidades del cliente. QFD es uno de los siete sistemas KAIZEN™.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d7f83fa7-69c6-4a75-b2b0-dc12e25df4ec	Destino	Conjunto de criterios que determinan a qué clientes y por qué canales se ofrecerá la promoción. Define el "a quién" y el "dónde" de la oferta comercial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d40f99fa-931b-4a4f-bf07-c56a3bdb0267	Detalle de recepción	Indica los artículos que conforman la orden, sus lotes, cantidades y bodegas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
addeb14e-2ba6-42c2-ac05-9a3f4cbb1b48	Detalles (en picking RF)	Permite consultar los detalles del picking.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
55c18305-456e-4170-afc5-559f129717c5	Deuda	Obligación financiera que una parte tiene con otra, que debe ser liquidada en un plazo acordado, generalmente con intereses.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1195ac80-39fd-41c1-8311-170a69b12bea	Devolución	Silo Ventas: proceso en el que un cliente devuelve un producto a un vendedor o empresa. Esto puede suceder por varias razones, como que el producto esté defectuoso, sea del tamaño o color incorrecto, o simplemente no cumpla con las expectativas del cliente. Reporte SIM – Indicador Venta: Suma de la venta multiplicando por -1, se aplica para todos los documentos con estado “D”.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:44:57.246+00
1cc466a1-9c72-42f0-bc69-16a0385799b6	Devolución %	Silo Control: Métrica que mide el porcentaje de productos devueltos en relación con el total de ventas. Se calcula como (Valor de Devoluciones / Ventas Totales) x 100. Es un indicador de la calidad del producto y la satisfacción del cliente. Reporte SIM – Indicador Venta: El porcentaje de productos vendidos que son devueltos por los clientes.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:36:54.599+00
0e0cd126-bb78-4f1f-b9bd-78397c2a3bc9	Diferencial cambiario	Ganancia o pérdida que surge de la fluctuación del tipo de cambio entre la fecha de una transacción en moneda extranjera y la fecha de su liquidación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
164f0739-2e3b-4929-850f-22bf6613562a	Dimensiones	Las medidas de un artículo en su empaque individual, incluyendo alto, ancho y profundidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c3fdbfd2-cbcc-4a4f-8a65-88e2a5068b5d	Dimensión	Es un atributo o una característica que describe y categoriza los datos para su análisis.	Dimensión	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-25 13:37:33+00
9012680a-f2f8-4c20-8395-b4aa20e7d77d	Diseño	Es el proceso de planificar y crear una solución para un problema, con un propósito específico y para un público determinado. Es un proceso creativo que va más allá de la simple estética; combina arte, funcionalidad, estrategia y empatía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4b65f25d-b9d8-482c-b9a6-6d6d27dd12f7	DISP (disponible)	Tareas que están disponibles para ser asignadas a un recurso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9994fd77-c02f-4df9-a2e4-76043b8d3c30	Disponibilidad para pagos	Se refiere al efectivo y equivalentes de efectivo que la empresa puede utilizar de inmediato para cumplir con sus obligaciones a corto plazo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
5adc1b08-a57b-4685-a634-b5484ba5946a	Disponible	Dimensión que hace referencia al filtro "Disponible para la venta" en el SIM.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
0edf13f6-9c16-4bbb-9792-4170fcb9abf5	Disponible para la venta (P1)	Determina que la mercancía se visualice disponible en los canales de venta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
962a1e6d-a4de-4fe9-9451-0374976d7ace	Distribución	 Lista de Áreas o Roles a los cuales se les distribuye o da acceso al documento. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
2f2b18b6-b86a-4f80-bf07-515f79372e79	Doble cierre	Permite llevar la contabilidad fiscal y la corporativa al día. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
cf743f84-7fab-48f5-9000-74ab18ce0fbb	Documentación mercantil	Conjunto de documentos (facturas, notas de crédito, cheques, etc.) que respaldan y formalizan las transacciones comerciales de una empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
a2c33f56-078c-477e-80bd-02e299150046	Documento	Se refiere al comprobante físico de una transacción. Existen documentos de débito que son documentos por cobrar, originados a partir de la adquisición de un bien o servicio ofrecido a un cliente. También existen documentos de crédito que se relacionan con las transacciones realizadas para el pago de los bienes o servicios.	Código Documento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:41:50.817+00
69552fbd-80fd-4dfa-a552-b78e298ff943	Documento de conteo	Documento que se crea desde eflow-WMS para iniciar el proceso de toma física, indicando el tipo de toma a realizar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
abe54920-a183-4bc1-83c5-7c680318da25	Documento normativo	Texto que establece reglas, políticas o estándares que deben cumplirse.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
ee7a0b16-dcf8-44e9-8719-58d28d3c587a	Documentos de crédito	Es definido también como Haber y es el origen de una transacción. Es un asiento contable que registra la reducción o eliminación de una partida de activo o de gastos, o la creación o aumento de un pasivo, o de una partida de capital neto o de ingreso; un asiento en el lado derecho de una cuenta; la cantidad contabilizada como tal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
14acb9a8-d8c8-458d-bea2-badd357c48c0	Documentos de deposito	Se refiere a una transacción que permite al cliente pagar documentos pendientes por medio de un depósito del monto parcial o total del documento a una cuenta bancaria de la compañía acreedora.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
dc5c6b9d-02ab-470f-b475-102a7ff9b7ec	Documentos maestros	Documentos en formato texto asociados con una fuente de datos que ingresa datos dentro de los campos en el documento. La fuente asocia a la fuente de datos los campos definidos y los reemplaza.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
460653a7-a46f-48ba-b423-02dde715ea09	Documentos relacionados	 Lista de Documentos asociados a la tarea. Estos pueden ser otros manuales, instrucciones de trabajo, anexos, etc. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
7283b819-28d4-4c0e-8197-f4ac994103c1	DPI	Es una unidad de medida que se utiliza para describir la resolución de una imagen o de un archivo que será impreso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
552c4845-31fb-49ec-9680-9adbaf53a0f1	DUA	Declaración Única de Aduana.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
fd56569d-4464-4f13-8c93-a78bae28a8a4	Dueño del Dato	Rol de negocio con la autoridad final sobre la definición, reglas y políticas del dato.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
bd906c33-8160-4f1a-8baa-89b27ee0963a	Día frecuencia pedido	Es la división del rango de días desde que se realizó el primer pedido hasta el último pedido realizado entre la cantidad de días con pedido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
15dd0329-b05c-4bef-be03-1264bf3511fa	Días de CxC	Son los días promedio que le toma a la empresa convertir sus ventas a crédito en efectivo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4d774ecf-3b0a-4c52-bf81-8dab919d5704	Días de falla	Días sin disponibilidad de producto, afectando la demanda real observada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b4c3661b-881a-44b5-af92-16e5c1705f09	Días de vacaciones	Período de descanso remunerado al que tiene derecho el trabajador después de un año de servicios continuos. La cantidad mínima de días está fijada por la ley de cada país.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:45:15.784+00
59ca3f1a-84ce-440e-80c9-23cc595c06e0	Días libres contenedor	Cantidad de días otorgados sin costo adicional para realizar las gestiones logísticas correspondientes, como retiro del contenedor, almacenamiento o devolución del equipo, según las condiciones establecidas por el operador logístico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
8d1f2e30-cc9e-4a5c-94ec-df3245c9c799	EAN	Código de barras estándar utilizado para identificar artículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
21fc1afd-7c6e-46c9-8de9-a7d35a121451	EBITDA	(Earnings Before Interest, Taxes, Depreciation, and Amortization) Utilidad Antes de Intereses, Impuestos, Depreciación y Amortización. Mide la capacidad de la empresa para generar efectivo a través de sus operaciones principales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
5ee575db-5641-4555-b13b-fa0bb440511e	EDI	Significa intercambio electrónico de datos. Es la transferencia electrónica de información de un negocio a otro, utilizando un formato estándar y predefinido. Básicamente, es una forma de que las computadoras de dos empresas se "hablen" entre sí sin intervención humana, para intercambiar documentos comerciales como órdenes de compra, facturas o avisos de envío.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
06a658bc-c0c0-41e9-8add-cf3e39ce65f0	Editable	cuando se puede modificar, cambiar o personalizar fácilmente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
cab5c2ad-7f79-4e18-bf3f-3f7bd874e1cc	Eficiencia operativa	La capacidad de realizar una tarea en el menor tiempo y con el menor costo posible, minimizando errores y manteniendo la calidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
786a250c-36b5-4e11-8386-77250197d429	Egresados	Es un indicador de salida de talento que representa el número total de colaboradores que han salido de la organización, ya sea de forma voluntaria o involuntaria, durante un período específico de tiempo (por ejemplo, un mes, un trimestre o un año).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
daa12537-7406-482e-bbe2-4bb66658872e	Egresados %	Es el indicador principal de retención y estabilidad de una organización. Representa el porcentaje de colaboradores que salieron de la empresa (egresados) en relación con el número total promedio de colaboradores en un período determinado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9100fbb9-a96c-4c05-8ca3-37385716eb84	Ejecutor del proceso	Persona encargada de realizar las actividades definidas en el proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4906d4ea-bef2-4411-b043-42acbc7024d3	Elasticidad precio	Medida del cambio en la demanda cuando varía el precio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d1c7b315-69ab-430f-a0a1-c97ada716727	Embarque	Documento que hace constar el recibo de los artículos enviados por el proveedor para satisfacer los requerimientos de una o varias órdenes de compra.	Embarque	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:41:53.513+00
af48b27c-be30-4c7e-86f7-1fa7bf599805	Embudo de marketing	es una representación visual del viaje que un cliente potencial realiza, desde que descubre una marca hasta que se convierte en un cliente fiel. Su forma de embudo ilustra que, de un gran número de personas que inicialmente entran en contacto con la marca, solo una pequeña fracción se convertirá en clientes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9cdfc090-1dee-4a32-ad47-d5108824423a	Empaque	La forma de embalaje de un artículo para su venta, que asegura su integridad durante el almacenamiento y el transporte en el proceso de distribución mayorista.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1c4ce8a4-fa58-444c-b742-10d87a329223	Empaque comercial	Unidad mínima de comercialización de un artículo, es múltiplo del Empaque de Inventario, y no necesariamente está relacionado a la cantidad de Piezas o Juegos que están contenidas en el empaque físico, aunque sí están estrechamente ligados. Este define en la empresa la cantidad mínima comercializable de un producto en el mercado de mayoreo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e3b097d5-2e8a-4ea6-98f5-0edc55a446c7	Empaque de inventario	Unidad mínima e indivisible de un producto. Este clasifica si el artículo se considera una pieza, un Juego o un Rollo. Representa la unidad de conteo de inventario, por cuanto el costo y el precio de un artículo se relaciona con esta unidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
68c167e2-d50e-4e74-8b5f-fcf9e519eb41	Empleado	Los empleados constituyen el sistema social interno de la empresa. ​ Un empleado es, para el sistema, el registro en el que se almacena la información personal del empleado físico. ​ Este registro se distingue mediante un código único. 	Empleado	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:37:02.177+00
3724a687-cdb4-4901-a424-3a30ee39f5ff	Empleado/ colaborador de confianza	Trabajador que desempeña funciones de dirección, administración, vigilancia o fiscalización, o cuyas labores sean de naturaleza personalísima. Su régimen horario y de prestaciones puede tener particularidades legales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
6a3a4f63-4dce-4d1b-bba3-d7aa0b69a7f6	Encabezado / pie de página	Áreas del documento que contienen información como fecha, autor, versión, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
6f835bff-a1e2-46ab-9e2f-af4fa5d57e49	Encuesta de satisfacción laboral	Herramienta de diagnóstico que mide la percepción de los colaboradores sobre el ambiente de trabajo, la cultura organizacional y las condiciones en la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d6fe6c9b-635c-43d9-83dd-78f799f84912	Engagement	La interacción y participación que los usuarios tienen con el contenido de una marca, especialmente en redes sociales (me gusta, comentarios, compartidos).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1cd604d3-c3db-4f5c-89d2-3e07a4bc4637	Engagement (compromiso)	Grado de identificación, compromiso y entusiasmo que un empleado tiene hacia su trabajo y la organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
77283da6-d5af-4bfd-b0ca-db1f3686c15e	Entidad comercial	Toda entidad jurídica con la cual se pueda realizar una transacción comercial. Para fines de esta Norma, transacción comercial se resume fundamentalmente en venderle mercancía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
796cc318-2109-4381-93ee-c5548d0b3938	Entradas	 Se especifica lo que se requiere para el proceso, la actividad o la tarea se pueda iniciar. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d2151e84-fed4-45c6-a448-81bd73d0b9ee	Entrega	Días en los que el proveedor realiza la entrega de la mercancía.	ENTREGA	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-25 13:37:33+00
b47031ea-52f8-4a18-aee5-c70aa7321734	GAN (generative adversarial network)	Tipo de red neuronal que genera contenido nuevo, como imágenes o música.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
129d3316-cdb8-4caf-8f79-9ce3d29649e6	Equipo comercial	 Mesa de trabajo que busca el desarrollo de los proyectos estratégicos de un Área Funcional. Está conformado por el Responsable Comercial, Responsable de Métodos, el Responsable Técnico, y los Usuarios Expertos. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
10ba0b09-2c66-4f0e-8469-77856a2c0277	Equipo de mercadeo	Equipo a disposición de desarrollo y seguimiento de proyectos del área funcional de Mercadeo. Compuesto por Responsable Comercial, Responsable de Métodos y Gerente de Proyectos de Mercadeo; y los Funcionales Expertos de Mercadeo representando a cada compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9ac34da6-1c52-49c2-b7d4-4ea080a7fd0d	ERP	Sistema de Planificación de Recursos Empresariales		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1f89de2d-be3e-4142-b6b2-4a28454e2f9c	Escala	es la relación entre el tamaño de un objeto real y su representación. En otras palabras, es la proporción de un elemento en comparación con otro, lo que ayuda a crear una sensación de tamaño, distancia y perspectiva.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
95d9c52c-1d97-4c81-8f55-1261a1eb93d3	Escala de grises	se refiere a una gama de tonos monocromáticos que van desde el negro más puro hasta el blanco más puro. Cada tono de gris se crea mezclando diferentes cantidades de negro y blanco, sin incluir ningún otro color.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
bb1c91fe-0a73-47dc-9fad-495da5432118	Eslogan	es una frase corta, memorable y concisa que resume la misión, los valores o los beneficios de una marca. Es una herramienta poderosa diseñada para ser fácil de recordar y asociar con un producto o servicio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
18534369-e5bd-410f-bf7d-9e82f7ff689d	Especificaciones	Lista de requisitos técnicos y funcionales que un sistema debe cumplir (ej. debe funcionar en móviles o permitir reportes).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
826c34c7-cf4c-43ce-9622-a309a10ad605	Especificación técnica	Documento que define requisitos técnicos de productos, servicios o procesos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
6de1abf5-e4b5-4a08-8df9-8865aa74a893	Estacionamiento	Área designada para el estacionamiento de vehículos de colaboradores y visitantes, sujeta a normas de uso y seguridad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c37a4105-9af2-405a-bbae-05b5b78150a1	Estado	Se refiere a la condición o la situación actual de una entidad en un momento específico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
a963844a-6d07-47e3-952c-d9d122ab95e8	Estado activo (Artículo)	Permite filtrar si el artículo está activo (Vigente) o no (Bloqueado).		homonimo	Se separó de un término homónimo compartido con: Estado activo (Empleado).	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-28 16:05:00+00
0be5ac17-d76c-4015-b05e-df895b317366	Estado activo (Empleado)	Estado del empleado que indica si el mismo está trabajando normalmente o si está suspendido ya sea por vacaciones, por despido, enfermedad u otros.		homonimo	Se separó de un término homónimo compartido con: Estado activo (Artículo).	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-28 16:05:00+00
7289526d-4362-4241-8c73-eec2a2cba69a	Estado de cuenta	Es un documento financiero que una empresa emite para su cliente. Detalla todas las transacciones pendientes, como facturas impagas y pagos recibidos, en un periodo de tiempo determinado. Es un resumen de la relación financiera entre el negocio y el cliente desde la perspectiva del proveedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e6ce3f85-c316-43c5-b677-f89e5fec9c90	Estado de cuenta bancario	Informe emitido por un banco que resume todas las transacciones de una cuenta durante un período específico, esencial para la conciliación bancaria.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b4a09102-2e7f-4d89-b8c6-8deabca3d663	Estado de ganancias y pérdidas	Reporte financiero que resume el desempeño económico de la empresa durante un período. Muestra los ingresos, costos y gastos, culminando en la utilidad o pérdida neta. Es el indicador clave de la rentabilidad operativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
21ed3384-2dea-42d5-b342-0ff1f0b2300d	Estado de resultados	Presentación formal de todos los ingresos y gastos pertenecientes a un período de tiempo específico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
7a871cb3-78a9-4e20-a435-7b3a1d80aa2e	Estados (unidad de transporte)	Pueden ser Activo (en uso) o Inactivo (no en uso).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
329fe90d-dd99-4f40-be47-3f1d56d4bd4e	Estados de la situación (unidad de transporte)	Pueden ser Asignado, Bloqueado o Disponible.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3ffc0f69-0757-43c9-b6e5-0dd57358f5fa	Estadísticas	Muestra indicadores de ventas como presupuesto, ventas facturadas, renglones facturados y total de clientes, entre otros		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b8a17f5d-4668-44dc-8bbe-b18cb7afe88c	Estandarización	Proceso de establecer normas y procedimientos uniformes para asegurar consistencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4d86efc1-0e57-4896-b4da-91f8e0b26b4a	Estandarización de Datos	Proceso de ajustar los datos a un formato, tipo y estructura común. Su objetivo es eliminar discrepancias en la captura de información para permitir la consolidación de datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
76000ca9-d790-49cc-a5ef-a649b2b03480	Estantería	 se le denomina así a los Racks o Bloques que se definen dentro del almacén, son estructuras que se conforman de niveles y columnas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b6342c59-7629-4967-bd0d-4d8df69682f1	Estiba europea (EUR / EPAL)	Tipo de estiba que corresponde al pallet estándar utilizado en Europa para el transporte y almacenamiento de mercancías, regulado y certificado por la organización EPAL (European Pallet Association). Medidas: 120 × 80 cm. Nombre internacional oficial Europallet / EPAL 1		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
a4075f49-b6bd-4636-8bf3-1c751f262add	Estiba GMA (Estándar Norteamericano)	Tipo de estiba que corresponde al pallet estándar utilizado principalmente en Norteamérica (Estados Unidos y Canadá), definido por la Grocery Manufacturers Association (GMA).\nMedidas: 122 × 102 cm. Nombre internacional oficial North American Standard (GMA)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3ec711e7-5531-4c74-97ca-95b71b03157c	Estiba ISO / Estándar	Tipo de estiba que corresponde al pallet cuyas dimensiones están normalizadas bajo la norma internacional ISO 6780.\nMedidas: 120 × 100 cm. Nombre internacional oficial ISO Pallet / Estándar internacional		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e0479815-c66f-4c95-9710-1ec803a1da4e	Estrategia	 Es la manera general como orientamos nuestras acciones para lograr los objetivos propuestos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4204bc9d-4f97-4756-a5df-16b6ee4c794b	Estructura organizativa	Organización jerárquica de cargos y funciones dentro de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e369fde7-513a-4e47-b926-b683d03192da	ETL (extract, transform, load)	Proceso de extraer datos de una fuente, transformarlos y cargarlos a un sistema de análisis.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
76df97ce-c137-4db9-890a-6356421d5510	Evaluación de desempeño	Proceso sistemático y periódico para medir el rendimiento de un colaborador en su puesto, en función de objetivos establecidos y competencias requeridas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c12b7008-c2bd-43bf-b0a7-ebe411a071bc	Evaluación de necesidades	Diagnóstico de los problemas presentes y de los desafíos futuros que pueden enfrentarse mediante capacitación y desarrollo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d36d88ec-30b3-4c76-b1b1-80d6bc2f29ee	Evaluación del interés	La fase de la venta donde se realizan preguntas exploratorias y se manejan las objeciones del cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1c3a137f-448f-4d5e-94ef-c550f14f2a4a	Evento contable	Nombre que se le asigna a cada uno de los procesos que implican la generación de una transacción en la contabilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4db007c6-c715-471f-be41-45bae35462d0	Exactitud de pronóstico	Porcentaje de acierto del plan consensuado vs. la venta real		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
63ffd8a3-7467-4494-8cb1-3b11f117b7b5	Expedición	Proceso de preparación y despacho de pedidos desde el CEDI hacia el cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
47b7d1ad-d844-431d-a7ed-71486587abfc	Extracto bancario	Documento oficial del banco que detalla todos los movimientos (créditos, débitos, comisiones) en una cuenta durante un periodo, mostrando fechas, importes y saldos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
cde4b67b-fa4e-42b6-b416-748a71e21e41	EXW	Ex Works - en fábrica (lugar convenido) . El vendedor pone mercancía a disposición del comprador en sus propias instalaciones, fábrica, almacén, etc. Todos los gastos a partir de ese momento son por cuenta del comprador.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e4c727d2-ff97-442a-9325-62330d6374eb	Factor de gasto	Representa el resultado del análisis de los costos y gastos imputables al costo de la mercancía vendida en un lapso no mayor de 6 meses según lo establecido en disposiciones legales presentadas en la Gaceta Oficial N°40.341, de la Superintendencia Nacional para la Defensa de los Derechos Socio Económicos de la República Bolivariana de Venezuela.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4b40dce8-95ea-4116-918f-725a5f754602	Factor logístico	La cantidad de unidades por caja.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4c23bf01-82bb-476d-954f-3fc4a8fb5c5a	Factura	Documento mercantil con validez fiscal que detalla una operación de compraventa, especificando productos, precios, impuestos y condiciones de pago.	Factura	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:37:08.304+00
8405afee-de94-4470-ab90-bd4af3190a08	Facturación 4.4	Se refiere a la versión 4.4 del sistema de comprobantes fiscales electrónicos establecido por el Ministerio de Hacienda de Costa Rica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
7124d2aa-5d1c-4f99-bb24-7a17fd6f47b9	Facturación de rutero	Un módulo que optimiza el proceso de preventa y cobro, y que está integrado con las actividades de control de inventarios, control de cobros y facturación. Refuerza la automatización de la fuerza de ventas, ruteo y preventa de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
f1c2f511-e395-4b62-8724-2206c7cc89cb	Facturación de rutero desktop	Es el componente a nivel de escritorio que sirve como administrador de rutas. Permite el registro, modificación y borrado de información como PDA's, agentes, clientes, artículos y rutas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
76e11483-cbdf-4389-a868-8a3a79bbd31f	Facturación de rutero móvil (FR)	Es el componente móvil del módulo que tiene como función principal facilitar la labor de preventa en el punto de venta a nivel móvil.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b64a8331-c47c-4f39-97c8-0728b869493c	Falla	Cantidad de artículos con inventario en cero.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
bd21e91a-8780-4772-b861-c415335a79e9	Falla %	Cantidad de artículos en falla entre el total de artículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
693053d5-4a14-4708-adf8-cb980158ecf3	Faltantes	Al cliente no le llegó el pedido, una línea o menos de lo indicado en la factura.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
a9979f50-e827-47d9-b1f8-4c7b33216eb6	Familia	División especifica dentro de cada sub categoría de artículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
f3810e3c-2e25-46a8-a41c-97d9aea69664	Familia de productos	Es el nivel más granular y se basa en las especificaciones del producto. Agrupa productos que son casi idénticos en su función, pero que varían en detalles técnicos cruciales para el cliente.	FAMILIA DE PRODUCTO	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-30 19:30:00+00
71e86388-67e1-48fc-9a73-dbd3764bc14f	FAS	(Free Alongside Ship - Libre al costado del buque (puerto de carga convenido)). El vendedor entrega la mercancía en el muelle pactado del puerto de carga convenido; esto es, al lado del barco. El vendedor es responsable de las gestiones y costes de la aduana de exportación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
611937a7-00e6-41ea-afb7-6c63c6f6cec5	FASB-52	Habilita el control de movimientos en moneda funcional y en moneda reporte según el tipo de cambio especificado. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
69e3cfac-a236-45d2-b253-8ed297796f97	Fase de adopción	 Fase 5 de la Metodología de Cambio. Pone la solución a operar y evalúa los resultados. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
488d0519-f283-457b-addb-a8dd5c0ac31a	Fase de alineación	 Fase 1 de la Metodología de Cambio. Crea un entendimiento común entre los participantes del propósito del proyecto. Se establece cuál es el área de oportunidad. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
46336647-5425-4fa3-8000-db79698f1344	Fase de construcción	 Fase 3 de la Metodología de Cambio. En la fase de  preparación se desarrollan los planes de  construcción e implementación (automatizada o no). Se establece quién hace cuándo para entregar la solución. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
ff9c8634-215b-442b-b5a2-0465083bf6fc	Fase de diseño	 Fase 2 de la Metodología de Cambio. Se identifican las razones del área de oportunidad, se aterriza el proyecto y establece un curso de acción. Se establece la forma de proceder para resolución. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
0cfb3a80-51d7-4b0c-a4a8-e04ca95aaf67	Fase de implementación	 Fase 4 de la Metodología de Cambio. En esta fase se prepara a la Organización/Compañía para recibir  la solución. Se prepara a la operación para operar el nuevo proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
61c00dbd-3eee-4c24-8910-1f4597287276	FCA	(Free Carrier - Libre transportista (lugar convenido)). El vendedor se compromete a entregar la mercancía en un punto acordado dentro del país de origen, que pueden ser los locales de un transitario, una estación ferroviaria. (Este lugar convenido para entregar la mercancía suele estar relacionado con los espacios del transportista). Se hace cargo de los costos hasta que la mercancía está situada en ese punto convenido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
41de50a8-f938-4c77-9299-b1f5b89ef76f	Fecha	Tipo de dato cronológico que indica el día calendario. Debe ser expresado en formato AAAA-MM-DD	Fecha	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:25.128+00
3a8587e8-f662-41b4-aa52-6a3409be7a96	Fecha de revisión	 Fecha en que se elabora o se realizan modificaciones al diagrama. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
8bdff05d-db3d-4448-91bc-07476266afb8	Fecha ETA estimada	ETA significa Estimated Time of Arrival, en español Fecha Estimada de Llegada. Es la fecha estimada de llegada del medio de transporte al puerto o destino establecido para la importación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9509e71b-bd55-467a-896a-1152bafd8cad	Fecha ETA real	ETA significa Estimated Time of Arrival, en español fecha estimada de llegada. Al agregar la palabra "real": es la fecha efectiva en la que el medio de transporte llegó al puerto o destino establecido para la importación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
10f53a08-b2eb-49af-ad27-44f9dc305193	Fecha ETD estimada	ETD significa Estimated Time of Departure; en español, es Fecha Estimada de Salida. Es la fecha estimada de salida del medio de transporte desde el puerto de origen hacia el destino de la importación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3c153793-215a-4f88-ae7a-da6fb26aeafb	Fecha ETD real	ETD significa Estimated Time of Departure, en español es Fecha Estimada de Salida. Cuando se agrega la palabra "real", es la fecha efectiva en la que el medio de transporte salió del puerto de origen con la mercancía embarcada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
abaded62-063f-4c35-a64c-6d6c1a566f40	Fecha ofrecida	Fecha en la que el proveedor se compromete a tener la mercancía completamente preparada, empacada y disponible en las condiciones acordadas para su carga y posterior transporte desde el proveedor hacia el CEDI	Fecha Ofrecida	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:29.911+00
0d59e30a-eec9-4b48-bbb6-3a8f7548f825	Fecha requerida	Fecha en la que se requiere contar con la mercancía disponible en el CEDI, considerando el Lead Time del proveedor	Fecha Requerida	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:31.101+00
852466dd-8ace-4204-a730-b7bf91dc365f	Fecha requerida embarque	Fecha objetivo en la que se requiere que la mercancía sea embarcada desde el país de origen, considerando los tiempos de tránsito internacional y demás procesos logísticos necesarios para cumplir con la fecha requerida	Fecha Requerida Embarque	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:32.731+00
a351cc47-2bd4-4ff7-a1ec-814dd9dc3588	Feedback (retroalimentación):	Comunicación bidireccional destinada a informar a un colaborador sobre su desempeño, con el objetivo de reforzar conductas positivas y corregir áreas de oportunidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
52969983-b2a0-4eff-a85a-77065d8fe339	FEFO	Acrónimo de “First Expired, First Out”, método de rotación de inventario basado en la fecha de caducidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
9b26198b-ec30-4763-8b73-f38090f5453b	Ficha de cliente	Una sección de la aplicación que muestra información detallada de un cliente, incluyendo sus datos, ubicación, contactos, finanzas y cuentas bancarias.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d80d31b8-635a-4246-b54f-14ad8a6f6e37	Ficha técnica	Información adicional para los artículos que puede incluir sustitutos, artículos relacionados y una descripción detallada.	Ficha Técnica	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-25 13:37:33+00
23235013-1de4-44dd-9629-693b32ebddfc	Fijación de precio	Proceso para determinar el valor monetario al que una empresa venderá sus productos o servicios. Es una decisión estratégica que debe considerar múltiples factores internos y externos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
7fcee247-f184-482b-95e2-12052d652da6	Fill Rate	Silo Control: Métrica de cadena de suministro que mide el porcentaje de la demanda de un cliente que se satisface con el inventario disponible de forma inmediata. Silo Logística: La tasa de cumplimiento o nivel de servicio, es un indicador que mide el porcentaje de pedidos de clientes que se entregan completos y a tiempo. Reporte SIM – Indicador Compra: Mercancía recibida entre mercancía solicitada.		dudoso	Las 3 definiciones originales no son idénticas: disponibilidad inmediata de inventario (Control), pedidos entregados completos y a tiempo (Logística), y mercancía recibida entre solicitada (Compras). Podrían ser métricas relacionadas pero distintas en vez de una sola.	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4f08050d-3ef8-4c1f-b9a9-09c0da44cbbe	Filtro	Herramienta que permite mostrar solo la información que cumple ciertos criterios (ej. ventas de enero).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
fcdd3730-f613-460a-9ed1-4d048e80e7ba	Finalizar pedido	Es la acción decisiva que convierte la intención de compra del cliente en una orden de venta activa y procesable para el negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d4822292-be2c-4700-b3b8-ff68873dc93c	Firewall	Programa o equipo que actúa como filtro de seguridad, bloqueando accesos no autorizados desde internet.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
514c23c2-3a2b-4022-9575-1255372307a2	Firmas autorizadas de bancos	Personas designadas y registradas en el banco con la potestad para aprobar y ejecutar transacciones financieras en nombre de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
ef5d9c40-a804-46fa-a304-c518e4c64f77	Flete internacional	Precio a pagar por los exportadores o los importadores por el servicio de transporte de las mercancías transportadas. Represente el monto desde el origen, es decir, desde el momento en que se elabora el conocimiento de embarque original y se inicia el servicio de transporte hasta el puerto o lugar de importación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
94d0f325-3853-4841-9f0c-a24056459342	Flujo de caja	Informe que muestra el movimiento de efectivo generado y utilizado por la empresa en sus actividades de operación, inversión y financiación durante un período. Es vital para evaluar la liquidez.	Flujo de Caja	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:34.212+00
c2f701d1-7dc8-4507-9581-0c3d194e15b0	Flujo de una pieza	La producción de flujo de una pieza consiste en fabricar las piezas una a una y pasar al siguiente proceso. Entre las ventajas del flujo de una pieza se encuentran: 1) la rápida detección de defectos para evitar un gran lote de defectos; 2) plazos de producción cortos; 3) reducción de costes de material e inventario; y 4) diseño de equipos y estaciones de trabajo de tamaño mínimo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
b05d4c35-0aaa-4727-9e0e-7efc5abe6952	Flujograma / diagrama de flujo	Representación visual de las etapas y decisiones dentro de un proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
d76ac863-b452-47e2-9148-54c93c916f92	Flyer	es una hoja de papel suelta, generalmente de tamaño A5 o más pequeño, que se utiliza para distribuir información y promocionar un producto, servicio, evento o idea.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
173c2074-4e95-4675-b648-344d0ef095c2	FOB	(Free On Board - Libre a bordo (puerto de carga convenido)). El vendedor entrega la mercancía sobre el buque. El comprador se hace cargo de designar y reservar el transporte principal (buque).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3fdc2d33-0d0c-460c-b247-9b16acb6e98b	Fondo de prestaciones sociales	Mecanismo de ahorro forzoso en Venezuela donde las empresas deben depositar un porcentaje del salario para cubrir las prestaciones sociales (equivalentes a cesantías y intereses sobre cesantías en Colombia)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
2dc54bd3-d2bb-4781-9da8-d65c3bd54e8a	Footer	es la sección inferior de una página web que se mantiene fija y visible en todas o la mayoría de las páginas de un sitio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
e6483ab9-d100-42d1-92e4-934504e7db2b	Forecast bias	Tendencia sistemática a sobreestimar o subestimar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
66691f84-9d4e-48c0-8fc7-d196a1de335f	Forecast Consensuado	El plan de demanda consensuado para toda la organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
46e8edf0-073a-41b3-9a13-f31e3a8c6fac	Forecast performance	Porcentaje de coincidencia entre el pronóstico y la demanda real.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
306b3852-8727-455b-981a-60627913d027	Formato	 Se elaboran con el propósito de solicitar, monitorear, registrar, analizar datos y dejar evidencia de los macroprocesos de la empresa. 	Formato	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-02 01:42:35.399+00
c0977f82-7f84-41f8-b0f2-fedd9430c9b0	Fotomontaje	es una técnica de edición digital que consiste en combinar o superponer varias fotografías para crear una única imagen que parece ser real o, al menos, coherente. Es una forma de "manipular" la realidad para lograr un efecto visual específico o para contar una historia que no podría ser capturada con una sola toma.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3707ade5-9bc1-413b-ab78-fbf06f658571	Fracciones de intereses	Se refiere a la modalidad de cálculo de porciones de intereses, que puede ser utilizada al cancelar un pago antes de la fecha de pago o pagos parciales de cuotas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
dda6e654-de3d-4a8d-9c98-070b3801198c	Frecuencia de colocación de orden de compra	Es el tiempo en días que transcurre entre una colocación de una orden de compra y la siguiente orden de compra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
737ae589-cd55-4d15-93c7-6c1cea5eb6cb	Frecuencia de revisión de la descripción de artículos	Se establece una frecuencia semestral para efectuar una revisión general de la estructura del surtido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
76db48c0-495b-40ed-aba3-da360432b072	Fuente	Relaciona un movimiento contable con el documento que lo sustenta (número de cheque, de factura, etc.). ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:45:41.834+00
2e1d70fc-99b4-424c-b283-de1e0079ee65	Fuente (tipografía)	) es un conjunto de caracteres alfanuméricos y símbolos con un estilo y diseño unificados. Se refiere a la apariencia visual del texto, incluyendo su forma, peso, tamaño, espaciado y estilo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
451ee6b5-e458-465c-9d4a-4f9747521c2d	Fundación kaizen	Los tres principios y siete conceptos de KAIZEN™ que sirven como base para los sistemas y herramientas necesarios para la implementación de la Mejora Continua y la Gestión de la Calidad Total, y que dan forma a la cultura y al pensamiento del liderazgo de una organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
26098429-0cc2-4012-a598-d862389a9d1f	Fusión	Operación en la que dos o más empresas se unen para formar una sola entidad legal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
6094dff6-5db8-45ab-9b56-d9c853e6a2a4	Físico de empaque	La cantidad de cajas físicas de un artículo en una ubicación específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
c3e39344-e626-4774-a756-9c4bd7ecd480	Ganancia operativa	Silo Control: Beneficio generado por las operaciones principales del negocio, antes de deducir intereses e impuestos. Mide la eficiencia y rentabilidad del core business. Reporte SIM – Indicador Control: Suma de las ganancias obtenidas de las operaciones principales de la empresa.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-28 16:00:00+00
829963e2-5428-466a-8234-3f6a34cc49ca	Garantía	Es una promesa del proveedor que asegura la calidad y el buen funcionamiento de un artículo por un período determinado. En el comercio mayorista, es crucial para la gestión de devoluciones y la satisfacción del cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
589c89ef-5bd7-4272-9045-51df779f4cc5	Gasto	Desembolso de dinero que una empresa realiza para sus actividades operativas que no está directamente ligado a la producción o adquisición de mercancía (ej. salarios administrativos, alquiler).	Gasto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-10-03 10:45:52.381+00
f0fb3d0c-9b1d-403d-b223-10404463e563	Gasto Personal	Es un indicador financiero clave que representa la suma total de todos los desembolsos e inversiones que realiza una organización para compensar y mantener a su fuerza laboral durante un período específico (normalmente un año o un trimestre fiscal). Es el costo total de emplear a las personas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3d90d835-0f33-4819-87c8-f8e5bdae2dd8	Gastos de personal	Todos los costos asociados a la remuneración de los empleados, incluyendo salarios, cargas sociales, beneficios, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	Gastos operativos	Silo Control: Costos incurridos en las actividades principales del negocio, excluyendo el costo de la mercancía vendida (CMV), intereses e impuestos. Reporte SIM – Indicador Control: Suma total de los gastos incurridos en las operaciones cotidianas de la empresa.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.628185+00	2026-09-28 16:00:00+00
76dfb724-036d-439b-af19-f83cbc743030	Gastos operativos / Renta Bruta	Ratio que muestra la proporción de la renta bruta que es consumida por los gastos operativos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
60332d87-3bd5-4c83-a051-b57b0a315267	Gastos operativos sin tributos	Suma de los gastos de operación de la empresa excluyendo los impuestos y tributos pagados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
7496be25-ccc1-405e-bcbc-974a656558da	Gemba	Palabra japonesa que literalmente significa "el lugar real". En el contexto de KAIZEN™, gemba suele referirse al lugar donde se añade valor, como el taller. En un sentido más amplio, gemba se refiere a cualquier lugar de una empresa donde se realiza el trabajo; por ejemplo, puede haber un gemba de ingeniería, un gemba de ventas, un gemba de contabilidad, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
6e775fb6-7e1e-40ef-b565-cdd071df95ed	Generación de asientos	Proceso automático o manual dentro del ERP que crea los asientos contables correspondientes a las transacciones operativas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
f8d7cda0-71f6-416e-867f-dbe04b1e2c12	Gestión de calidad total (TQM)	La Gestión de Calidad Total (GCT) es una filosofía de gestión integral que busca la mejora continua de la calidad de productos y procesos. La GCT se basa en la premisa de que la calidad de los productos y procesos es responsabilidad de todos los involucrados en la creación o el consumo de los productos o servicios que ofrece una organización, lo que requiere la participación de la gerencia, el personal, los proveedores y los clientes para cumplir o superar las expectativas de los clientes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
3abd6eda-e147-4eec-a98f-f9ba770069c1	Gestión de cobranza	Es el conjunto de procesos y estrategias que la empresa implementa para recuperar el pago de las deudas que sus clientes tienen con ella. Su objetivo principal es asegurar que los pagos se reciban a tiempo, lo que mantiene un flujo de caja saludable y evita problemas financieros.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
8a7f1f41-ede9-4cf3-ba71-b8d8be357e6e	Gestión de Restricciones	Etapa del S&OP en la que el plan de demanda (irrestricto) se confronta contra las limitaciones reales de suministro (capacidad productiva, inventario, lead times, proveedores, presupuesto). Su objetivo es transformar un plan "deseado" en un plan factible y ejecutable, resolviendo los desbalances entre lo que se quiere vender y lo que se puede abastecer.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
eb380dce-f66d-4e80-970c-ab4c50384ef6	Gestión de ventas	Es el proceso integral de planificar, dirigir, coordinar y controlar todas las actividades relacionadas con las ventas de una empresa para alcanzar sus metas de ingresos y crecimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
746362d3-7001-4f29-9b78-e8fc38130ef8	Gestión multifuncional	La coordinación interdepartamental necesaria para alcanzar los objetivos estratégicos y de políticas de KAIZEN™ y la Gestión de Calidad Total. Su importancia fundamental reside en el seguimiento para alcanzar los objetivos y medidas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
2a4be756-cc6e-41cf-b658-7b61674cc1d7	Gestión orientada a resultados	Un estilo de gestión generalmente asociado con controles, desempeño, consideraciones sobre productos o resultados, recompensas y/o castigos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
1eea46f5-c30b-44c4-9064-b45ef2b0fdba	Gestión upstream	Un concepto y proceso KAIZEN™ mediante el cual, a través de la mejora continua, los defectos se eliminan cada vez más arriba en el proceso de producción, primero en la inspección, luego en la línea y luego en el desarrollo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
52c7999a-3f8f-49ed-bb87-70f0e6c9e9c1	Gestión visual	La Gestión Visual es un conjunto de técnicas para crear un entorno de trabajo que integre la comunicación y el control visual en todo el entorno laboral. La filosofía de la Gestión Visual se basa en la idea de que «lo que se mide y se muestra, se hace». Se utilizan herramientas visuales sencillas para identificar el estado objetivo y cualquier desviación se corrige con medidas correctivas. También facilita la comprensión de los procesos implementados. Esta información puede referirse a los propios puestos de trabajo, a la empresa en su conjunto o al progreso de los equipos de trabajo en un proyecto. Ejemplos de Gestión Visible son las tarjetas Kanban, los tableros de sombras de herramientas, los guiones gráficos, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.628185+00	\N
4470fdd2-0fb4-4c91-96c5-a436704c274e	GM ROI	Margen por Rotación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
50fd7612-3aa2-4db8-84f4-66083f19a639	GMROI	(Gross Margin Return on Investment) Métrica que evalúa la rentabilidad del inventario. Se calcula como (Margen Bruto / Inventario Promedio) e indica cuántos dólares de margen bruto se generan por cada dólar invertido en inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
26eeec1a-f5b9-445b-a90d-4acb2dc30a08	Gobernanza de datos	Marco de políticas, estándares y procesos para gestionar los activos de datos de la empresa, garantizando que sean precisos, consistentes y seguros, consolidando la "única verdad".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d0adcb58-5c3f-4c2e-9ad2-37bf22628ad9	Granularidad	Nivel de detalle o atomicidad de los datos contenidos en una tabla. Una granularidad alta implica que el dato representa la transacción mínima (ej. el ítem de una factura), mientras que una granularidad baja representa datos agregados o resumidos (ej. el total de ventas mensual).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	Grupo Compra	Reporte SIM – Dimensión Compras: Muestra la agrupación de marcas asignadas por comprador. Reporte SIM – Filtro Compra: Permite visualizar la informaciónen en base a la selección de uno o mas Grupos compra.	Grupo Compra	fusionado	Fusionado a partir de 2 filas originales.	t	Se registran ambos campos técnicos porque varían según la empresa.	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-28 16:00:00+00
a2812462-ca90-4752-ba9d-a1043dc636d9	Grupo de usuarios	Un grupo de usuarios es un conjunto de empleados en la compañía para quienes se establecen, simultáneamente, los mismos derechos sobre cada una de las opciones de los módulos del sistema. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f92e62a8-424e-427c-b4af-8ca7758ef77c	Grupo Marca	Es la división por subgrupos que realiza Mayoreo de las marcas.	Grupo Marca	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
29f13494-d82e-4112-8b21-660e2b57c00e	Grupos	La clasificación más general de productos. Una regla establece que debe haber un mínimo de 4 y un máximo de 7 grupos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4495cc46-cdea-435d-82c7-d64aeba2064a	Grupos logísticos	 Agrupación de artículos por familia para el proceso de almacenaje. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
3ea74b7a-7d38-4a93-a2b8-c01fbcdb2430	Gráfico de control	Un gráfico con límites de control superior e inferior dentro de los cuales una máquina o proceso se encuentra bajo control. Con frecuencia, una línea central, a medio camino entre ambos límites, ayuda a detectar tendencias hacia uno u otro. El trazado de mediciones críticas en el gráfico indica cuándo una máquina o proceso se ha descontrolado y debe ajustarse. Es una de las Siete Herramientas Básicas de la Calidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
dc0fce8d-1198-4c77-a19b-1fbbf83ab519	Gráfico de radar	Un diagrama circular con diez rayos, uno para cada uno de los tres principios y siete conceptos de KAIZEN™. Se utiliza como herramienta de diagnóstico para medir, en una escala de cero (en el centro) a diez (en el borde), el grado de coherencia con los principios y conceptos de KAIZEN™ que exhibe una organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2d598cf8-a56c-4aba-b71f-02bda83c8fce	GTIN (global trade item number)	Campo informativo u opcional para ingresar el Número global de artículo comercial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d8aaf9df-463d-4b74-87ca-e64b2202433c	Hablador	Hoja de papel bond blanco tamaño carta, que contiene información sobre el contenido de una paleta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fc371003-0e8d-4a9d-8922-adec80f9fddd	Hallazgo de auditoría	Es una conclusión resultante de un proceso de auditoría que identifica una desviación o brecha entre la condición actual de un proceso y el criterio o estándar esperado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
1a2203b1-5018-44a7-a202-a1de180a8a51	Hand held	Herramienta donde se registran pedidos y demás transacciones propias de preventa y ruteo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
cd5955df-e709-4cf2-8661-c53438da7529	Hanedashi	Expulsión automática de piezas. Las piezas pueden insertarse manualmente en la máquina, pero al finalizar el ciclo, la pieza procesada se expulsa automáticamente para que el operador pueda simplemente insertar la nueva pieza y pasarla al siguiente proceso, reduciendo así el tiempo de ciclo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d972cc47-ac2b-4a20-a414-431c3cb3b166	Hardware	Componentes físicos de un sistema, es decir, todo lo que se puede tocar: servidores, computadoras, impresoras, routers.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f85ebc8e-f5fd-45ab-b60c-55994f999ba1	Header	es la sección superior de una página web que se encuentra en un lugar fijo y visible, generalmente en la parte de arriba del sitio. Es uno de los primeros elementos que los visitantes ven y, por lo tanto, es crucial para la navegación, el branding y la usabilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
8bed0f8c-263e-428f-939e-70d929f01152	Help desk / mesa de ayuda	Área de soporte técnico que atiende a los usuarios cuando tienen problemas con sus sistemas o computadoras.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
78a45a97-7efd-475e-8c8e-0eb3c7320229	Hexadecimal	es un sistema de codificación que se utiliza para representar los colores. Es la forma más común de definir los colores en la web, en CSS, HTML y en programas de diseño.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4aff6140-751f-4ea4-be47-12de9ad9bfc4	Highligh	Barra de color llamativo que actúa como un cursor sobre una opción en un menú representada como texto. Normalmente responde a las teclas direccionales o al cursor del ratón.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
741ff552-de9e-443c-972d-6c6fa7272a71	Homologación	Proceso para asegurar que una autoparte cumple con las especificaciones técnicas de un vehículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
9f909e1b-cd3b-4ba6-a90d-ed7a2211b8ba	Horario	Horario de trabajo de los empleados, éste puede ser fijo o bien, rotativo, dependiendo de los turnos en que se trabaje y de la demanda del producto o servicio.	Horario	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:42:36.851+00
b3c80b7b-36c3-4109-b605-aa0747033d9c	Horas hombre (%)	Son los procesos del BPA con mayor cantidad de horas hombre hasta alcanzar el 80% de las horas de ejecución. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
cdda8b88-2a14-4ec8-9c22-c604902f4e0a	Hot keys	Al español puede traducirse como "teclas rápidas". ​ Combinación de teclas que permiten ejecutar la función deseada, sin tener que utilizar el menú. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bfe738d8-52f7-4203-80e2-7e822e96a31e	Hueso	Artículo Vigente que tiene inventario inicial y final durante el mes, sin ventas durante los últimos seis meses.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
dd05ae9e-44c4-4462-a1c3-4c4e6e9eeb4c	I.V.A atrapado	Pérdida de valor del crédito fiscal (IVA retenido) debido a la devaluación de la moneda local, cuando los estados financieros se valoran en una moneda más fuerte como el dólar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
1b02f54a-3080-458f-917e-8867e9ac48ac	I.V.A.	(Impuesto al Valor Agregado) Tributo que grava el valor añadido en cada etapa de la cadena de producción y comercialización de bienes y servicios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
df4a48c7-6607-49ba-92b0-cc80888f89cd	Icono	es un pequeño símbolo o imagen visual que se utiliza para representar una idea, un objeto, una acción o una función de manera rápida y universal. Los íconos son una forma de comunicación visual que trasciende el lenguaje, ya que su significado a menudo se comprende de manera intuitiva.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d178be34-dc5e-417b-9355-dfff06bc9dad	ID de recepción	Un identificador único para la creación del documento de recepción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
8e103754-fa34-4c18-b95d-e3b36c99e698	Identidad infografía	es una herramienta de comunicación visual que se usa para contar la historia o definir las características de un sujeto (marca, persona, concepto) de una manera gráfica, concisa y memorable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
351514bb-ad91-4433-a45b-09ef4806ab38	Identificación de ubicaciones	 Código alfanumérico para definir las ubicaciones dentro del almacén. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
33b0d33d-1b51-496e-ac29-ec438c397995	Implementación de políticas	El proceso de implementar las políticas de liderazgo de una organización directamente a través de los gerentes de línea e indirectamente a través de la integración y cooperación interfuncional.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
203ada12-595d-4ec1-a490-56e067a628d5	Impuesto Sobre la Renta (ISLR)	Tributo que se paga al Estado sobre las ganancias o enriquecimientos netos obtenidos durante un período fiscal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
db284fd6-6424-4de5-99fc-55244c2934b4	Impuestos	Pagos obligatorios al gobierno, calculados sobre ingresos, ganancias o transacciones, cuya correcta gestión es una función clave del área de Control.	Impuesto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-30 20:00:00+00
09bb93d1-4140-40de-bea1-d433fc900ae8	Inactivación de proveedores	Procedimiento de control para desactivar a un proveedor en el sistema, asegurando que no queden saldos pendientes y manteniendo la base de datos depurada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
70cc4c6a-ded1-4600-bb21-b4fbc77ec9c9	Inbound marketing	(también conocido como marketing de atracción) es una metodología que se enfoca en atraer clientes potenciales de manera no intrusiva, a través de la creación de contenido de valor y experiencias que son relevantes y útiles para ellos. A diferencia del Outbound Marketing,		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
5a49fe61-9a85-4275-b0a1-810483d9b6b1	Incidencia (en Picking RF)	Genera una alerta de picking, solicitando el motivo de la incidencia y la cantidad de unidades alistadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
15d36341-29fd-4011-8b3b-14e383c03861	Inclinarse	En inglés, este término significa literalmente que no contiene grasa; es decir, es magro. Aplicado al contexto de la gestión, se refiere a una estrategia que busca reducir o eliminar el exceso o el desperdicio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
279755b0-adca-4d04-9bca-279171c9df53	Inclusión	El proceso de agregar nuevos artículos y proveedores al sistema de información de la compañía, asegurando su calidad, consistencia y alineación con los objetivos estratégicos de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bbfc56b8-4711-43f6-bdb6-dc85366bb63a	Incoterms	International Comercial Terms, (términos internacionales de comercio), son un conjunto de reglas internacionales, regidos por la Cámara de Comercio Internacional, que determinan el alcance de las cláusulas comerciales incluidas en el contrato de compraventa internacional.	Incoterms	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:42:40.188+00
5537d68f-f723-4795-b794-019b29214bb0	Indicador	 Debe definirse al menos un (01) indicador por proceso y por actividad. Debe especificar qué miden, cuáles son las acciones que se toman en cada caso, quién es el responsable de obtener el indicador, quién(es) es el responsable(s) de ejecutar las acciones. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:37:26.956+00
2b8f81d5-b864-407b-b2fe-47d72ba61eb5	Inducción	Proceso de formación y acompañamiento inicial para nuevos colaboradores o aquellos que cambian de puesto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
43688de0-472a-47c5-90dc-000bb921d946	Infaltable	Producto que es fundamental tener disponible dentro de la oferta de la marca, independientemente de su volumen de ventas o su BDF. Es un producto que es clave para la estrategia comercial, porque es necesario para vender otros productos o porque el fabricante lo considera indispensable dentro de la marca.	INFALTABLE	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
39ffa8dc-bc6a-43c8-9ad8-f83bb074f39e	Información	Conjunto de datos organizados que tienen un significado útil, por ejemplo: “Ana tiene 23 años y vive en Costa Rica”.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d7b28b13-dfa7-4d24-b241-f5f64ccc0eed	Informe (report)	Documento digital con varias visualizaciones o gráficos sobre los datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bd49e79e-759d-4384-bb8c-b6a8501ae0aa	Informe de conciliación bancaria	Documento formal que presenta el resultado del proceso de conciliación bancaria, detallando las partidas conciliadas y las pendientes, y que requiere aprobación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
0f9999a0-a767-4cb7-843a-33ca0315fa13	Ingresados	Es un indicador de adquisición de talento que representa el número total de nuevos colaboradores que se han incorporado a la organización a través de todos los canales de reclutamiento (contrataciones externas, traslados internos de otras unidades de negocio, practicantes, etc.) durante un período específico de tiempo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
b1dcc2a3-0eb1-4556-85b5-4df90ee4dba3	Ingresos Mercantiles			\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
9b5b49ac-7ce2-4972-80a4-a4bae96bddbb	Ingresos Mercantiles %			\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
c7c1614b-37f0-468e-a4fb-98e014ffbc2b	Iniciativas	 Son proyectos específicos que buscan introducir innovaciones, cambios o mejoras en el funcionamiento de la compañía o lograr objetivos específicos. Éstas se generan del proceso de planificación estratégica. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
88a1d98a-44f0-45e9-901d-09560e1f0e88	Input comercial	Es el "override" o ajuste de juicio (comercial) sobre el estadístico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
ee16447a-4d2b-4aee-840d-c6af5e2114e8	Instrucciones	 Es un documento que contiene instrucciones detalladas que especifican exactamente qué pasos seguir para ejecutar algo específico. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
1065afc3-15cf-461c-8503-25408b9e1986	Instructivo	Documento que detalla paso a paso cómo ejecutar una tarea específica.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
395ce751-880c-4d3a-9da9-a8429c365304	Instrumento	Medio físico o digital; de carácter comercial, de identidad o comunicacional; que lleve la Imagen Corporativa de alguna Unidad de Negocio. Ejemplo: Tarjeta de Presentación. Lámina de Presentación. Uniforme. Un instrumento debe regirse por las leyes y legislaciones que puedan estar relacionadas a su uso en algún país.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
cbdef073-c753-47ac-a5f9-3369dd1cd7ed	Integración contable	El proceso de integración contable se basa en la relación entre los distintos módulos del sistema. De manera que, todas las transacciones generadas desde módulos auxiliares como Cuentas por Cobrar se reflejarán en la contabilidad de la compañía, la cual es manejada directamente por el módulo de Contabilidad General.	Integración Contable	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-03 10:46:09.068+00
464060a1-fe3f-40e9-ad13-da22dfefc73c	Inteligencia artificial (ia)	Tecnología que permite que las máquinas realicen tareas que normalmente requieren inteligencia humana, como reconocer imágenes o responder preguntas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
63b42134-bcc6-4b6b-8502-3136831c91cf	Intelix	Proveedor de tecnología responsable del desarrollo, integración y despliegue de la solución tecnológica del proyecto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fe4baef5-8a04-4b0a-8b90-2c7e0b57d5d1	Interacción con el cliente	Conjunto de actividades que se realizan al inicio del contacto con el cliente y que se ejecutan según la planificación de ventas		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
de73a61a-fcc0-481c-a899-30bb66710c76	Intereses	Silo Control: Costo financiero por el uso de dinero prestado, o el rendimiento generado por prestarlo.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-28 16:00:00+00
35937657-9640-4a2d-97b9-78eddf1137be	Intereses / Ganancia operativa	Ratio que indica la capacidad de la empresa para cubrir sus pagos de intereses con su ganancia operativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
43d8ae39-2d9b-4805-bd98-9e93acc5a2a8	Intereses sobre cesantías	En Colombia, compensación financiera que se paga anualmente al empleado sobre el valor acumulado de sus cesantías, como reconocimiento por el uso que hace la empresa de esos recursos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2b6079e7-9678-4cce-a2b3-38c8ebdab75e	Interés de mora	Tasa de interés que el proveedor cobra debido al vencimiento de los documentos por pagar generados en las transacciones de compra.	Interés Mora	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:42:42.747+00
5bd88f67-1138-4455-9c8f-78a370219935	Inventario	Silo Control: Representa el valor de las mercancías disponibles para la venta. La gestión de inventario busca equilibrar la disponibilidad del producto con el costo de mantenerlo. Silo Logística: Registro detallado de las existencias de productos en un almacén, incluyendo cantidades, ubicaciones y estado. Reporte SIM – Indicador Compra: Sumatoria de la Columna Inventario en moneda local o dólar dividido entre el número de meses consultados (Se tomarán en cuenta los inventarios al cierre de mes y el último inventario registrado para el mes actual).		fusionado	Fusionado a partir de 3 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-28 16:00:00+00
4831f25f-e9da-440e-9ad8-1327c41eeff6	Inventario de seguridad	Cantidad extra, en meses, de mercancía almacenada para protegerse contra fluctuaciones inesperadas en la demanda o retrasos de proveedores, evitando así rupturas de stock y mejorando la satisfacción del cliente. Se calcula considerando la variabilidad del tiempo de entrega y ventas, esencial para la continuidad operativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
de688085-12c9-4b3f-ae82-f7275c18c156	Inventario físico	Conteo real y físico de todos los artículos existentes en bodega.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
48e63bc3-0160-4113-ac4a-3c0e714062f3	Inventario inicial	Proceso para registrar el inventario en el sistema sin necesidad de documento de entrada, generando un ajuste de entrada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e9e1ea5d-1147-45aa-a489-f7d608b42bce	Inversiones	 Se considera inversión la adquisición de mobiliario o activo fijo para la empresa.	Inversión	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:42:44.92+00
51a513d6-9e4a-4af0-9fbe-17297c35d7cf	Isotipo	Se refiere a la parte icónica y de mayor jerarquía del Logotipo. El infinito se refiere a una cantidad sin límite ni fin.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
97758713-2d22-483f-b374-b500a5e13eeb	Iva atrapado	Suma de los montos de IVA (Impuesto al Valor Agregado) que la empresa ha pagado a sus proveedores, pero que aún no ha podido deducir del IVA que debe al fisco por sus propias ventas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
5a261a82-4c07-40f3-a368-ebd7a0b824b4	Jerarquía visual	es una herramienta de comunicación visual que se utiliza para contar la historia o definir las características de un sujeto (marca, persona, concepto) de una manera gráfica, concisa y memorable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
8c5d702e-287e-42f8-944c-65abf43a2fba	Justo a tiempo (JIT)	Justo a Tiempo es un sistema que impulsa las piezas a través de la producción según la demanda del cliente, en lugar de impulsarlas según la demanda proyectada. Esta técnica puede implementarse con la ayuda de diferentes herramientas Lean, como Flujo Continuo, Heijunka, Kanban, Trabajo Estandarizado y Tiempo Takt. Los resultados del Justo a Tiempo incluyen el equilibrio de la línea, el flujo de una sola pieza y un inventario de material excedente mínimo o nulo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
14d66810-5769-4b23-8e36-a47c46998b59	Kaizen	Término japonés que significa "cambio para mejorar". KAIZEN™ es un enfoque gradual y a largo plazo para lograr cambios pequeños e incrementales en los procesos con el fin de mejorar la eficiencia y la calidad. KAIZEN™ fue popularizado por Masaaki Imai en su libro "KAIZEN™: La clave del éxito competitivo de Japón".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
ae825b7a-ae33-4dfa-97cc-7a365f765878	Kamishibai	Kamishibai es una forma de contar historias originaria de Japón. Las tarjetas Kamishibai se utilizan, en el contexto empresarial, como control visual para realizar auditorías de procesos. El resultado de la verificación se muestra visualmente (verde/rojo).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
0a1cb318-40f3-4eed-8d45-0e85fc660063	Kanban	Una herramienta de planificación de necesidades de materiales en el sistema de producción y control de inventario "Just-in-Time" desarrollado por Toyota. Kanban se considera a menudo un elemento central de la fabricación eficiente y probablemente el tipo de sistema de señalización pull más utilizado. Kanban significa una señal visual (tarjeta Kan, señal Ban). Gracias al reabastecimiento automático (mediante tarjetas que indican cuándo se necesitan más productos), se regula el flujo de mercancías con proveedores externos, dentro de la fábrica y con los clientes. Este sistema se denomina "Kanban".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
5826d8cf-24e1-402d-8aeb-7be8424085f9	Kata	Kata significa rutina o patrón de comportamiento. El término Kata, en el ámbito KAIZEN™, se refiere a dos comportamientos: Kata de Mejora y Kata de Coaching. El Kata de Mejora es una metodología de cuatro pasos mediante la cual una organización mejora y se adapta. El Kata de Coaching es la rutina mediante la cual líderes y gerentes guían el proceso de mejora del Kata.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
31f89921-971d-4b2d-9908-1246fc37a810	Kit	Es un conjunto de artículos o herramientas necesarias para un propósito específico, generalmente incluye todo lo necesario para completar una tarea o actividad. Los kits son prácticos y están diseñados para proporcionar una solución integral, requieren embalaje y a nivel de facturación se refleja en una sola línea con un código único.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e5af349d-9220-4362-83f5-2d73b6850dbd	Kobetsu kaizen	La palabra Kobetsu proviene de Japón y significa "enfocado", y Kobetsu KAIZEN™ se refiere a un KAIZEN™ enfocado. Es una metodología estructurada de resolución de problemas que se utiliza para lograr diversos objetivos, como reducir defectos o errores, costos y plazos de entrega; aumentar la productividad o la seguridad en el puesto de trabajo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
33dcb9c9-d1c9-4e79-8dc4-f10db46538d3	KPI	Acrónimo en inglés de indicadores clave, los indicadores clave de un proceso o actividad determinada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
8448d68d-df03-489c-b2c7-c5b6180303d8	Lead	es una persona o una organización que ha mostrado interés en el producto o servicio de tu empresa. Es un contacto que, de alguna manera, ha interactuado con tu marca y, por lo tanto, tiene el potencial de convertirse en un cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
26dc13e4-d303-4add-8f9f-48a72c07a3dc	Lead Time	Tiempo total transcurrido en días, entre que se genera una orden y el inventario se encuentra disponible para la venta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e335e2d9-89b7-4b21-9a0b-a4b9153d7f9e	Legal	Área responsable de la gestión de asuntos legales de la compañía, incluyendo contratos, litigios y cumplimiento normativo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
9d2e0a88-9483-407e-b0d3-769c5c4e813e	Legibilidad	es la cualidad de un texto que permite al lector leerlo y comprenderlo con facilidad y rapidez. Es la facilidad con la que un lector puede distinguir las letras, las palabras y las oraciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
b73e829a-c2cb-4cc2-98bc-d5eb8b8cbc6a	Letra de cambio	Una letra de cambio es un documento que se genera cuando dos personas físicas o jurídicas se comprometen a tener relaciones financieras entre sí, de modo que una preste dinero o bien ofrezca bienes o servicios a crédito y la otra se comprometa formalmente a pagar por ellos en el período de tiempo establecido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fa8b47bf-43f9-4de0-9a25-eb8dbb4ce7aa	Libro de compra	Registro auxiliar obligatorio donde se asientan cronológicamente todas las facturas de compras de bienes y servicios, clave para el control de costos y la liquidación de IVA.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
784b061e-fb03-4696-91a5-5a6bd9b470ea	Libro de venta	Registro auxiliar obligatorio donde se asientan cronológicamente todas las facturas de venta emitidas, fundamental para el cálculo y declaración de impuestos como el IVA.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d9e8a4fd-2e2d-4f1f-8176-e65158f4e0c4	Libro diario	Registro contable principal donde se anotan todas las transacciones de la empresa en orden cronológico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
16641aa3-e9aa-4107-a58d-e23c0d423e3c	Libro mayor	Registro que agrupa y resume todas las transacciones por cuenta contable, mostrando el saldo de cada una y permitiendo el análisis de movimientos específicos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
72289b36-acf1-41f2-bfc8-27a30eefe0bd	Licencia	Permiso formal para usar, hacer o poseer algo (ej. licencia de software), cuya gestión es importante para el control de gastos y el cumplimiento legal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e7b33b6d-f3a2-4a16-ad91-f9d6fbcc4f11	Liquidación	Cálculo y pago de todos los conceptos adeudados al empleado al momento de la terminación del contrato de trabajo. Incluye salarios pendientes, vacaciones no disfrutadas, prima de servicios y, de aplicarse, indemnizaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:37:45.761+00
2be78423-f27e-460b-9e2d-b2dd402d8b71	Liquidación de prestaciones sociales	Cálculo del monto total adeudado al empleado por conceptos de beneficios acumulados según la ley del país (cesantías, antigüedad, etc.) al finalizar la relación laboral.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
ed49d15e-fefe-4656-9e7c-23b8e6a792e6	Lista de precio	Muestra las listas de precio creadas en la compañia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
93c2192e-5604-4318-b8f3-a44609ecb7af	Lista de precios	Listado de bienes o servicios emitido por un proveedor, que muestra, entre otras cosas, los precios correspondientes a cada bien o servicio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4fd1c2c8-5d42-459c-ab70-049cb844b243	Lista de precios - base	Es el catálogo de precios maestro que sirve como eje de cálculo para otras listas dependientes. Se caracteriza porque las actualizaciones de precios se realizan directamente sobre ella, afectando automáticamente a las listas que están vinculadas mediante factores o porcentajes.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
387c398e-e97f-4cce-a288-c6b215ffc0ee	Lista de precios - independiente	Es una lista única que se crea de forma autónoma para responder a criterios comerciales específicos o necesidades de un cliente/grupo particular. A diferencia de la lista base, las actualizaciones de precios se realizan de manera directa sobre ella, ya que no depende de cálculos o factores derivados de otra lista.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
7ded5450-52c3-4435-9212-ebfdbd68dc9a	Litigio	Disputa o controversia legal llevada ante un tribunal para su resolución.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d87efcbd-a496-4bd9-b624-190f0c9c8a92	Llave primaria	Atributo único y obligatorio que identifica unívocamente a un registro dentro de una tabla. Su función es evitar la duplicidad y permitir la vinculación precisa entre diferentes conjuntos de datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e3c041fb-ddb8-4088-8876-4961c91d0df0	LLM (large language model)	Modelo de IA entrenado con grandes cantidades de texto para generar y entender lenguaje humano (ej. ChatGPT).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
203ac07f-1298-4f6f-b771-3830027938cf	Localización	Ubicación dentro de la bodega, que permite localizar más fácilmente dónde se almacena cada artículo. Las localizaciones pueden ser áreas, estantes, niveles, etc.	Localización	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:38:01.502+00
9a81b99a-5128-4a90-8c7a-60aa64eec9c6	Lockers	Casilleros asignados a colaboradores para almacenamiento personal, sujetos a normas de uso y revisiones aleatorias.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f3ee3788-8cdb-4889-b7aa-c443228cc09b	Logotipo	es un símbolo gráfico o una marca tipográfica que se utiliza para identificar una empresa, producto, organización o marca. Es la piedra angular de la identidad visual de una marca, ya que es la primera impresión que muchos consumidores tienen de una empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
112199b3-1592-4657-96cb-d8d75b32ed20	Los menús de radio	 Pantallas de menú para los usuarios y poder escoger tareas a realizar. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
69f0079c-fc32-471f-83af-f1937b4688eb	Lote	Corresponde a una tanda particular de fabricación, identificada por un número, para controlar el momento en que fue producido, el período de cuarentena del artículo, la vida útil y la fecha de expiración del mismo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-05 13:38:51.75+00
25301206-6cc3-4a60-9330-6b05c6533ef8	Lote Múltiplo	En este campo se ingresa el multiplo de venta del artículo en el proveedor.	Lote Múltiplo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
835e7ca0-d43c-4f37-b34a-357c6e52e848	Límite de crédito	Se refiere al monto máximo de crédito que un cliente tiene disponible	Límite Crédito	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:38:06.574+00
9f66929e-9676-428b-873b-b7f387d2e987	Líneas de extracto bancario	Cada una de las transacciones (débitos o créditos) individuales que aparecen en un extracto bancario y que se cargan a Sage XRT para su conciliación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
42970bc1-953c-401b-8458-7d6d4fcdd594	Machine learning (aprendizaje automático)	Tipo de IA donde los sistemas “aprenden” de datos, como cuando Netflix recomienda películas según lo que viste.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
eb8430aa-22e6-4006-a2a0-b9912965c028	Macroproceso	 Es un conjunto de Procesos interrelacionados que gestiona el funcionamiento de una parte determinada del negocio. Representado por una caja en el BPA. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
00b39fc8-29bf-4a66-9a61-8307236c3139	Macroproceso de planificación	 Es un esfuerzo organizacional disciplinado y bien definido que apunta a definición de los planes estratégicos, operativos y presupuesto de una empresa, abarcando (según aplique) los niveles de empresa, de negocio, y funcionales, y asignando responsabilidades para su ejecución coordinada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
6fe03a4e-37dc-4582-8011-e1a950292c39	Macroprocesos prioritarios	 Macroprocesos ordenados por cantidad de horas hombre decreciente, que suman el 80% superior del total. Macroprocesos con riesgo a las personas,  legal, fiscal o que detienen la operación. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
654bc61b-5157-4e45-a7ec-d4497ea2778d	Macroprocesos relacionados	 Sirve para especificar aquellos macroprocesos que tienen relación alguna con el macroproceso desarrollado. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
16307ef0-ea94-4f0d-a55c-0ee9e70f650d	Madurez de procesos	 Escala establecida para definir la evolución de la madurez de procesos de una empresa. En la escala se establecen los pasos que deben ser completados para ir incrementando el valor del indicador.  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e7ac4ff5-2eff-45df-b1bb-a5bb3a794dcd	Magnitud Comercial	Valor numerico para unidad de medida comercial.	Magnitud Comercial	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
e73a283b-5905-41d2-917f-0678dbf7f1c3	Mantenimiento preventivo	Actividades planificadas para garantizar el funcionamiento óptimo y seguro de equipos e instalaciones		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
47a8ff3a-93d3-4198-bd64-390252f65f2a	Mantenimiento productivo total (TPM)	TPM es un enfoque holístico del mantenimiento que se centra en el mantenimiento proactivo y preventivo para maximizar el tiempo de funcionamiento de los equipos. TPM difumina la distinción entre mantenimiento y producción, poniendo un gran énfasis en capacitar a los operadores para que ayuden a mantener sus equipos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bbee356f-1dfd-4325-8e89-a33211b6fb40	Manual	 Es un documento que presenta un compendio de reglas y estándares a seguir para el cumplimiento de unos lineamientos o algo en particular. Señala el procedimiento a seguir para lograr el trabajo de cualquier grupo que desempeña responsabilidades específicas. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
25333962-747f-4cea-9408-90be09753796	Manual de marca	Es un documento fundamental que contiene las normas, reglas y directrices sobre cómo se debe aplicar la identidad visual y el mensaje de una marca.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
782c52a6-b200-4d2e-8b4f-ddc5d0bbce9a	Mapa de objetivos	 Es un gráfico (red) que define los objetivos de la empresa y las relaciones causales entre ellos, clasificados según cinco perspectivas básicas (BSC:  Balance Score Card). 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2f94faf2-f509-41d1-a9da-c587a607152b	Mapa de procesos	Representación gráfica de los procesos de una organización y sus interrelaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4274c2f7-47d5-428b-91dd-5eac64fb3b3c	Mapa de reconocimiento	 La información contenida en este mapa es una recopilación de información existente en la Compañía que permite conocer el marco de acción a fin de mantener alineados los procesos de acuerdo con la razón de ser de la compañía.  Esto incluye  Misión, Visión, Valores, Oferta de Productos y Servicios, Competencia, entre otros. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bf8583b8-c2b9-4d7b-ad36-8a20d0eb41cd	MAPE	Promedio de errores absolutos porcentuales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
45963a0d-d557-41da-91b4-383de61e01ed	Mapeo del flujo de valor	Se crea una imagen visual del estado actual o cómo fluyen los materiales y la información desde los proveedores, pasando por la fabricación, hasta el cliente. Se miden el plazo total de entrega, los tiempos de ciclo del proceso y los tiempos de valor añadido. El estado futuro se crea con base en los objetivos deseados, las condiciones del mercado y la planificación estratégica del negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
7893c509-a892-4e32-9f51-f083d41bb2a9	Moneda del documento	La divisa específica en la que se emite y registra una transacción o documento (ej. una factura en USD o EUR).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
31d1da51-22d1-4d81-9e5c-85d3f5ac8bb4	Maqueta	es un modelo a escala, un prototipo o una representación física o digital de un producto, una página web, un empaque o cualquier otro proyecto. Su propósito principal es visualizar una idea de forma tangible y permitir la exploración, la prueba y la comunicación antes de la producción final.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
199b6151-3a75-43c8-947a-de02a29f4159	Marca	Se refiere a la cartera de marcas que comercializa la compañía sin importar el proveedor.	MARCA	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
7cf192de-073b-4068-bd7a-e6a6cd6321f1	Marchamo	Etiqueta o sello que garantiza la integridad del producto durante su transporte o almacenamiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4da7aa52-cfe3-4e7d-a58d-079747d456ba	Margen	Indicador porcentual de la contribución sobre las ventas netas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	Margen con rebates	Silo Control: Es el margen de contribución después de considerar el efecto de los descuentos o bonificaciones (rebates) acordados con clientes o proveedores. Reporte SIM – Indicador Compra: Margen de contribución total sobre las ventas netas.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-28 16:00:00+00
890f7aac-83da-4cc7-ab4c-79ecbb5550be	Margen mínimo	Se refiere al valor mínimo de margen aceptado para el artículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
31cd216f-3518-4e41-ac26-aee854f78690	Margen neto	Indicador de rentabilidad final. Se calcula como (Utilidad Neta/Ventas Netas)×100. Muestra el porcentaje de cada dólar de venta que se convierte en ganancia neta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
43723a6d-1ef6-4986-a99a-f49c58ea9286	Margen total	Margen de beneficio final después de considerar todos los costos directos, rebates y otros descuentos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
dbacd453-681c-4caf-8e30-2842e4716473	Marketing de contenidos	La creación y distribución de contenido relevante (blogs, videos, podcasts, etc.) para atraer y retener a una audiencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f904ba40-0922-4faf-a71d-9bba5871b4c8	Material	El componente o sustancia principal de la que está hecho un artículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d263761c-c58f-4f3f-bc06-975d6bbe77d3	Materiales en proceso	Estos son materiales y componentes sobre los que se efectúa un trabajo o que se encuentran esperando en la fábrica entre una operación y otra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f9be7032-a9eb-40fd-b654-9f2b0ec7e09c	Materias primas	Materiales como acero, harina, madera, telas u otros utilizados para elaborar productos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fd462e1b-7149-4c8c-b067-5be132f2d700	Matriz de deuda financiera	Archivo o documento de control donde se registra y monitorea detalladamente toda la información de los préstamos y financiamientos de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e2a2c510-7926-45da-9705-9825fe03c89b	Matriz de documentación	Tabla que organiza los documentos por tipo, área, responsable y estado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e9ea663c-4239-414c-a2df-ed642742f22b	Matriz foda	 Es una matriz de doble entrada en la cual se incluye los resultados de los análisis  de Fortalezas, Debilidades (Escrutinio Interno), Oportunidades y Amenazas (Análisis Externo). 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e1ae85ad-7ac8-4a0a-8ddd-8c5df533867f	Mayorizar	Trasladar las transacciones contables del diario al mayor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
7387937d-40fc-4d3f-a6e3-0cbdc0a2cf5a	MCG	Mayoreo Compras Global		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
25685a44-42b0-49a4-809c-75f26ac4a670	Media estiba europea	Tipo de estiba que corresponde a la mitad del pallet europeo estándar (EUR/EPAL). Medidas: 80 × 60 cm. Nombre Internacional Oficial EPAL 6 / EPAL 7 / Display Pallet		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2deb8cbd-6a41-4f1d-abab-e114b60d1fc1	Medida (measure)	Cálculo que se hace sobre los datos, como suma de ventas, promedio de edad o porcentaje de crecimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
371e3521-83ea-4633-b1c7-7ee1cf9d28a4	Medio de pago	Muestra las herramienta o métodos de pago que utiliza la compañia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2dea99c8-8cde-4640-bcae-d8c1dc37509d	Medio de transporte	Cualquier vehículo (buque, aeronave, vagón ferroviario, etc.) utilizado para el transporte de personas o mercancías.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
6a437518-d809-4e64-b5b3-af9a40bd83e4	Mejora continua	Proceso sistemático y recurrente de evaluación y optimización de procedimientos, normas y sistemas para aumentar la eficiencia, seguridad y calidad de forma constante.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	Meta	Silo Control: Valor objetivo a alcanzar, que en un entorno de control y Kaizen, a menudo se define como cero errores u operación bajo condiciones óptimas. Reporte SIM – Indicador Venta: Es el monto a alcanzar de la venta neta asignado por vendedor. Sumatoria de la columna Meta en moneda local y dólar. venta del cliente activo de los últimos 6 meses * meta del vendedor.		dudoso	Se fusionó el concepto genérico de control/Kaizen (valor objetivo, cero errores) con la fórmula específica de meta de venta por vendedor. No se contradicen, pero también podrían tratarse como homónimos.	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:38:13.2+00
a2cdb2d1-66e2-4dcd-ac22-ca718ad28d5a	Metadatos	Información estructurada que describe el contenido, autoría y contexto de un documento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
965644de-d300-45b2-8ea1-6dc47580201a	Metodología de cambio	 Es herramienta que nos permita manejar el proceso de cambio y la gestión de Procesos de Negocio, de forma eficiente y ordenada. La metodología consta de 5 fases:  Alineación, Diseño, Construcción, Implementación y Adopción. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
16fe83b5-c5ec-4fd6-818a-fe9abc5d05a7	Milkrun	Un método de organización del transporte en ciclos estandarizados en el que un vehículo pasa por varios puntos de recogida/entrega con una frecuencia fija. Funciona como una línea de metro que cumple horarios fijos con frecuencias determinadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
72d300e0-f652-4f9d-820e-2b95e38f3e38	Miniatura	es una versión en tamaño reducido de una imagen, un video o un documento. Funciona como una vista previa que permite a los usuarios identificar rápidamente el contenido antes de hacer clic para verlo en su tamaño original.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fbebe421-180b-4c84-80d8-22c6f8d56d51	Mizusumashi (araña de agua)	Una persona que gestiona toda la logística de transportar componentes, materias primas, etc., en pequeñas cantidades a las estaciones de trabajo para minimizar los inventarios de productos en proceso. Esto permite ubicar las máquinas más cerca y evita que el operador tenga que interrumpir su ciclo, minimizando así los costos de transporte. Los operarios de agua suelen ser trabajadores con experiencia. Saben dónde se almacenan las piezas o materias primas necesarias y prestan servicio en varias estaciones de trabajo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
87e13e39-c07e-4d2e-8645-4382dd48cfe2	Mockup	es una representación visual realista de cómo se verá un producto o un diseño en su contexto final. No es el producto terminado, sino una vista previa de alta fidelidad que ayuda a visualizar y comunicar una idea de forma profesional.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
3c9d2c50-b8a2-4ae7-96ad-ce337ceed630	Modelado financiero mandatorio	Política de control que exige un análisis financiero riguroso (VPN, TIR) para todas las inversiones que superen un umbral definido, garantizando decisiones basadas en datos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
aa2c57fd-0f99-4dce-a4ab-21d9c5f3e3ad	Modelo de datos	Estructura que organiza cómo se relacionan las tablas y datos en un análisis.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fe681876-2a14-42db-ab19-e9007a827d22	Moneda alterna	Una segunda moneda utilizada en el sistema contable para registrar transacciones, permitiendo la reportería en diferentes divisas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
271d15fc-ba22-498c-977d-67e811ddd36b	Monitor de conciliaciones	Desarrollo a medida para monitorear el ciclo de vida de los recibos de cobro y anexos de depósito, desde su creación hasta su correcta aplicación en el ERP.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
c7c4c80d-d9cc-42d0-a68c-4fc28fee3d9c	Montos	Tipo de condición de pago en el que se definen manualmente los montos de cada pago.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
42bec33e-04aa-4189-affa-4ae279a9d522	Motoparte	Son todos aquellos componentes que forman parte del sistema de una motocicleta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	Movilidad (Personal)	Silo Personal: Cambio de puesto o área de un colaborador dentro de la organización, que puede ser horizontal (rotación) o vertical (ascenso o descenso). Reporte SIM – Dimensión Personal: Cambio de puesto o área de un colaborador dentro de la organización, que puede ser horizontal (rotación) o vertical (ascenso o descenso), de acuerdo al esquema establecido.		homonimo	Se separó de un término homónimo compartido con: Movilidad (Transporte).	t	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-28 16:05:00+00
11009e0a-52bf-480c-a628-0458e7da2c62	Movimientos bancarios en espera	En Sage XRT, se refiere a las líneas del extracto bancario que han sido cargadas y están pendientes de ser conciliadas contra un movimiento interno.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
6aa5c15c-e53c-4ee5-98b2-eefad8a4cebb	Movimientos en bancos	Son todos aquellos movimientos o transacciones dentro de la cuenta bancaria que el banco ha reportado		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
bd161ab5-aae9-4443-972a-96dcbfce8f30	Movimientos en libros	Son todos aquellos movimientos o transacciones dentro de la cuenta bancaria que se han registrado dentro de la empresa como parte de su funcionamiento cotidiano (información que se lleva en el módulo de Control Bancario de Softland).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
861d11ae-dea8-4d67-9da7-d909cdd2ddf7	Muda	Palabra japonesa para desperdicio y un concepto clave en el TPS como uno de los tres tipos (muda, Mura [irregularidad o desigualdad] y Muri [tensión]) de desviación de la asignación óptima de recursos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
404a017b-4132-4ab0-a337-bdda6cc4ba54	Muda walk	Un recorrido por el gemba para observar evidencia de lo que podrían ser diversos tipos de Muda. El objetivo de este recorrido es mostrar que el gemba está repleto de datos y oportunidades de mejora para quienes están entrenados para verlos. Los recorridos de muda no buscan generar oportunidades para culpar ni encontrar fallos. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
83483a13-3a30-4b27-a01a-5bf0f6466703	Muelle	Hace referencia a la asignación de la ubicación destino de la mercadería alistada para una orden de expedición.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
b6f1c6a8-f6f4-478d-b8c6-a97fa3b7d11f	Multimodal	Es la articulación entre diferentes modos de transporte, a fin de realizar más rápida y eficazmente las operaciones de trasbordo de materiales y mercancías.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
71289ec9-3d91-4db9-ac8d-4b9a5bd0d265	Multiplo de venta	Unidad de medida en la que se vende el artículo.	Múltiplo Venta	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-30 20:00:00+00
2fcd5605-ae7c-4cdd-a4a4-294d7ecc9fff	Método de actualización (inventario)	Define cómo se actualizará el inventario después del conteo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
0715f5b8-e3fa-4e94-90ad-8cb41cfa00da	Módulo de carga camión	Módulo del sistema eflow-WMS cuyo objetivo es certificar que se cargue lo que se alistó.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
972bc2a5-bf6d-476d-aecd-37dc0666b5f8	Módulo de Control de Inventario (CI)	Es el corazón de las actividades de manufactura del sistema, ya que integra todos los movimientos transaccionales relacionados con consumos, ventas, ingresos, etc.. Permite a la empresa registrar y controlar los movimientos de mercadería, tanto interna como de importaciones, y maneja la información que relaciona a cada proveedor con los artículos, para el establecimiento de puntos de re-orden y pedidos. Este módulo tiene como objetivo principal el manejo de los artículos y las acciones que se presenten sobre su desempeño.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
7edf53c0-a3c4-4cf4-98bb-0755765589e2	Módulo de expediciones	Módulo del sistema eflow-WMS cuyo objetivo es facilitar los procesos de ejecución relacionados con la preparación de pedidos y el despacho.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
3e6008f6-10e4-43d3-bd74-57bfdc32e638	Módulo de recepciones	Parte vital de la cadena de abastecimiento, ya que es el inicio del proceso de trazabilidad de mercadería en el almacén.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
fd7032c4-5deb-4858-9659-4cec34d24a38	Módulo de seguridad	Opción del sistema eflow WMS donde se administran todos los usuarios y los menús a utilizar según los permisos correspondientes al perfil de trabajo, permitiendo brindar o restringir accesibilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
a626dd44-5e92-474e-ba6e-3ad9fd54f28c	Módulo de toma física	Permite realizar conteos selectivos de forma versátil a un grupo específico o a la totalidad de los SKUs en inventario, con actualización en tiempo real.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d356850e-327c-4823-9960-448b8a2e838b	Módulo eflow-wms	Un módulo del sistema que describe una serie de procedimientos para realizar ajustes de inventario, facilitando la capacitación del usuario en cada proceso dentro del CEDI.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
c0abdd24-bed8-41a3-b9f3-e96380134084	N.I.T (número de identificación tributaria)	Código único asignado por la autoridad fiscal para identificar a cada contribuyente. Indispensable para toda documentación legal y fiscal.	Contribuyente (RIF/NIT)	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-30 19:30:00+00
fde6f994-cfe0-4443-8075-e213405cefe2	Naturaleza	Origen o la relación de la marca del producto con la empresa, refleja la clasificacion establecida por la compañia: Propia, exclusiva o distribuida.	NATURALEZA	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-09-25 13:37:33+00
2fde72d0-dc75-4481-b69d-a5fcbbaeff2c	Nicho de clientes	Refiere a un conjunto de clientes que se encuentran dentro de una combinación de Segmentos. Los nichos pueden ser usados para combinar estrategias, o realizar análisis comercial. Los nichos no están descritos específicamente, y su denominación queda a discreción de los usuarios de este documento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
f0ae4996-e7c7-4b4f-83f4-1ad4649d3192	Nivel	Muestra las jerarquías establecidas por la compañia que describen el puesto del colaborador dentro de la estructura organizacional (ej.: operativo, supervisor, gerencial, directivo).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
c55ef00b-3f17-4cbf-b531-534ae742aef2	Nivel de servicio	Es un indicador que mide la capacidad de una empresa para satisfacer las demandas de sus clientes. En términos más simples, es la probabilidad de que un cliente reciba el producto o servicio que necesita, en el momento que lo necesita y en la cantidad requerida.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
60ce0431-901f-4a94-bfc0-198872b4cfba	Nivel organizacional	Jerarquía o estrato que ocupa un puesto dentro de la estructura organizacional (ej: operativo, supervisor, gerencial, directivo).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
a8a5606e-c1ff-49a8-8908-00e2f11fe255	Niveles de la arquitectura de procesos	 Existen 3 niveles:  Comprensión, Evolución y Normalización. A) El nivel 1 de Comprensión donde se elabora el Mapa de Reconocimiento que será fuente de información para la elaboración del BPA. El BPA que nos permite tener una visión general de los procesos que operan en la empresa. B) El nivel 2 Evolución, inicia con el desarrollo de los macroprocesos al nivel de procesos o actividades. En este nivel se generan los cambios necesarios para la mejora continua de nuestros procesos. C) El nivel 3 Normalización, es el nivel donde desarrollamos a nivel de tarea nuestros macroprocesos, ya que en este nivel llegamos al máximo nivel de detalle de información donde se muestra quién hace qué en la operación. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
39ca2b0d-0cd1-43d4-919b-c762435ba5aa	NLP (procesamiento del lenguaje natural)	Tecnología que permite que las computadoras entiendan y respondan en lenguaje humano (ej. Siri, ChatGPT).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
a8e5ae9b-406d-42bb-8564-a5ada7dc9a29	No conformidad	Desviación respecto a un requisito establecido en el proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
a7bc28e1-ce3c-43d6-bda9-ac9ac6755124	No disponible para la venta (P2)	Determina que la mercancía no se ve disponible en los canales de venta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
db653250-a2c3-4d16-b1e2-5ae8d7ffa9bc	Nombre del asiento	Nombre o código identificador de cada asiento. ​ Este campo acepta caracteres alfanuméricos. ​ Debe ser un identificador único.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
d8cfc057-de09-4fe5-aa78-57295a011fac	Nombre del paquete	Es el nombre del paquete en uso en el que está ubicado un conjunto de asientos. ​ Normalmente está intrínsecamente relacionado con los tipos de asiento que contiene, a menos que esté orientado de cara al personal que lo opera. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
242cbf9f-1bdd-42ee-92ee-940e8f71a7a2	Norma	 Documento que permite describir lineamientos establecidos por la Organización, que se definen para el cumplimiento de todos los Colaboradores o de un área en particular, así como los pasos a seguir para cumplirlas. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
7c96bf44-a398-4491-aedc-a6979957f2ef	Normalización	Proceso de elaboración, edición y aplicación de normas que simplifican y estandarizan actividades.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
2d034385-53b2-42fc-a367-2c84c569f56d	Nota de crédito	Documento fiscal que reduce el saldo de un cliente. Se utiliza para anular facturas, registrar devoluciones de mercancía o aplicar descuentos post-facturación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
80e3e0cb-639b-40cc-9d1e-2e444c432819	Nota de crédito u otro crédito	Para el funcionamiento del módulo de Cuentas por Cobrar, una nota de crédito u otro crédito son documentos que se emiten para hacer constar que un cliente ha realizado un abono a su saldo pendiente.Al emitir una nota de crédito se da conocimiento del monto que la empresa va a deducir de la cuenta que el cliente tiene pendiente. Es por esta razón que las notas de crédito y los otros créditos disminuyen el activo de la empresa, dado que producen una reducción en las cuentas por cobrar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
97246305-5558-40a3-beaf-449a6f5bf995	Nota de débito	Documento fiscal que incrementa el saldo de un cliente, por ejemplo, para corregir un error en la facturación original o cobrar intereses de mora.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
b5c022be-79e2-48a1-9481-1ad712f8d00a	Nota de débito u otro débito	Para el funcionamiento del módulo de Cuentas por Cobrar, una nota de débito u otro débito son documentos que se emiten para hacer constar que un cliente le debe dinero a la empresa, por un monto determinado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
1deafde3-b641-4e85-937e-7445d4e5e646	Notificación de despido	Comunicación formal por escrito por parte del empleador al empleado, informando la decisión de terminar el contrato de trabajo. Debe ajustarse a los requisitos legales de cada país.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
4f916722-8b46-415f-91d5-4d8059827ef2	Nómina	Conjunto de procesos administrativos y financieros relacionados con el cálculo y pago de las remuneraciones, deducciones y aportes legales de los empleados.	Nómina	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	2026-10-02 01:42:45.952+00
dde95473-83f2-4a90-a193-4d5fb0627eec	Número de revisión	 La primera versión de un documento será identificada con el número 0. Luego las modificaciones que se realicen al mismo, serán registradas con el número correlativo siguiente. Ej. Rev.0, Rev. 1, Rev. 2. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
696217be-952c-497b-a2f7-5b5d3e6f48d8	Número decimal	Tipo de dato que representa valores numéricos con precisión decimal. Es el estándar obligatorio para montos financieros, precios, tasas de cambio y medidas de peso o volumen.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
df6334a2-732d-48fd-9569-eaa08ef78ed2	Número entero	Tipo de dato que representa valores numéricos sin componentes decimales, ya sean positivos o negativos. Se utiliza habitualmente para conteos de unidades, cantidades de artículos o IDs numéricos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
b63b0bc8-9132-4a92-9946-f68b470a0570	Objetivo	 Establecer criterios que definan el propósito general del proceso, actividad o tarea. Debe describir de manera clara el “Porque” y el “Que”, centrándose en aquellos aspectos que lo hace único, debe ser entendible por todos. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.632815+00	\N
8bbc8045-534a-444e-9182-b79740522f2e	Obsolescencia	Estado en el que un documento ya no es vigente ni aplicable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
a6e5ffa2-1375-4795-9d2b-5fdf3189c88f	OC	Orden de compra		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
51c67093-938d-466d-9304-d7a6e6feb924	OC por recibir	Silo Control: (Órdenes de Compra por Recibir) Se refiere a los productos que ya han sido ordenados a un proveedor pero que aún no han ingresado físicamente al inventario de la empresa. Reporte SIM – Indicador Compra: Cantidad de OC en tránsito más backorder que no han sido recibidas por el almacén.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
7c5be820-67eb-4cae-aee5-7472e456ef88	Ofrecimiento de productos	Conjunto de actividades para impulsar productos, que incluye la presentación de promociones y la revisión del historial de artículos del cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ff98363f-b080-4832-ad65-5acbd8653c52	OLA´s	 “Operation Level Agreement”. Acuerdo Interno de Servicio, es el acuerdo formal que se realiza entre dos partes internas de la compañía para definir la entrega de un servicio. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f2b5bfcd-0316-4d6b-86fd-3f14a9620a04	Omitir (en picking rf)	Ordena que la línea de picking se coloque al final de la secuencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
108089ed-9a8e-47ec-a36e-2c45a5d22242	Opciones de segmento	Posibles nombres o campos que se le puede asignar a un Segmento, en una determinada línea de negocio. Por ejemplo, en Ferretería, un Tipo de Negocio es una Ferretería General. Un cliente puede aplicar para varios Opciones de un Segmento, y aplicaría dentro de los Nichos que aplican en la combinación de Segmentos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5de2451a-e107-4a8a-9c5d-15d3773d2ee9	Orden de compra	Documento en el sistema que compromete a la empresa con un Tercero.	Orden Compra	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:42:47.074+00
49f88bfd-59f5-47c8-8e72-1915f0928a70	Orden de expedición	Documento generado por el ERP que indica los artículos y cantidades a preparar para despacho.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
cc94069a-a9be-49d9-928e-a14012570b62	Orden de recepción	Documento que registra la entrada de mercadería al CEDI.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
6d7749e5-0a6b-4319-94d9-76ee18e5bcd1	Orden de ruta	Indica si la ruta de picking es lineal, zigzag o por fragilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
3aecde29-0e10-4273-be74-4d633310b05a	Orden multinivel	Corresponde al orden en que se realizará el recorrido del almacenamiento, ya sea por nivel o por columna.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f75b11fd-6312-49cc-a239-bead1e8d4b2c	Orden mínima	Cantidad mínima de pedido que acepta un proveedor. En el sistema, la orden mínima se establece en la moneda local del proveedor.	Orden Mínima	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-25 13:37:33+00
8960252d-2284-47ee-ada3-0927cbbfeae6	Order plan streamline	Plan de compras generado por el software Streamline, basado en pronósticos de demanda, que se utiliza para estimar futuras salidas de efectivo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e1c09b09-15e6-4000-a408-449e0bdb429f	Organigrama	Representación gráfica de la estructura organizacional de la empresa, que muestra los cargos, las relaciones jerárquicas, las líneas de reporte y las dependencias funcionales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
18ee3b43-b6dc-46ee-a491-070865869011	Origen	Reporte SIM – Dimensión Compras: Muestra los países que represntan el origen de la compra de mercancía del proveedor. Reporte SIM – Filtro Logística: Permite filtrar por uno o mas países el origen de la compra de mercancía del proveedor.	ORIGEN	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
8c05d3c8-cea0-4537-9f9e-e76ffa96360a	Otro crédito	Documento interno que disminuye el saldo de una cuenta por cobrar (activo) para ajustar saldos a favor del cliente, sin ser un documento fiscal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f0f43978-c412-406e-b69a-510a48ada645	Outbound marketing	se refiere a cualquier estrategia en la que una empresa inicia el contacto y empuja su mensaje a una audiencia, sin que esta lo haya solicitado. La característica principal es que la comunicación va del negocio al consumidor, y no al revés.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8a70b61b-e229-4091-a499-90161c8ce90d	Overfitting / Underfitting	Problemas en el entrenamiento de modelos: cuando aprenden demasiado de los datos de prueba (overfitting) o aprenden muy poco (underfitting).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
98d51ccf-1c1c-47d7-91f4-f66a804a99f8	OyM (organización y métodos)	Área responsable de revisar, aprobar y divulgar normas dentro de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
09994c7c-0348-40fa-8c27-f54f62c411d5	Packaging	Es el proceso de diseñar y producir el envoltorio, la caja, la botella o cualquier otro contenedor de un producto. Es el punto de contacto final entre la marca y el cliente en el punto de venta, y su papel va mucho más allá de simplemente proteger el producto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d54144ed-a533-4b23-92a6-38d9deda8f61	Pago	Proceso de liquidación de una obligación financiera con un proveedor o acreedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
11dc59ef-9e86-4bbf-87ea-760049204bcd	Pago a proveedores	Proceso administrativo y financiero para saldar las deudas con proveedores por los bienes y servicios adquiridos, clave para la gestión de tesorería y relaciones comerciales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
2f6bb46b-7092-41ea-8d7b-7aa3fa38460f	Pagos urgentes	Pagos que se procesan fuera del ciclo normal debido a una necesidad crítica del negocio. Deben ser excepcionales, estar debidamente justificados y aprobados por una Firma Autorizada para mantener el control.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
390ee84b-8b44-4fb3-8197-3546465a4259	Palet	También conocido como pallet o tarima, es una plataforma rígida, generalmente de madera, plástico o metal, utilizada para apilar, almacenar, manipular y transportar mercancías de manera segura y eficiente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
dcb9d3dc-1214-4827-9d7f-921eb246c982	Palet multi-artículo	Tipo de contenedor que permite agrupar múltiples artículos en una sola unidad de almacenamiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
dea5968c-d713-4292-9eba-a388b98e84f4	Paletizado	 Cantidad de cajas que componen un pallet estándar. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9b60c14b-b38f-42d4-8ce1-9dbdc056001b	Pantone	es una empresa mundialmente reconocida por su sistema de correspondencia de colores. En lugar de ser solo un modelo de color (como RGB o CMYK), Pantone es un estándar de comunicación universal que asegura que un color sea consistente en cualquier parte del mundo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
0bdaac42-1ef4-4eb8-b348-0dc9715e234f	Paquete recurrente	Cuando un paquete es recurrente, no borra los asientos que contiene cuando realiza el cierre. ​ Esto es útil cuando los asientos ​ de un paquete no varían mucho de un período a otro y significa más trabajo volverlos a digitar que modificar los datos ya insertados. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
a7a934d3-7253-48a4-94bf-7022512dbf6e	Paquetes 	Los paquetes son unidades contables que contienen transacciones contables del mismo tipo o clasificación. El objetivo del uso de paquetes es agrupar todos los movimientos similares en una sola y única unidad mayor, de manera que se agilice su localización en el diario y su aplicación al mayor de la contabilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d8116351-4736-4aee-80b0-819dfa254343	Parámetro	Valor configurable que define el comportamiento de un módulo o proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8cde9fdc-429d-442a-b923-ac4f75a51d03	Parámetros del módulo	Valores que pueden ser cambiados, modificados o ajustados según la preferencia o necesidad del usuario para adaptar el sistema a sus requerimientos. Definen aspectos generales como el formato de las cifras decimales, métodos de costeo, texto de clasificaciones, costo de ingresos especiales, unidades de medida, conteos cíclicos y capas de costo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
0c9f2e0d-8e83-424b-abe0-66fd040bc404	Pasante	Estudiante que realiza prácticas profesionales en la empresa bajo un programa estructurado y supervisado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5977f266-55f9-415a-875a-46c8fef5a449	Pasantes	Representa el número total de personas que se encuentran realizando una práctica profesional o pasantía en la organización en un momento específico en el tiempo (una fecha de corte).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
490bb07f-79cd-4228-8732-eb6a7ba50e8b	Pasivos	Obligaciones presentes de la empresa, surgidas a raíz de sucesos pasados, para cuya cancelación la entidad espera desprenderse de recursos económicos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e878c4b4-5132-4c86-9917-d139b43cf6fb	Paso	 Es una acción realizada que expresa el mínimo nivel de ejecución. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ddd9b24f-dc91-41a2-8c8f-e6b4f85ca788	Pasos	 Escala establecida para medir la madurez.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
91af15b0-b2dd-46b0-a7e1-981961a6a1fe	Patente	Derecho exclusivo concedido sobre una invención, que constituye un activo intangible valioso para la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
29cf40f7-9b42-40b1-8fa5-8ab9443d333e	PDA	Se refiere a los dispositivos móviles o "Hand Helds" que utiliza el asesor para registrar pedidos y otras transacciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5e3ec8b9-177a-42d8-9570-ad4ae4c5e796	Pedido	El pedido es un documento que la empresa elabora a partir de una orden de compra emitida por un cliente en la que se solicita cierta cantidad de artículos.  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:42:50.746+00
2c5a6835-d961-45e0-92ef-b060f0e996fd	Pedido especial	Cualquier solicitud de producto que se encuentra fuera del surtido regular de la compañía, ya sea en términos de especificaciones especiales del producto, aplicabilidad, comercialización o cualquier otra característica, pero está disponible dentro del catálogo de productos que ofrecen nuestros proveedores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d9f609d5-c875-46ff-a4c3-9100aef8bb84	Pedidos	Documentos que reservan artículos para que no puedan ser utilizados en otras transacciones. Se crean a partir de las existencias disponibles en el inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
792c66a9-3bc1-4e55-b16d-b099540235a2	Perfil	Conjunto de permisos que definen las acciones que un usuario puede realizar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d382369a-d4b5-4b33-9e67-004ac51e13ef	Perfil (de recurso)	La capacidad física con la que contará el recurso. Incluye abreviatura, descripción, nivel máximo de almacenaje, nivel máximo de picking y capacidad de contenedores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
3e4a71ab-7ff3-4ec4-9143-ba1e5a0d7788	Perfil de trabajo	 Funciones que va a cumplir el operario dentro del CEDI. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9492d2f9-4000-49d7-9b35-09ebc099f4da	Perfil de usuario	Conjunto de permisos asignados a un usuario para acceder a funciones específicas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c6b7238f-029f-4145-86d4-d7107811e1c9	Perfil del cargo	Descripción detallada de las características, competencias, experiencia y formación requeridas para desempeñar un puesto de trabajo de manera exitosa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
6098d463-ba39-40f5-aacb-5c9801bed788	Redondeo	Factor del tiempo por el cual se redondearán las cantidades a la unidad siguiente si son mayores.	REDONDEO	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-25 13:37:33+00
986b8974-80ef-452e-ae2d-862982a7d39f	Periodo de recuperación	El tiempo necesario para que los flujos de efectivo de una inversión igualen el costo inicial de la misma. Es una medida simple del riesgo y la liquidez de un proyecto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
036915da-2710-4a83-9a3e-09dd5274f046	Permiso laboral	Autorización concedida al empleado para ausentarse de su trabajo por un tiempo determinado, con o sin goce de salario, por motivos personales, médicos o legales (licencia por luto, licencia por maternidad/paternidad, permisos remunerados).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
75c987e5-1a7f-453a-9ffc-5654139be6e8	Permisos	Autorizaciones que habilitan o restringen funciones dentro del sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
835c0200-8ead-4715-928c-fbf72662354b	Permisos por pantalla	Configuración que habilita o restringe botones específicos en cada módulo del sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
71423c1e-7ca0-4f62-8514-6eb4d763c82a	Peso visual	es un concepto fundamental que se refiere a la capacidad de un elemento (como una imagen, un texto o un color) para atraer la atención del espectador. Cuanto mayor sea el peso visual de un elemento, más prominente se sentirá y más rápidamente captará la mirada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f41365fd-b2d4-4dff-b09f-6838d8153817	Pestaña	 Es parte del documento BizAgi, representa otra página del documento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
20d3b8b8-4e37-4228-baa0-a849dd85a054	PI	Proforma		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
233c4fbb-ece8-457b-a91e-ba9b546a5cda	Picking	Proceso de selección y preparación de artículos desde su ubicación de almacenaje hasta el área de despacho.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
1859ef70-ee73-43d1-a5ee-f699a6ba44ff	Picking a piso	 Son tarimas que se encuentran en el primer nivel de alisto, y que se utilizan para el proceso de picking. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b06e4660-fb61-42fe-aa1a-eb30e3a2ba87	Picking automático	Asignación automática de tareas de picking a los recursos disponibles.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
79b71198-6665-4491-ba0c-a4e7d2045da7	Picking inverso	Proceso de devolución de artículos desde el muelle de expedición hacia zonas de almacenaje.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
94a0d616-c29c-4635-8f82-6ff0fe299de8	Piloto	Despliegue controlado de un sprint a un grupo representativo de usuarios reales, previo al despliegue masivo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
65f7cd76-eeca-43c6-8045-0fa03558bad3	Pixel	es la unidad más pequeña de una imagen digital.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
aefa1af2-63f9-42c9-97e4-ac2bcd84815a	Placa	Identificador del vehículo utilizado en el proceso de carga.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ddf37ba6-30c5-462b-b426-79017c99af5f	Plan (PE)	Valor meta establecido en el Plan Estratégico de la compañía, que sirve como guía a largo plazo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e94a32b6-4c21-4533-ba27-6a5070bf7e84	Plan de beneficios	Conjunto de compensaciones no salariales que ofrece la empresa para atraer, motivar y retener talento (seguro médico privado, planes de pensiones complementarios, bonos, vales de comida, etc.).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
50915e46-2856-4246-abd8-23c90dfdf613	Plan de Contribución	Valor esperado de contribución según lo establecido en el plan estratégico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
11f2ab29-cdf2-4190-895c-a73160f39156	Plan de control	 Documento donde se detallan las características del macroproceso (o tarea) y las reglas específicas para estas, así como el método de validación, las posibles fallas que se pueden presentar y las acciones a ser realizadas en caso de que éstas se presenten. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
921791b1-f03f-4ad1-bba2-519c2abafdfb	Plan de demanda	Conocido también como Final Forecast. Es el pronóstico resultante de enriquecer el pronóstico estadístico base con el input comercial (conocimiento del mercado, promociones, lanzamientos, proyectos, información de clientes). Representa la visión consensuada y única de la demanda que la organización adopta como plan oficial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5bc02c47-0033-43ec-8af0-ea6afd16b680	Plan de Margen	Valor esperado de Margen según lo establecido en el plan estratégico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
6e5763a4-1716-4b2c-9c0c-8a7dcad5d67b	Plan de Venta	Valor esperado de Venta según lo establecido en el plan estratégico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
20abed27-9706-46f4-9502-7f44d5a239ac	Plan estratégico	 Es el plan de evolución del negocio, donde están todos los planes para alcanzar los objetivos propuestos por la organización. De aquí salen las distintas iniciativas y proyectos. Estos planes tienen una vigencia que oscila entre 1 y 5 años (por lo general,  3 años).  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
892976eb-737d-49c6-a07e-7f2ab59704f7	Plan integrado de negocio (IBP)	Proceso de planificación que alinea las áreas de ventas, operaciones, cadena de suministro y finanzas bajo una "única versión de la verdad" para la toma de decisiones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
46e31a25-e525-4f6c-b9d5-f465a490826c	Plan operativo	 Los planes operativos tienen como sujeto a una función. Son planes a 1 año y están alineados con el plan estratégico a través de los objetivos establecidos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f54eb08d-8305-4ff3-ac86-f25beba1d1b5	Plan semestral	Presupuesto táctico ajustado periódicamente que sirve de puente entre el plan estratégico anual y la operación diaria del negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b92af578-7367-4854-8245-8d18ec973491	Planificación de la venta	La programación de actividades que se divide en periódica, diaria y de la llamada, donde se revisan documentos y se prepara la propuesta para el cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d5e805de-2f37-4da7-aa3c-0c5ec369481f	Planificación financiera	Área responsable de elaborar presupuestos, pronósticos y análisis para guiar la toma de decisiones estratégicas y operativas de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4b8d0a6f-f524-4094-973a-fd44743a0e41	Planificador de cobranza	Reporte que sirve de guía para planificar la gestión de cobranza, mostrando por rutas los documentos que están próximos a vencer en un rango de fecha		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ce8f8079-d4c8-4d6a-9cb0-f5922dc0da5b	Plantillas o modelos de transacciones contables	Formato que se le dará a un determinado transacción contable, debe estar asociado a un evento contable. Permite el manejo de operadores especiales y de la información contenida en las variables del evento de tal manera que automáticamente construye las cuentas y calcula los montos que van a los débitos y a los créditos de cada línea de la transacción contable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
234eaa50-306e-4e1e-bc07-cbd93a7795d9	Plaza	Se refiere a la cantidad de personas que pueden trabajar en un mismo puesto simultáneamente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
2fc70601-e38a-4677-8bac-7c402c89262c	PO	Purchase Order (en español: Orden de Compra)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f025e34f-775d-46df-91fa-bfd49786478e	Poder	Documento legal que autoriza a una persona a actuar en nombre de otra o de una empresa para actos específicos (firmar contratos, realizar trámites, etc.).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
7f652dbf-eef9-4666-b349-9fbbecdbd0c3	Política	Lineamientos generales que regulan el comportamiento y decisiones dentro de la organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e5d2c84c-7765-438b-bf70-763c919f9839	Política de garantía	Las condiciones establecidas por el proveedor para asegurar la calidad y el buen funcionamiento de un artículo, dentro de un período de tiempo específico, y que rigen las devoluciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ce66dbe5-ac3c-4e30-beb0-6d6e49bbe740	Porcentaje ajuste costo	Porcentaje para calcular el costo estimado para artículos de proveedores extranjeros. Este porcentaje se utiliza cuando no se conocen los costos y el artículo tiene que ser ingresado al inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d3b29032-77be-46ae-b1f8-ba95e0e516c8	Porcentaje descuento	Porcentaje por rebajar, igual para cada línea de la orden de compra. Es un descuento otorgado por el proveedor sobre la orden de compra en general.	Porcentaje Descuento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:38:22.819+00
901f1993-b3d4-4dd5-9e9f-4a3676f291b1	Portafolio	Agrupación de marcas que permite a los equipos comerciales y de ventas dedicarse exclusivamente a un grupo de marcas, asegurando una vista integral de punta a punta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
258bae8a-8418-4832-afce-a0db718a40f1	Portafolio de trabajo	Es una colección organizada y seleccionada de los mejores trabajos de un individuo o una empresa. Sirve como una herramienta de presentación para demostrar habilidades, experiencia y estilo a clientes potenciales, empleadores o colaboradores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8af6f8c4-3e71-4565-b805-fd8250f85ce7	Portal de imprenta digital	Plataforma web donde se almacenan y pueden ser consultados todos los documentos fiscales electrónicos emitidos por la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
2b30f754-dbb1-4601-8407-735ee6fccf41	Portal de pedidos			\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
25d5af81-0ca8-46c7-ba3e-a35c8fdaeadf	Portal web bancario	Plataforma en línea proporcionada por un banco para que los clientes realicen transacciones, consultas y gestionen sus productos financieros.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ac01395e-3f1c-4634-bbc6-44c075364150	Power query	Herramienta de Power BI para transformar y limpiar datos antes de analizarlos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ef01f19a-acd1-4dda-82e8-7f6202a2fcb4	PPP	Es una medida de la densidad de píxeles en una imagen digital y se utiliza principalmente para pantallas y monitores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
84b26c9e-33c2-40d0-a96a-95c36d305be0	PPTO	Abreviatura de Presupuesto. Se refiere al valor original estimado o asignado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
da6cec11-13bb-433c-84c9-2d0e8cb09888	Preaviso	Notificación anticipada que debe dar cualquiera de las partes (empleador o empleado) para poner fin al contrato de trabajo. El tiempo de antelación requerido está estipulado en la ley laboral de cada país.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9436162f-6019-49ec-bb6a-1a6029b6f74d	Precio	El valor monetario de adquisición de un producto o servicio ofrecido por un proveedor. También se le llama "precio de compra".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
a42ddfad-fb07-48df-88e7-faba85b0c70a	Precio base	El valor monetario estándar que ofrece el proveedor en sus productos o servicios a todos sus clientes, sin ningún tipo de descuento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
afb51585-cd15-4862-8833-cfb1b344cd99	Precio de Venta	Este es un indicador clave que te dice a qué precio se están vendiendo tus productos o servicios en promedio, una vez que se han considerado todos los descuentos y promociones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
2df671f7-3fc9-4f77-835e-84be0d0d4572	Precio de venta mayoreo	Es el precio de venta base definido para un producto y constituye el punto de partida para la fijación de los precios de los clientes.\nEl precio de venta mayoreo debe establecerse por encima del costo del producto, evitando márgenes negativos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8ddae5b8-16f6-49f7-9d6b-8f6798f51198	Precio del Cliente - "Su Precio"	Es el precio final al que accede cada cliente después de aplicar el descuento correspondiente sobre el Precio de Venta Mayoreo.\nDicho descuento es exclusivo para cada cliente y se determina mediante variables comerciales previamente definidas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
da33c177-78c4-4d04-af93-5017004e20dc	Precio neto	El resultado de aplicar todos los descuentos ofrecidos por el proveedor al precio base de un producto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8d0eeb71-6dad-49e8-b020-902b457ce577	Presupuesto	Estimación financiera detallada de los ingresos y gastos esperados durante un período de tiempo futuro. Es una herramienta clave de planificación y control.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
226eaebb-f428-4198-aaf3-9914bebf0e55	Presupuesto bruto	Sumatoria de la Columna Presupuesto de venta bruta en moneda local o dólar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ba7f2ed3-abda-44b8-ab5b-1b472fb12f51	Presupuesto Cartera	Valor presupuestado de deuda por cobrar		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
deec0cae-a38c-4451-ab2f-ab82a7129c46	Presupuesto Compras	Monto total de la mercancía que la empresa planea adquirir en un período determinado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
0eab8f58-43a4-4376-bef7-f9bfcc639dd4	Presupuesto Cuentas por pagar	Monto total de las deudas que la empresa espera tener con sus proveedores.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5c5f9972-a390-463b-8850-bb7fcbbc18c0	Presupuesto de contribución	Sumatoria de la utilidad.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9f1d620b-e587-4e46-9acf-0754059a5292	Presupuesto de inventario	Presupuesto de inventario mensual necesario para alcanzar un Retorno de la Inversión (ROI) en Margen Bruto (GMROI) deseado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
081f7bc8-03b3-453a-951b-ecacd1ef9953	Presupuesto neto	Sumatoria de la Columna Presupuesto de venta neta en moneda local o dólar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c450cf42-b50a-4a10-9ee1-9ff113dc49da	Pricing	se refiere a la estrategia que utiliza una empresa para determinar el precio de sus productos o servicios. Es un proceso crucial que va más allá de simplemente cubrir los costos, ya que busca maximizar la rentabilidad y el valor percibido por el cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d4228403-55e0-49bd-b5a0-9cc9a46fbfe6	Prima de servicios	Prestación social en Colombia equivalente a un salario mensual por año, pagadera en dos mitades (semestres). En Venezuela existe una figura similar llamada "Bono Vacacional" que, aunque asociado a las vacaciones, cumple una función de ingreso adicional.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4377ac19-c199-4c27-8706-0e977da947dd	Principal	Monto de la deuda incurrida por el cliente sin tomar en cuenta los intereses		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9a7a3645-cbad-427e-ad31-06477e2dfcec	Prioridad	Otorga un ordenamiento a la atención de acciones en eflow WMS.	Prioridad	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:42:55.941+00
6345a403-0755-4cd6-8206-fe3eff78cd7a	Prioridad de atención de la orden	Un dato utilizado como referencia para el manejo operativo y la priorización de tareas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
81d7239a-95e7-4647-acfe-deceef2d5b41	PROB (Problema)	Tareas relacionadas con una orden de expedición con faltante de inventario, creadas pero en situación de PROB para no ser atendidas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
823103f1-1745-4683-802f-ab9e5d964bf1	Procedimiento	Secuencia de pasos detallados que indican cómo ejecutar un proceso, incluyendo responsables y acciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
adcd2c9b-76ba-4703-bd32-f336fd99df42	Procedimiento de pagos por TXT	Método para ejecutar pagos masivos mediante la carga de un archivo de texto plano (.txt) en la plataforma del banco, optimizando el proceso de pagos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
be05b4d1-6db7-47f9-8714-dcd59c624eeb	Proceso	 Es un conjunto de tareas que tienen una secuencia lógica que toman una o más entradas y generan un producto o servicio. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8d892886-55c2-443c-8b87-787063d15f27	Proceso central	Actividad clave o conjunto de actividades que deben realizarse de manera ejemplar para garantizar la competitividad continua de una empresa porque agrega valor primario a un producto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
1dd259c1-1b5e-4306-a490-6486171b6f46	Proceso de diferencial cambiario	Rutina ejecutada en el ERP para calcular, reconocer y contabilizar las ganancias o pérdidas por diferencias en el tipo de cambio de documentos en moneda extranjera.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
1720286e-7d16-4b09-810c-8784cd1047c6	Proceso embebido	 Funcionalidad de BizAgi. Los procesos embebidos son aquellos que comparten la misma información o datos del proceso padre. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
92b4d2c0-f5d9-49a2-b604-fcf7136d887d	Proceso en RF (toma física)	Pasos para ejecutar una toma física usando el menú de inventario en la Terminal de Radio Frecuencia (HH).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4ac7e0b1-80e6-400a-b17a-b9b15c9f3324	Proceso reusable	 1. Se consideran procesos reusables aquellos macroprocesos del BPA que son comunes entre la “Cadena de Valor” y “Soporte. Para estos casos, se define que estos procesos serán diagramados en la “Cadena de Valor” y reutilizados en la parte de “Soporte”. 2. Funcionalidad disponible en Bizagi que indica que el proceso contiene un conjunto de actividades que son independientes del proceso padre, el cual es el proceso que los llama.  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
baeaf1a8-e7b9-442a-aa98-51213fb260d3	Producto regular	Se refiere a un grupo de artículos que se les da entrada como un sólo SKU, almacenados en una misma ubicación y se factura con un sólo código. Se origina cuando un Kit se mantiene en el tiempo y deja de cumplir una función promocional.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b148b208-f81c-4d84-a406-772df7c1a4a6	Productos terminados	Estos son artículos terminados que se tienen en inventario y que se encuentran listos para ser embarcados a un cliente de acuerdo a un pedido en una planta de producción. En todos estos tipos de inventario participan artículos, los cuales se encuentran en distintos estados como se mencionó anteriormente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
18c70a89-ccfd-44f8-800a-68e6efb4de2e	Promedio pedido diario	Esta fórmula calcula el promedio de pedidos que se crean cada día laboral en un período específico. Es un indicador clave de la actividad comercial y la demanda diaria que enfrenta la compañía		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
eea4d50d-c417-45cb-9608-b794a894828b	Promoción	Reconocimiento al desempeño o antigüedad que puede incluir un aumento de responsabilidades, remuneración o ambos, no necesariamente implica un cambio de nivel jerárquico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ac1e9498-95d1-4a64-ad47-468f0acaa2ca	Promoción Asociativa	Se pueden asociar las premisas generales a un grupo de artículos de diferentes marcas, donde se cumplan las premisas entre todos los artículos asociados a esta promoción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
af0b7cbf-4e2d-4290-a10a-7180f2dcbbda	Promoción Liquidación	Son promociones donde se otorga un descuento adicional a aquellos artículos que ya no formarán parte del inventario para la venta.		sinetiqueta	Esta fila no tenía Etiqueta Principal en el archivo original y no es duplicado de nada; no se pudo inferir con confianza el silo correcto.	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
7bfd0f30-eee9-4125-b447-166f6aaf0c38	Promoción Volumen	Son promociones basadas en descuentos por volumen de compra definidos por montos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e53f8a1b-b42b-4b8f-a84f-58fd53b52182	Pronóstico con restricciones	Es el pronóstico "aterrizado" a la realidad de la empresa. Es el volumen que la compañía realmente puede servir dadas sus limitaciones de dinero, espacio o suministro.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9642531c-1e0f-4ea3-a147-f1bc89b39439	Pronóstico de demanda	Estimación futura del volumen de productos requeridos, basada en datos históricos y factores externos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
f0aff911-b4f9-47c2-873c-035682feeecb	Pronóstico estadístico base	Es el pronóstico generado automáticamente por un modelo matemático, a partir únicamente del comportamiento histórico de la demanda, sin intervención humana ni juicio comercial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
7f536a81-9d75-40ea-91b7-26d091667c72	Pronóstico sin restricciones	Representa la demanda "pura" del mercado, lo que el cliente querría comprar si no hubiera límites de inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
0144ff95-5a0f-4b35-ace6-95f4a60c53ef	Propiedad	Es un atributo o característica específica que describe a un cliente o a su comportamiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
1200e264-b71d-4962-952f-5681923cd536	Proporción	es la relación de tamaño entre dos o más elementos de una composición. Se trata de cómo los elementos se comparan entre sí en términos de tamaño, cantidad o grado. La proporción es un principio fundamental que los diseñadores usan para crear armonía, equilibrio y un sentido de orden en cualquier pieza visual, desde un logo hasta una página web.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
77c1b8c0-e952-4be8-9a5e-df4406d82fda	Propuesta de valor	La promesa que una empresa le hace a su cliente de entregarle un beneficio o una experiencia única.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
744ffabb-c047-4cf7-887f-6c9cc236af9b	Prospección	Una actividad cuyo objetivo es validar si un prospecto cumple con un perfil determinado para convertirse en un cliente potencial.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
467f3301-3710-44df-9a0b-1c90e765ca83	Proveedor activo	Cartera de proveedores activos de la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
36ed4900-51da-475d-a7d2-d198403bc654	Proveedor Administrativo	Persona o empresa que suministra los bienes o servicios necesarios para el proceso productivo de otra empresa, o las mercancías que esta necesita para su actividad comercial. Es el proveedor que factura y se utiliza en la gestión administrativa, campo legal con NIT y nombre de registro.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e09bc304-5146-49ae-b1ea-0952da8a029e	Proveedor agrupación	Corresponde al proveedor con el que se mantiene la relación comercial y que aglomera los vehículos de facturación asociados a él.	Proveedor Agrupación	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-25 13:37:33+00
55368c1b-e83d-482b-bafa-72b3cff511e8	Proveedor Dummy	Registro genérico y temporal de proveedor en el ERP utilizado para presupuestar, planificar compras o registrar transacciones iniciales cuando la entidad proveedora real aún no ha sido identificada o registrada formalmente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
6d5cd030-7c15-45d7-8d1b-80f8d895a426	Proyecciones de flujo de caja	Estimación futura de las entradas y salidas de efectivo. Es una herramienta estratégica clave para anticipar necesidades de liquidez, planificar inversiones y gestionar la capacidad de pago.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
87592ff3-0d8b-4ad9-87a4-1f42b9a3da40	Proyección (proy)	Estimación ajustada periódicamente sobre un valor presupuestado, que refleja la expectativa más actualizada de lo que se espera alcanzar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
a09f322a-f2c3-4137-b193-eaa0e576916f	Prueba psicotécnica	Herramienta utilizada en selección de personal para evaluar habilidades cognitivas, aptitudes y rasgos de personalidad de los candidatos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4532da78-69ef-4289-807d-609516b22731	Publicación	Distribución oficial de un documento para su uso operativo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
cb7cca2b-6e5b-4a35-9497-ce87658167cb	Puesto	Ocupación del empleado en la compañía, según los puestos definidos por la estructura organizacional de la misma.	Puesto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:42:58.244+00
9dc598ef-a55a-496c-b049-a86e36f4f52e	Puesto de apartado	Ubicación en el almacén para un ítem en específico. Cada ubicación debe indicar: pasillo, rack y puesto. Estos puestos contienen mercancía fuera de su empaque original.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4bdc6792-b55c-4165-a7f7-89fe61e447b7	Puesto de aéreo	Puesto dentro del almacén para un ítem en específico que comprende una paleta completa. Los aéreos contienen empaques originales y están identificados con un “hablador”. Su ubicación indica pasillo, rack y puesto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
ab6c42a9-8545-4a2e-bb42-2a105858181d	Punto de re-orden	Se refiere al nivel de existencias en el que se hace un nuevo pedido al proveedor. Siempre será mayor al nivel de existencia mínima y debe considerar los consumos durante el período de reabastecimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
a4224f06-5e35-4311-ae5b-2b477e76dc93	Purga de datos	Proceso en que se eliminan todos los datos almacenados hasta cierta fecha límite. Este proceso no es reversible.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c05854b8-9a22-4eca-8371-e34c8494e1e4	Referencia	Detalle o descripción de un movimiento contable. En la generación de asientos la referencia corresponde a la aplicación definida al documento		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9a0bf99c-ca66-4fd6-87ae-9816c514bf31	Push money	es una estrategia de promoción de ventas en la que un fabricante o distribuidor le paga una comisión o incentivo económico directamente al personal de ventas de un minorista. El objetivo es motivar a estos vendedores a hacer un esfuerzo adicional para "empujar" la venta de un producto o línea de productos en particular.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9fe9a4e9-e215-481d-960e-5ec085093f0a	QDC	El concepto de QCD (Calidad, Costo, Entrega) se enfatiza principalmente en proporcionar productos y servicios a los clientes con mejor calidad, precios asequibles y a tiempo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e9c7000f-334e-47ec-ae95-efb5db0a2865	Rama de negocio	Clasificación de una compañía de Mayoreo dependiendo del tipo de mercancía que comercializa. Dentro de los presentes se encuentre Ferretería, Autopartes y Quincallería. Corporativo representa la división que brinda soporte de este tipo a las áreas comerciales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c61e584b-547e-412b-b8b7-6d16798c6be5	Ranking	Reporte SIM – Dimensión Compras: Muestra la clasificacion de los artículos del surtido regular segun la categoría de colores: “Verde”, “Amarillo”, “Naranja” y “Rojo”. Estas categorías reflejan el comportamiento de los artículos en los últimos doce meses, basándose en tres indicadores específicos: contribución, clientes activados y rotación de inventario. Reporte SIM – Dimensión Ventas: Es una clasificación ordenada de elementos (como personas, productos o empresas) basada en un criterio o métrica específica. Es una herramienta para comparar y evaluar el rendimiento o la importancia de algo dentro de un grupo.		dudoso	Compras usa una metodología propia (semáforo de colores según contribución, clientes activados y rotación); Ventas tiene una definición genérica de “ranking”. Se asumió que Ventas usa el concepto general y Compras una implementación específica.	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
176e36a4-47b6-4707-9632-46b7039999eb	Razón social	Nombre oficial y legal bajo el cual una persona natural o jurídica es constituida y registrada ante las autoridades competente.	Nombre / Razón Social	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-30 19:30:00+00
1cd929b3-9d98-4feb-93fc-3c48ba0e1064	Reabastecimiento	Lapso que tarda el proveedor en hacer llegar el pedido al cliente desde la emisión de la orden de compra hasta la recepción de la mercadería. Se debe definir en días.	Reabastecimiento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-25 13:37:33+00
d52be40b-6939-41d4-a93f-c52027dcfc9f	Rebate global	Silo Control: Descuento o bonificación que un proveedor otorga retroactivamente por alcanzar un volumen de compra determinado durante un período. Reporte SIM – Indicador Control: Suma total de los descuentos recibidos por las comercializadoras.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
01cb4769-1e28-4b69-bac9-5d4dc6a3fb14	Rebate Global %	Ratio que muestra el porcentaje del rebate global con respecto al monto total facturado por las comercializadoras		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
3454d6a4-19e8-4e78-a931-0360242538f8	Recaudación	Suma total de los ingresos en efectivo recibidos por la compañía		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
35fb9800-845b-4c24-8310-0b9411fb5f3a	Recepción	Eprac: Proceso de recibo de artículos en el CEDI, ya sea por primera vez o reintegrados por una razón comercial. Silo Logística: Proceso de ingreso de mercancías al CEDI, incluye descarga, revisión documental y registro en el WMS.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
22456395-ad0c-4d83-aa88-b1c7492345d7	Recepción (en RF)	La segunda pantalla utilizada en la Terminal de Radio Frecuencia para el ingreso de mercadería.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
bb44a91e-dadd-44b7-8401-73418178db4f	Recibo	El recibo es un documento que se emite para constar que se recibió dinero en efectivo del cliente, para abonar o cancelar el monto que adeuda a la empresa.Este documento disminuye la cuenta por cobrar, de manera que se produce un pago a un monto por cobrar pendiente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c9a9cce0-396e-45cc-a045-5ca431e6f434	Recibo de cobro	Documento que evidencia la recepción de un pago por parte de un cliente, detallando el monto y las facturas que se están cancelando.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
00692473-839e-4b7f-9a60-6fd43a9da966	Recibo de nomina	Documento que detalla el desglose del salario devengado, las deducciones aplicadas y el neto a pagar a cada empleado en un período determinado. Sinónimo de "Recibo de Nómina" o "Desprendible de Pago".		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
7dbf5121-e23c-4ef4-bf7a-73ae3f86a874	Recibos de cobranza	Un submenú en el Módulo de Cobranzas que permite crear, imprimir y gestionar los recibos de cobro de un cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
0e1f5bb6-1624-439d-9a5a-35bc0ed5475f	Reclamo	Solicitud formal ante discrepancias en la recepción (faltantes, exceso, daño).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
2319cfea-0ab5-45c1-8434-dda2ebf87a2c	Reclamo por error en el despacho	El producto y las cantidades facturadas son iguales a las solicitadas por el cliente, pero físicamente hubo un error de código.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
5941f130-5946-4ec3-b30f-44e4f9e60fde	Reclamo por error en el precio facturado	En la factura se evidencia un precio distinto al ofrecido al cliente por parte del vendedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d0a56bd5-b31d-4c67-8af0-4848d7f79712	Reclamo por error en pedido	Pedido mal ingresado por el vendedor (error de código, error de precio y sobrantes facturados)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
3d541bab-2998-4367-9137-e10f2b0d6c70	Reclamo por producto dañado	El producto llegó en mal estado o hay evidencias de un daño físico. No incluye problemas en el funcionamiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
928c744e-d4e4-4591-ab1a-570dccf32e11	Reclamo por sobrantes no facturados	El cliente recibe artículos adicionales no indicados en la factura.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4fa16655-4c81-41dd-bd5d-f4810f5784bd	Reclutamiento	Conjunto de actividades para atraer candidatos potencialmente calificados para ocupar una vacante dentro de la organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8e4fa96c-0888-4ea2-8902-182bca746aa8	Reconocimiento por años de servicio	Mecanismo mediante el cual la empresa reconoce la antigüedad de sus colaboradores (ej: 5, 10, 15 años).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
7438ba06-a922-4565-8c5e-c4cbca49ec64	Reconteo	Conteo sucesivo al segundo conteo de artículos. El segundo y primer conteo se comparan para validar que no existan diferencias, si no hay diferencias entre A y B, pero si hay diferencias con Teórico, el Coordinador de Control de Inventario toma la decisión de crear un Ticket de Auditoría. En caso de haber diferencias entre A y B se realiza el conteo de Libro de control (3er Conteo).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8adc218b-6062-4456-9fe2-c9a985f17ba5	Recurso	Equipo físico o rol operativo (ej. montacargas, alistador) vinculado a tareas en el sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
49faca4e-b4db-4d41-9309-423271211bc2	Recíproco	Dos artículos son alternos mutuamente, se pueden sustituir entre ambos, en las dos direcciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4a6412f7-0ab0-4c58-9821-699e6d7b1c09	Red neuronal artificial (RNA)	Modelo matemático inspirado en el cerebro humano que ayuda a que las máquinas aprendan y reconozcan patrones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
c001a96c-bbdb-44d9-9c6d-e43a43f7c2d6	Redención	Aplicación efectiva de una promoción sobre un pedido o línea; representa el uso o "consumo" del beneficio por parte del cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b28a7bdd-47ee-4106-84ae-5942aaccbef9	Redes	Infraestructura que conecta computadoras y dispositivos entre sí para que compartan información (ej. la red de la oficina o internet).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e4cdd2e6-d91a-4d2d-9a79-e4af1629256c	Redes sociales	plataformas digitales que permiten la creación de perfiles, la interacción entre usuarios y la difusión de contenido en línea.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
26c8a648-0585-4aec-aaf2-613af8509951	Referencia del artículo	Un identificador único asignado a un artículo para su seguimiento y gestión en el sistema de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
61ea4579-714b-4024-9ced-6e9fcc0831d2	Regalía	Es un artículo o muestra gratis que la empresa entrega a sus clientes como obsequio		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
4c38ff86-f09a-43e8-87b1-f8f9ee15cb4c	Registros	 Formatos y /o Reportes que evidencian que el proceso documentado se ha ejecutado. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	Región	Silo Ventas / Reporte SIM – Dimensión Ventas: Porción del país que agrupa un conjunto de coordinaciones geográficamente cercanas que componen el territorio de ventas. Reporte SIM – Filtro Venta: Ubicación geográfica del cliente.	Región de Venta / Region	fusionado	Fusionado a partir de 3 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-30 19:30:00+00
f8a49357-efff-46c6-9346-c7431c2d0f7d	Regla de cálculo	Declaración formal que define o restringe un aspecto del negocio y que se traduce en una lógica de cálculo o filtro dentro de un tablero(ej. la metodología para el cálculo del margen operativo bruto).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
9100ddb7-e768-4573-a44e-987717f03a83	Regla del ochenta y veinte	Se refiere al principio de Pareto que establece que para muchos eventos aproximadamente el 80% de los efectos provienen del 20% de las causas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
fb470077-1ba9-436e-a827-a572bd4fa557	Reglas	 Todos aquellos patrones, normas, estándares, especificaciones u otros documentos que le soportan y/o complementan. Debe describir las condiciones específicas para que la tarea se pueda llevar a cabo. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e061750b-071a-4041-a239-60f01f2aa900	Reglas del cargo y abono	Las cinco cuentas básicas de la contabilidad son: activo, pasivo, capital, ingresos y gastos. Las transacciones que se llevan a cabo en una compañía afectan alguna de las cuentas mencionadas. Para aumentar o disminuir estas cuentas la contabilidad ha establecido dos reglas muy sencillas: las reglas del Cargo y el Abono. Un Cargo, Débito o Debe representa un aumento en una cuenta de activo o una disminución en una cuenta de pasivo o capital.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	Reglones Facturados	Reporte SIM – Indicador Compra: Sumatoria de la cantidad de renglones facturados. Reporte SIM – Indicador Venta: Esta fórmula representa el número total de artículos o líneas de detalle que se han facturado en un período de tiempo específico.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
3205d947-4b83-4783-85df-b241dff36fca	Reglones Pedidos	Reporte SIM – Indicador Compra: Sumatoria de la cantidad de renglones pedidos. Reporte SIM – Indicador Venta: Esta fórmula calcula el número total de líneas de detalle en todos los pedidos que se han recibido en un período de tiempo determinado.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-09-28 16:00:00+00
ccc1e004-b6a0-4cd3-8c3d-e1fbb1830194	Reingeniería de procesos	Rediseño radical de procesos para lograr mejoras significativas en rendimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
78e3d926-ac02-4bb2-9e33-037f5ea3ce87	Reintegro	Proceso mediante el cual se devuelve a la caja chica el dinero otorgado por los vales. El detalle de su ejecución se presenta en la sección "Reintegro de Caja Chica" en la página 77.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
42f7b526-e47c-4975-8152-567192aca839	Relacionados	Artículos que, aunque no son sustitutos directos, se venden a menudo junto con el artículo principal. Esto permite a una empresa mayorista promocionar productos complementarios y aumentar el volumen de ventas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
8c203f3b-94ff-4c21-9ca7-3e5290e120a1	Relación de depósitos	Una opción para realizar depósitos de pagos en efectivo y/o cheques en un mismo banco		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
51ff99bf-96a3-4d0e-a459-efba0f9d6c51	Remisión	Una remisión es un documento que se genera y envía a un cliente, en el cual se hace constar las cantidades y precios de los artículos enviados. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
34457931-4769-412a-b07a-3610bef1392c	Renglones	Se refiere a la cantidad de artículos diferentes incluidos en una transacción		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
b8b31d29-c55a-4ff6-81f9-c915469b9801	Renuncia voluntaria	Decisión unilateral del empleado de dar por terminada la relación laboral.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
bf370d51-dd16-4ac1-8d6b-c047be4dcb4f	Reparaciones fuera de garantía	El cliente solicita la reparación del artículo. Los costos asociados a la reparación serán cubiertos por el cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
e8bc8672-faea-4f4c-b003-82e9db5f9b02	Reporte	Documento estático o dinámico derivado de un conjunto de datos, diseñado para la lectura humana. A diferencia de una base de datos, el reporte presenta la información ya procesada, filtrada y resumida bajo un formato visual específico. Su estructura no es apta para el procesamiento automatizado, sino para la interpretación directa de resultados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	2026-10-02 01:43:01.279+00
3ed7891f-c51a-4e60-aefa-949498db36c7	Representantes legales	Individuos con la autoridad legal para actuar y obligar a la empresa en actos jurídicos y financieros de alta importancia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.6383+00	\N
d21296c8-d92e-448a-b7eb-0decd5a845f1	Repuesto remanufacturado	son piezas usadas que se someten a un proceso industrial de restauración completo, que incluye el desmontaje, limpieza exhaustiva, reemplazo de componentes desgastados y pruebas rigurosas para que cumplan o superen el rendimiento de una pieza nueva.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c7b14be5-72bb-453e-9b07-3b5ddece6d1c	Resolución	se refiere a la cantidad de detalle y nitidez en una imagen, un video o una pantalla. Es una medida que determina la calidad visual y la claridad de un archivo o dispositivo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
0999c5f9-f065-4b38-b52d-bebb9c0bdb18	Responsable aprobación	 Rol encargado de aprobar el documento elaborado, previo a su divulgación y publicación. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a3bd97af-f903-4835-8a0f-dcaa977875e4	Responsable comercial	 Autoridad estratégica de un Área Funcional. Define, prioriza y designa los recursos para llevar a cabo iniciativas estratégicas, las cuales se vuelven proyectos de desarrollo para Mayoreo. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
d7edcc43-5950-4003-8035-5ddff611d98b	Responsable de métodos	 Especialista de Procesos de un área funcional. Documenta, normaliza procesos, y los optimiza para que sea implementado con un sistema o proyecto.  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6b6729dd-5c30-4884-b755-ad7729a3d770	Responsable revisión	 Rol encargado de revisar el documento elaborado, previo a su divulgación y publicación. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
f657a545-3055-44a4-bcef-769ae331923f	Responsable técnico	 Especialista de Sistemas y Tecnologías de un área funcional. Gerencia los proyectos de desarrollo, y provee al Responsable Comercial información sobre la viabilidad económica y tecnológica de una iniciativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c03de426-62cb-437c-a6ad-08dd0f156ec0	Responsable última actualización	 Persona que elabora y/o actualiza el documento. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
9738d588-b4a8-4d91-b870-bc7f37bf39cb	Resumen de ventas	Muestra el total del pedido y la cantidad de renglones vendidos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
fee8e98b-8827-480e-9217-03edc7d76d28	Resurtido de artículos	Método de abastecimiento o compra de artículos con el propósito de mantener un inventario disponible que satisfaga la demanda de nuestros clientes y que cumpla con el nivel de rentabilidad establecido por la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
af9a1522-e9d2-4db5-bff7-1ded4351aa43	Retenciones	Módulo de la aplicación para registrar retenciones de Impuesto al Valor Agregado (I.V.A.) a un cliente		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a845c892-2d44-4509-8f92-367759176960	Retención	Dinero que se retiene de los proveedores cuando realiza una transacción de compra de materias primas o suministros y debe ser entregado a una entidad determinada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c1024cc8-d271-412a-9f1f-a606e4b3408c	Retención ISLR	Monto que el pagador retiene y entera al fisco como un adelanto del Impuesto Sobre la Renta del beneficiario del pago.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e6bcdac0-f460-48c5-b4c6-d3de4894e040	Retención IVA	Mecanismo por el cual el comprador retiene una porción del IVA de una transacción y la paga directamente a la autoridad tributaria en nombre del vendedor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
fc501c86-3082-42f5-a5d7-232e24214d21	Retención municipal	Impuesto sobre ingresos brutos que es retenido y pagado a la municipalidad correspondiente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
d69b0fd1-471b-404f-992a-00b79a626d66	Retroalimentación para el desarrollo	Espacio formal entre colaborador y supervisor para discutir desempeño, actitudes y acordar planes de mejora		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a4391511-8111-405c-9ef5-578ff17dba18	Revisión	Evaluación técnica y de contenido antes de la aprobación de un documento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
5892d213-2486-45c9-af21-89a8c9301de4	Revisión de precio	Es un proceso estratégico y continuo que se realiza para evaluar y ajustar el valor monetario de los productos o servicios. A diferencia de la fijación de precios inicial, que se hace al incluir un nuevo producto, la revisión de precios se lleva a cabo de forma periódica o en respuesta a cambios en el entorno de negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
457fd5a7-7d7f-463e-bb8c-4c7bf90dbf7b	Revisión de precio masiva	Un proceso que se realiza para actualizar masivamente el precio o la contribución de ventas de todos los artículos del surtido, con o sin existencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
97c6438a-6917-46e1-a9fa-6863a30c9375	Revisoría	Área encargada de validar el cumplimiento de normas y detectar oportunidades de mejora.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a42f1f35-c5c8-45c4-93df-96976d63c76d	RF	Radiofrecuencia; tecnología utilizada para ejecutar tareas logísticas mediante dispositivos móviles.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
67f1d3ba-0273-43b4-9d92-7ca7b0807605	RGB	es un modelo de color que se utiliza para representar los colores en las pantallas digitales. El acrónimo RGB significa: R = Rojo (Red), G = Verde (Green), B = Azul (Blue)		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
856c5137-c8a9-437c-8d2a-42c9418306ad	Riesgo	 Son aquellos procesos que representan riesgo a la persona, riesgo fiscal, legal o que puedan detener la operación. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6c2fa11c-375a-4a91-ba45-72dd7529d50a	Riesgos operativos y financieros	Son los riesgos que se buscan identificar y minimizar para asegurar una correcta ejecución y validación de los ajustes de precio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
080c7109-9e3a-44a1-ac47-e9de0ad7b455	ROA (return on assets)	Retorno sobre los Activos. Indica la eficiencia con la que la empresa utiliza sus activos para generar ganancias. Se calcula como Utilidad Neta/Total de Activos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
10932cad-5b4f-4a4b-8fd7-846a14d30827	ROI	es una métrica clave que se utiliza para evaluar la eficiencia y la rentabilidad de una inversión. Es una forma de medir el beneficio que se obtiene de una inversión en relación con su costo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
0c96848c-a0f5-4420-869a-0fe278f9806f	Rollback	Plan de reversión que permite regresar a la versión anterior del sistema ante un fallo crítico en producción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	Rotación	Silo Control: Métrica que mide la eficiencia con la que se gestiona un activo, como el inventario. La rotación de inventario se calcula como. Reporte SIM – Indicador Compra: Rotación anual de inventario. Cantidad de veces que la compañía vende y reemplaza el inventario en el año.	ROTACION	fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
a9602108-5f1c-4c06-b5d6-655068e72bdf	Rotación de puestos	Proceso de trasladar a los empleados de uno a otro puesto para conseguir mayor variedad en las actividades y la oportunidad de aprender nuevas habilidades.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
069bfcdb-9242-4219-a8ca-9eca0e6f8932	Rotación General %	Es el indicador fundamental de Recursos Humanos que mide la tasa de renovación de la plantilla en un período determinado. Expresa, en forma de porcentaje, la proporción de colaboradores que salieron de la empresa en relación con el número total promedio de colaboradores que tuvo la organización en ese mismo lapso de tiempo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
02f26556-cbf5-4a0f-b71e-28aafef81640	Rotación Indeseada	Es un indicador de calidad (KPI) que mide específicamente la pérdida de talento de alto valor y desempeño que la organización preferiría retener.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
baedb644-22b1-49c5-91a2-8cc02d41b153	Rotación Indeseada %	Es un indicador de riesgo de talento (KPI) que mide la proporción de colaboradores de alto desempeño que la empresa ha perdido en relación con el total de talento de alto desempeño que poseía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
252779d7-9211-41c1-9d7b-88c60a2f4651	Ruta de visita	Una opción de filtro para seleccionar la ruta de visita del cliente en la aplicación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
cdaa1bd5-d57e-4d79-8779-023885aeaf37	Rutas	Planificación de visitas a los clientes de acuerdo a la ubicación, distancia o condiciones de los clientes, que intenta lograr el máximo aprovechamiento del tiempo de los asesores de ventas	Ruta	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 19:30:00+00
df07c0bf-0cb9-4528-adb0-92debc45e731	Rutas de picking	Permite agrupar las diferentes secuencias de picking creadas en el almacén, indicando la ruta que deben seguir los preparadores de pedidos en las zonas de picking.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
91fbfea8-a0c8-4b02-b665-3b9e2b97c548	Régimen vacacional	Cada conjunto de contribuciones vacacionales distinto utilizado para calcular el número de días de vacaciones que corresponden a los empleados de la empresa por su trabajo. Un grupo particular de empleados pertenece a un régimen vacacional determinado cuando a todos los empleados del grupo se les calcula la cantidad de días de vacaciones a las que tienen derecho de la misma manera, distinta de la forma en que se calcula a los empleados de otros regímenes vacacionales.	Regimen Vacacional	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:38:25.352+00
3171b596-e350-42d9-94e8-971e476909c2	S&OP (Sales & Operations Planning)	En español, Planificación de Ventas y Operaciones. Proceso de gestión mensual y multifuncional que alinea la demanda con la capacidad de suministro, integrando las áreas comercial, operaciones, finanzas y dirección, para tomar una decisión única y consensuada sobre el plan del negocio.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
d5d73ae5-f724-4db2-99bf-3b66ce8f7b5a	S.D.S (sincronizador)	Aplicación que se utiliza para la transmisión de datos entre la aplicación móvil de ventas AFV y el ERP de la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
019f9bcd-b3bb-4a94-9e41-fcebff22a961	Sage XRT	Sistema de software especializado utilizado para la gestión de tesorería y la conciliación bancaria.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
7150f0cd-4a23-4301-9c3d-bd0c7778c48a	Salario	Retribución en dinero o su equivalente pagado por el empleador al empleado en función del cargo que éste ejerce y de los servicios que presta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
88b0b7ca-42d8-44a3-8b27-78f57dada430	Salario base	Remuneración fija que recibe un empleado, excluyendo complementos, bonos, horas extras y otros beneficios en especie.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2cb21705-9af5-4a42-a167-9cf5d4b7e452	Sistema de producción Toyota (tps)	Una metodología fruto de más de 50 años de KAIZEN™ en Toyota. TPS se basa en la nivelación, con los pilares de apoyo de Justo a Tiempo y Jidoka.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2b45e1ea-32c8-4d27-aeac-47c707210c51	Salario diario integrado	Es el cálculo del salario que devenga el empleado diariamente, según los conceptos tipo base, beneficio, deducción y anticipo asociados a la nómina a la que pertenece. Su cálculo involucra una proporción diaria que es la proporción de aporte del concepto al salario diario integrado del empleado.	Salario Diario Integrado	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:38:28.899+00
48848ff4-5636-4660-b9f1-089d2568d05d	Salario integral	Modalidad salarial en Colombia y Venezuela que incorpora en una sola suma el valor del salario, las prestaciones sociales y los recargos por trabajo nocturno, extra y dominical, simplificando el cálculo de aportes parafiscales.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e429df0b-36de-4035-bdb3-68fc6d7fe913	Saldo	El valor neto de una cuenta en un momento dado, resultado de sumar todos los débitos y restar todos los créditos (o viceversa).	Saldo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:03.841+00
4f75c460-ea43-4e8e-b34b-8c42b9269527	Saldo a favor	Monto disponible en la cuenta de un cliente o proveedor que puede ser aplicado a deudas futuras o devuelto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
99e07992-4e99-427b-b53f-5daed7bee852	Saldo de proveedores	El saldo de proveedores representa las deudas pendientes de pago por concepto de compra a crédito de bienes o servicios. El saldo aumenta por compras o servicios contratados a crédito por la empresa. Las facturas, recibos y otros hacen aumentar la cuenta. Este saldo disminuye por pagos parciales o totales de las deudas, por descuentos obtenidos o por devoluciones de mercadería. Los pagos hechos por transferencia electrónica o cheque disminuyen la cuenta.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
20574940-ef3a-4801-8e44-ea564ce66e09	Saldo deudor	Importe que un cliente debe a la empresa, representando una cuenta por cobrar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ab7a75da-ad32-4af5-9057-25a02ee7754f	Saldo en bancos	El saldo de efectivo disponible en una cuenta bancaria según el extracto emitido por la entidad financiera en una fecha específica.	Saldo según Bancos	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:05.015+00
de79a7c0-8737-4cc3-aa81-ac2339dc5e0a	Saldo en libros	El saldo de efectivo de una cuenta bancaria según los registros contables internos de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6d4ac37a-add0-4666-af29-e02dd112c489	Saldo normal	Indica si una cuenta es de débito o de crédito, determinando de qué lado de la ecuación se encuentra, el lado contrario al definido será utilizado cuando el saldo sea negativo. ​	Saldo Normal	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:06.158+00
81a51a04-efd4-481b-9b23-b241b65fb3fb	Salidas	 Todo aquello que se genera cuando se realiza el macroproceso, proceso, la actividad o la tarea. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e181c7cc-29aa-4e95-8141-be486823be9c	Sangrado	Es un término técnico que se refiere a una extensión de una imagen, color o gráfico que se extiende más allá del borde de la página final.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
5066244a-9070-420e-81bf-1fbe0ddc9028	Saturación	s una de las tres propiedades principales del color, junto con el matiz (el color en sí, como rojo o azul) y la luminosidad (el brillo o la oscuridad).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
16270b31-0aad-4066-af64-7e6c014104af	SDCA (estandarizar, hacer, verificar, actuar)	Un refinamiento del ciclo PDCA orientado a la estabilización de los procesos de producción antes de realizar intentos de mejora.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
57d0da50-d78d-4090-9abd-44a74a04531f	Secuencias de picking	Corresponde al número consecutivo para la secuencia según el ordenamiento lógico general en el almacén.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2c4b02da-15a7-4281-aa69-5a800c020ccc	Segmentación (slicer)	Filtro visual que permite seleccionar valores directamente en un informe (ej. elegir país en un gráfico).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
714929b1-aebe-420e-8a90-692a354bc5f9	Segmentación de mercado	El proceso de dividir un mercado amplio en subgrupos más pequeños (segmentos) con características, necesidades o comportamientos similares.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ff5f0a8f-3c39-44a1-a9b1-0458a3c7d0a8	Segmento de clientes	Es una clasificación que se le da a un conjunto de clientes, basados en una definición o elemento que comparten los mismos. Un cliente puede pertenecer a diferentes segmentos. El presente documento enuncia y describe los Segmentos que están definidos para Mayoreo. Un Segmento puede tener una subclasificación, si la necesidad comercial de una línea de negocio (ferretería, repuestos, quincalla) lo amerita.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e173b004-ed64-452b-93a2-7c3389882f32	Segregación de funciones (sod)	Principio de control interno que busca prevenir fraudes y errores al dividir las responsabilidades de una transacción (autorización, registro, custodia) entre diferentes personas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e934cb41-0318-4f40-9e77-a1276aa38a9d	Seguridad informática	Conjunto de medidas para proteger la información y los sistemas contra accesos no autorizados o ataques.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
5b43060c-b730-43a6-8bd3-0068ba5b6da1	Seguro	El monto pagado sobre el valor de la mercancía para cubrir los posibles daños que sufra durante su transporte.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c56da89b-a376-4427-b858-902854c31954	Seguro de carga	El monto pagado sobre el valor de la mercancía para cubrir los posibles daños materiales que sufran las mercancías durante su transporte.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
fed3236b-5cbd-4135-b605-e69babb06c9a	Selección de personal	Fase del proceso de contratación que sigue al reclutamiento, donde se evalúan y elige entre los candidatos al más idóneo para el puesto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2c39bbe5-240b-4d40-9f62-492eb46ae14b	Semi-neto	Resultado de la empresa antes del impuesto sobre las utilidades. Refleja el desempeño operativo y financiero previo al impacto fiscal.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
20f9d46f-9496-4a37-a5a0-aef1d3e18555	Semidirigido	Método de almacenaje donde el sistema sugiere una ubicación destino para el artículo trasladado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
afaaa296-f644-4195-91d7-0a17154cd45d	Semineto	Utilidad antes de ISLR		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ce7548a6-df5e-42ec-b319-3806d7282e89	Servidores	Computadoras de gran capacidad que ofrecen servicios a otros dispositivos, por ejemplo el servidor que guarda los correos o archivos compartidos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
54a33a25-c745-479f-b1c3-ba627aa637c9	Sesgo	Tendencia sistemática al sobrepronóstico o subpronóstico		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
1996c917-a8e4-4e99-b054-639c4d9b38d2	Shojinka	Shojinka significa "línea de mano de obra flexible" y la capacidad de ajustar la línea para satisfacer los requisitos de producción con cualquier número de trabajadores y cambios en la demanda. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a52482cb-ff4e-4483-a854-456704e1b862	Silo	Muestra las divisiones de la compañía a nivel macro en relación a sus procesos funcionales: Compra, Ventas, Logistica, Control, Mercadeo, Personal, Sistemas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
144e2195-0a48-429e-a4cd-79fee80d39c0	SIP	Sistema de Información de Personal. Sistema o repositorio digital centralizado donde se gestiona y almacena toda la información laboral de los colaboradores (expedientes, evaluaciones, reconocimientos, etc.).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
1791d892-b194-4555-bcaa-e03ddd81ef8c	Sistema armonizado	Es una nomenclatura internacional y polivalente de productos que ha sido elaborada por la Organización Mundial de Aduanas (OMA).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
8feb4cb2-4aad-4907-9ab0-b6aed6da3df7	Sistema contra incendio	Conjunto de equipos y protocolos (alarmas, extintores, hidrantes, etc.) para prevenir y combatir incendios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e7492691-6072-4feb-9b51-6d566bc6042e	Sistema de alisto de mercadería	Una parte vital de la cadena de abastecimiento que implica la administración de recursos, zonas de acceso y algoritmos de extracción de artículos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
41091523-3253-4fd7-b83a-db5886b0ad05	Sistema de reportes	Plataforma centralizada para la compilación y consulta de reportes de las diferentes áreas de la compañía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2ba4a1d9-91cd-47b2-8b54-2b66ea9973eb	Sistema de sugerencias kaizen	El Sistema de Sugerencias KAIZEN™ es parte esencial de un KAIZEN™ orientado al individuo. Su diseño se planifica, implementa y comunica cuidadosamente. Se presta especial atención a la capacidad de respuesta de la alta dirección y al desarrollo de un sistema de retroalimentación, reconocimiento y recompensas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
9057d4ee-f655-4b55-b0a6-5f8118e68d6b	Situación de trabajo	Estado actual de una acción: disponible (DISP), atendida (ATEN), terminada (TERM), problema (PROB), anulada (ANUL).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
7fdaf5c0-4fa4-4a8f-9576-3ae2967c3909	SKU	Stock Keeping Unit (en español: Unidad de Mantenimiento de Inventario). Es un identificador único que se asigna a cada producto o variante de producto dentro de un inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
79a29291-7ef4-4c12-86fe-531df77276bf	SKU activados	Silo Ventas: Códigos de productos que están actualmente disponibles para la venta en el inventario. Reporte SIM – Indicador Venta: SKU con ventas mayores que cero.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
c3e24b9c-2bd1-4fc4-a55e-f48be04058e6	SKU activados %	La proporción de productos o referencias (SKU) que han sido activados o puestos a la venta en un período determinado, en relación con el total de artículos disponibles en el inventario		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
8ef2955f-79ff-423c-a3da-208f222da23e	SLA´s	 “Service Level Agreement”.  Acuerdo de servicio, es el acuerdo formal que se realiza entre dos partes (la compañía y el cliente) para definir la entrega de un servicio. Los SLA´s se negocian con el fin de asegurar que el Macroproceso / Proceso se ejecute en los tiempos en que es requerido, eliminan retrabajo, inconformidades o no entendimientos entre las partes que interactúan dentro de un Macroproceso / proceso. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
5ebe4eaf-9346-4ed8-8604-3aa57aec8c58	SMAPE	Silo Logística: Variante simétrica del MAPE para reducir distorsiones.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
e253ac7f-8474-46b6-bcfa-76ba8e30044c	Sobrantes	El cliente recibe artículos adicionales no indicados en la factura.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
dff5dbdf-7bae-403d-b91a-140e9b1437f7	Sobre giro bancario	Exceder el crédito más allá de las posibilidades de pago del deudor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c264cc12-7a44-4236-8e7b-29dcffe765c0	Sobre inventario	Exceso de inventario proyectado que contempla lo que se encuentra en almacén, las órdenes de compra en tránsito, el pronóstico de venta durante los días de anticipación y lo requerido para un ciclo de pedido		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6526b818-0470-4ff7-b26e-f90478900bcb	Sobreinventario	Es la situación en la que se almacena una cantidad de productos superior a la demanda real o proyectada durante un período determinado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
7c422c16-f5b4-41d0-a7b3-3d1fc078f3dc	Software	Programas y aplicaciones que se instalan o se usan en los dispositivos, como Word, Excel o un sistema de facturación.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2e4e3059-f525-43c3-80f7-e344bc29b1a2	Solapamiento	Coincidencia entre dos o más promociones sobre el mismo SKU, audiencia, canal y vigencia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
f4d81610-e298-44d7-9073-07a2f8e1dd07	Solicitud de cancelación de pedido por parte del cliente	El cliente desea cancelar el pedido, previo a la entrega y ya está facturado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2240bfcf-6b5b-4cfe-9bc7-a8d519f9f5a8	Solicitud de compra	Documento interno de la empresa, en el que los departamentos y funcionarios hacen sus requisiciones de materiales al encargado de compras.	Solicitud de Compra	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:07.588+00
5434056d-1a08-45c5-bc3b-9e45c7077530	Solicitud de reclamos y observaciones	Procedimiento para levantar un reclamo sobre una orden de recepción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
261e142e-d769-4018-b13d-ac2dd81678a5	Solicitud de reparación	Solicito la reparación del artículo. Los costos asociados a la reparación serán cubiertos por el cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
980a5d45-bd32-423b-83eb-50a2b4b51c54	SPI	Sistema de Nomina		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
34d0d6de-e29b-495b-b263-d21bea4770e4	Sprint	Entrega parcial del proyecto, con alcance delimitado, que permite la validación progresiva de funcionalidades y la reducción del riesgo global del proyecto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2b406ca5-792c-45ed-b4c9-9f825fe0aeb9	Stakeholder (parte interesada)	Persona o grupo que tiene interés o se ve afectado por el proceso.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
dd6e9c86-f0d6-4976-a69e-32bf6d4653b5	Status bar	Espacio ubicado en la parte inferior de una ventana cuya función es informar y brindar asistencia rápida sobre las opciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
41cf3794-1642-47d7-b466-28602faaa24c	Stock de seguridad	Cantidad mínima que debe existir en el inventario, para asegurarse que no se produzcan faltantes en el momento requerido.	STOCK DE SEGURIDAD	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
fa757d8e-dd8a-4f61-b6ab-9cb2cbbd13f1	Streamline	Silo Logística: Plataforma de la cadena de suministro diseñada para optimizar los procesos S & OP actuales.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
4eddd612-e921-49aa-b4ce-c1540976cc8d	Sub-Categorías	Reporte SIM – Dimensión Compras: Una división más específica dentro de una categoría. Reporte SIM – Filtro Compra: Permite filtrar por una o mas divisiones específicas dentro de una categoría.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
697736ac-1a9a-4a0a-8d79-b408a0fcafbe	Sub-subtipo	Ofrece un detalle más específico para registrar la transacción de inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
77f4b86f-86c0-4aa9-98cd-db5f53faef75	Subcategorías	Una división más específica dentro de una categoría. Cada categoría debe contener un rango de 10 a 30 subcategorías. Al igual que las categorías, sus nombres deben ser descritos en singular, en mayúsculas y sin acento.	Nombr Sub Categoría	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 19:30:00+00
2df81113-36e6-4328-8e52-c6f36a711690	Subproceso	División específica dentro de un proceso mayor que cumple una función determinada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ab58f521-3580-463c-a423-12b1783bb590	Subtipo de transacción	Establece una clasificación según el tipo de transacción que se haya elegido y determina el estado del inventario afectado (disponible, cuarentena, reservado o vencido).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
7b4711b1-75f6-43d9-8183-9aec39fd2dee	Sucesión	Silo Personal: Proceso planificado de identificación, evaluación y desarrollo de talento interno para asegurar la cobertura futura de posiciones críticas o clave dentro de la organización. Reporte SIM – Indicador Personal: Es un proceso estratégico mediante el cual una organización identifica y prepara a colaboradores clave con el potencial (N) y el desempeño (M/P) necesario para ocupar posiciones críticas en el futuro, asegurando así la continuidad del liderazgo y la operación del negocio.		fusionado	Fusionado a partir de 2 filas originales.	t	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-28 16:00:00+00
041c8239-2716-40f5-a246-4e86b9cff44c	Sucesión %	Es un indicador crítico de robustez del talento que mide el grado de preparación de una organización para llenar sus posiciones de liderazgo críticas desde dentro.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6e702e79-7fd0-48b5-ba12-20e664220179	Tipo	Este campo ubicado en la pestaña de Clasificaciones de la ventana articulos, indica si el articulo se encuentra disponible para la venta o no disponible para la venta, colocando P1 o P2 respectivamente.	Tipo	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
42e972b0-9a7b-4aec-93b4-c663bc40bfca	Sucesión N3	Es un indicador de gestión del talento que identifica específicamente a los colaboradores con el más alto desempeño (M5) que se encuentran en una etapa intermedia de desarrollo (Nivel de Potencial 3) y que ocupan posiciones de mediano rango (Paso {4,5}), constituyendo la cantera principal para posiciones críticas de liderazgo en el largo plazo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
612dbd3b-6fe9-4b93-9d2f-86d695763fbd	Sucesión N3 %	Es un indicador de profundidad del bench de talento que mide la proporción de posiciones de nivel senior (≥3) para las cuales la empresa ha identificado candidatos internos de alto desempeño y alto potencial (M5, N≥3) que, si bien no están listos para una promoción inmediata, constituyen la cantera de futuros líderes para esas posiciones críticas en el mediano y largo plazo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
07a48ef6-57f3-4775-bb23-62b229838a2f	Sucursal	 Divisiones que se realizan a nivel de compañía para separar los documentos e inventarios en subpartes más pequeñas. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
404d183c-af0b-4fb9-a32c-4ceaf24ecde5	Supervisor	Líder operativo que no solo gestiona tareas, sino que también se enfoca en el desarrollo y el bienestar de su equipo para lograr los mejores resultados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c6fac623-e13f-437f-b2cf-e865297a6e3a	Supervisor Colaboradores	es un profesional encargado de guiar, coordinar y evaluar el trabajo de un equipo de colaboradores para asegurar el cumplimiento de los objetivos operativos y mantener estándares de calidad, productividad y clima laboral.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
8af202d1-87c0-4f5b-9036-82b3d7f6adea	Surtido Activo	Surtido regular con inventario (incluye descontinuados).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
3ab7bcf9-2e51-422c-b1f6-7a655a3090da	Surtido Comercial	Se refiere a todos los articulos exceptuando los articulos de Mercadeo, Servicios Generales y Taller.	SURTIDO COMERCIAL	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
d3d631ec-ee1f-402f-aab6-13401de6258a	Surtido no regular	Se refiere a la variedad de productos que no forman parte de la planificación regular de reposición, incluyendo los combos y los Kits. Los tipos de artículos de este surtido incluye: Nuevos (N), Ocasionales (L), de Temporada (T), Pedido Especial (P) y Complementarios (J), los cuales se reponen en determinadas épocas del año o bajo solicitud específica de un cliente. Además, se consideran productos Descontinuados (E), Suspendidos (Z), así como Mercadeo y Suministros (S), que no están incluidos en el proceso de reposición.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
1abba21b-63e6-4c4a-9910-70a51fa94299	Surtido regular	Se refiere al surtido comercial a excepción de Pedido Especial, Temporada (Ocasional), Nuevos y Descontinuados. Estos  son: Básicos (B, D, F), Complementarios (H, K, M).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
78cf0901-6155-42b8-a23e-27d20ba307f7	Surtido vigente	Hace referencia al surtido regular menos Descontinuados.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
0322d9de-7862-439b-a78f-328a988c460f	Sustitución	El proceso de reemplazo de un artículo existente por uno nuevo en el portafolio de productos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
371225f8-e022-4688-8db6-2e197b108037	Sustituto	Un artículo que puede reemplazar a otro en caso de que este no esté disponible, manteniendo características y funcionalidad similares para satisfacer la demanda del cliente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
325eb394-b130-4c74-9bc1-5aae21082b7c	Súper usuario	 Persona con perfil de administrador capacitada en las funcionalidades del sistema eflow WMS. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
3326f43c-e43c-42ab-934a-641dd88dc5b3	T.E.F (transferencia electrónica de fondos)	Operación que registra el movimiento electrónico de dinero entre cuentas bancarias.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
0a000ef5-f710-4608-b489-95a32d6f1578	Tabla de Dimensiones	Estructura que contiene los atributos descriptivos de un proceso de negocio. Se utiliza para segmentar, filtrar y categorizar los datos (ej. Dimensión Geográfica, Dimensión Tiempo, Dimensión Producto).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6b1bc498-8c49-4068-9560-6e5a035893d5	Tabla de Hechos	Tabla central de un modelo de datos que almacena las métricas cuantitativas o medidas de un proceso de negocio (ej. cantidades vendidas, montos facturados), las cuales son susceptibles de ser agregadas o calculadas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e231b9cf-29ee-4eea-8f10-c5177d500b16	Tabla Plana	Estructura de datos bidimensional (filas y columnas) que carece de relaciones jerárquicas complejas, celdas combinadas, subtotales o formatos de presentación humana, siendo el formato óptimo para el procesamiento automatizado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
721e35d7-7367-4681-91ba-3f58fc6dd79c	Tarea	 Conjunto de pasos simples interrelacionados para lograr un objetivo. En este nivel se identifica “quién hace qué” (un agente, un tiempo, múltiples pasos). 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
dbcb06fe-e449-40f7-9532-58c4d8c301a3	Target	También conocido como "público objetivo", se refiere al grupo de personas a las que se dirigen los productos o servicios de una empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e4309837-bb68-462c-9be0-378293dc4019	Tasa de conversión	es una métrica clave que mide el porcentaje de usuarios que completan una acción deseada en un sitio web, un anuncio o una campaña. Es una forma de evaluar la efectividad de una estrategia.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6d2a8e10-fe4c-448c-917a-c5a3daa4f0fe	Tasa impositiva	Es el porcentaje (%) de impuestos que corresponde pagar al fisco por algo que la ley manda.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c9d1b478-dc12-4ebb-a043-5fff729219e0	Tecnología	 Especificar si para llevar a cabo la Tarea se utiliza un sistema automatizado específico o se usa determinada herramienta. Puede también usarse como el conjunto de Software y Hardware que utiliza un proceso para llevar a cabo sus objetivos.  		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c0618a4a-4e73-4c62-ae71-428188e3d152	Temporal	Estado del empleado que indica si el mismo trabaja fijo o por temporada.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
00dc4458-9419-47a7-a5b2-0b2a3b47105c	Terceros	Personas o empresas subcontratadas para servicios específicos (limpieza, etiquetado, etc.).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
613f5862-3ed2-4f20-ade9-c440ccedd7ad	TERM (terminada)	Tareas que ya fueron atendidas en la RF y se realizó un proceso sobre las mismas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6a65040a-25f1-44b9-a595-6d74425aecc4	Terminación de contrato	Conclusión de la relación laboral, que puede darse por diversas causas: mutuo acuerdo, renuncia voluntaria, despido, expiración del término pactado, entre otras.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
5f23cb83-ef3c-44bf-8af2-7b321416b0fa	Terminales de radio frecuencia (rf)	 Equipos también llamados “Hand Held (HH)”, son computadores móviles, capaces de ejecutar un sistema informático y de comunicarse mediante protocolos WIFI o Bluetooth, hacia el servidor central. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
48864aed-d824-4ef7-9795-df0ac6bc1fff	Terminales desktop	 Equipos de cómputo tipo PC, para la ejecución del sistema eflow WMS. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a37fdd19-4089-40b7-9e43-16846e79a599	Terminar el palet (en picking rf)	Indica que no se alistarán más artículos en el contenedor, pero aún no se ubicará en el destino asignado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ddb42d92-addd-465f-b8fa-d8798305b1e0	Ticket de auditoría	Conteo de artículos que se generan por criterio del Coordinador de Control de Inventario. Este conteo incluye aéreos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6ad7be9b-3426-4d81-aac1-cc60be45b191	Tiempo takt	El tiempo Takt, un elemento vital para equilibrar los flujos de producción de piezas individuales, se calcula dividiendo la demanda diaria total de los clientes en unidades completadas (televisores, automóviles, abrelatas y similares) por el número total de minutos o segundos de producción trabajados en un período de veinticuatro horas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
629be99e-7eaa-4abe-a141-95412f8b5cf1	Tipo Codigo de Barra	Campo en la ventana de artículo donde se especifica si el codigo de barras es genérico.	Tipo Codigo de Barra	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 14:05:00+00
18e2ecc7-01d9-49bd-8ef3-1f3e8a204d54	Tipo de artículo	Se refiere a la clasificación de los productos en categorías, subcategorías y familias para organizar el surtido.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
264823e9-dfda-4a88-b0c4-90f695ac85ec	Tipo de asiento	Distingue el presente asiento de entre un conjunto de tipos de asiento que el usuario puede definir. ​	Tipo de Asiento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:16.424+00
dfe56a6e-7106-47bb-bf4c-100185c40cf9	Tipo de cambio	Tasa a la que una moneda puede ser cambiada por otra. Su fluctuación genera riesgo cambiario.	Tipo Cambio	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:24.496+00
293085ac-402d-429e-9ca8-870fec95dea1	Tipo de carga	Modalidad de despacho de los artículos: por palet completo, único o múltiple.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
979d4728-f5ea-46dc-9471-ac3f09498a8a	Tipo de contabilidad	Determina si la transacción contable se manejará solo en la contabilidad Fiscal, en la Corporativa o en Ambas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
cb97e6c5-3944-4fda-9b24-d594e1849f14	Tipo de cuenta	Define si la cuenta es de Balance de Situación o de Estado de Resultados. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
8565d76f-c016-47ae-bded-91436403bccc	Tipo de dato	Atributo que indica al sistema la naturaleza de la información contenida en un campo (ej. Integer para números enteros, Decimal para valores monetarios, String para texto y Date para cronología).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
10788374-99fb-4ffb-8bfb-3a7813f8abfc	Tipo de estiba	Clasificación que define la forma en que se organizan, apilan y aseguran las mercancías o cargas sobre una unidad de transporte (pallet, contenedor, bodega de buque, camión, etc.), según criterios como la naturaleza del producto, su resistencia, forma, peso y condiciones de manipulación. Busca garantizar la estabilidad de la carga, optimizar el espacio disponible y prevenir daños durante el almacenamiento o el transporte.	Tipo de Estiba	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	Tipo de Pick	Silo Compras: Se refiere a cómo se debe preparar un pedido antes de su envío: pieza, inner, caja, tarima, kg, rollo. Silo Logística: Define desde cuál nivel de empaque se realiza el picking (preparación de pedidos) en el almacén para despacho al cliente. Los valores aplicables son: unidad, inner, caja, tarima.	Otros - Tipo de Pick	dudoso	Compras y Logística listan valores distintos (Compras agrega kg y rollo; Logística usa “unidad” en vez de “pieza”). Se fusionó asumiendo que es el mismo campo operativo visto desde dos áreas.	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 20:00:00+00
5d96c2cc-4617-4b49-8068-3f2e9e13b461	Tipo de Producto	Campo en la ventana de artículo donde se especifica si el producto es terminado, kit, de servicio, entre otros.	Tipo de Producto	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
e5183cc3-7824-4305-a32f-354352d5454f	Tipo de recepción	Clasificación de la orden según su origen: RECERP, RECLIB, RECTRA, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c84cb905-2f59-4f59-a84e-d236e795236c	Tipo de tarea	Clasificación de acciones operativas (ej. picking, carga, recepción).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e85b69d6-3fa2-418d-a801-661a9988febb	Tipo de transacción	Es un campo específico en la estructura de la facturación electrónica en Costa Rica, que se utiliza para definir la naturaleza de la operación para efectos fiscales y de declaraciones.	Tipo de transacción	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-25 13:37:33+00
9795572c-0c9f-4f49-b7a0-d0e3f8e78d61	Tipo de transacción contable	Define transacciones contables que involucran el mismo tipo de transacción. Por ejemplo, cheques, planilla, vacaciones, cesantía, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e73b53ac-c63d-460c-9523-609cb86efe05	Tipografía	es el arte y la técnica de diseñar y organizar el texto para hacerlo legible, atractivo y significativo. Va más allá de elegir una fuente bonita; se trata de usar el tipo de letra para comunicar la personalidad de una marca, crear jerarquía visual y guiar la mirada del lector.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
76726aa3-83cd-4406-a13f-ebca190b4ed0	Tipos de artículos	Incluyen Co-producto, Desecho, Fantasma, Kit, Laboral, Mat. Empaque, Materia Prima, Otros, Proceso, Refacción, Reproceso, Semielaborado, Servicio, Subproducto y Terminado. Los artículos con tipo Proceso, Laboral, Servicio, Fantasma, Kit, Reproceso y Otros no se incluirán en reportes de existencias ya que no tienen existencias en inventario.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c2e11444-fe54-4c3a-bd8c-92233254f353	Tipos de trabajo	Un filtro para observar la cantidad de tareas asignadas para un tipo de trabajo específico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
d0d381a3-011d-4d50-9eee-6d25cac79f33	Tipos de transacciones contables	Los tipos de transacción contable corresponden a clasificaciones de las transacciones contables generados por tipos de movimiento. Por ejemplo, las transacciones contables pueden clasificarse si corresponden a generación de cheques, aunque estos cheques se hagan para cualquier transacción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e23d656f-8c3e-4366-bbaf-190025163170	Tipos de transacción	Incluyen Consumo - Dev., Ensamble, Físico, Producción y Traspaso.	Tipo Transacción	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:30.982+00
e18046eb-d216-491c-bd6b-6a74407f3a23	Tipos de unidad de transporte	Incluyen los diferentes tipos Cabezal, Camiones repartidores, Furgón.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
654c1872-b5d2-40ad-bb14-4ecee6f6217c	Tir (tasa interna de retorno)	La tasa de descuento que hace que el VPN de un proyecto sea igual a cero. Representa la rentabilidad intrínseca del proyecto. Una inversión es viable si su TIR es mayor que el costo de capital.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2c93e8f5-c147-4522-bee5-7cfabdf6a517	Titulo	es un elemento de texto breve que se utiliza para presentar, resumir o dar un nombre a un contenido, como un artículo, un anuncio, un video, un libro o una página web.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
ab749864-d037-418c-8dfc-435580556cce	Titulo de cobertura	Instrumento financiero (como un forward o una opción) utilizado para mitigar el riesgo de fluctuaciones adversas en tipos de cambio o tasas de interés.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a26be7ef-360f-4975-b63a-01a6644724f8	Tolerancia	Margen de tiempo permitido para la entrada y la salida del empleado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e375d010-fd7d-49f0-9ca5-abfdb66f3b63	Toma física	Proceso de conteo manual de inventario para validar cantidades reales versus sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6e4b9778-1bf3-4002-b261-fbf42a3cd5a5	Toma física de auditoría	Aplica para controles de auditoría en el almacén.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
55d70e88-30fc-4180-b911-c8260ca7a4b3	Toma física de muestreo	Aplica a tomas físicas que no requieren actualización de inventario, utilizadas para analizar el inventario físico y teórico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
fc1a8706-9e83-4752-b54e-d8effedaea30	Toma física dirigida (ubicación – artículo)	Un tipo de Toma Física donde es necesario indicar el o los artículos que se desean contar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
05c5c140-fef3-4c12-b634-a1811b4d2d50	Toma física dirigida (ubicación)	Un tipo de Toma Física donde es necesario indicar la o las ubicaciones que se desean contar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
3f32b16d-b478-4618-8b65-dcb6609da984	Toma física libre	Un tipo de Toma Física donde no es necesario restringir la toma por ubicaciones o artículos, pero se puede restringir a un usuario específico.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
3cc129a8-7ec5-46bb-b045-5bf23a43e3cf	Toolbar	Barra con iconos que forma una especie de submenú gráfico de fácil utilización, pues las opciones se aplican al activar un icono posicionando el cursor del ratón y presionando el botón izquierdo. ​		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e7ea765d-97d7-4634-b47b-cac473ab16f1	Trabajo automático	Procedimiento para iniciar la atención de tareas en RF, donde eflow-WMS asigna tareas a los recursos disponibles.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2d58e261-8012-434b-a6d5-f700ba9fb79b	Transacción	Una transacción u operación es cualquier evento (o suceso) o condición, cuyo reconocimiento se expresa en forma de un asiento en los registros de la contabilidad. ​ Expuesta en cantidades monetarias, una transacción u operación, tal como la concibe un contador, se encuentra formada por una igualdad entre créditos y débitos; los primeros representando el origen y los segundos la identificación y la disposición inmediatas. ​ 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
a28bc089-0eb5-4d76-bd29-12a4992c7c71	Transacción contable	Análisis en un diario de los efectos de una transacción en las cuentas contables, usualmente acompañado por una explicación. En algunos países el concepto de transacción contable se define por términos tales como: póliza, boucher, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
391fe4d0-e459-45cb-9d7e-56472fa751a0	Transacción de inventario	Operaciones que deben realizarse para mover artículos del inventario, ya sea ingreso, salida o traslados de una bodega a otra o dentro de la misma bodega. Al ser aplicadas, registran un asiento contable en el módulo de Contabilidad General.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
6dd12e2c-8e01-4999-ad7e-45a1bca4cbad	Transferencia de stock	Movimiento de inventario entre ubicaciones dentro del almacén.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
70f77e1a-9787-4f39-a82c-9a8c36ee9253	Transferencia electrónica de fondos	Una transferencia electrónica de fondos (T.E.F.) es una transacción que permite al cliente pagar documentos pendientes por medio de un depósito electrónico del monto parcial o total del documento a una cuenta bancaria de la compañía. Para poder generar una T.E.F. es preciso que tanto el cliente como la compañía tengan cuentas bancarias en la misma entidad financiera.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
b38e2a7f-582e-4c3f-88aa-a4bbe64925c4	Transportista	Conductor de vehículos que realiza entregas o recolecciones de mercancía.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2351ce25-b4aa-43a6-9da7-dc63a17d5588	Trazabilidad	Silo Procesos: Capacidad de seguir el historial, aplicación y cumplimiento de una norma o proceso. Silo Logística: Registro digital completo de cada pedido desde recepción hasta entrega final.		dudoso	Silo Procesos define un concepto general de cumplimiento normativo; Silo Logística describe específicamente el registro digital de pedidos en el CEDI. Se fusionó como concepto general + su aplicación en Logística.	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
c93c4600-d7bf-4590-886f-757f38e615e4	Turno	Horario asignado a un recurso para operar en el sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
4043ee9d-a16b-457b-9c5f-e81bbcb1afdd	Turno de trabajo	Período de horas durante el cual el empleado debe prestar sus servicios. Pueden existir turnos diurnos, nocturnos, rotativos o mixtos, cada uno con regulaciones específicas sobre recargos		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
03fcd378-880c-4476-8d8c-410f7f939db9	UAT (User Acceptance Testing)	Validación del producto con usuarios reales antes del despliegue a producción.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
28c22366-7950-4c53-8b25-baf908e71265	Ubicación de referencia	 Para cada referencia de artículo se puede gestionar un punto dentro de una zona almacenaje que funcione como eje de gravedad en los algoritmos de búsqueda de ubicación. El algoritmo de ubicación trata de colocar el producto lo más cercano posible a esta ubicación de referencia. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
514eb4f7-56fd-4cbb-8c81-3ee13438eb13	Ubicación libre	Funcionalidad que permite trasladar artículos de un palet a otra ubicación sin restricciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e4ee354c-5f5c-45ea-8431-8ef8f003560f	Ubicar el palet (en picking rf)	Indica que no se alistarán más artículos en el palet y este se ubicará en el destino asignado.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2afbcd91-311d-4d7f-b100-57ebb1684950	Unidad almacenamiento	Unidad de medida en la que se almacenan los artículos en la bodega y con base en la cual se realizan las transacciones de inventario.	Almacenamiento	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 19:30:00+00
393b0f55-08ce-4d63-b3b5-fd39156ce464	Unidad de detalle	Establece el número de unidades elementales del artículo que componen la unidad de almacenamiento. Existe un factor de conversión entre estas dos unidades.	Detalle	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 19:30:00+00
e6c315bd-69d8-47a0-8d71-b4ab47fc0b67	Unidad de negocio	División de una empresa que opera de forma semiautónoma, con su propio mercado, clientes y estrategia, pero integrada en la estructura corporativa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
39ac923f-bfcd-4f71-b969-261d3f1a0593	Unidad de transporte	Vehículo o equipo utilizado para realizar la carga de pedidos; puede ser cabezal, furgón, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
b77bed1c-168c-4b07-b731-88002527e3c5	Unidad Medida C	Campo UDF donde se indica la unidad de medida para Magnitud Comercial. Ej: Kg, m, m2, m3	Unidad_Medida_C	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-09-30 19:30:00+00
6594335b-3a50-487f-8899-361e86c6e1f7	Unidad medida compra	Unidad de medida para solicitar a los proveedores las materias primas o suministros.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
e0dbd68f-aff5-44de-8ff4-651335f1699e	Unidades de distribución	Función para llevar el control de hasta ocho presentaciones diferentes que maneja cada artículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
3818befa-bd67-48a3-bb6c-ea5a8001f76f	Unidades de medida	Patrón en el que se miden los artículos del inventario, según el fin que se necesite considerar  almacenamiento, detalle o venta.	Unidad de Medida	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:43:42.833+00
1375b3e7-717b-417c-a20a-7a72a4f15982	Unidades de transporte	Unidades que se crean en el módulo de catálogos y se configuran para realizar el proceso de carga de camión.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
2c317644-5539-4ba8-bc27-6d7151007ee9	Unidades en inventario	La cantidad de unidades teóricas de un artículo		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
9b832008-8b58-4016-b716-f08e6da13959	Usuario	Persona con acceso al sistema, configurada con nombre, clave y permisos.	Usuario	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:47:42.986+00
b0b19564-212b-4549-912d-262634e249d4	Vacaciones	Período de descanso al que tiene derecho el empleado, después de cada año de trabajo, que es exigido por la legislación laboral del país, o inclusive por convenciones colectivas con sindicatos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
aebf0e13-48cd-4ec4-8635-0ef01c9778ce	Vacaciones adicionales	Período de descanso al que tiene derecho el empleado, después de cierto periodo de trabajo definido por políticas propias de la empresa que las otorga como un incentivo a los empleados. No es exigido por la legislación laboral del país.	Vacaciones adicionales	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:47:45.879+00
7b203557-e87c-48cf-8160-619fc2f803a9	Vacante	Puesto de trabajo que se encuentra disponible para ser ocupado, ya sea por una nueva creación o porque la persona que lo ocupaba lo dejó libre.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
8a87022f-31b1-4504-b089-dc78b81e0d27	Vale	Comprobante de entrega de efectivo, para la realización de compras o gastos según el concepto definido.	Vale	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	2026-10-02 01:47:48.342+00
ce76ed35-9cfe-4d56-b841-bc9faeaee146	Validación	Confirmación de que el conteo fue realizado correctamente y coincide con el sistema.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.642673+00	\N
38bc65b5-56a1-4bff-9ae7-b4b842891b62	Validación de carga	Confirmación de que los artículos alistados han sido efectivamente cargados en el vehículo.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
956685dd-1a2e-411f-a6e1-bdad3fb73896	Validación general	Proceso en RF para registrar artículos recibidos, incluyendo lote y fecha de vencimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
69f989f3-e848-4083-8dd7-013ac74d4a11	Validación general (en rf)	Una de las dos pantallas utilizadas en la Terminal de Radio Frecuencia para el ingreso de mercadería.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
1d4c950f-1612-428d-a537-e61b4a668b74	Valores organizacionales	Principios fundamentales y creencias que guían el comportamiento y la toma de decisiones dentro de una empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
fda4ffce-abca-40d8-96bd-b5cca68d2341	Variable decisión	Para las fórmulas que se configuran como tablas, la variable de decisión es el criterio para escoger el rango adecuado.	Variable de decisión	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	2026-10-02 01:38:35.241+00
7a261012-2ffb-4e4e-aaa5-a8e219f24218	Variación de precios	El incremento o la disminución del precio de un bien o servicio, ofrecido por un proveedor y notificado mediante una lista de precios.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
a61e8b16-4566-495d-904e-5791f67c4378	Vector	es un tipo de imagen digital que se crea a partir de puntos, líneas, curvas y formas geométricas, en lugar de píxeles. A diferencia de las imágenes rasterizadas (como JPG o PNG), que se basan en una cuadrícula de píxeles, las imágenes vectoriales se construyen con fórmulas matemáticas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
57033a94-22e4-456e-8861-e21e0f63ce1f	Vehículo eléctrico	Es un medio de transporte que funciona con uno o más motores eléctricos, alimentados por la energía almacenada en baterías recargables o, en algunos casos, por una fuente de electricidad externa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
145f178a-0cfa-4239-8920-8377de6718df	Vehículo híbrido	es aquel que utiliza dos fuentes de energía distintas para su propulsión: un motor de combustión interna (generalmente de gasolina) y uno o más motores eléctricos alimentados por una batería		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
ea3b2fb9-f85f-4954-b408-e1b410cb2a87	Vehículo liviano/pasajeros	Son aquellos que transportan en esencia personas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
fe3f8acd-3ee3-45b3-a732-dc60eb0d0d2e	Vehículo pesado	Vehículo de motor con un peso superior a las 3.5 toneladas, utilizado para el transporte de mercancías o personas		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
83365f02-180f-41b2-9b84-64caa69599fa	Vencimiento	Estado que presentan los artículos que utilizan lotes cuando su vida útil ya ha expirado, es decir, cuando se ha sobrepasado la fecha definida como vencimiento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
1ed8ae2a-ad38-4c8f-9928-4e1b952c1a0a	Venta Bruta	Es la sumatoria de la venta excluyendo las bonificaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
387daf71-7103-49c5-bd88-4beb24a5bc44	Venta Neta	Es la sumatoria de la Columna Venta en moneda local o dólar.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
caa9ded0-f931-4aeb-b70f-753d2eda05e8	Ventas	Corresponde a las ventas netas presupuestadas, calculadas como facturación bruta menos devoluciones, descuentos y bonificaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
1e7cbfe5-db38-48bc-9800-915a46827151	Ventas del día	Opción para consultar las ventas realizadas en el día, mostrando datos como la moneda, la fecha, el total de pedidos, renglones, bruto, IVA y neto.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
31469c99-8f49-421d-8373-1a341d8b5963	Versión	Número que indica cambios o actualizaciones en un documento.	Versión	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	2026-10-02 01:48:00.313+00
45111102-9fc7-4b15-a862-760d8e7f2470	Vigencia	Periodo durante el cual el documento es válido y aplicable.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
bed27e34-f3c5-4254-aec1-05363d92e873	Vigilancia	Servicio de seguridad encargado del control de acceso y permanencia en las instalaciones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
4e59a1ae-d67c-413a-bcff-9ddaff5ec92f	Visión / misión / valores	Elementos que definen la razón de ser, objetivos y principios rectores de la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
a00e81c5-2648-44c3-b75e-f0c4e7b9f5c8	Visión por computadora	Tecnología que permite a las computadoras interpretar imágenes y videos (ej. reconocimiento facial).		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
24b8efef-8341-4dac-babd-0f7fa2aeabdc	Visualización	Representación gráfica de la información, como gráficos de barras, líneas o mapas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
21f197bc-6e06-4efb-9879-21754d095abf	Viáticos	Gastos incurridos por un empleado durante un viaje de negocios (hospedaje, comidas, transporte), que son reembolsados por la empresa.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
498d787d-69eb-46a8-ae00-28f51af29545	Vpn (valor presente neto)	Método para evaluar la rentabilidad de una inversión calculando el valor actual de todos los flujos de caja futuros que generará el proyecto. Un VPN positivo indica que el proyecto crea valor.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
4bbd5a69-9f33-4d72-80a6-09a6c0eac31c	WACC	(Costo Promedio Ponderado de Capital) La tasa de costo promedio de todas las fuentes de financiamiento de una empresa. Es la tasa mínima de retorno que una empresa debe generar en sus inversiones.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
13fcc93d-07d6-4c38-bd0c-e6cc60f49ea1	Warusa-kagen	Un término en TQC que se refiere a aspectos que aún no son problemas, pero que aún no están del todo bien. Suelen ser el punto de partida de las actividades de mejora, ya que, si no se atienden, pueden convertirse en problemas graves.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
d7196ad6-855d-42ab-8231-d3db25147019	Wildcard	Carácter que sirve de comodín, por convención se utilizan "?" ​ para cualquier carácter y "*" para cualquier tira de caracteres.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
9baad0db-bf94-41c8-9cca-277e4bfcf9f6	Wizard	Asistente para las funciones de Excel, que presenta una ventana amigable donde usted puede definir los parámetros fácilmente.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
6d6c8348-ca27-46de-b42f-19df46c6e775	WMS	Sistema de gestión de almacenes		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
78412d7d-b371-4b92-818d-62b43cbe9bd8	Workflow	Flujo de trabajo automatizado que define la secuencia de tareas y responsables.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
07178582-ebdb-4bc3-b38b-c06f95ee65e2	Yokoten	Yokoten es una palabra japonesa que significa "implementación horizontal" y se refiere a la práctica de aplicar los buenos resultados de KAIZEN™ de un área a otras. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
f5a3ad08-8158-4e3f-836c-e43ecec65a27	Zona	División geográfica o territorial usada como criterio de segmentación de audiencia.	Zona	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	2026-09-25 13:37:33+00
d69a3e74-99b4-4b67-9999-1e48de379e54	Zona de almacenaje	 Es una división que se realiza dentro del sistema WMS para partir el área total del CEDI en subpartes más pequeñas. Para lograr mejor control sobre la ubicación de la mercadería. Cada artículo se configura para tener una zona de almacenaje principal, y una o varias zonas de extensión en caso de que la zona principal este totalmente llena. 	Zona de Almacen	\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	2026-09-30 19:30:00+00
3f65a5e6-1a71-426b-b6b7-b55f6f3752cc	Zona de trabajo	Área del almacén donde un recurso puede ejecutar tareas.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
88e9ffd0-b273-4038-a96e-f194c3b78d8d	Zona de trabajo de preparación	Corresponde a un espacio de trabajo preparación delimita un espacio de trabajo al que se asocian ciertos recursos de preparación. Los recursos que trabajan en estas zonas son: carretillas eléctricas, carretillas manuales, etc.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
27e7a6c8-a609-454b-929d-3cc1e1f88066	Zonas	Área geográfica donde se encuentran ubicados un conjunto de clientes asignados a un determinado Representante de Ventas. Esta zona debe estar localizada en un área que facilite su adecuada y rentable cobertura quedando bien definidos los límites geográficos para facilitar la tarea de valoración y control.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
f29b9826-21fc-481a-9460-7f10c0b88724	Zonas cola de preparación	Permiten fragmentar el trabajo de preparación de una orden de expedición en tantos grupos como zonas colas de preparación existan		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
1b219451-7b80-40d0-9db1-e2414ae55681	Zonas de operación	Áreas designadas y señalizadas para la circulación o operación segura de vehículos y equipos.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
0ea844e0-82c9-4318-b410-2a4029c35ae0	Zonas de picking	 Son divisiones del almacén que se realizan en eflow WMS para distribuir el trabajo de los alistadores de mercadería hacia un cliente final. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
9abdbd49-94dc-4585-a027-d00da9d1f391	Zonas de trabajo recursos	 Son divisiones del almacén que se realiza en eflow WMS para distribuir el trabajo de los recursos (Montacargas, carretillas hidráulicas, carretillas manuales) en el almacén. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
803d0ce7-88b6-42f4-8e06-ffcc85aaca11	Árbol de surtido	Un sistema de clasificación que organiza los productos en grupos, categorías y subcategorías, con el objetivo de facilitar la toma de decisiones para el resurtido y la inversión eficiente del presupuesto de compra.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
4af62927-ccf6-4300-85df-1c1fc2f9f45a	Área	Dimension que refleja las divisiones principales de la organización.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
5d89ad3f-6494-4554-9d43-a6f34a92fa21	Área funcional	 Área estratégica de algún responsable comercial. En el presente, se manejan  Sistemas, Personal, Control, Mercadeo, Logística, Ventas y Compras. 		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
7d5602d0-c33d-4137-93cc-7f001453fabd	Índice 	Sistema de organización documental por departamento, área, proceso y nombre del documento.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
a96dffcb-fa2c-4ee3-a19e-e4ea9afc0023	Órdenes de expedición	Documentos de salida enviados desde el ERP a eflow WMS que muestran el detalle de un pedido para la generación de acciones y finalizan en el despacho.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
125cd9fb-c7c6-4a4b-806b-3ca5bc9ec218	Órdenes en tránsito	Órdenes de compra que ya han sido registradas en el ERP pero cuya mercancía aún no ha sido recibida y/o facturada. Se usan para proyectar futuros pagos en el flujo de caja.		\N	\N	f	\N	f	f	\N	2026-10-21 17:37:23.646978+00	\N
\.
INSERT INTO may_qa_glosario_sch_core.tbl_terminos (id, termino, definicion, campo_softland, estado_origen, nota_origen, revisado, nota_decision, es_nuevo, editado, eliminado_en, creado_en, actualizado_en) SELECT id, termino, definicion, campo_softland, estado_origen, nota_origen, revisado, nota_decision, es_nuevo, editado, eliminado_en, creado_en, actualizado_en FROM _stg_tbl_terminos ON CONFLICT DO NOTHING;
-- public.definicion_fragmentos → may_qa_glosario_sch_core.tbl_definicion_fragmentos (80 filas)
CREATE TEMP TABLE _stg_tbl_definicion_fragmentos (LIKE may_qa_glosario_sch_core.tbl_definicion_fragmentos) ON COMMIT DROP;
COPY _stg_tbl_definicion_fragmentos (termino_id, orden, contexto, texto) FROM stdin;
54dd51b5-de9c-47a7-ac8f-db288aa0d235	0	Reporte SIM – Dimensión Compras	Dimensión que muestra el código y descripción de los articulos de la compañía.
54dd51b5-de9c-47a7-ac8f-db288aa0d235	1	Reporte SIM – Filtro Compra	Permite seleccionar el código y descripción de uno o varios artículos en específico.
978bbf94-9f13-42c2-b58c-ecaba813d23f	0	Reporte SIM – Dimensión Compras	Refleja la clasificación de los artículos de acuerdo a la nomenclatura BDF.
978bbf94-9f13-42c2-b58c-ecaba813d23f	1	Reporte SIM – Filtro Compra	Permite seleccionar una o mas clasificaciones BDF de articulos.
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	0	Softland	Instalaciones físicas donde se almacenan las materias primas, los productos terminados y los suministros relacionados con la empresa. La definición de privilegios por usuario para cada bodega se realiza en el módulo de Administración del Sistema.
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	1	Reporte SIM – Dimensión Ventas	Muestra las bodegas que conforman los almacenes de las compañías.
63d3eb0a-0cfe-46d0-9755-ae2b044003d4	0	Silo Sistemas	Unidad mínima de información que compone un registro. En una estructura de datos, corresponde a las columnas y representa un atributo específico (ej. Fecha, Monto, SKU).
63d3eb0a-0cfe-46d0-9755-ae2b044003d4	1	Silo Sistemas	Columna creada a partir de una fórmula para mostrar información derivada de los datos originales.
74da4cc1-da25-4776-930a-4f5fe6cb584f	0	Silo Control	El valor total de las deudas que los clientes tienen con la empresa en una fecha determinada. Su análisis por antigüedad de saldos es fundamental para gestionar el riesgo de incobrabilidad.
74da4cc1-da25-4776-930a-4f5fe6cb584f	1	Reporte SIM – Indicador Venta	Sumatoria del total de las Cuentas por Cobrar, es decir el monto total de dinero que los clientes le deben a la compañía.
672bb14a-6d84-48da-bb59-1f4a1f582315	0	Reporte SIM – Dimensión Compras	Muestra las categorias creadas para segmentar los artículos.
672bb14a-6d84-48da-bb59-1f4a1f582315	1	Reporte SIM – Dimensión Ventas	Una categoría es una clasificación o grupo que se utiliza para agrupar elementos que comparten características o propiedades comunes.
672bb14a-6d84-48da-bb59-1f4a1f582315	2	Reporte SIM – Filtro Compra	Permite seleccionar una o mas categorias especificas de los articulos.
672bb14a-6d84-48da-bb59-1f4a1f582315	3	Silo Compras	Una clasificación dentro de un grupo, donde cada grupo debe contener un rango de 10 a 30 categorías. Los nombres de categorías deben ser descritos en singular, en mayúsculas y sin acento, y no deben llevar conectores. Es la clasificación más general de un producto.
54c95665-119b-4a6d-a401-7a7f3d1abc29	0	Reporte SIM – Filtro Venta	Permite seleccionar una o mas categorias de clientes.
54c95665-119b-4a6d-a401-7a7f3d1abc29	1	Reporte SIM – Dimensión Ventas	Muestra la clasificación que se utiliza para agrupar a los clientes de la compañía.
2da438cf-e4ff-42ab-9d96-330753c41554	0	Silo Ventas	Persona natural o jurídica, debidamente registrada que realiza transacciones sobre los bienes comercializados.
2da438cf-e4ff-42ab-9d96-330753c41554	1	Reporte SIM – Dimensión Ventas	Muestra los clientes que adquieren los productos y servicios de la organización.
705656df-3e02-4d5d-b5e3-03ab5c140722	0	Silo Personal	Persona que trabaja en la empresa y está sujeta a sus normas y políticas.
705656df-3e02-4d5d-b5e3-03ab5c140722	1	Reporte SIM – Dimensión Personal	Refleja a todas las personas que presta sus servicios para la compañía, contribuyendo al logro de sus objetivos y metas.
99f2e0b3-21cf-4ecc-bae8-092d688c8631	0	Silo Compras / Silo Mercadeo	Se refiere a una oferta que agrupa varios productos, a menudo a un precio reducido, para incentivar la compra. Los productos en un combo no necesariamente se utilizan juntos, pero se venden como un paquete promocional.
f22bccba-178e-4b14-885d-4446ab180ab0	0	Silo Control	Resultado de restar el costo de la mercancía vendida (CMV) a las ventas netas. Refleja el ingreso disponible para cubrir gastos operativos y generar utilidad.
f22bccba-178e-4b14-885d-4446ab180ab0	1	Reporte SIM – Indicador Compra	Esta fórmula calcula la ganancia inicial de la compañía. Simplemente, resta el costo directo de lo que vendiste (el costo de venta) de los ingresos totales que generaste (la venta neta).
33a985f1-dd16-4c84-af75-bd3a3b0f086c	0	Eprac	Corresponde al flujo directo de mercancía a través de una instalación, de muelle de recepción al muelle de expedición, eliminando la necesidad de almacenamiento y alisto.
33a985f1-dd16-4c84-af75-bd3a3b0f086c	1	Silo Logística	Transferencia directa de mercancías de un transporte a otro, sin almacenar en el almacén.
59a49b15-f234-491f-8349-493ae498b8fc	0	Softland	Unidad funcional de la empresa, en la cual se agrupan las actividades que son semejantes y están relacionadas lógicamente entre sí. El departamento representa la estructura formal de la organización tal como aparecería en un organigrama.
59a49b15-f234-491f-8349-493ae498b8fc	1	Reporte SIM – Dimensión Personal	Muestra las sub divisiones que existen dentreo de las areas de la compañia.
1195ac80-39fd-41c1-8311-170a69b12bea	0	Silo Ventas	proceso en el que un cliente devuelve un producto a un vendedor o empresa. Esto puede suceder por varias razones, como que el producto esté defectuoso, sea del tamaño o color incorrecto, o simplemente no cumpla con las expectativas del cliente.
1195ac80-39fd-41c1-8311-170a69b12bea	1	Reporte SIM – Indicador Venta	Suma de la venta multiplicando por -1, se aplica para todos los documentos con estado “D”.
1cc466a1-9c72-42f0-bc69-16a0385799b6	0	Silo Control	Métrica que mide el porcentaje de productos devueltos en relación con el total de ventas. Se calcula como (Valor de Devoluciones / Ventas Totales) x 100. Es un indicador de la calidad del producto y la satisfacción del cliente.
1cc466a1-9c72-42f0-bc69-16a0385799b6	1	Reporte SIM – Indicador Venta	El porcentaje de productos vendidos que son devueltos por los clientes.
7fcee247-f184-482b-95e2-12052d652da6	0	Silo Control	Métrica de cadena de suministro que mide el porcentaje de la demanda de un cliente que se satisface con el inventario disponible de forma inmediata.
7fcee247-f184-482b-95e2-12052d652da6	1	Silo Logística	La tasa de cumplimiento o nivel de servicio, es un indicador que mide el porcentaje de pedidos de clientes que se entregan completos y a tiempo.
7fcee247-f184-482b-95e2-12052d652da6	2	Reporte SIM – Indicador Compra	Mercancía recibida entre mercancía solicitada.
c3e39344-e626-4774-a756-9c4bd7ecd480	0	Silo Control	Beneficio generado por las operaciones principales del negocio, antes de deducir intereses e impuestos. Mide la eficiencia y rentabilidad del core business.
c3e39344-e626-4774-a756-9c4bd7ecd480	1	Reporte SIM – Indicador Control	Suma de las ganancias obtenidas de las operaciones principales de la empresa.
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	0	Silo Control	Costos incurridos en las actividades principales del negocio, excluyendo el costo de la mercancía vendida (CMV), intereses e impuestos.
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	1	Reporte SIM – Indicador Control	Suma total de los gastos incurridos en las operaciones cotidianas de la empresa.
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	0	Reporte SIM – Dimensión Compras	Muestra la agrupación de marcas asignadas por comprador.
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	1	Reporte SIM – Filtro Compra	Permite visualizar la informaciónen en base a la selección de uno o mas Grupos compra.
de73a61a-fcc0-481c-a899-30bb66710c76	0	Silo Control	Costo financiero por el uso de dinero prestado, o el rendimiento generado por prestarlo.
5bd88f67-1138-4455-9c8f-78a370219935	0	Silo Control	Representa el valor de las mercancías disponibles para la venta. La gestión de inventario busca equilibrar la disponibilidad del producto con el costo de mantenerlo.
5bd88f67-1138-4455-9c8f-78a370219935	1	Silo Logística	Registro detallado de las existencias de productos en un almacén, incluyendo cantidades, ubicaciones y estado.
5bd88f67-1138-4455-9c8f-78a370219935	2	Reporte SIM – Indicador Compra	Sumatoria de la Columna Inventario en moneda local o dólar dividido entre el número de meses consultados (Se tomarán en cuenta los inventarios al cierre de mes y el último inventario registrado para el mes actual).
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	0	Silo Control	Es el margen de contribución después de considerar el efecto de los descuentos o bonificaciones (rebates) acordados con clientes o proveedores.
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	1	Reporte SIM – Indicador Compra	Margen de contribución total sobre las ventas netas.
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	0	Silo Control	Valor objetivo a alcanzar, que en un entorno de control y Kaizen, a menudo se define como cero errores u operación bajo condiciones óptimas.
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	1	Reporte SIM – Indicador Venta	Es el monto a alcanzar de la venta neta asignado por vendedor. Sumatoria de la columna Meta en moneda local y dólar. venta del cliente activo de los últimos 6 meses * meta del vendedor.
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	0	Silo Personal	Cambio de puesto o área de un colaborador dentro de la organización, que puede ser horizontal (rotación) o vertical (ascenso o descenso).
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	1	Reporte SIM – Dimensión Personal	Cambio de puesto o área de un colaborador dentro de la organización, que puede ser horizontal (rotación) o vertical (ascenso o descenso), de acuerdo al esquema establecido.
51c67093-938d-466d-9304-d7a6e6feb924	0	Silo Control	(Órdenes de Compra por Recibir) Se refiere a los productos que ya han sido ordenados a un proveedor pero que aún no han ingresado físicamente al inventario de la empresa.
51c67093-938d-466d-9304-d7a6e6feb924	1	Reporte SIM – Indicador Compra	Cantidad de OC en tránsito más backorder que no han sido recibidas por el almacén.
18ee3b43-b6dc-46ee-a491-070865869011	0	Reporte SIM – Dimensión Compras	Muestra los países que represntan el origen de la compra de mercancía del proveedor.
18ee3b43-b6dc-46ee-a491-070865869011	1	Reporte SIM – Filtro Logística	Permite filtrar por uno o mas países el origen de la compra de mercancía del proveedor.
c61e584b-547e-412b-b8b7-6d16798c6be5	0	Reporte SIM – Dimensión Compras	Muestra la clasificacion de los artículos del surtido regular segun la categoría de colores: “Verde”, “Amarillo”, “Naranja” y “Rojo”. Estas categorías reflejan el comportamiento de los artículos en los últimos doce meses, basándose en tres indicadores específicos: contribución, clientes activados y rotación de inventario.
c61e584b-547e-412b-b8b7-6d16798c6be5	1	Reporte SIM – Dimensión Ventas	Es una clasificación ordenada de elementos (como personas, productos o empresas) basada en un criterio o métrica específica. Es una herramienta para comparar y evaluar el rendimiento o la importancia de algo dentro de un grupo.
d52be40b-6939-41d4-a93f-c52027dcfc9f	0	Silo Control	Descuento o bonificación que un proveedor otorga retroactivamente por alcanzar un volumen de compra determinado durante un período.
d52be40b-6939-41d4-a93f-c52027dcfc9f	1	Reporte SIM – Indicador Control	Suma total de los descuentos recibidos por las comercializadoras.
35fb9800-845b-4c24-8310-0b9411fb5f3a	0	Eprac	Proceso de recibo de artículos en el CEDI, ya sea por primera vez o reintegrados por una razón comercial.
35fb9800-845b-4c24-8310-0b9411fb5f3a	1	Silo Logística	Proceso de ingreso de mercancías al CEDI, incluye descarga, revisión documental y registro en el WMS.
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	0	Silo Ventas / Reporte SIM – Dimensión Ventas	Porción del país que agrupa un conjunto de coordinaciones geográficamente cercanas que componen el territorio de ventas.
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	1	Reporte SIM – Filtro Venta	Ubicación geográfica del cliente.
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	0	Reporte SIM – Indicador Compra	Sumatoria de la cantidad de renglones facturados.
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	1	Reporte SIM – Indicador Venta	Esta fórmula representa el número total de artículos o líneas de detalle que se han facturado en un período de tiempo específico.
3205d947-4b83-4783-85df-b241dff36fca	0	Reporte SIM – Indicador Compra	Sumatoria de la cantidad de renglones pedidos.
3205d947-4b83-4783-85df-b241dff36fca	1	Reporte SIM – Indicador Venta	Esta fórmula calcula el número total de líneas de detalle en todos los pedidos que se han recibido en un período de tiempo determinado.
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	0	Silo Control	Métrica que mide la eficiencia con la que se gestiona un activo, como el inventario. La rotación de inventario se calcula como.
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	1	Reporte SIM – Indicador Compra	Rotación anual de inventario. Cantidad de veces que la compañía vende y reemplaza el inventario en el año.
79a29291-7ef4-4c12-86fe-531df77276bf	0	Silo Ventas	Códigos de productos que están actualmente disponibles para la venta en el inventario.
79a29291-7ef4-4c12-86fe-531df77276bf	1	Reporte SIM – Indicador Venta	SKU con ventas mayores que cero.
5ebe4eaf-9346-4ed8-8604-3aa57aec8c58	0	Silo Logística	Variante simétrica del MAPE para reducir distorsiones.
fa757d8e-dd8a-4f61-b6ab-9cb2cbbd13f1	0	Silo Logística	Plataforma de la cadena de suministro diseñada para optimizar los procesos S & OP actuales.
4eddd612-e921-49aa-b4ce-c1540976cc8d	0	Reporte SIM – Dimensión Compras	Una división más específica dentro de una categoría.
4eddd612-e921-49aa-b4ce-c1540976cc8d	1	Reporte SIM – Filtro Compra	Permite filtrar por una o mas divisiones específicas dentro de una categoría.
7b4711b1-75f6-43d9-8183-9aec39fd2dee	0	Silo Personal	Proceso planificado de identificación, evaluación y desarrollo de talento interno para asegurar la cobertura futura de posiciones críticas o clave dentro de la organización.
7b4711b1-75f6-43d9-8183-9aec39fd2dee	1	Reporte SIM – Indicador Personal	Es un proceso estratégico mediante el cual una organización identifica y prepara a colaboradores clave con el potencial (N) y el desempeño (M/P) necesario para ocupar posiciones críticas en el futuro, asegurando así la continuidad del liderazgo y la operación del negocio.
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	0	Silo Compras	Se refiere a cómo se debe preparar un pedido antes de su envío: pieza, inner, caja, tarima, kg, rollo.
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	1	Silo Logística	Define desde cuál nivel de empaque se realiza el picking (preparación de pedidos) en el almacén para despacho al cliente. Los valores aplicables son: unidad, inner, caja, tarima.
2351ce25-b4aa-43a6-9da7-dc63a17d5588	0	Silo Procesos	Capacidad de seguir el historial, aplicación y cumplimiento de una norma o proceso.
2351ce25-b4aa-43a6-9da7-dc63a17d5588	1	Silo Logística	Registro digital completo de cada pedido desde recepción hasta entrega final.
\.
INSERT INTO may_qa_glosario_sch_core.tbl_definicion_fragmentos (termino_id, orden, contexto, texto) SELECT termino_id, orden, contexto, texto FROM _stg_tbl_definicion_fragmentos ON CONFLICT DO NOTHING;
-- public.sugerencias_diccionario → may_qa_glosario_sch_core.tbl_sugerencias_diccionario (171 filas)
CREATE TEMP TABLE _stg_tbl_sugerencias_diccionario (LIKE may_qa_glosario_sch_core.tbl_sugerencias_diccionario) ON COMMIT DROP;
COPY _stg_tbl_sugerencias_diccionario (id, termino_id, confianza, orden, estado, maestro_sugerido, elegido_columna, elegido_tabla, elegido_etiqueta, elegido_maestro, decidido_en, decidido_por, fuente) FROM stdin;
s000	e36e4409-2f84-4cd7-be22-0488fa92b308	Alta	0	aplicada	Proveedor	CATEGORIA_PROVEED	CATEGORIA_PROVEED	Categoría Proveedor	Proveedor	2026-10-02 01:34:54.604+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s001	35b0dfde-ef5a-46f7-9ff1-5d1e554aa3ab	Alta	1	aplicada		CONSECUTIVO	CONSECUTIVO	Consecutivo	\N	2026-10-02 01:35:31.286+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s002	16fb12bd-227c-4bd9-847f-6468b69c2452	Alta	2	aplicada	Empleado	CONTRIBUCION_VAC	CONTRIBUCION_VAC	Contribución Vacacional	Empleado	2026-10-02 01:35:46.846+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s003	7dde307a-6882-47d7-8f30-c27f0d1817a9	Alta	3	aplicada	Artículo	COSTO_COMPARATIVO	ARTICULO	Costo Comparativo	Artículo	2026-10-02 01:35:56.998+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s004	133e4395-58f4-47b5-9ce9-cd6f06c076b2	Alta	4	aplicada	Artículo	COSTO_FISCAL	ARTICULO	Costo Fiscal	Artículo	2026-10-02 01:36:03.604+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s005	ab1115fd-0473-4a60-81f5-21fc7bdee866	Alta	5	aplicada	Empleado	CALCULO_VACACIONAL	CALCULO_VACACIONAL	\N	Empleado	2026-10-02 01:36:31.936+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s006	59a49b15-f234-491f-8349-493ae498b8fc	Alta	6	aplicada	Empleado	DEPARTAMENTO	DEPARTAMENTO	Departamento	Empleado	2026-10-02 01:36:44.548+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s007	1cc466a1-9c72-42f0-bc69-16a0385799b6	Alta	7	aplicada		DEVOLUCION	DEVOLUCION	\N	\N	2026-10-02 01:36:54.598+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s008	68c167e2-d50e-4e74-8b5f-fcf9e519eb41	Alta	8	aplicada	Empleado	EMPLEADO	EMPLEADO	Empleado	Empleado	2026-10-02 01:37:02.176+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s009	4c23bf01-82bb-476d-954f-3fc4a8fb5c5a	Alta	9	aplicada		FACTURA	FACTURA	Factura	\N	2026-10-02 01:37:08.304+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s010	29f13494-d82e-4112-8b21-660e2b57c00e	Alta	10	descartada		\N	\N	\N	\N	2026-10-02 01:37:20.72+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s011	5537d68f-f723-4795-b794-019b29214bb0	Alta	11	aplicada		INDICADOR	INDICADOR	\N	\N	2026-10-02 01:37:26.956+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s012	e7b33b6d-f3a2-4a16-ad91-f9d6fbcc4f11	Alta	12	aplicada		LIQUIDACION	LIQUIDACION	\N	\N	2026-10-02 01:37:45.761+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s013	203ac07f-1298-4f6f-b771-3830027938cf	Alta	13	aplicada		LOCALIZACION	LOCALIZACION	Localización	\N	2026-10-02 01:38:01.501+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s014	835e7ca0-d43c-4f37-b34a-357c6e52e848	Alta	14	aplicada	Cliente	LIMITE_CREDITO	CLIENTE	Límite Crédito	Cliente	2026-10-02 01:38:06.573+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s015	e51e4332-4e3a-411b-9fd6-c62ed14d33cc	Alta	15	aplicada		META	META	\N	\N	2026-10-02 01:38:13.2+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s016	d3b29032-77be-46ae-b1f8-ba95e0e516c8	Alta	16	aplicada		PORC_DESCUENTO	ORDEN_COMPRA	Porcentaje Descuento	\N	2026-10-02 01:38:22.818+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s017	91fbfea8-a0c8-4b02-b665-3b9e2b97c548	Alta	17	aplicada	Empleado	REGIMEN_VACACIONAL	REGIMEN_VACACIONAL	Regimen Vacacional	Empleado	2026-10-02 01:38:25.351+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s018	2b45e1ea-32c8-4d27-aeac-47c707210c51	Alta	18	aplicada	Empleado	SALARIO_DIARIO_INT	EMPLEADO	Salario Diario Integrado	Empleado	2026-10-02 01:38:28.899+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s019	fda4ffce-abca-40d8-96bd-b5cca68d2341	Alta	19	aplicada		VARIABLE_DECISION	CONCEPTO	Variable de decisión	\N	2026-10-02 01:38:35.24+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s020	560ba3fb-0a79-4ae8-b895-0b93684a02dd	Media	20	aplicada	Artículo	ACTIVO	ARTICULO	Activo	Artículo	2026-10-02 01:38:37.244+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s021	54dd51b5-de9c-47a7-ac8f-db288aa0d235	Media	21	aplicada	Artículo	ARTICULO	ARTICULO	Artículo	Artículo	2026-10-02 01:38:51.612+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s022	9cb95e2f-92a6-412d-8cfb-9ef066b35505	Media	22	aplicada	Artículo	ARTICULO	ARTICULO	Artículo	Artículo	2026-10-02 01:38:55.261+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s023	d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	Media	23	aplicada	Artículo	ARTICULO	ARTICULO	Artículo	Artículo	2026-10-02 01:38:57.091+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s024	4a43bcfb-60e4-4479-a0d5-1dc339273837	Media	24	aplicada		ASIENTO	EMBARQUE	Asiento	\N	2026-10-02 01:39:02.557+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s025	f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	Media	25	aplicada		BODEGA	BODEGA	Bodega	\N	2026-10-02 01:39:09.268+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s026	c4ed6b87-b155-4324-b142-422bfc746f46	Media	26	aplicada		CENTRO_COSTO	CENTRO_COSTO	Centro de Costo	\N	2026-10-02 01:39:22.833+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s027	e41c3b16-7eca-4119-8883-0200ba956f05	Media	27	aplicada		CENTRO_COSTO	CENTRO_COSTO	Centro de Costo	\N	2026-10-02 01:39:24.531+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s028	2da438cf-e4ff-42ab-9d96-330753c41554	Media	28	aplicada	Cliente	CLIENTE	CLIENTE	Cliente	Cliente	2026-10-02 01:39:28.79+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s029	57bc8c06-7952-4fdd-9b1e-9b1df66d925d	Media	29	aplicada		COMPANIA	COMPANIA	Compañía	\N	2026-10-02 01:39:44.983+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s030	950aed9e-4739-4f2d-8ea6-21609a741d09	Media	30	aplicada		CONCEPTO	CONCEPTO	Concepto	\N	2026-10-02 01:39:49.11+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s031	7add3bb1-6d86-48a2-861a-ccb64935d6c0	Media	31	aplicada		CONTABILIDAD	ASIENTO_DE_DIARIO	CONTABILIDAD	\N	2026-10-02 01:40:30.013+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s032	f3e0961e-aadd-4be1-882b-34341aca2e61	Media	32	aplicada	Empleado	CTA_BANCARIA	DOCUMENTOS_CC	Cuenta Bancaria	Empleado	2026-10-03 10:42:46.945+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s033	6f3df057-63d5-4fbb-890a-117be5f2ded4	Media	33	aplicada		CUENTA_CONTABLE	CUENTA_CONTABLE	Cuenta Contable	\N	2026-10-02 01:41:28.031+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s034	dc6d69af-9a09-4be2-b81c-e17a7c8dbc94	Media	34	aplicada		CTA_CXC	PAIS	Cuenta Cuentas por Cobrar	\N	2026-10-02 01:41:32.213+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s035	d5157c64-ba43-4814-8c6b-8a2944308847	Media	35	aplicada	Proveedor	CTA_CXP	CATEGORIA_PROVEED	Cuenta Cuentas por Pagar	Proveedor	2026-10-02 01:41:33.54+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s036	968e71bc-13de-45ba-9dbc-438bc52c2110	Media	36	aplicada		DOCUMENTO	DOCUMENTO	Código Documento	\N	2026-10-02 01:41:37.05+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s037	a2c33f56-078c-477e-80bd-02e299150046	Media	37	aplicada		DOCUMENTO	DOCUMENTO	Código Documento	\N	2026-10-02 01:41:50.817+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s038	d1c7b315-69ab-430f-a0a1-c97ada716727	Media	38	aplicada		EMBARQUE	EMBARQUE	Embarque	\N	2026-10-02 01:41:53.513+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s039	c37a4105-9af2-405a-bbae-05b5b78150a1	Media	39	descartada		\N	\N	\N	\N	2026-10-03 10:43:25.84+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s040	41de50a8-f938-4c77-9299-b1f5b89ef76f	Media	40	aplicada		FECHA	FECHA	Fecha	\N	2026-10-02 01:42:25.128+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s041	abaded62-063f-4c35-a64c-6d6c1a566f40	Media	41	aplicada		FECHA_OFRECIDA	ORDEN_COMPRA	Fecha Ofrecida	\N	2026-10-02 01:42:29.91+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s042	0d59e30a-eec9-4b48-bbb6-3a8f7548f825	Media	42	aplicada		FECHA_REQUERIDA	ORDEN_COMPRA	Fecha Requerida	\N	2026-10-02 01:42:31.101+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s043	852466dd-8ace-4204-a730-b7bf91dc365f	Media	43	aplicada		FECHA_REQ_EMBARQUE	ORDEN_COMPRA	Fecha Requerida Embarque	\N	2026-10-02 01:42:32.731+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s044	94d0f325-3853-4841-9f0c-a24056459342	Media	44	aplicada		FLUJO_CAJA	FLUJO_CAJA	Flujo de Caja	\N	2026-10-02 01:42:34.212+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s045	306b3852-8727-455b-981a-60627913d027	Media	45	aplicada		FORMATO	FORMATO	Formato	\N	2026-10-02 01:42:35.399+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s046	9f909e1b-cd3b-4ba6-a90d-ed7a2211b8ba	Media	46	aplicada		HORARIO	HORARIO	Horario	\N	2026-10-02 01:42:36.85+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s047	bbfc56b8-4711-43f6-bdb6-dc85366bb63a	Media	47	aplicada		INCOTERMS	FACTURA	Incoterms	\N	2026-10-02 01:42:40.187+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s048	2b6079e7-9678-4cce-a2b3-38c8ebdab75e	Media	48	aplicada	Cliente	TASA_INTERES_MORA	CLIENTE	Interés Mora	Cliente	2026-10-02 01:42:42.746+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s049	e9e1ea5d-1147-45aa-a489-f7d608b42bce	Media	49	aplicada		INVERSION	INVERSION	Inversión	\N	2026-10-02 01:42:44.919+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s050	4f916722-8b46-415f-91d5-4d8059827ef2	Media	50	aplicada	Empleado	NOMINA	NOMINA	Nómina	Empleado	2026-10-02 01:42:45.952+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s051	5de2451a-e107-4a8a-9c5d-15d3773d2ee9	Media	51	aplicada		ORDEN_COMPRA	ORDEN_COMPRA	Orden Compra	\N	2026-10-02 01:42:47.073+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s052	5e3ec8b9-177a-42d8-9570-ad4ae4c5e796	Media	52	aplicada		PEDIDO	PEDIDO	\N	\N	2026-10-02 01:42:50.746+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s053	9a7a3645-cbad-427e-ad31-06477e2dfcec	Media	53	aplicada		PRIORIDAD	ORDEN_COMPRA	Prioridad	\N	2026-10-02 01:42:55.941+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s054	cb7cca2b-6e5b-4a35-9497-ce87658167cb	Media	54	aplicada	Empleado	PUESTO	PUESTO	Puesto	Empleado	2026-10-02 01:42:58.243+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s055	e8bc8672-faea-4f4c-b003-82e9db5f9b02	Media	55	aplicada	Empleado	REPORTE	NOMINA	\N	Empleado	2026-10-02 01:43:01.278+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s056	e429df0b-36de-4035-bdb3-68fc6d7fe913	Media	56	aplicada	Cliente	SALDO	CLIENTE	Saldo	Cliente	2026-10-02 01:43:03.84+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s057	ab7a75da-ad32-4af5-9057-25a02ee7754f	Media	57	aplicada		SALDO_BANCOS	CUENTA_BANCARIA	Saldo según Bancos	\N	2026-10-02 01:43:05.015+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s058	6d4ac37a-add0-4666-af29-e02dd112c489	Media	58	aplicada		SALDO_NORMAL	CUENTA_CONTABLE	Saldo Normal	\N	2026-10-02 01:43:06.157+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s059	2240bfcf-6b5b-4cfe-9bc7-a8d519f9f5a8	Media	59	aplicada		SOLICITUD_OC	SOLICITUD_OC	Solicitud de Compra	\N	2026-10-02 01:43:07.588+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s060	264823e9-dfda-4a88-b0c4-90f695ac85ec	Media	60	aplicada		TIPO_ASIENTO	TIPO_ASIENTO	Tipo de Asiento	\N	2026-10-02 01:43:16.423+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s061	dfe56a6e-7106-47bb-bf4c-100185c40cf9	Media	61	aplicada		TIPO_CAMBIO	TIPO_CAMBIO	Tipo Cambio	\N	2026-10-02 01:43:24.495+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s062	e23d656f-8c3e-4366-bbaf-190025163170	Media	62	aplicada	Artículo	TIPO_TRANSACCION	ARTICULO	Tipo Transacción	Artículo	2026-10-02 01:43:30.982+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s063	3818befa-bd67-48a3-bb6c-ea5a8001f76f	Media	63	aplicada		UNIDAD_MEDIDA	CLASIFICACION	Unidad de Medida	\N	2026-10-02 01:43:42.833+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s064	9b832008-8b58-4016-b716-f08e6da13959	Media	64	aplicada		USUARIO	USUARIO	Usuario	\N	2026-10-02 01:47:42.986+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s065	aebf0e13-48cd-4ec4-8635-0ef01c9778ce	Media	65	aplicada	Empleado	VACS_ADICIONALES	EMPLEADO	Vacaciones adicionales	Empleado	2026-10-02 01:47:45.878+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s066	8a87022f-31b1-4504-b089-dc78b81e0d27	Media	66	aplicada		VALE	VALE	Vale	\N	2026-10-02 01:47:48.342+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s067	31469c99-8f49-421d-8373-1a341d8b5963	Media	67	aplicada		VERSION	CUENTA_CONTABLE	Versión	\N	2026-10-02 01:48:00.313+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s068	f69f1e62-c818-4c57-ba7a-cafc356bed17	Baja	68	descartada		\N	\N	\N	\N	2026-10-02 01:48:15.831+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s069	6dd8d1ea-c987-4da3-86d4-533d5e718643	Baja	69	aplicada		DESPACHO	DESPACHO	\N	\N	2026-10-02 01:48:20.411+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s070	4fc7c8a4-e653-4a44-bc96-b345fe6b5de4	Baja	70	aplicada		HANDHELD	ARCHIVO_HANDHELD	\N	\N	2026-10-02 01:48:35.826+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s071	55f7d2ad-b94f-4da6-9daf-917100539ed6	Baja	71	aplicada	Empleado	ACCION_PERSONAL	CALC_VAC_DETALLE	Número Acción	Empleado	2026-10-02 01:48:46.417+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s072	4a62a163-f307-46c2-8b9f-dd456bb3c7a1	Baja	72	aplicada		ACTIVIDAD	ACT_ECONO_SGRL	Actividad Económica SGRL	\N	2026-10-02 01:48:47.756+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s073	7ab3d352-4745-4dc0-b321-f40d02a1d394	Baja	73	aplicada		ADELANTO	COMPROMISO_PP	\N	\N	2026-10-02 01:48:49.085+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s074	eee64272-fb29-4353-a8cd-919f802951ca	Baja	74	aplicada		AGENTE	AGENTE_ASOC_RT	AGENTE	\N	2026-10-02 01:48:50.292+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s075	fd94e0a3-32d5-46df-9298-53696467dd83	Baja	75	descartada		\N	\N	\N	\N	2026-10-02 01:49:05.044+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s076	26e00352-72ab-4d3b-91a2-f47d84317719	Baja	76	aplicada		APLICA	DET_MOD_RETENCION	Aplicar	\N	2026-10-02 01:49:20.619+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s077	6efeaa8c-1c50-4f58-97ae-179de8cd4d1a	Baja	77	aplicada		TIPO_GARANTIA	GARANTIAS_DOC_FA	Artículo garantía	\N	2026-10-02 01:49:29.829+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s078	2d44a9ce-0df7-43cb-8d0c-04ee5bb1e93b	Baja	78	aplicada		ATRIBUTO	ATRIBUTO	\N	\N	2026-10-02 01:49:32.408+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s079	322927ed-2f94-40d6-b731-3bcf52815d50	Baja	79	aplicada		BENEFICIARIO	DET_TRANS_CB	\N	\N	2026-10-02 01:49:37.546+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s080	cdbdf3f6-82b3-4e54-bf7e-c7afa108fcc7	Baja	80	aplicada		CAJA	CAJA	\N	\N	2026-10-02 01:49:40.552+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s081	722d3b03-deef-42a7-b4d1-daa174746cf1	Baja	81	aplicada		CLASIFICACION_ART	RETENCIONES	Clasificación Artículo	\N	2026-10-02 01:49:51.537+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s082	5f0c90f2-00c8-47a4-9361-44d8db8d4cc1	Baja	82	aplicada		CLIENTE_REPORTE	DOCUMENTOS_CC	Cliente Reporte	\N	2026-10-02 01:49:53.428+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s083	075f07d5-10ab-4417-8c6b-6f2b0d5c3f6a	Baja	83	descartada		\N	\N	\N	\N	2026-10-02 01:50:02.942+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s084	1f819569-19c1-4ab0-8a10-cf930aa5fe9c	Baja	84	aplicada		CLIENTES_INACTIVOS	GLOBALES_RUTEO	\N	\N	2026-10-02 01:50:05.94+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s085	bbb04904-62a7-4425-b4e6-872b97e1a99d	Baja	85	aplicada		COBRO	COBRO_POS	COBRO	\N	2026-10-02 01:50:07.525+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s086	52b95173-f65c-4f6a-98c0-c3e473e46798	Baja	86	aplicada	Artículo	COLOR	ARTICULO	\N	Artículo	2026-10-02 01:50:08.961+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s087	0f871c56-32d1-4abd-9dce-682d15668aa6	Baja	87	aplicada		COMBINACION	SP_PROBABILIDAD	\N	\N	2026-10-02 01:50:10.365+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s088	df2a5f2b-824b-4b7e-aae4-8daa90fd06fd	Baja	88	aplicada		CONTRATO	CONTRATO	\N	\N	2026-10-02 01:50:11.741+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s089	b0608711-832b-4136-9926-1664648eafda	Baja	89	aplicada		CONVERSION	CUENTA_CONTABLE	Conversión	\N	2026-10-02 01:50:13.052+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s090	9c20735f-ee7e-463d-b36b-869290a8aad2	Baja	90	aplicada		COSTO	ASOC_HERRAM	\N	\N	2026-10-02 01:50:22.017+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s091	bdc5f517-6576-48c9-83e6-86472237bc3e	Baja	91	aplicada		CREDITO	ASIENTOS_CHEQUE	Crédito	\N	2026-10-03 10:43:31.66+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s092	c6a2c8d2-c803-4903-8679-93f05c4534e7	Baja	92	aplicada		CUENTA_GASTO	CENTRO_CUENTA	Cuenta Gasto	\N	2026-10-03 10:43:33.198+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s093	3b052d4d-96c6-4b18-87aa-16a203a6103f	Baja	93	aplicada		CODIGO_BARRAS	ACTIVO_DESMANTELAMIENTO	Código barras	\N	2026-10-03 10:43:35.847+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s094	fb2a3361-e143-4f6c-ac25-931c77dc9727	Baja	94	descartada		\N	\N	\N	\N	2026-10-03 10:43:55.018+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s095	fb404425-9f5b-4d1a-98de-b3fcfe886e9d	Baja	95	descartada		\N	\N	\N	\N	2026-10-03 10:44:01.346+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s096	75f88e1b-531f-4ecd-8424-f1c5fe55c4a1	Baja	96	aplicada		DEBITO	ASIENTOS_CHEQUE	Débito	\N	2026-10-03 10:44:12.909+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s097	e7700a11-52c5-43d7-9287-0e675e2538d4	Baja	97	descartada		\N	\N	\N	\N	2026-10-03 10:44:21.361+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s098	66db2076-eb9b-45d7-b230-4a6aa148eed3	Baja	98	aplicada		DEPOSITO	DEPOSITO_POS	\N	\N	2026-10-03 10:44:26.958+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s099	59f44e56-9e9a-4117-b1b2-251221005813	Baja	99	aplicada		DEPRECIACION	ME_PREVIA_MEDIO_PERU	\N	\N	2026-10-03 10:44:29.391+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s100	9dc7b33d-dd2c-42ed-b0ca-f63e2cb240b2	Baja	100	aplicada		DESCRIPCION_CUENTA	CG_CERTIFICADO_RET	\N	\N	2026-10-03 10:44:34.356+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s101	11fc47a9-1e3c-4662-8385-3d03cb1ec7e4	Baja	101	aplicada		DESCUENTO_LINEA	CONTRATO_LINEA	Descuento por Línea	\N	2026-10-03 10:44:39.491+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s102	08a9a1ab-f0b0-45b2-ac66-fdf8201610da	Baja	102	aplicada		DESCUENTO_PRONTO_PAGO	GLOBALES_RUTEO	\N	\N	2026-10-03 10:44:41.514+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s103	d7f83fa7-69c6-4a75-b2b0-dc12e25df4ec	Baja	103	descartada		\N	\N	\N	\N	2026-10-03 10:44:51.172+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s104	1195ac80-39fd-41c1-8311-170a69b12bea	Baja	104	aplicada		DEVOLUCION	DEVOLUCION	\N	\N	2026-10-03 10:44:57.246+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s105	9012680a-f2f8-4c20-8395-b4aa20e7d77d	Baja	105	descartada		\N	\N	\N	\N	2026-10-03 10:45:02.844+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s106	962a1e6d-a4de-4fe9-9451-0374976d7ace	Baja	106	descartada		\N	\N	\N	\N	2026-10-03 10:45:12.769+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s107	b4c3661b-881a-44b5-af92-16e5c1705f09	Baja	107	aplicada		DIAS_VACACIONES	BENEFICIOS_ANTIGUE	\N	\N	2026-10-03 10:45:15.784+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s108	06a658bc-c0c0-41e9-8add-cf3e39ce65f0	Baja	108	descartada		\N	\N	\N	\N	2026-10-03 10:45:19.937+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s109	1f89de2d-be3e-4142-b6b2-4a28454e2f9c	Baja	109	descartada		\N	\N	\N	\N	2026-10-03 10:45:23.25+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s110	3a8587e8-f662-41b4-aa52-6a3409be7a96	Baja	110	descartada		\N	\N	\N	\N	2026-10-03 10:45:29.395+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s111	4f08050d-3ef8-4c1f-b9a9-09c0da44cbbe	Baja	111	descartada		\N	\N	\N	\N	2026-10-03 10:45:38.709+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s112	76db48c0-495b-40ed-aba3-da360432b072	Baja	112	aplicada		FUENTE	ASIENTO_DISTRIBUID	\N	\N	2026-10-03 10:45:41.834+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s113	829963e2-5428-466a-8234-3f6a34cc49ca	Baja	113	descartada		\N	\N	\N	\N	2026-10-03 10:45:46.355+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s114	589c89ef-5bd7-4272-9045-51df779f4cc5	Baja	114	aplicada		GASTO_COMPRA	LIQUIDAC_GASTO	Gasto	\N	2026-10-03 10:45:52.38+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s115	39ffa8dc-bc6a-43c8-9ad8-f83bb074f39e	Baja	115	descartada		\N	\N	\N	\N	2026-10-03 10:46:00.206+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s116	ee16447a-4d2b-4aee-840d-c6af5e2114e8	Baja	116	descartada		\N	\N	\N	\N	2026-10-03 10:46:04.913+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s117	cbdef073-c753-47ac-a5f9-3369dd1cd7ed	Baja	117	aplicada		INTEGRACION_CONTA	GLOBALES_AM	Integración Contable	\N	2026-10-03 10:46:09.068+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s118	5bd88f67-1138-4455-9c8f-78a370219935	Baja	118	descartada		\N	\N	\N	\N	2026-10-03 10:46:23.671+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s119	4831f25f-e9da-440e-9ad8-1327c41eeff6	Baja	119	descartada		\N	\N	\N	\N	2026-10-03 10:46:33.815+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s120	72289b36-acf1-41f2-bfc8-27a30eefe0bd	Baja	120	descartada		\N	\N	\N	\N	2026-10-05 13:38:09.931+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s121	ed49d15e-fefe-4656-9e7c-23b8e6a792e6	Baja	121	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s122	93c2192e-5604-4318-b8f3-a44609ecb7af	Baja	122	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s123	69f0079c-fc32-471f-83af-f1937b4688eb	Baja	123	aplicada		LOTE	LOTE	\N	\N	2026-10-05 13:38:51.75+00	Procesos (claude.ai)	Diccionario de datos Softland (01/10/2026)
s124	c7c4c80d-d9cc-42d0-a68c-4fc28fee3d9c	Baja	124	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s125	f0ae4996-e7c7-4b4f-83f4-1ad4649d3192	Baja	125	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s126	db653250-a2c3-4d16-b1e2-5ae8d7ffa9bc	Baja	126	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s127	b63b0bc8-9132-4a92-9946-f68b470a0570	Baja	127	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s128	a6e5ffa2-1375-4795-9d2b-5fdf3189c88f	Baja	128	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s129	d54144ed-a533-4b23-92a6-38d9deda8f61	Baja	129	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s130	d8116351-4736-4aee-80b0-819dfa254343	Baja	130	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s131	d9f609d5-c875-46ff-a4c3-9100aef8bb84	Baja	131	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s132	792c66a9-3bc1-4e55-b16d-b099540235a2	Baja	132	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s133	234eaa50-306e-4e1e-bc07-cbd93a7795d9	Baja	133	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s134	ce66dbe5-ac3c-4e30-beb0-6d6e49bbe740	Baja	134	pendiente	Artículo	\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s135	9436162f-6019-49ec-bb6a-1a6029b6f74d	Baja	135	pendiente	Artículo	\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s136	afb51585-cd15-4862-8833-cfb1b344cd99	Baja	136	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s137	8d0eeb71-6dad-49e8-b020-902b457ce577	Baja	137	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s138	4377ac19-c199-4c27-8706-0e977da947dd	Baja	138	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s139	823103f1-1745-4683-802f-ab9e5d964bf1	Baja	139	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s140	be05b4d1-6db7-47f9-8714-dcd59c624eeb	Baja	140	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s141	bb44a91e-dadd-44b7-8401-73418178db4f	Baja	141	pendiente	Empleado	\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s142	c05854b8-9a22-4eca-8371-e34c8494e1e4	Baja	142	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s143	fb470077-1ba9-436e-a827-a572bd4fa557	Baja	143	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s144	78e3d926-ac02-4bb2-9e33-037f5ea3ce87	Baja	144	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s145	42f7b526-e47c-4975-8152-567192aca839	Baja	145	pendiente	Proveedor	\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s146	c7b14be5-72bb-453e-9b07-3b5ddece6d1c	Baja	146	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s147	af9a1522-e9d2-4db5-bff7-1ded4351aa43	Baja	147	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s148	a845c892-2d44-4509-8f92-367759176960	Baja	148	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s149	48848ff4-5636-4660-b9f1-089d2568d05d	Baja	149	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s150	de79a7c0-8737-4cc3-aa81-ac2339dc5e0a	Baja	150	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s151	ce7548a6-df5e-42ec-b319-3806d7282e89	Baja	151	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s152	07a48ef6-57f3-4775-bb23-62b229838a2f	Baja	152	pendiente	Cliente	\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s153	404d183c-af0b-4fb9-a32c-4ceaf24ecde5	Baja	153	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s154	371225f8-e022-4688-8db6-2e197b108037	Baja	154	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s155	6d2a8e10-fe4c-448c-917a-c5a3daa4f0fe	Baja	155	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s156	c0618a4a-4e73-4c62-ae71-428188e3d152	Baja	156	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s157	18e2ecc7-01d9-49bd-8ef3-1f3e8a204d54	Baja	157	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s158	979d4728-f5ea-46dc-9471-ac3f09498a8a	Baja	158	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s159	cb97e6c5-3944-4fda-9b24-d594e1849f14	Baja	159	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s160	76726aa3-83cd-4406-a13f-ebca190b4ed0	Baja	160	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s161	2c93e8f5-c147-4522-bee5-7cfabdf6a517	Baja	161	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s162	2d58e261-8012-434b-a6d5-f700ba9fb79b	Baja	162	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s163	b38e2a7f-582e-4c3f-88aa-a4bbe64925c4	Baja	163	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s164	c93c4600-d7bf-4590-886f-757f38e615e4	Baja	164	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s165	e0dbd68f-aff5-44de-8ff4-651335f1699e	Baja	165	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s166	83365f02-180f-41b2-9b84-64caa69599fa	Baja	166	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s167	caa9ded0-f931-4aeb-b70f-753d2eda05e8	Baja	167	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s168	27e7a6c8-a609-454b-929d-3cc1e1f88066	Baja	168	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s169	4af62927-ccf6-4300-85df-1c1fc2f9f45a	Baja	169	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
s170	5d89ad3f-6494-4554-9d43-a6f34a92fa21	Baja	170	pendiente		\N	\N	\N	\N	\N	\N	Diccionario de datos Softland (01/10/2026)
\.
INSERT INTO may_qa_glosario_sch_core.tbl_sugerencias_diccionario (id, termino_id, confianza, orden, estado, maestro_sugerido, elegido_columna, elegido_tabla, elegido_etiqueta, elegido_maestro, decidido_en, decidido_por, fuente) SELECT id, termino_id, confianza, orden, estado, maestro_sugerido, elegido_columna, elegido_tabla, elegido_etiqueta, elegido_maestro, decidido_en, decidido_por, fuente FROM _stg_tbl_sugerencias_diccionario ON CONFLICT DO NOTHING;
-- public.termino_campos_bd → may_qa_glosario_sch_core.tbl_termino_campos_bd (165 filas)
CREATE TEMP TABLE _stg_tbl_termino_campos_bd (LIKE may_qa_glosario_sch_core.tbl_termino_campos_bd) ON COMMIT DROP;
COPY _stg_tbl_termino_campos_bd (termino_id, orden, campo, aplica_a) FROM stdin;
6dd8d1ea-c987-4da3-86d4-533d5e718643	0	DESPACHO	
4fc7c8a4-e653-4a44-bc96-b345fe6b5de4	0	HANDHELD	
55f7d2ad-b94f-4da6-9daf-917100539ed6	0	ACCION_PERSONAL	
4a62a163-f307-46c2-8b9f-dd456bb3c7a1	0	ACTIVIDAD	
560ba3fb-0a79-4ae8-b895-0b93684a02dd	0	ACTIVO	
7ab3d352-4745-4dc0-b321-f40d02a1d394	0	ADELANTO	
eee64272-fb29-4353-a8cd-919f802951ca	0	AGENTE	
c3f3471e-c75d-4565-9727-6ee9da50914b	0	U_AGRUPACION	
bd94cf74-4ba3-41d9-bcbf-cc51580fd3f6	0	ALIAS	
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	0	U_MOVILIDAD	
26e00352-72ab-4d3b-91a2-f47d84317719	0	APLICA	
f4bddfde-e390-4564-b6ce-4e5f02076e0f	0	PARTIDA_ARANCELARIA	
54dd51b5-de9c-47a7-ac8f-db288aa0d235	0	ARTICULO	
9cb95e2f-92a6-412d-8cfb-9ef066b35505	0	ARTICULO	
6efeaa8c-1c50-4f58-97ae-179de8cd4d1a	0	TIPO_GARANTIA	
d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	0	ARTICULO	
4a43bcfb-60e4-4479-a0d5-1dc339273837	0	ASIENTO	
2d44a9ce-0df7-43cb-8d0c-04ee5bb1e93b	0	ATRIBUTO	
978bbf94-9f13-42c2-b58c-ecaba813d23f	0	CLASIFICACION_5	Cofersa, Mundi Partes
978bbf94-9f13-42c2-b58c-ecaba813d23f	1	CLASIFICACION_4	Beval, Febeca, Sillaca
322927ed-2f94-40d6-b731-3bcf52815d50	0	BENEFICIARIO	
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	0	BODEGA	
cdbdf3f6-82b3-4e54-bf7e-c7afa108fcc7	0	CAJA	
719cfe41-ac48-44da-a550-56f665c0c231	0	CARGO	
ea677fc7-f5f7-4737-a4ea-611b8915d33a	0	U_CAT_PROVEEDOR	
672bb14a-6d84-48da-bb59-1f4a1f582315	0	CLASIFICACION_1	
54c95665-119b-4a6d-a401-7a7f3d1abc29	0	CATEGORIA_CLIENTE	
e36e4409-2f84-4cd7-be22-0488fa92b308	0	CATEGORIA_PROVEED	
c4ed6b87-b155-4324-b142-422bfc746f46	0	CENTRO_COSTO	
e41c3b16-7eca-4119-8883-0200ba956f05	0	CENTRO_COSTO	
722d3b03-deef-42a7-b4d1-daa174746cf1	0	CLASIFICACION_ART	
2da438cf-e4ff-42ab-9d96-330753c41554	0	CLIENTE	
5e111960-30c1-4a79-9448-aade3eac7166	0	ES_CORPORACION	
5f0c90f2-00c8-47a4-9361-44d8db8d4cc1	0	CLIENTE_REPORTE	
1f819569-19c1-4ab0-8a10-cf930aa5fe9c	0	CLIENTES_INACTIVOS	
bbb04904-62a7-4425-b4e6-872b97e1a99d	0	COBRO	
52b95173-f65c-4f6a-98c0-c3e473e46798	0	COLOR	
0f871c56-32d1-4abd-9dce-682d15668aa6	0	COMBINACION	
57bc8c06-7952-4fdd-9b1e-9b1df66d925d	0	COMPANIA	
950aed9e-4739-4f2d-8ea6-21609a741d09	0	CONCEPTO	
ab24f441-88fa-41c4-bd75-329d26c1d2fc	0	CONDICION_PAGO	
35b0dfde-ef5a-46f7-9ff1-5d1e554aa3ab	0	CONSECUTIVO	
7add3bb1-6d86-48a2-861a-ccb64935d6c0	0	CONTABILIDAD	
df2a5f2b-824b-4b7e-aae4-8daa90fd06fd	0	CONTRATO	
16fb12bd-227c-4bd9-847f-6468b69c2452	0	CONTRIBUCION_VAC	
b0608711-832b-4136-9926-1664648eafda	0	CONVERSION	
9c20735f-ee7e-463d-b36b-869290a8aad2	0	COSTO	
7dde307a-6882-47d7-8f30-c27f0d1817a9	0	COSTO_COMPARATIVO	
133e4395-58f4-47b5-9ce9-cd6f06c076b2	0	COSTO_FISCAL	
bdc5f517-6576-48c9-83e6-86472237bc3e	0	CREDITO	
f3e0961e-aadd-4be1-882b-34341aca2e61	0	CTA_BANCARIA	
6f3df057-63d5-4fbb-890a-117be5f2ded4	0	CUENTA_CONTABLE	
c6a2c8d2-c803-4903-8679-93f05c4534e7	0	CUENTA_GASTO	
35e93f64-8590-4225-bed0-0fd6d7e972af	0	ARTICULO_CUENTA	
dc6d69af-9a09-4be2-b81c-e17a7c8dbc94	0	CTA_CXC	
d5157c64-ba43-4814-8c6b-8a2944308847	0	CTA_CXP	
ab1115fd-0473-4a60-81f5-21fc7bdee866	0	CALCULO_VACACIONAL	
a0a8426e-68d0-4ea8-aa47-f4a4dfcbb616	0	CODIGO_HACIENDA	
cc88857b-05ee-4333-8514-838320775f60	0	ARTICULO	
3b052d4d-96c6-4b18-87aa-16a203a6103f	0	CODIGO_BARRAS	
bb8f6d12-4f68-4335-a7dd-c111f4baad28	0	CODIGO_BARRAS_INVT	
8b0d67eb-c048-4412-be6c-87b3f57a0e89	0	CODIGO_BARRAS	
8d3e85b7-3149-4c8b-8f0c-669420e6bff8	0	CLIENTE	
968e71bc-13de-45ba-9dbc-438bc52c2110	0	DOCUMENTO	
7bfbc5cf-4bbd-4bc9-b39a-1236ac629940	0	COD_PROVEEDOR	
75f88e1b-531f-4ecd-8424-f1c5fe55c4a1	0	DEBITO	
59a49b15-f234-491f-8349-493ae498b8fc	0	DEPARTAMENTO	
66db2076-eb9b-45d7-b230-4a6aa148eed3	0	DEPOSITO	
59f44e56-9e9a-4117-b1b2-251221005813	0	DEPRECIACION	
9dc7b33d-dd2c-42ed-b0ca-f63e2cb240b2	0	DESCRIPCION_CUENTA	
8914816b-4626-4599-877f-98ca1af1f052	0	DESCRIPCION	
aaafac17-d36f-43a6-b714-761900be9270	0	DESCUENTO	
11fc47a9-1e3c-4662-8385-3d03cb1ec7e4	0	DESCUENTO_LINEA	
162fe414-c107-43ab-885b-84ca3e97dc49	0	U_DESC_FP	
08a9a1ab-f0b0-45b2-ac66-fdf8201610da	0	DESCUENTO_PRONTO_PAGO	
1195ac80-39fd-41c1-8311-170a69b12bea	0	DEVOLUCION	
1cc466a1-9c72-42f0-bc69-16a0385799b6	0	DEVOLUCION	
c3fdbfd2-cbcc-4a4f-8a65-88e2a5068b5d	0	U_DIMENSION	
a2c33f56-078c-477e-80bd-02e299150046	0	DOCUMENTO	
b4c3661b-881a-44b5-af92-16e5c1705f09	0	DIAS_VACACIONES	
d1c7b315-69ab-430f-a0a1-c97ada716727	0	EMBARQUE	
68c167e2-d50e-4e74-8b5f-fcf9e519eb41	0	EMPLEADO	
d2151e84-fed4-45c6-a448-81bd73d0b9ee	0	U_ENTREGA	
4c23bf01-82bb-476d-954f-3fc4a8fb5c5a	0	FACTURA	
f3810e3c-2e25-46a8-a41c-97d9aea69664	0	U_FAMILIA_DE_PRODUCTO	
41de50a8-f938-4c77-9299-b1f5b89ef76f	0	FECHA	
abaded62-063f-4c35-a64c-6d6c1a566f40	0	FECHA_OFRECIDA	
0d59e30a-eec9-4b48-bbb6-3a8f7548f825	0	FECHA_REQUERIDA	
852466dd-8ace-4204-a730-b7bf91dc365f	0	FECHA_REQ_EMBARQUE	
d80d31b8-635a-4246-b54f-14ad8a6f6e37	0	DOC_ADJUNTO	
94d0f325-3853-4841-9f0c-a24056459342	0	FLUJO_CAJA	
306b3852-8727-455b-981a-60627913d027	0	FORMATO	
76db48c0-495b-40ed-aba3-da360432b072	0	FUENTE	
589c89ef-5bd7-4272-9045-51df779f4cc5	0	GASTO_COMPRA	
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	0	CLASIFICACION_4	Cofersa, Mundi Partes
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	1	CLASIFICACION_5	Beval, Febeca, Sillaca
f92e62a8-424e-427c-b4af-8ca7758ef77c	0	CLASIFICACION_3	
9f909e1b-cd3b-4ba6-a90d-ed7a2211b8ba	0	HORARIO	
db284fd6-6424-4de5-99fc-55244c2934b4	0	IMPUESTO	Artículos
db284fd6-6424-4de5-99fc-55244c2934b4	1	CODIGO_IMPUESTO	Clientes
bbfc56b8-4711-43f6-bdb6-dc85366bb63a	0	INCOTERMS	
5537d68f-f723-4795-b794-019b29214bb0	0	INDICADOR	
43688de0-472a-47c5-90dc-000bb921d946	0	U_INFALTABLE	
cbdef073-c753-47ac-a5f9-3369dd1cd7ed	0	INTEGRACION_CONTA	
2b6079e7-9678-4cce-a2b3-38c8ebdab75e	0	TASA_INTERES_MORA	
e9e1ea5d-1147-45aa-a489-f7d608b42bce	0	INVERSION	
e7b33b6d-f3a2-4a16-ad91-f9d6fbcc4f11	0	LIQUIDACION	
203ac07f-1298-4f6f-b771-3830027938cf	0	LOCALIZACION	
69f0079c-fc32-471f-83af-f1937b4688eb	0	LOTE	
25301206-6cc3-4a60-9330-6b05c6533ef8	0	LOTE_MULTIPLO	
835e7ca0-d43c-4f37-b34a-357c6e52e848	0	LIMITE_CREDITO	
e7ac4ff5-2eff-45df-b1bb-a5bb3a794dcd	0	U_MAGNITUD_COMERCIAL	
199b6151-3a75-43c8-947a-de02a29f4159	0	U_MARCA	
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	0	META	
71289ec9-3d91-4db9-ac8d-4b9a5bd0d265	0	UNIDAD_VENTA	
c0abdd24-bed8-41a3-b9f3-e96380134084	0	CONTRIBUYENTE	Clientes
c0abdd24-bed8-41a3-b9f3-e96380134084	1	NIT	Tabla Contribuyente
fde6f994-cfe0-4443-8075-e213405cefe2	0	U_NATURALEZA	
4f916722-8b46-415f-91d5-4d8059827ef2	0	NOMINA	
5de2451a-e107-4a8a-9c5d-15d3773d2ee9	0	ORDEN_COMPRA	
f75b11fd-6312-49cc-a239-bead1e8d4b2c	0	ORDEN_MINIMA	
18ee3b43-b6dc-46ee-a491-070865869011	0	U_ORIGEN	
5e3ec8b9-177a-42d8-9570-ad4ae4c5e796	0	PEDIDO	
d3b29032-77be-46ae-b1f8-ba95e0e516c8	0	PORC_DESCUENTO	
9a7a3645-cbad-427e-ad31-06477e2dfcec	0	PRIORIDAD	
e09bc304-5146-49ae-b1ea-0952da8a029e	0	U_AGRUP_PROVEEDOR	
cb7cca2b-6e5b-4a35-9497-ce87658167cb	0	PUESTO	
176e36a4-47b6-4707-9632-46b7039999eb	0	NOMBRE	
1cd929b3-9d98-4feb-93fc-3c48ba0e1064	0	PLAZO_REABAST	
6098d463-ba39-40f5-aacb-5c9801bed788	0	U_REDONDEO	
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	0	U_REGION_VTA	Clientes
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	1	CAMPO_6	Dirección de embarque
e8bc8672-faea-4f4c-b003-82e9db5f9b02	0	REPORTE	
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	0	U_ROTACION	
cdaa1bd5-d57e-4d79-8779-023885aeaf37	0	RUTA	Clientes
cdaa1bd5-d57e-4d79-8779-023885aeaf37	1	CAMPO_8	Dirección de embarque
91fbfea8-a0c8-4b02-b665-3b9e2b97c548	0	REGIMEN_VACACIONAL	
2b45e1ea-32c8-4d27-aeac-47c707210c51	0	SALARIO_DIARIO_INT	
e429df0b-36de-4035-bdb3-68fc6d7fe913	0	SALDO	
ab7a75da-ad32-4af5-9057-25a02ee7754f	0	SALDO_BANCOS	
6d4ac37a-add0-4666-af29-e02dd112c489	0	SALDO_NORMAL	
2240bfcf-6b5b-4cfe-9bc7-a8d519f9f5a8	0	SOLICITUD_OC	
41cf3794-1642-47d7-b466-28602faaa24c	0	U_STOCK_SEGURIDAD	
77f4b86f-86c0-4aa9-98cd-db5f53faef75	0	CLASIFICACION_2	
3ab7bcf9-2e51-422c-b1f6-7a655a3090da	0	U_SURTIDO_COMERCIAL	
6e702e79-7fd0-48b5-ba12-20e664220179	0	CLASIFICACION_6	
629be99e-7eaa-4abe-a141-95412f8b5cf1	0	TIPO_COD_BARRA_DET	
264823e9-dfda-4a88-b0c4-90f695ac85ec	0	TIPO_ASIENTO	
dfe56a6e-7106-47bb-bf4c-100185c40cf9	0	TIPO_CAMBIO	
10788374-99fb-4ffb-8bfb-3a7813f8abfc	0	U_TIPO_ESTIBA	
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	0	U_TIPO_PICK	
5d96c2cc-4617-4b49-8068-3f2e9e13b461	0	TIPO	
e85b69d6-3fa2-418d-a801-661a9988febb	0	TIPO_TRANSACCION	
e23d656f-8c3e-4366-bbaf-190025163170	0	TIPO_TRANSACCION	
2afbcd91-311d-4d7f-b100-57ebb1684950	0	UNIDAD_ALMACEN	
393b0f55-08ce-4d63-b3b5-fd39156ce464	0	UNIDAD_EMPAQUE	
b77bed1c-168c-4b07-b731-88002527e3c5	0	U_UNIDAD_MEDIDA_C	
3818befa-bd67-48a3-bb6c-ea5a8001f76f	0	UNIDAD_MEDIDA	
9b832008-8b58-4016-b716-f08e6da13959	0	USUARIO	
aebf0e13-48cd-4ec4-8635-0ef01c9778ce	0	VACS_ADICIONALES	
8a87022f-31b1-4504-b089-dc78b81e0d27	0	VALE	
fda4ffce-abca-40d8-96bd-b5cca68d2341	0	VARIABLE_DECISION	
31469c99-8f49-421d-8373-1a341d8b5963	0	VERSION	
f5a3ad08-8158-4e3f-836c-e43ecec65a27	0	ZONA	
d69a3e74-99b4-4b67-9999-1e48de379e54	0	Sector	
\.
INSERT INTO may_qa_glosario_sch_core.tbl_termino_campos_bd (termino_id, orden, campo, aplica_a) SELECT termino_id, orden, campo, aplica_a FROM _stg_tbl_termino_campos_bd ON CONFLICT DO NOTHING;
-- public.termino_etiquetas → may_qa_glosario_sch_core.tbl_termino_etiquetas (1403 filas)
CREATE TEMP TABLE _stg_tbl_termino_etiquetas (LIKE may_qa_glosario_sch_core.tbl_termino_etiquetas) ON COMMIT DROP;
COPY _stg_tbl_termino_etiquetas (termino_id, etiqueta_id, orden) FROM stdin;
ddcf1d3a-f07d-46f8-aec9-e58dc3205f6d	1	0
82bd6a08-78d7-4497-b821-99a36656151d	1	0
1978b6b0-0816-4c06-bd15-c3e9386e33fe	1	0
f93401a7-54f4-4662-baa2-966397d42e30	1	0
2a8fabee-9893-4414-8201-a19a4532aa39	1	0
54054d6a-a5c8-4b93-9438-5797875bc6c4	1	0
5543bcb4-54ba-4306-8f68-99c585fd811e	1	0
2c803123-f70f-4ca0-99b4-7e2e2be342d2	1	0
527ac1f6-2acc-48e5-954c-bc4dccd32cb1	1	0
8b5298f2-f783-446b-82e5-f421d21a032b	1	0
84ade85b-710b-4699-8fe4-7edd6581425b	1	0
2b4dc552-f196-463e-b340-24b8fddb74cd	1	0
14626fcc-a1a3-4473-ae01-70bb1034a059	2	0
91a349d6-1753-473f-83a5-476a238c3e6a	3	0
1ab74e29-b076-4683-995d-aaf066a55bf3	4	0
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	4	1
978bbf94-9f13-42c2-b58c-ecaba813d23f	4	0
80593ba1-d3a3-4974-9b4e-cd65ee946439	4	0
d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	4	0
54dd51b5-de9c-47a7-ac8f-db288aa0d235	4	0
bd94cf74-4ba3-41d9-bcbf-cc51580fd3f6	4	0
c3f3471e-c75d-4565-9727-6ee9da50914b	4	0
20f292a0-beba-4ead-a70d-d38444529da7	5	0
2d44a9ce-0df7-43cb-8d0c-04ee5bb1e93b	5	0
b5767fac-92f3-40c0-afc5-6d9001fabf61	5	0
a921fe06-9e53-4444-9175-c29a6318ae3c	5	0
b876a0e1-cfd5-45fd-ba9f-1663cfa6d889	5	0
9a90766b-0366-4b29-b599-7b92e6a21bf7	5	0
d85c6ec7-3e47-49a0-a942-98707878afc7	5	0
fa84ce89-acef-43d3-9293-f3c1399e71bc	5	0
45160c14-dc31-4bb1-99dd-6e2c91add35f	5	0
99c392dc-9ebe-4146-8ce4-8ed54c796cf6	5	0
c6f44a66-9dc9-4ccb-ac1d-db808c93c4a9	5	0
b1bed8c4-6aee-4d53-b558-63cc28972c4c	5	0
28113b90-b7a1-429c-be22-5518ab989f0f	5	0
c59aa0f2-9f8d-4051-9fdc-0a6b50f6410c	5	0
3159cadb-3c1f-4240-ba03-f33ac4230f1d	5	0
c93e35b5-1596-4903-9f97-9c7408942fa6	5	0
9cb95e2f-92a6-412d-8cfb-9ef066b35505	5	0
5735cb7c-5b72-4b58-8ed8-137a62e8c356	5	0
fd94e0a3-32d5-46df-9298-53696467dd83	5	0
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	5	0
84eda7b2-8ba6-441a-a404-ce6bc8f06b00	5	0
afb9bd4a-79e4-4c99-bb1c-935d5686f8e1	5	0
4155f205-171c-42b4-9932-a93231a5aa90	5	0
12e41012-b323-413c-ad9d-515079a5e992	6	0
05ad0b8d-df30-4865-be8a-6900a32388c5	6	0
93580ff2-6b41-4396-806f-149537b08b3e	6	0
a4917d57-5278-4ac4-87cb-a568130bc23f	6	0
fb77f861-4e2b-4d7c-9e53-a631238d5a35	6	0
4ceed903-7f8b-4034-8e8e-128ee1450007	6	0
4a43bcfb-60e4-4479-a0d5-1dc339273837	6	0
25248767-700c-4654-a976-db862eb0ce44	6	0
2a343c49-9dad-45eb-8d03-8774e1ce7aaf	6	0
acafd1f1-2e19-4d9b-952a-52dc430e7d3e	6	0
9aab3557-cb41-4944-b553-52beae877422	6	0
41ecc608-60ba-4bf2-a2ff-fd5f4fafb8cc	6	0
9dbb7635-04f1-4372-8ed2-81d17ae8a4cc	6	0
560ba3fb-0a79-4ae8-b895-0b93684a02dd	6	0
8cb331b0-6765-46ff-9e18-ec417f56e3be	7	0
1ad2abd1-55e0-4e2d-a840-cf2ce5766928	7	0
385f0450-0b1b-46d1-9ca5-8485ac76f5ef	7	0
e6d10ea0-5797-477d-b8c5-5f7464dc464a	7	0
319219ff-0102-4acb-aa78-2f8167eed6f2	7	0
c4e11d09-6085-44b2-aec7-a52604e6aea8	7	0
3d9bc66c-3e85-4635-b05e-43acf096c125	7	0
694e0029-10e1-4af3-a090-a0816f46c95b	7	0
38bdd1c5-9bd5-4205-adbc-704f5d4ab0cf	7	0
653a0477-80fd-4bca-b3ce-51a5f971e212	7	0
a09a1469-5bab-42b5-a0cc-06067c6ba4fc	7	0
2b7d3243-d267-4cac-beb1-09152cbe4dee	7	0
6efeaa8c-1c50-4f58-97ae-179de8cd4d1a	7	0
a610d962-5a08-4d9c-ae48-b89670ffff8c	7	0
3b664f51-9504-4c3d-8648-e395adc4a6bc	7	0
b29d596a-40c6-496d-b2a5-fe322cd0abef	7	0
5f862776-ad73-43c2-9421-fca1b36b2a58	7	0
88d06b11-4229-4fac-b068-a3c1886d6097	7	0
55b87d9c-7ad7-4644-992d-a60c84d49bb0	7	0
90db3b92-aff4-4484-87be-2f9b2df5eb35	7	0
c41a9032-721e-456f-86c0-2ef40f404df4	7	0
3395e5f6-ef7c-46ae-b921-4e5561e90c1c	7	0
57bb491a-3485-4619-81fe-588070d2474d	7	0
20b1f6b0-da8c-4dbc-96ae-ba1952df2e58	7	0
0b52d8a5-5a05-48cf-864b-67f4b79b20ff	7	0
4d497265-29ad-4b68-9098-bf95b247b3f9	7	0
4226625f-a0ca-462f-a0f8-a52f66b576c2	7	0
11d77557-7489-4621-ae5d-ec2eb5ace5b1	7	0
d9d3b2fc-44ec-44ea-b1ff-72b9a00e0666	7	0
b261db36-61be-47bd-bc5b-e3ca037f4af0	7	0
379a7b64-aacd-4991-9b26-bdecadb6cb08	7	0
a3b3c87e-a9b3-43b4-a3d2-21c466b5b530	7	0
dfc67e4c-c2bc-4862-aa58-d7937c50b123	7	0
51af7f43-1f3c-4c6c-adfe-62e8b7afa033	7	0
0f773c04-e1ab-49e7-ab6e-cf3853ddfa91	7	0
571c5523-7328-4269-8d86-4668415e9131	7	0
46238357-6cbc-4703-8246-1e9043e86635	7	0
250d9de4-4429-4bde-ad83-7e9fc0037b59	7	0
059a95df-72a9-47f0-93e2-373bf725ff13	7	0
a211a5ee-112b-41c8-be70-7e26535b1cd6	7	0
10603b47-ba82-4cdf-92b9-7f5bc92fa9fd	7	0
12f5ca55-df15-406d-b846-79284591a0f7	7	0
4fc7c8a4-e653-4a44-bc96-b345fe6b5de4	7	0
e19a0033-a0db-4eb9-8981-7989df88dc92	7	0
403dfab9-0c64-4e98-a2a8-5c8c19d275f5	7	0
7f77a437-5fd2-4454-97f2-74965041220a	7	0
bd18cd20-f053-4ac5-bd1c-3eeb28fec53e	7	0
33703e15-f853-4b8c-a737-b2247db621ba	7	0
6dd8d1ea-c987-4da3-86d4-533d5e718643	7	0
69e6a98c-97b2-4d72-8700-669697c81dd7	7	0
dd628283-d383-46ed-adf2-99fc052ffc24	7	0
3e946d3d-b212-47ff-ad7d-e3903d3f5110	7	0
9fd66c8f-8752-42ea-a733-17f96207133b	7	0
99c5eedb-aad8-422f-9d85-208ef594ed9d	7	0
f69f1e62-c818-4c57-ba7a-cafc356bed17	7	0
89af55eb-9c33-4cbb-a251-b2548b8a693e	7	0
eb2aacb7-f805-47fc-bdb0-fb3d8fe72c6b	7	0
ae0a4ed4-a3dd-4b6d-957e-9cdc19d695f1	7	0
4979eb1c-3073-408c-8303-21e288e292aa	7	0
e6e40aa1-3a74-441e-9eed-439505447e28	8	0
0d4fb517-1f2f-4022-b87e-507e8b6b854d	8	0
677a7bac-6a56-4edc-abe5-7048966181b5	8	0
98e6b0b2-ec51-441d-80fb-81bc7f12f514	8	0
2c4bffe8-885d-4d9d-8240-cad82991c026	9	0
f6ae7d9c-ddb4-47a7-b5c0-124b45c6e2f3	9	0
7aed4c7e-5620-4074-92a3-92047ca70a08	9	0
18a6320b-1473-4455-b202-dcd495003009	9	0
6c659bc6-b43d-4cb5-9ecd-e138e7a6693b	9	0
87800534-77b4-414f-b091-aa5607cd0d27	9	0
912f0772-34a9-45a0-ae87-59b5d610cc15	9	0
9b5576bd-8e4c-4ae7-8f1b-84913db15d84	9	0
10b71976-93a5-40b0-be8a-c841c006c3bc	9	0
bf7cc120-47d7-459e-bc81-c59f8c56a567	9	0
e7c5727d-900e-470b-b2bf-8911299aa58f	9	0
f0a0efcd-68b1-49fa-bcad-7c737f2dd2d1	9	0
1ed78209-8954-47d5-ae1a-bf29a656c0ab	10	0
1888ecb9-cfa8-45dd-abba-e5df45dae7a1	10	0
7f8e0077-9350-4e58-a59e-69a86f6ae61b	10	0
336bd53a-c95e-456f-818e-5cc33f33b62d	10	0
f80a6a04-52a4-44c5-bd0b-a6fc6a74ff5a	10	0
63080814-630d-4ae7-9395-573b5578b3f1	10	0
56be082e-6f8c-4781-bd9c-9a5ffde9398b	10	0
4354b86f-2813-4ba5-b49f-82af8445d0c4	10	0
edb5b7ad-3403-41a4-9652-ee13584e82e8	10	0
38a9a6ac-b761-4c81-ab82-51ba5e6a76d9	10	0
f72c4bef-78d9-4c9a-959a-9d39384bf8cc	10	0
348e8b8f-aa77-4e3c-b176-383088f58812	10	0
4a62a163-f307-46c2-8b9f-dd456bb3c7a1	10	0
71337e1f-db49-4c60-9f08-10d4dcf220a2	10	0
137fea0e-0bcb-48fd-9686-cd51884d30af	10	0
c8fc44e8-574f-40f0-885c-dc318e3fce9f	11	0
9048360b-7b3f-4d02-b4b3-61e130370c58	11	0
374800bb-e35a-4b3f-8380-5dd9a56d431e	11	0
6779a7de-acd0-4eb3-b57c-814a06eb3164	11	0
f8df2642-33c5-49a6-9c31-35a616cd8e33	11	0
29cf6716-ca3d-4f5e-8b72-9e11e3bccfe5	11	0
a363100e-663f-4ef8-a904-f1b582375527	11	0
882266a0-81c4-4129-8c43-3022046461a0	11	0
cd487562-3733-4006-9e1c-f08b487a11dc	11	0
7bfb10f8-b734-4a58-811e-a40701388542	11	0
f38f1048-cffd-4a64-8548-e39493039fbe	11	0
0ee617ed-1696-43fd-895c-605a8a26e129	11	0
a4a9bde8-e65e-4fbf-9d65-e28147834458	11	0
1a86f0a1-8368-4954-8b9c-1394edd8dc22	11	0
f5f7de91-0abc-49ae-957d-44769bb90c86	11	0
2773e9f0-b2f4-46ef-8f0d-a38b17576969	11	0
327bf95c-9219-4ab4-a4ef-42639cf87597	11	0
869ee472-863c-4dcb-b31b-f0235b82349d	12	0
6405d99e-e7a4-4715-9ed0-e52dbce7e0d1	12	0
6da8ca0b-007c-4287-8442-5f5e3becb0ae	12	0
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	13	0
eef1c009-d23a-4b45-abe2-799efc9f3062	13	0
322927ed-2f94-40d6-b731-3bcf52815d50	13	0
09e66518-a81f-4ef4-86cb-a2e1cb7774a7	13	0
9b87f39f-5941-49a0-87b4-11632ba76e49	13	0
fba042dc-2d2b-491a-b46c-d41e951877e1	13	0
804708fe-b877-4ab1-b7e3-b3158d6b3e23	13	0
b83b9a9b-1527-4cdb-b58b-db2508b1806a	13	0
f4bddfde-e390-4564-b6ce-4e5f02076e0f	13	0
3ec20b94-cf26-40e8-b433-1906e6ca413e	13	0
26e00352-72ab-4d3b-91a2-f47d84317719	13	0
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	13	1
7836196b-26d6-49f1-8415-f4e6152aff40	13	0
4c2736f3-5f41-4ab7-8ed5-0e51af7ebcf6	13	0
eee64272-fb29-4353-a8cd-919f802951ca	13	0
7ab3d352-4745-4dc0-b321-f40d02a1d394	13	0
55f7d2ad-b94f-4da6-9daf-917100539ed6	13	0
b97abec6-a176-413f-a520-a5b9d3aaa76b	13	0
4971f6f4-dfb3-43e6-8480-957adf39b36d	13	0
978bbf94-9f13-42c2-b58c-ecaba813d23f	14	1
54dd51b5-de9c-47a7-ac8f-db288aa0d235	14	1
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	14	2
f6dfaec7-a1ed-440e-ae23-9d2fb12f04c2	17	2
80593ba1-d3a3-4974-9b4e-cd65ee946439	17	1
bd94cf74-4ba3-41d9-bcbf-cc51580fd3f6	17	1
c3f3471e-c75d-4565-9727-6ee9da50914b	17	1
978bbf94-9f13-42c2-b58c-ecaba813d23f	18	2
54dd51b5-de9c-47a7-ac8f-db288aa0d235	18	2
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	18	3
d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	21	1
1ab74e29-b076-4683-995d-aaf066a55bf3	22	1
33a985f1-dd16-4c84-af75-bd3a3b0f086c	1	0
76beeb7b-72e2-4e80-9ba7-d34d4e8c649a	1	0
8e7065db-72cb-4ad1-9e1c-f29e8c4d0689	1	0
cab3e766-3cf9-49d9-8ca7-c1ca9099a170	1	0
1369e5d7-4baa-497e-9b55-4162184d69e9	1	0
57bc8c06-7952-4fdd-9b1e-9b1df66d925d	1	0
44a65f9d-d5b0-4b81-91b2-66b8ddc35ce0	1	0
8984ea5e-3b2f-48ca-a47d-28d73bbb1046	1	0
603a8209-c844-4453-a939-b380a9c9a20e	1	0
272f5e2a-23c1-406b-b04a-02f5b147fb2e	1	0
71c524f2-85b9-4064-b658-88ccd225b167	1	0
305e0d18-6827-46eb-8a1e-9da8f7a851f5	1	0
88744fcc-cb27-4602-aa4b-fce0149a7e0d	1	0
b045f075-a27d-44d9-8b06-ed3a16d1dc15	1	0
f2c756e9-b874-42d6-8c46-031770b8675f	2	0
6fead420-048f-4f17-954f-51943ec68902	2	0
fd3df67a-afc5-4ee5-9f6b-0673ed26bcff	3	0
ca94e7f4-96c1-44f4-8010-a4e346db6efd	3	0
ecf3d1db-fe84-4af7-a79f-20e490f20a6e	3	0
4026eda0-a294-40a8-bfb6-483c1dee1099	3	0
93bdb177-e62d-42d3-940f-286e686ae424	3	0
1c0e85be-4f10-415d-b081-463cc96a0a78	3	0
0d52f24a-ba82-4396-9c81-bdc0e8eb6d64	3	0
cd331226-cd6b-48fc-b64b-33cc66061965	3	0
6c4e9190-a7a5-44d5-af4f-66a392445986	3	0
62bd4b73-155a-4da3-ab84-a656a26931bb	3	0
53a2eb25-c882-4aa3-9e0f-f32e35942fc7	4	0
ce8663c7-7119-49ae-b7fa-b4648099110e	4	0
e38f6dbc-02b8-4bb7-b680-a96cf071ae57	4	0
f22bccba-178e-4b14-885d-4446ab180ab0	4	1
18e70aa5-6cc9-4d00-928c-1dd9746aa36a	4	0
383c1915-433a-4bd6-8f7e-10f6b6290fed	4	0
6393a36f-6089-4e04-88ad-29c364e11735	4	0
705656df-3e02-4d5d-b5e3-03ab5c140722	4	1
bbb04904-62a7-4425-b4e6-872b97e1a99d	4	0
db79e919-4abc-40a3-9c79-425c100615fc	4	0
1f819569-19c1-4ab0-8a10-cf930aa5fe9c	4	0
00e5d40b-cda2-486d-954d-afb6bdfb1363	4	0
80f860f9-c5ab-484d-945b-711b4b0cb293	4	0
075f07d5-10ab-4417-8c6b-6f2b0d5c3f6a	4	0
2da438cf-e4ff-42ab-9d96-330753c41554	4	1
e41c3b16-7eca-4119-8883-0200ba956f05	4	0
54c95665-119b-4a6d-a401-7a7f3d1abc29	4	0
672bb14a-6d84-48da-bb59-1f4a1f582315	4	0
cad059d2-b187-4d74-804c-3a9b94c3fe34	4	0
74da4cc1-da25-4776-930a-4f5fe6cb584f	4	1
61868244-4edd-4e3f-ba94-a52acf3a2b2a	4	0
d61cc8d9-82ea-4b05-87c7-5b29107b0fa0	4	0
54ed1074-b921-4d12-ad95-15d3ce274024	5	0
6f2f49ef-c124-4cf2-89dc-25a9236aeb0f	5	0
36354a95-28a0-4189-9a22-50a936a0ae06	5	0
9c20735f-ee7e-463d-b36b-869290a8aad2	5	0
f1fff8b7-81c8-42c2-a0c2-bbb63b3c7bf5	5	0
ddd900c6-fe56-4687-9883-859f9bc66e65	5	0
cdfa5be7-46d7-4bdc-9a71-01e855bbb05c	5	0
99f2e0b3-21cf-4ecc-bae8-092d688c8631	5	0
52b95173-f65c-4f6a-98c0-c3e473e46798	5	0
24f73744-0786-43d7-9418-00c3828a43f7	5	0
6ad2327c-5e6b-4b06-9ff6-0c9f452d8787	5	0
ab148210-e1d1-4dc0-a11b-fd0b1b3c9808	5	0
e795b72b-63aa-45b9-919b-f823fc02ef1c	5	0
e36e4409-2f84-4cd7-be22-0488fa92b308	5	0
672bb14a-6d84-48da-bb59-1f4a1f582315	5	1
ea677fc7-f5f7-4737-a4ea-611b8915d33a	5	0
5236dfee-a646-43b0-8bcc-5664e5c6b012	6	0
c6a2c8d2-c803-4903-8679-93f05c4534e7	6	0
6f3df057-63d5-4fbb-890a-117be5f2ded4	6	0
862dc68e-cacb-4638-b856-e6306b2a6bd6	6	0
b17781fb-cfe5-4eb1-b101-62195c2e5178	6	0
f5758307-f729-434e-91e5-dc43078f083a	6	0
f22bccba-178e-4b14-885d-4446ab180ab0	6	0
df2a5f2b-824b-4b7e-aae4-8daa90fd06fd	6	0
7add3bb1-6d86-48a2-861a-ccb64935d6c0	6	0
b278c633-65a3-4efa-be40-90630bb20b54	6	0
0e165717-a0d2-4d87-bc84-d3902e499e14	6	0
ba0b37d4-e3a7-4f6f-9964-0f2ade015909	6	0
c4ed6b87-b155-4324-b142-422bfc746f46	6	0
74da4cc1-da25-4776-930a-4f5fe6cb584f	6	0
44365b45-4db2-4853-9b36-cae664e3ce77	6	0
33a985f1-dd16-4c84-af75-bd3a3b0f086c	7	1
334d1c95-f825-4b1c-a563-8586e21810f1	7	0
f510e273-6f65-45c9-88c3-c2cd16c8942e	7	0
bf257244-c945-414c-98b5-4d5b8157e7c9	8	0
bd8aca7f-665a-43e8-909e-82db8e4aac43	8	0
b206bd39-864d-44aa-b0df-c337a15e8b4c	8	0
ca726239-15d9-4409-bab1-a67871704628	8	0
99f2e0b3-21cf-4ecc-bae8-092d688c8631	8	1
0591371a-b0a6-4c2d-bb15-a45a1e3ff5b7	8	0
03d966f9-539b-4c8e-a9da-1136e069f191	8	0
86af93da-172d-4768-ac54-9501cf94ded7	8	0
d54b84b3-37ee-411d-98cd-c6acd0c6e641	8	0
4d952bd5-aa10-432a-8c50-dfeceba06263	8	0
8d3bd529-aa4b-4771-af0b-6a9d1e43f0a8	8	0
78d65aca-aeec-4ced-8d66-6f77d25c834d	8	0
d03373dd-300f-4b90-91bc-2d703eb78740	9	0
973acff1-3e05-4f31-9bbc-ca10695b97ef	9	0
3afffc20-7aaf-4afa-a52c-9d515c9e42bc	9	0
3a18157e-34fe-4016-817e-6493357fb901	9	0
468bdddc-ce8a-4022-b9e0-01620617e70a	9	0
ea7736ed-3a99-4c6f-ba05-89a975c2be5d	9	0
705656df-3e02-4d5d-b5e3-03ab5c140722	9	0
0103ffea-8643-4a5f-90aa-2bbd33b4e12b	9	0
8c755284-5b00-48d9-ac26-4e2cf6b03c73	9	0
5f87cf47-1635-44d0-b71d-a05348599d25	9	0
ff6a102a-a7aa-4c34-8703-b578b0c6046a	9	0
260eda61-b279-49e9-aba7-fc748b824f77	9	0
719cfe41-ac48-44da-a550-56f665c0c231	9	0
46b31ab9-da76-477a-a5eb-b150802e7bf3	10	0
c38af7b3-cd0f-4616-805f-18e34ff1fe1f	10	0
e01a16ac-bd20-4758-be74-2d8940e536ee	10	0
879bc3e2-1f38-4aec-8cfe-a1fb6c4ade57	10	0
4a780c50-d29a-4e4e-90de-40c5474c0ea6	10	0
af3168a4-867d-4f30-b78c-17fb7b564add	10	0
cdbdf3f6-82b3-4e54-bf7e-c7afa108fcc7	10	0
cae3b7db-ac82-4be4-9a27-8989ba4fd4d6	10	0
d4a11ae2-2b86-4ab2-acd6-56fc286e30d6	10	0
b183ec05-17f7-4a10-b775-88b74fa2d50b	11	0
16fc7bbc-3f7e-4892-b6a7-54f1c26ce748	11	0
3226b77f-59ce-48e8-8ef0-a4e880a67727	11	0
5b7846a7-7b7a-4c42-ba7a-3e28d87135f6	11	0
b1def5e6-ec46-49a0-a66f-9bda9573169c	11	0
63d3eb0a-0cfe-46d0-9755-ae2b044003d4	11	0
d8de4c4d-ad7e-4aa5-ba1b-12934411d19f	11	0
99940ac2-aad5-434a-ac7c-1fc8b51d9504	11	0
e1b3d41c-2d75-497a-8534-fd57328e3d19	12	0
97035dc3-536f-4b5c-afc3-4be86d60f3c2	12	0
fbee7bc3-bb79-4855-8cbc-f9222628459a	12	0
2da438cf-e4ff-42ab-9d96-330753c41554	12	0
2ea5bcba-ba7a-4354-be1f-b7d168d9cc05	12	0
8dfc0f6d-ea80-4325-9aa1-0a3f5aa29129	12	0
27f4e7a0-f6dd-469c-ac58-2f9a1287e624	13	0
74d0f881-372f-4387-bc53-7dd2986aa52a	13	0
605759ec-39fe-433f-8d95-91927a559ddf	13	0
e6d6c25a-ad48-459e-ab2f-2a5dd81365c3	13	0
f3e0961e-aadd-4be1-882b-34341aca2e61	13	0
d60645c0-90b1-486a-80b8-60ac9cf94877	13	0
462c0879-e6ab-4ed0-8e31-0db2e60c26e3	13	0
bdc5f517-6576-48c9-83e6-86472237bc3e	13	0
d937d1eb-72b1-4715-9bb7-3e32cc63da0e	13	0
7b5dd10b-a062-4a38-9515-2bce4124176a	13	0
133e4395-58f4-47b5-9ce9-cd6f06c076b2	13	0
e39b995d-285c-445c-b64e-f11a2cfdfe8b	13	0
7dde307a-6882-47d7-8f30-c27f0d1817a9	13	0
976003fe-736b-4507-acbc-7a0f0f31a988	13	0
5d0244cf-913a-4c85-b5cd-1ffc7e0ce587	13	0
d235eeb7-1583-4219-9655-0beaf8be8e54	13	0
f4bc020f-47da-4882-8dfd-76a2dc01ad52	13	0
b0608711-832b-4136-9926-1664648eafda	13	0
355f6560-e2b5-47b3-90f0-68b0034ca979	13	0
2024f4b3-e234-4ad7-a6d8-cf4e28a14e00	13	0
a0f9be39-5579-4d4c-8169-e7110e5c37ed	13	0
eb1b8021-aa99-40f8-b41f-69ed1bace4c6	13	0
16fb12bd-227c-4bd9-847f-6468b69c2452	13	0
c9fec659-9f86-4173-a3f1-55e87865dc1f	13	0
35b0dfde-ef5a-46f7-9ff1-5d1e554aa3ab	13	0
ab24f441-88fa-41c4-bd75-329d26c1d2fc	13	0
4515e60e-c9dd-498a-bc76-f8e8cc4333e5	13	0
45acdd76-b08b-425b-a3fa-4b917679313e	13	0
950aed9e-4739-4f2d-8ea6-21609a741d09	13	0
6b728f4d-aa09-4823-b33e-392edd58f23f	13	0
a883cf3b-21da-4f0d-9fe8-a920991ae397	13	0
33c7f3e2-e555-4574-a7b9-0b8603f8304f	13	0
9049f3f5-3d13-4812-ab89-541d77b5598c	13	0
0f871c56-32d1-4abd-9dce-682d15668aa6	13	0
144b0c7c-b38a-493e-9942-b17d79a296c7	13	0
5f0c90f2-00c8-47a4-9361-44d8db8d4cc1	13	0
082cd402-ffff-4ba0-a019-121120dc9f14	13	0
5e111960-30c1-4a79-9448-aade3eac7166	13	0
722d3b03-deef-42a7-b4d1-daa174746cf1	13	0
5cb30859-86f6-40d1-a06f-9918cfbd4636	13	0
1d938d02-ff4b-4f95-a708-8b3177860dbc	13	0
0cf63b13-f647-47d2-881f-bd33faff13c5	13	0
5a923afb-d8c5-4573-89a2-2b9df9d8fc55	13	0
96cea58c-9c9c-4bae-9bab-b10ab037649f	13	0
60003f55-6cee-4784-a1e0-51be7d4b8c5c	13	0
672bb14a-6d84-48da-bb59-1f4a1f582315	14	2
e41c3b16-7eca-4119-8883-0200ba956f05	15	1
705656df-3e02-4d5d-b5e3-03ab5c140722	16	2
2da438cf-e4ff-42ab-9d96-330753c41554	17	2
54c95665-119b-4a6d-a401-7a7f3d1abc29	17	2
672bb14a-6d84-48da-bb59-1f4a1f582315	17	3
672bb14a-6d84-48da-bb59-1f4a1f582315	18	4
54c95665-119b-4a6d-a401-7a7f3d1abc29	20	1
53a2eb25-c882-4aa3-9e0f-f32e35942fc7	21	1
f22bccba-178e-4b14-885d-4446ab180ab0	21	2
18e70aa5-6cc9-4d00-928c-1dd9746aa36a	21	1
ce8663c7-7119-49ae-b7fa-b4648099110e	22	1
e38f6dbc-02b8-4bb7-b680-a96cf071ae57	22	1
cad059d2-b187-4d74-804c-3a9b94c3fe34	22	1
383c1915-433a-4bd6-8f7e-10f6b6290fed	23	1
6393a36f-6089-4e04-88ad-29c364e11735	23	1
db79e919-4abc-40a3-9c79-425c100615fc	23	1
bbb04904-62a7-4425-b4e6-872b97e1a99d	24	1
1f819569-19c1-4ab0-8a10-cf930aa5fe9c	24	1
00e5d40b-cda2-486d-954d-afb6bdfb1363	24	1
80f860f9-c5ab-484d-945b-711b4b0cb293	24	1
075f07d5-10ab-4417-8c6b-6f2b0d5c3f6a	24	1
74da4cc1-da25-4776-930a-4f5fe6cb584f	24	2
61868244-4edd-4e3f-ba94-a52acf3a2b2a	24	1
d61cc8d9-82ea-4b05-87c7-5b29107b0fa0	24	1
4b40dce8-95ea-4116-918f-725a5f754602	1	0
63ffd8a3-7467-4494-8cb1-3b11f117b7b5	1	0
76000ca9-d790-49cc-a5ef-a649b2b03480	1	0
329fe90d-dd99-4f40-be47-3f1d56d4bd4e	1	0
7a871cb3-78a9-4e20-a435-7b3a1d80aa2e	1	0
8d1f2e30-cc9e-4a5c-94ec-df3245c9c799	1	0
69552fbd-80fd-4dfa-a552-b78e298ff943	1	0
4b65f25d-b9d8-482c-b9a6-6d6d27dd12f7	1	0
addeb14e-2ba6-42c2-ac05-9a3f4cbb1b48	1	0
d40f99fa-931b-4a4f-bf07-c56a3bdb0267	1	0
5eb8ce30-1e0c-449d-9590-0f9326474ff2	1	0
047b171d-3c49-4e6d-ba08-23dcac7c1cc5	1	0
76ca5da9-aba5-4cfa-a754-691f8804bc6c	1	0
b211eb53-647e-4878-b400-197a85c1c4e0	1	0
cc88857b-05ee-4333-8514-838320775f60	1	0
fd56569d-4464-4f13-8c93-a78bae28a8a4	2	0
bfd3ae97-aa4b-4e0b-83b2-5b057b36e8ec	2	0
a518ba93-e044-430b-8a3a-6c8699a1a361	2	0
7e778586-c998-454b-8d13-df5ebfa34842	2	0
d5f87625-e16c-48bd-872d-3e7cbd2b5105	2	0
8988aa0b-14cb-4955-96ca-1cfb9a37244f	3	0
60727b9b-2dd2-45ce-b5e4-24ef68316e73	3	0
34a88758-5698-4039-98f4-23b87ab87848	3	0
a9979f50-e827-47d9-b1f8-4c7b33216eb6	4	0
bd21e91a-8780-4772-b861-c415335a79e9	4	0
b64a8331-c47c-4f39-97c8-0728b869493c	4	0
a963844a-6d07-47e3-952c-d9d122ab95e8	4	0
c37a4105-9af2-405a-bbae-05b5b78150a1	4	0
daa12537-7406-482e-bbe2-4bb66658872e	4	0
786a250c-36b5-4e11-8386-77250197d429	4	0
15dd0329-b05c-4bef-be03-1264bf3511fa	4	0
bd906c33-8160-4f1a-8baa-89b27ee0963a	4	0
5adc1b08-a57b-4685-a634-b5484ba5946a	4	0
c3fdbfd2-cbcc-4a4f-8a65-88e2a5068b5d	4	0
1cc466a1-9c72-42f0-bc69-16a0385799b6	4	1
1195ac80-39fd-41c1-8311-170a69b12bea	4	1
317b035d-d9b8-4321-bc8c-1d3b8fbab970	4	0
1a5dcb7f-befc-438d-ba7a-c0ec8b56b4b8	4	0
59a49b15-f234-491f-8349-493ae498b8fc	4	1
0dbe7b2d-e08b-4963-aa57-c2f9ebdd8bdf	4	0
9b274939-d392-4fbc-8878-94fec95b8b9e	4	0
d5157c64-ba43-4814-8c6b-8a2944308847	4	0
71e86388-67e1-48fc-9a73-dbd3764bc14f	5	0
f3810e3c-2e25-46a8-a41c-97d9aea69664	5	0
e4c727d2-ff97-442a-9325-62330d6374eb	5	0
cde4b67b-fa4e-42b6-b416-748a71e21e41	5	0
9cdfc090-1dee-4a32-ad47-d5108824423a	5	0
cab5c2ad-7f79-4e18-bf3f-3f7bd874e1cc	5	0
552c4845-31fb-49ec-9680-9adbaf53a0f1	5	0
164f0739-2e3b-4929-850f-22bf6613562a	5	0
aaafac17-d36f-43a6-b714-761900be9270	5	0
8914816b-4626-4599-877f-98ca1af1f052	5	0
2901df4f-ee6d-4718-97e0-eb24b3c4383c	5	0
b2a30de1-7207-469e-99dc-abaadd43919c	5	0
761955ec-8af4-4ffb-9dfe-ee8b86b2c317	5	0
114a8191-e796-4e32-b7d1-050e32d626a2	5	0
63cedff9-3000-465f-bf3f-76b39fba8dd0	5	0
fb2a3361-e143-4f6c-ac25-931c77dc9727	5	0
2b759da7-f87b-4cda-8d20-15d739e44f5b	5	0
9ed439d3-0d03-40ef-958e-bd84eddda054	5	0
3b052d4d-96c6-4b18-87aa-16a203a6103f	5	0
a0a8426e-68d0-4ea8-aa47-f4a4dfcbb616	5	0
b68235a5-b85d-437a-b219-6522feb9132d	5	0
5656db19-0b32-436f-baf7-0444c551a3c4	5	0
8405afee-de94-4470-ab90-bd4af3190a08	6	0
4c23bf01-82bb-476d-954f-3fc4a8fb5c5a	6	0
47b7d1ad-d844-431d-a7ed-71486587abfc	6	0
b4a09102-2e7f-4d89-b8c6-8deabca3d663	6	0
e6ce3f85-c316-43c5-b677-f89e5fec9c90	6	0
21fc1afd-7c6e-46c9-8de9-a7d35a121451	6	0
cf743f84-7fab-48f5-9000-74ab18ce0fbb	6	0
9994fd77-c02f-4df9-a2e4-76043b8d3c30	6	0
0e0cd126-bb78-4f1f-b9bd-78397c2a3bc9	6	0
1cc466a1-9c72-42f0-bc69-16a0385799b6	6	0
55c18305-456e-4170-afc5-559f129717c5	6	0
08a9a1ab-f0b0-45b2-ac66-fdf8201610da	6	0
162fe414-c107-43ab-885b-84ca3e97dc49	6	0
59f44e56-9e9a-4117-b1b2-251221005813	6	0
d4ade745-ca07-4e69-8a5a-45bf37868fd4	6	0
5bbd0de8-cf4a-487e-99a3-4fc127b4292e	6	0
57b8b668-f908-466b-af54-1e86c3f560f7	6	0
bba202e3-b0ee-4fef-8def-d64f73014f59	6	0
7bfbc5cf-4bbd-4bc9-b39a-1236ac629940	6	0
8d3e85b7-3149-4c8b-8f0c-669420e6bff8	6	0
5cda38cb-b0fe-4960-bf63-7da9a0ced869	6	0
693053d5-4a14-4708-adf8-cb980158ecf3	7	0
4db007c6-c715-471f-be41-45bae35462d0	7	0
3ec711e7-5531-4c74-97ca-95b71b03157c	7	0
a4075f49-b6bd-4636-8bf3-1c751f262add	7	0
b6342c59-7629-4967-bd0d-4d8df69682f1	7	0
9ac34da6-1c52-49c2-b7d4-4ea080a7fd0d	7	0
e3b097d5-2e8a-4ea6-98f5-0edc55a446c7	7	0
1c4ce8a4-fa58-444c-b742-10d87a329223	7	0
4906d4ea-bef2-4411-b043-42acbc7024d3	7	0
59ca3f1a-84ce-440e-80c9-23cc595c06e0	7	0
4d774ecf-3b0a-4c52-bf81-8dab919d5704	7	0
c8209fc3-250b-4d29-a7f9-1dbd80b21768	7	0
bb1c91fe-0a73-47dc-9fad-495da5432118	8	0
95d9c52c-1d97-4c81-8f55-1261a1eb93d3	8	0
1f89de2d-be3e-4142-b6b2-4a28454e2f9c	8	0
10ba0b09-2c66-4f0e-8469-77856a2c0277	8	0
77283da6-d5af-4bfd-b0ca-db1f3686c15e	8	0
d6fe6c9b-635c-43d9-83dd-78f799f84912	8	0
af48b27c-be30-4c7e-86f7-1fa7bf599805	8	0
06a658bc-c0c0-41e9-8add-cf3e39ce65f0	8	0
7283b819-28d4-4c0e-8197-f4ac994103c1	8	0
9012680a-f2f8-4c20-8395-b4aa20e7d77d	8	0
d7f83fa7-69c6-4a75-b2b0-dc12e25df4ec	8	0
cc5c217e-72fe-4bf0-9377-9290487c98df	8	0
ac4b7888-0097-4c41-b069-a2b7080bb6a2	8	0
76df97ce-c137-4db9-890a-6356421d5510	9	0
6de1abf5-e4b5-4a08-8df9-8865aa74a893	9	0
1cd604d3-c3db-4f5c-89d2-3e07a4bc4637	9	0
6f835bff-a1e2-46ab-9e2f-af4fa5d57e49	9	0
3724a687-cdb4-4901-a424-3a30ee39f5ff	9	0
b4c3661b-881a-44b5-af92-16e5c1705f09	9	0
5ba1a453-95ed-4981-bcb8-0dbe7a325995	9	0
288b6d35-b029-4286-b7b8-6f551ae22360	9	0
87496a44-e516-468c-89ff-61c11af5e955	9	0
4204bc9d-4f97-4756-a5df-16b6ee4c794b	10	0
e0479815-c66f-4c95-9710-1ec803a1da4e	10	0
b8a17f5d-4668-44dc-8bbe-b18cb7afe88c	10	0
826c34c7-cf4c-43ce-9622-a309a10ad605	10	0
129d3316-cdb8-4caf-8f79-9ce3d29649e6	10	0
796cc318-2109-4381-93ee-c5548d0b3938	10	0
6a3a4f63-4dce-4d1b-bba3-d7aa0b69a7f6	10	0
9100fbb9-a96c-4c05-8ca3-37385716eb84	10	0
460653a7-a46f-48ba-b423-02dde715ea09	10	0
abe54920-a183-4bc1-83c5-7c680318da25	10	0
962a1e6d-a4de-4fe9-9451-0374976d7ace	10	0
0878e7eb-d429-450f-b086-b131057ff6c9	10	0
968e71bc-13de-45ba-9dbc-438bc52c2110	10	0
e369fde7-513a-4e47-b926-b683d03192da	11	0
4d86efc1-0e57-4896-b4da-91f8e0b26b4a	11	0
18534369-e5bd-410f-bf7d-9e82f7ff689d	11	0
c9fc606a-da62-4019-8c89-5fbbf977ca4c	11	0
e2e1d54a-5e08-488b-8529-1afc7202f867	11	0
65f7df2c-9d44-4e67-a5dd-9042deacf1d4	11	0
fb404425-9f5b-4d1a-98de-b3fcfe886e9d	11	0
debab99f-9abd-46a7-90c8-848575d80f14	11	0
b02f6d0b-5952-4f01-b2e2-d3c6d26192ae	11	0
f58a1fba-6b4b-4e99-9390-0181ca7ac57b	11	0
76e11483-cbdf-4389-a868-8a3a79bbd31f	12	0
f1c2f511-e395-4b62-8724-2206c7cc89cb	12	0
7124d2aa-5d1c-4f99-bb24-7a17fd6f47b9	12	0
d36d88ec-30b3-4c76-b1b1-80d6bc2f29ee	12	0
3ffc0f69-0757-43c9-b6e5-0dd57358f5fa	12	0
7289526d-4362-4241-8c73-eec2a2cba69a	12	0
5ee575db-5641-4555-b13b-fa0bb440511e	12	0
1195ac80-39fd-41c1-8311-170a69b12bea	12	0
1c3a137f-448f-4d5e-94ef-c550f14f2a4a	13	0
c12b7008-c2bd-43bf-b0a7-ebe411a071bc	13	0
21ed3384-2dea-42d5-b342-0ff1f0b2300d	13	0
0be5ac17-d76c-4015-b05e-df895b317366	13	0
d2151e84-fed4-45c6-a448-81bd73d0b9ee	13	0
68c167e2-d50e-4e74-8b5f-fcf9e519eb41	13	0
d1c7b315-69ab-430f-a0a1-c97ada716727	13	0
dc5c6b9d-02ab-470f-b475-102a7ff9b7ec	13	0
14acb9a8-d8c8-458d-bea2-badd357c48c0	13	0
ee7a0b16-dcf8-44e9-8719-58d28d3c587a	13	0
a2c33f56-078c-477e-80bd-02e299150046	13	0
2f2b18b6-b86a-4f80-bf07-515f79372e79	13	0
0edf13f6-9c16-4bbb-9792-4170fcb9abf5	13	0
11fc47a9-1e3c-4662-8385-3d03cb1ec7e4	13	0
9dc7b33d-dd2c-42ed-b0ca-f63e2cb240b2	13	0
66db2076-eb9b-45d7-b230-4a6aa148eed3	13	0
59a49b15-f234-491f-8349-493ae498b8fc	13	0
066c5e98-90ad-41a9-aa93-332b3648af95	13	0
e7700a11-52c5-43d7-9287-0e675e2538d4	13	0
75f88e1b-531f-4ecd-8424-f1c5fe55c4a1	13	0
a6e95ec5-23e6-48b6-afae-52190c043859	13	0
bb1e3383-e848-4dfb-89ba-5e099b43a263	13	0
8b0d67eb-c048-4412-be6c-87b3f57a0e89	13	0
bb8f6d12-4f68-4335-a7dd-c111f4baad28	13	0
ab1115fd-0473-4a60-81f5-21fc7bdee866	13	0
30d3c72f-bda2-4a51-991b-4b6c4383c3f7	13	0
dc6d69af-9a09-4be2-b81c-e17a7c8dbc94	13	0
09b5e32d-2d1b-4da0-a9d9-0143dff54bc5	13	0
971dac8b-8470-42a0-ac8e-8f90a0c86a40	13	0
35e93f64-8590-4225-bed0-0fd6d7e972af	13	0
22ae1a63-d8ec-40d4-8f71-9c2d5bbee91d	13	0
835209c9-22d5-4a3a-aadf-8b652ff67a50	13	0
59a49b15-f234-491f-8349-493ae498b8fc	16	2
c37a4105-9af2-405a-bbae-05b5b78150a1	17	1
c3fdbfd2-cbcc-4a4f-8a65-88e2a5068b5d	17	1
a9979f50-e827-47d9-b1f8-4c7b33216eb6	18	1
a963844a-6d07-47e3-952c-d9d122ab95e8	18	1
bd21e91a-8780-4772-b861-c415335a79e9	21	1
b64a8331-c47c-4f39-97c8-0728b869493c	21	1
15dd0329-b05c-4bef-be03-1264bf3511fa	22	1
9b274939-d392-4fbc-8878-94fec95b8b9e	22	1
d5157c64-ba43-4814-8c6b-8a2944308847	22	1
daa12537-7406-482e-bbe2-4bb66658872e	23	1
786a250c-36b5-4e11-8386-77250197d429	23	1
317b035d-d9b8-4321-bc8c-1d3b8fbab970	23	1
1a5dcb7f-befc-438d-ba7a-c0ec8b56b4b8	23	1
bd906c33-8160-4f1a-8baa-89b27ee0963a	24	1
1cc466a1-9c72-42f0-bc69-16a0385799b6	24	2
1195ac80-39fd-41c1-8311-170a69b12bea	24	2
0dbe7b2d-e08b-4963-aa57-c2f9ebdd8bdf	24	1
112199b3-1592-4657-96cb-d8d75b32ed20	1	0
48e63bc3-0160-4113-ac4a-3c0e714062f3	1	0
5a49fe61-9a85-4275-b0a1-810483d9b6b1	1	0
351514bb-ad91-4433-a45b-09ef4806ab38	1	0
d178be34-dc5e-417b-9355-dfff06bc9dad	1	0
4495cc46-cdea-435d-82c7-d64aeba2064a	1	0
e3a21df6-499a-40f0-b2e9-9b14e8729186	1	0
6094dff6-5db8-45ab-9b56-d9c853e6a2a4	1	0
52969983-b2a0-4eff-a85a-77065d8fe339	1	0
33dcb9c9-d1c9-4e79-8dc4-f10db46538d3	3	0
e5af349d-9220-4362-83f5-2d73b6850dbd	3	0
5826d8cf-24e1-402d-8aeb-7be8424085f9	3	0
0a1cb318-40f3-4eed-8d45-0e85fc660063	3	0
ae825b7a-ae33-4dfa-97cc-7a365f765878	3	0
14d66810-5769-4b23-8e36-a47c46998b59	3	0
8c5d702e-287e-42f8-944c-65abf43a2fba	3	0
15d36341-29fd-4011-8b3b-14e383c03861	3	0
33b0d33d-1b51-496e-ac29-ec438c397995	3	0
cd5955df-e709-4cf2-8661-c53438da7529	3	0
dc0fce8d-1198-4c77-a19b-1fbbf83ab519	3	0
3ea74b7a-7d38-4a93-a2b8-c01fbcdb2430	3	0
52c7999a-3f8f-49ed-bb87-70f0e6c9e9c1	3	0
1eea46f5-c30b-44c4-9064-b45ef2b0fdba	3	0
2a4be756-cc6e-41cf-b658-7b61674cc1d7	3	0
746362d3-7001-4f29-9b78-e8fc38130ef8	3	0
f8d7cda0-71f6-416e-867f-dbe04b1e2c12	3	0
7496be25-ccc1-405e-bcbc-974a656558da	3	0
451ee6b5-e458-465c-9d4a-4f9747521c2d	3	0
c2f701d1-7dc8-4507-9581-0c3d194e15b0	3	0
ed49d15e-fefe-4656-9e7c-23b8e6a792e6	4	0
97758713-2d22-483f-b374-b500a5e13eeb	4	0
5bd88f67-1138-4455-9c8f-78a370219935	4	2
35937657-9640-4a2d-97b9-78eddf1137be	4	0
de73a61a-fcc0-481c-a899-30bb66710c76	4	1
9b5b49ac-7ce2-4972-80a4-a4bae96bddbb	4	0
b1dcc2a3-0eb1-4556-85b5-4df90ee4dba3	4	0
0f9999a0-a767-4cb7-843a-33ca0315fa13	4	0
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	4	0
4470fdd2-0fb4-4c91-96c5-a436704c274e	4	0
60332d87-3bd5-4c83-a051-b57b0a315267	4	0
76dfb724-036d-439b-af19-f83cbc743030	4	0
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	4	1
f0fb3d0c-9b1d-403d-b223-10404463e563	4	0
c3e39344-e626-4774-a756-9c4bd7ecd480	4	1
7fcee247-f184-482b-95e2-12052d652da6	4	2
93c2192e-5604-4318-b8f3-a44609ecb7af	5	0
31f89921-971d-4b2d-9908-1246fc37a810	5	0
43688de0-472a-47c5-90dc-000bb921d946	5	0
bbfc56b8-4711-43f6-bdb6-dc85366bb63a	5	0
279755b0-adca-4d04-9bca-279171c9df53	5	0
bfe738d8-52f7-4203-80e2-7e822e96a31e	5	0
741ff552-de9e-443c-972d-6c6fa7272a71	5	0
29f13494-d82e-4112-8b21-660e2b57c00e	5	0
829963e2-5428-466a-8234-3f6a34cc49ca	5	0
737ae589-cd55-4d15-93c7-6c1cea5eb6cb	5	0
173c2074-4e95-4675-b648-344d0ef095c2	5	0
ef5d9c40-a804-46fa-a304-c518e4c64f77	5	0
23235013-1de4-44dd-9629-693b32ebddfc	5	0
d80d31b8-635a-4246-b54f-14ad8a6f6e37	5	0
61c00dbd-3eee-4c24-8910-1f4597287276	5	0
9f66929e-9676-428b-873b-b7f387d2e987	6	0
7ded5450-52c3-4435-9212-ebfdbd68dc9a	6	0
72289b36-acf1-41f2-bfc8-27a30eefe0bd	6	0
16641aa3-e9aa-4107-a58d-e23c0d423e3c	6	0
d9e8a4fd-2e2d-4f1f-8176-e65158f4e0c4	6	0
784b061e-fb03-4696-91a5-5a6bd9b470ea	6	0
fa8b47bf-43f9-4de0-9a25-eb8dbb4ce7aa	6	0
e335e2d9-89b7-4b21-9a0b-a4b9153d7f9e	6	0
5bd88f67-1138-4455-9c8f-78a370219935	6	0
de73a61a-fcc0-481c-a899-30bb66710c76	6	0
bd49e79e-759d-4384-bb8c-b6a8501ae0aa	6	0
09bb93d1-4140-40de-bea1-d433fc900ae8	6	0
db284fd6-6424-4de5-99fc-55244c2934b4	6	0
203ada12-595d-4ec1-a490-56e067a628d5	6	0
1b02f54a-3080-458f-917e-8867e9ac48ac	6	0
dd05ae9e-44c4-4462-a1c3-4c4e6e9eeb4c	6	0
fc371003-0e8d-4a9d-8922-adec80f9fddd	6	0
26eeec1a-f5b9-445b-a90d-4acb2dc30a08	6	0
50fd7612-3aa2-4db8-84f4-66083f19a639	6	0
6e775fb6-7e1e-40ef-b565-cdd071df95ed	6	0
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	6	0
3d90d835-0f33-4819-87c8-f8e5bdae2dd8	6	0
589c89ef-5bd7-4272-9045-51df779f4cc5	6	0
c3e39344-e626-4774-a756-9c4bd7ecd480	6	0
26098429-0cc2-4012-a598-d862389a9d1f	6	0
94d0f325-3853-4841-9f0c-a24056459342	6	0
514c23c2-3a2b-4022-9575-1255372307a2	6	0
7fcee247-f184-482b-95e2-12052d652da6	6	0
26dc13e4-d303-4add-8f9f-48a72c07a3dc	7	0
4831f25f-e9da-440e-9ad8-1327c41eeff6	7	0
5bd88f67-1138-4455-9c8f-78a370219935	7	1
88a1d98a-44f0-45e9-901d-09560e1f0e88	7	0
d8aaf9df-463d-4b74-87ca-e64b2202433c	7	0
8a7f1f41-ede9-4cf3-ba71-b8d8be357e6e	7	0
dda6e654-de3d-4a8d-9c98-070b3801198c	7	0
46e8edf0-073a-41b3-9a13-f31e3a8c6fac	7	0
66691f84-9d4e-48c0-8fc7-d196a1de335f	7	0
e6483ab9-d100-42d1-92e4-934504e7db2b	7	0
7fcee247-f184-482b-95e2-12052d652da6	7	1
852466dd-8ace-4204-a730-b7bf91dc365f	7	0
0d59e30a-eec9-4b48-bbb6-3a8f7548f825	7	0
abaded62-063f-4c35-a64c-6d6c1a566f40	7	0
3c153793-215a-4f88-ae7a-da6fb26aeafb	7	0
10f53a08-b2eb-49af-ad27-44f9dc305193	7	0
9509e71b-bd55-467a-896a-1152bafd8cad	7	0
8bdff05d-db3d-4448-91bc-07476266afb8	7	0
f3ee3788-8cdb-4889-b7aa-c443228cc09b	8	0
9d2e0a88-9483-407e-b0d3-769c5c4e813e	8	0
8448d68d-df03-489c-b2c7-c5b6180303d8	8	0
5a261a82-4c07-40f3-a368-ebd7a0b824b4	8	0
51a513d6-9e4a-4af0-9fbe-17297c35d7cf	8	0
395ce751-880c-4d3a-9da9-a8429c365304	8	0
70cc4c6a-ded1-4600-bb21-b4fbc77ec9c9	8	0
8e103754-fa34-4c18-b95d-e3b36c99e698	8	0
df4a48c7-6607-49ba-92b0-cc80888f89cd	8	0
78a45a97-7efd-475e-8c8e-0eb3c7320229	8	0
f85ebc8e-f5fd-45ab-b60c-55994f999ba1	8	0
2e1d70fc-99b4-424c-b283-de1e0079ee65	8	0
c0977f82-7f84-41f8-b0f2-fedd9430c9b0	8	0
2dc54bd3-d2bb-4781-9da8-d65c3bd54e8a	8	0
d76ac863-b452-47e2-9148-54c93c916f92	8	0
9a81b99a-5128-4a90-8c7a-60aa64eec9c6	9	0
2be78423-f27e-460b-9e2d-b2dd402d8b71	9	0
e7b33b6d-f3a2-4a16-ad91-f9d6fbcc4f11	9	0
43d8ae39-2d9b-4805-bd98-9e93acc5a2a8	9	0
2b8f81d5-b864-407b-b2fe-47d72ba61eb5	9	0
3fdc2d33-0d0c-460c-b247-9b16acb6e98b	9	0
a351cc47-2bd4-4ff7-a1ec-814dd9dc3588	9	0
eb8430aa-22e6-4006-a2a0-b9912965c028	10	0
e9e1ea5d-1147-45aa-a489-f7d608b42bce	10	0
1065afc3-15cf-461c-8503-25408b9e1986	10	0
ee16447a-4d2b-4aee-840d-c6af5e2114e8	10	0
c7c1614b-37f0-468e-a4fb-98e014ffbc2b	10	0
5537d68f-f723-4795-b794-019b29214bb0	10	0
b3c80b7b-36c3-4109-b605-aa0747033d9c	10	0
306b3852-8727-455b-981a-60627913d027	10	0
b05d4c35-0aaa-4727-9e0e-7efc5abe6952	10	0
3a8587e8-f662-41b4-aa52-6a3409be7a96	10	0
0cfb3a80-51d7-4b0c-a4a8-e04ca95aaf67	10	0
ff9c8634-215b-442b-b5a2-0465083bf6fc	10	0
46336647-5425-4fa3-8000-db79698f1344	10	0
488d0519-f283-457b-addb-a8dd5c0ac31a	10	0
69e3cfac-a236-45d2-b253-8ed297796f97	10	0
42970bc1-953c-401b-8458-7d6d4fcdd594	11	0
e3c041fb-ddb8-4088-8876-4961c91d0df0	11	0
d87efcbd-a496-4bd9-b624-190f0c9c8a92	11	0
63b42134-bcc6-4b6b-8502-3136831c91cf	11	0
464060a1-fe3f-40e9-ad13-da22dfefc73c	11	0
d7b28b13-dfa7-4d24-b241-f5f64ccc0eed	11	0
39ffa8dc-bc6a-43c8-9ad8-f83bb074f39e	11	0
a77bf089-5051-464f-980b-2ca54ee4a309	11	0
8bed0f8c-263e-428f-939e-70d929f01152	11	0
d972cc47-ac2b-4a20-a414-431c3cb3b166	11	0
d0adcb58-5c3f-4c2e-9ad2-37bf22628ad9	11	0
b47031ea-52f8-4a18-aee5-c70aa7321734	11	0
d4822292-be2c-4700-b3b8-ff68873dc93c	11	0
4f08050d-3ef8-4c1f-b9a9-09c0da44cbbe	11	0
41de50a8-f938-4c77-9299-b1f5b89ef76f	11	0
835e7ca0-d43c-4f37-b34a-357c6e52e848	12	0
387c398e-e97f-4cce-a288-c6b215ffc0ee	12	0
4fd1c2c8-5d42-459c-ab70-049cb844b243	12	0
fe4baef5-8a04-4b0a-8b90-2c7e0b57d5d1	12	0
eb380dce-f66d-4e80-970c-ab4c50384ef6	12	0
3abd6eda-e147-4eec-a98f-f9ba770069c1	12	0
fcdd3730-f613-460a-9ed1-4d048e80e7ba	12	0
9b26198b-ec30-4763-8b73-f38090f5453b	12	0
25301206-6cc3-4a60-9330-6b05c6533ef8	13	0
69f0079c-fc32-471f-83af-f1937b4688eb	13	0
203ac07f-1298-4f6f-b771-3830027938cf	13	0
b73e829a-c2cb-4cc2-98bc-d5eb8b8cbc6a	13	0
de688085-12c9-4b3f-ae82-f7275c18c156	13	0
2b6079e7-9678-4cce-a2b3-38c8ebdab75e	13	0
cbdef073-c753-47ac-a5f9-3369dd1cd7ed	13	0
cdda8b88-2a14-4ec8-9c22-c604902f4e0a	13	0
9f909e1b-cd3b-4ba6-a90d-ed7a2211b8ba	13	0
4aff6140-751f-4ea4-be47-12de9ad9bfc4	13	0
1a2203b1-5018-44a7-a202-a1de180a8a51	13	0
2d598cf8-a56c-4aba-b71f-02bda83c8fce	13	0
f92e62a8-424e-427c-b4af-8ca7758ef77c	13	0
a2812462-ca90-4752-ba9d-a1043dc636d9	13	0
76db48c0-495b-40ed-aba3-da360432b072	13	0
3707ade5-9bc1-413b-ab78-fbf06f658571	13	0
611937a7-00e6-41ea-afb7-6c63c6f6cec5	13	0
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	14	1
ed49d15e-fefe-4656-9e7c-23b8e6a792e6	17	1
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	18	2
5bd88f67-1138-4455-9c8f-78a370219935	21	3
4470fdd2-0fb4-4c91-96c5-a436704c274e	21	1
7fcee247-f184-482b-95e2-12052d652da6	21	3
97758713-2d22-483f-b374-b500a5e13eeb	22	1
35937657-9640-4a2d-97b9-78eddf1137be	22	1
de73a61a-fcc0-481c-a899-30bb66710c76	22	2
9b5b49ac-7ce2-4972-80a4-a4bae96bddbb	22	1
b1dcc2a3-0eb1-4556-85b5-4df90ee4dba3	22	1
60332d87-3bd5-4c83-a051-b57b0a315267	22	1
76dfb724-036d-439b-af19-f83cbc743030	22	1
66f28f69-670c-4ba9-9c68-bc3cd0c4056a	22	2
c3e39344-e626-4774-a756-9c4bd7ecd480	22	2
0f9999a0-a767-4cb7-843a-33ca0315fa13	23	1
f0fb3d0c-9b1d-403d-b223-10404463e563	23	1
aefa1af2-63f9-42c9-97e4-ac2bcd84815a	1	0
79b71198-6665-4491-ba0c-a4e7d2045da7	1	0
b06e4660-fb61-42fe-aa1a-eb30e3a2ba87	1	0
1859ef70-ee73-43d1-a5ee-f699a6ba44ff	1	0
233c4fbb-ece8-457b-a91e-ba9b546a5cda	1	0
835c0200-8ead-4715-928c-fbf72662354b	1	0
75c987e5-1a7f-453a-9ffc-5654139be6e8	1	0
9492d2f9-4000-49d7-9b35-09ebc099f4da	1	0
3e4a71ab-7ff3-4ec4-9143-ba1e5a0d7788	1	0
d382369a-d4b5-4b33-9e67-004ac51e13ef	1	0
792c66a9-3bc1-4e55-b16d-b099540235a2	1	0
d8116351-4736-4aee-80b0-819dfa254343	1	0
dea5968c-d713-4292-9eba-a388b98e84f4	1	0
dcb9d3dc-1214-4827-9d7f-921eb246c982	1	0
3aecde29-0e10-4273-be74-4d633310b05a	1	0
6d7749e5-0a6b-4319-94d9-76ee18e5bcd1	1	0
cc94069a-a9be-49d9-928e-a14012570b62	1	0
49f88bfd-59f5-47c8-8e72-1915f0928a70	1	0
f2b5bfcd-0316-4d6b-86fd-3f14a9620a04	1	0
d356850e-327c-4823-9960-448b8a2e838b	1	0
a626dd44-5e92-474e-ba6e-3ad9fd54f28c	1	0
fd7032c4-5deb-4858-9659-4cec34d24a38	1	0
3e6008f6-10e4-43d3-bd74-57bfdc32e638	1	0
7edf53c0-a3c4-4cf4-98bb-0755765589e2	1	0
0715f5b8-e3fa-4e94-90ad-8cb41cfa00da	1	0
2fcd5605-ae7c-4cdd-a4a4-294d7ecc9fff	1	0
83483a13-3a30-4b27-a01a-5bf0f6466703	1	0
7cf192de-073b-4068-bd7a-e6a6cd6321f1	1	0
404a017b-4132-4ab0-a337-bdda6cc4ba54	3	0
861d11ae-dea8-4d67-9da7-d909cdd2ddf7	3	0
fbebe421-180b-4c84-80d8-22c6f8d56d51	3	0
16fe83b5-c5ec-4fd6-818a-fe9abc5d05a7	3	0
45963a0d-d557-41da-91b4-383de61e01ed	3	0
47a8ff3a-93d3-4198-bd64-390252f65f2a	3	0
6e5763a4-1716-4b2c-9c0c-8a7dcad5d67b	4	0
5bc02c47-0033-43ec-8af0-ea6afd16b680	4	0
50915e46-2856-4246-abd8-23c90dfdf613	4	0
5977f266-55f9-415a-875a-46c8fef5a449	4	0
18ee3b43-b6dc-46ee-a491-070865869011	4	0
51c67093-938d-466d-9304-d7a6e6feb924	4	1
f0ae4996-e7c7-4b4f-83f4-1ad4649d3192	4	0
fde6f994-cfe0-4443-8075-e213405cefe2	4	0
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	4	1
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	4	1
371e3521-83ea-4633-b1c7-7ee1cf9d28a4	4	0
43723a6d-1ef6-4986-a99a-f49c58ea9286	4	0
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	4	1
e5d2c84c-7765-438b-bf70-763c919f9839	5	0
2c5a6835-d961-45e0-92ef-b060f0e996fd	5	0
5de2451a-e107-4a8a-9c5d-15d3773d2ee9	5	0
c55ef00b-3f17-4cbf-b531-534ae742aef2	5	0
42bec33e-04aa-4189-affa-4ae279a9d522	5	0
2dea99c8-8cde-4640-bcae-d8c1dc37509d	5	0
f904ba40-0922-4faf-a71d-9bba5871b4c8	5	0
890f7aac-83da-4cc7-ab4c-79ecbb5550be	5	0
199b6151-3a75-43c8-947a-de02a29f4159	5	0
84b26c9e-33c2-40d0-a96a-95c36d305be0	6	0
25d5af81-0ca8-46c7-ba3e-a35c8fdaeadf	6	0
8af6f8c4-3e71-4565-b805-fd8250f85ce7	6	0
f025e34f-775d-46df-91fa-bfd49786478e	6	0
d5e805de-2f37-4da7-aa3c-0c5ec369481f	6	0
f54eb08d-8305-4ff3-ac86-f25beba1d1b5	6	0
892976eb-737d-49c6-a07e-7f2ab59704f7	6	0
ddf37ba6-30c5-462b-b426-79017c99af5f	6	0
986b8974-80ef-452e-ae2d-862982a7d39f	6	0
91af15b0-b2dd-46b0-a7e1-981961a6a1fe	6	0
490bb07f-79cd-4228-8732-eb6a7ba50e8b	6	0
2f6bb46b-7092-41ea-8d7b-7aa3fa38460f	6	0
11dc59ef-9e86-4bbf-87ea-760049204bcd	6	0
d54144ed-a533-4b23-92a6-38d9deda8f61	6	0
8c05d3c8-cea0-4537-9f9e-e76ffa96360a	6	0
8960252d-2284-47ee-ada3-0927cbbfeae6	6	0
51c67093-938d-466d-9304-d7a6e6feb924	6	0
97246305-5558-40a3-beaf-449a6f5bf995	6	0
2d034385-53b2-42fc-a367-2c84c569f56d	6	0
c0abdd24-bed8-41a3-b9f3-e96380134084	6	0
bd161ab5-aae9-4443-972a-96dcbfce8f30	6	0
6aa5c15c-e53c-4ee5-98b2-eefad8a4cebb	6	0
11009e0a-52bf-480c-a628-0458e7da2c62	6	0
271d15fc-ba22-498c-977d-67e811ddd36b	6	0
7893c509-a892-4e32-9f51-f083d41bb2a9	6	0
fe681876-2a14-42db-ab19-e9007a827d22	6	0
3c9d2c50-b8a2-4ae7-96ad-ce337ceed630	6	0
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	6	0
fd462e1b-7149-4c8c-b067-5be132f2d700	6	0
31cd216f-3518-4e41-ac26-aee854f78690	6	0
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	6	0
4da7aa52-cfe3-4e7d-a58d-079747d456ba	6	0
2fc70601-e38a-4677-8bac-7c402c89262c	7	0
921791b1-f03f-4ad1-bba2-519c2abafdfb	7	0
20d3b8b8-4e37-4228-baa0-a849dd85a054	7	0
390ee84b-8b44-4fb3-8197-3546465a4259	7	0
a6e5ffa2-1375-4795-9d2b-5fdf3189c88f	7	0
b6f1c6a8-f6f4-478d-b8c6-a97fa3b7d11f	7	0
25685a44-42b0-49a4-809c-75f26ac4a670	7	0
7387937d-40fc-4d3f-a6e3-0cbdc0a2cf5a	7	0
bf8583b8-c2b9-4d7b-ad36-8a20d0eb41cd	7	0
ef01f19a-acd1-4dda-82e8-7f6202a2fcb4	8	0
258bae8a-8418-4832-afce-a0db718a40f1	8	0
65f7cd76-eeca-43c6-8045-0fa03558bad3	8	0
71423c1e-7ca0-4f62-8514-6eb4d763c82a	8	0
9b60c14b-b38f-42d4-8ce1-9dbdc056001b	8	0
09994c7c-0348-40fa-8c27-f54f62c411d5	8	0
f0f43978-c412-406e-b69a-510a48ada645	8	0
108089ed-9a8e-47ec-a36e-2c45a5d22242	8	0
2fde72d0-dc75-4481-b69d-a5fcbbaeff2c	8	0
87e13e39-c07e-4d2e-8645-4382dd48cfe2	8	0
72d300e0-f652-4f9d-820e-2b95e38f3e38	8	0
dbacd453-681c-4caf-8e30-2842e4716473	8	0
31d1da51-22d1-4d81-9e5c-85d3f5ac8bb4	8	0
25333962-747f-4cea-9408-90be09753796	8	0
e94a32b6-4c21-4533-ba27-6a5070bf7e84	9	0
036915da-2710-4a83-9a3e-09dd5274f046	9	0
c6b7238f-029f-4145-86d4-d7107811e1c9	9	0
0c9f2e0d-8e83-424b-abe0-66fd040bc404	9	0
e1c09b09-15e6-4000-a408-449e0bdb429f	9	0
4f916722-8b46-415f-91d5-4d8059827ef2	9	0
1deafde3-b641-4e85-937e-7445d4e5e646	9	0
60ce0431-901f-4a94-bfc0-198872b4cfba	9	0
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	9	0
6a437518-d809-4e64-b5b3-af9a40bd83e4	9	0
e73a283b-5905-41d2-917f-0678dbf7f1c3	9	0
7f652dbf-eef9-4666-b349-9fbbecdbd0c3	10	0
46e31a25-e525-4f6c-b9d5-f465a490826c	10	0
20abed27-9706-46f4-9502-7f44d5a239ac	10	0
11f2ab29-cdf2-4190-895c-a73160f39156	10	0
f41365fd-b2d4-4dff-b09f-6838d8153817	10	0
ddd9b24f-dc91-41a2-8c8f-e6b4f85ca788	10	0
e878c4b4-5132-4c86-9917-d139b43cf6fb	10	0
98d51ccf-1c1c-47d7-91f4-f66a804a99f8	10	0
ff98363f-b080-4832-ad65-5acbd8653c52	10	0
8bbc8045-534a-444e-9182-b79740522f2e	10	0
b63b0bc8-9132-4a92-9946-f68b470a0570	10	0
dde95473-83f2-4a90-a193-4d5fb0627eec	10	0
7c96bf44-a398-4491-aedc-a6979957f2ef	10	0
242cbf9f-1bdd-42ee-92ee-940e8f71a7a2	10	0
a8e5ae9b-406d-42bb-8564-a5ada7dc9a29	10	0
a8a5606e-c1ff-49a8-8908-00e2f11fe255	10	0
965644de-d300-45b2-8ea1-6dc47580201a	10	0
a2cdb2d1-66e2-4dcd-ac22-ca718ad28d5a	10	0
e9ea663c-4239-414c-a2df-ed642742f22b	10	0
e2a2c510-7926-45da-9705-9825fe03c89b	10	0
4274c2f7-47d5-428b-91dd-5eac64fb3b3c	10	0
2f94faf2-f509-41d1-a9da-c587a607152b	10	0
782c52a6-b200-4d2e-8b4f-ddc5d0bbce9a	10	0
bbee356f-1dfd-4325-8e89-a33211b6fb40	10	0
16307ef0-ea94-4f0d-a55c-0ee9e70f650d	10	0
654bc61b-5157-4e45-a7ec-d4497ea2778d	10	0
6fe03a4e-37dc-4582-8011-e1a950292c39	10	0
00b39fc8-29bf-4a66-9a61-8307236c3139	10	0
ac01395e-3f1c-4634-bbc6-44c075364150	11	0
94a0d616-c29c-4635-8f82-6ff0fe299de8	11	0
8a70b61b-e229-4091-a499-90161c8ce90d	11	0
df6334a2-732d-48fd-9569-eaa08ef78ed2	11	0
696217be-952c-497b-a2f7-5b5d3e6f48d8	11	0
39ca2b0d-0cd1-43d4-919b-c762435ba5aa	11	0
aa2c57fd-0f99-4dce-a4ab-21d9c5f3e3ad	11	0
2deb8cbd-6a41-4f1d-abab-e114b60d1fc1	11	0
2b30f754-dbb1-4601-8407-735ee6fccf41	12	0
901f1993-b3d4-4dd5-9e9f-4a3676f291b1	12	0
4b8d0a6f-f524-4094-973a-fd44743a0e41	12	0
b92af578-7367-4854-8245-8d18ec973491	12	0
5e3ec8b9-177a-42d8-9570-ad4ae4c5e796	12	0
29cf40f7-9b42-40b1-8fa5-8ab9443d333e	12	0
7c5be820-67eb-4cae-aee5-7472e456ef88	12	0
d3b29032-77be-46ae-b1f8-ba95e0e516c8	13	0
ce66dbe5-ac3c-4e30-beb0-6d6e49bbe740	13	0
234eaa50-306e-4e1e-bc07-cbd93a7795d9	13	0
ce8f8079-d4c8-4d6a-9cb0-f5922dc0da5b	13	0
d9f609d5-c875-46ff-a4c3-9100aef8bb84	13	0
8cde9fdc-429d-442a-b923-ac4f75a51d03	13	0
a7a934d3-7253-48a4-94bf-7022512dbf6e	13	0
0bdaac42-1ef4-4eb8-b348-0dc9715e234f	13	0
f75b11fd-6312-49cc-a239-bead1e8d4b2c	13	0
b5c022be-79e2-48a1-9481-1ad712f8d00a	13	0
80e3e0cb-639b-40cc-9d1e-2e444c432819	13	0
d8cfc057-de09-4fe5-aa78-57295a011fac	13	0
db653250-a2c3-4d16-b1e2-5ae8d7ffa9bc	13	0
a7bc28e1-ce3c-43d6-bda9-ac9ac6755124	13	0
972bc2a5-bf6d-476d-aecd-37dc0666b5f8	13	0
71289ec9-3d91-4db9-ac8d-4b9a5bd0d265	13	0
c7c4c80d-d9cc-42d0-a68c-4fc28fee3d9c	13	0
e1ae85ad-7ac8-4a0a-8ddd-8c5df533867f	13	0
f9be7032-a9eb-40fd-b654-9f2b0ec7e09c	13	0
d263761c-c58f-4f3f-bc06-975d6bbe77d3	13	0
e7ac4ff5-2eff-45df-b1bb-a5bb3a794dcd	13	0
18ee3b43-b6dc-46ee-a491-070865869011	14	1
fde6f994-cfe0-4443-8075-e213405cefe2	14	1
f0ae4996-e7c7-4b4f-83f4-1ad4649d3192	16	1
3b5c8976-14c4-47c4-9bf7-0286c9e4a480	16	2
371e3521-83ea-4633-b1c7-7ee1cf9d28a4	17	1
18ee3b43-b6dc-46ee-a491-070865869011	19	2
51c67093-938d-466d-9304-d7a6e6feb924	21	2
63d3b1b1-4d0a-4444-90dc-da82f401f7c8	21	2
6e5763a4-1716-4b2c-9c0c-8a7dcad5d67b	22	1
5bc02c47-0033-43ec-8af0-ea6afd16b680	22	1
50915e46-2856-4246-abd8-23c90dfdf613	22	1
43723a6d-1ef6-4986-a99a-f49c58ea9286	22	1
5977f266-55f9-415a-875a-46c8fef5a449	23	1
e51e4332-4e3a-411b-9fd6-c62ed14d33cc	24	2
57d0da50-d78d-4090-9abd-44a74a04531f	1	0
df07c0bf-0cb9-4528-adb0-92debc45e731	1	0
a42f1f35-c5c8-45c4-93df-96976d63c76d	1	0
8adc218b-6062-4456-9fe2-c9a985f17ba5	1	0
0e1f5bb6-1624-439d-9a5a-35bc0ed5475f	1	0
22456395-ad0c-4d83-aa88-b1c7492345d7	1	0
35fb9800-845b-4c24-8310-0b9411fb5f3a	1	0
92b4d2c0-f5d9-49a2-b604-fcf7136d887d	1	0
81d7239a-95e7-4647-acfe-deceef2d5b41	1	0
6345a403-0755-4cd6-8206-fe3eff78cd7a	1	0
9a7a3645-cbad-427e-ad31-06477e2dfcec	1	0
55368c1b-e83d-482b-bafa-72b3cff511e8	2	0
16270b31-0aad-4066-af64-7e6c014104af	3	0
9100ddb7-e768-4573-a44e-987717f03a83	3	0
9fe9a4e9-e215-481d-960e-5ec085093f0a	3	0
8d892886-55c2-443c-8b87-787063d15f27	3	0
baedb644-22b1-49c5-91a2-8cc02d41b153	4	0
02f26556-cbf5-4a0f-b71e-28aafef81640	4	0
069bfcdb-9242-4219-a8ca-9eca0e6f8932	4	0
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	4	1
3205d947-4b83-4783-85df-b241dff36fca	4	0
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	4	0
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	4	1
3454d6a4-19e8-4e78-a931-0360242538f8	4	0
01cb4769-1e28-4b69-bac9-5d4dc6a3fb14	4	0
d52be40b-6939-41d4-a93f-c52027dcfc9f	4	1
c61e584b-547e-412b-b8b7-6d16798c6be5	4	0
467f3301-3710-44df-9a0b-1c90e765ca83	4	0
0144ff95-5a0f-4b35-ace6-95f4a60c53ef	4	0
18c70a89-ccfd-44f8-800a-68e6efb4de2e	4	0
081f7bc8-03b3-453a-951b-ecacd1ef9953	4	0
9f1d620b-e587-4e46-9acf-0754059a5292	4	0
5c5f9972-a390-463b-8850-bb7fcbbc18c0	4	0
0eab8f58-43a4-4376-bef7-f9bfcc639dd4	4	0
deec0cae-a38c-4451-ab2f-ab82a7129c46	4	0
ba7f2ed3-abda-44b8-ab5b-1b472fb12f51	4	0
226eaebb-f428-4198-aaf3-9914bebf0e55	4	0
afb51585-cd15-4862-8833-cfb1b344cd99	4	0
5b43060c-b730-43a6-8bd3-0068ba5b6da1	5	0
6c2fa11c-375a-4a91-ba45-72dd7529d50a	5	0
457fd5a7-7d7f-463e-bb8c-4c7bf90dbf7b	5	0
5892d213-2486-45c9-af21-89a8c9301de4	5	0
fee8e98b-8827-480e-9217-03edc7d76d28	5	0
d21296c8-d92e-448a-b7eb-0decd5a845f1	5	0
42f7b526-e47c-4975-8152-567192aca839	5	0
26c8a648-0585-4aec-aaf2-613af8509951	5	0
e09bc304-5146-49ae-b1ea-0952da8a029e	5	0
baeaf1a8-e7b9-442a-aa98-51213fb260d3	5	0
da33c177-78c4-4d04-af93-5017004e20dc	5	0
8ddae5b8-16f6-49f7-9d6b-8f6798f51198	5	0
2df671f7-3fc9-4f77-835e-84be0d0d4572	5	0
a42ddfad-fb07-48df-88e7-faba85b0c70a	5	0
9436162f-6019-49ec-bb6a-1a6029b6f74d	5	0
e173b004-ed64-452b-93a2-7c3389882f32	6	0
de79a7c0-8737-4cc3-aa81-ac2339dc5e0a	6	0
ab7a75da-ad32-4af5-9057-25a02ee7754f	6	0
20574940-ef3a-4801-8e44-ea564ce66e09	6	0
4f75c460-ea43-4e8e-b34b-8c42b9269527	6	0
e429df0b-36de-4035-bdb3-68fc6d7fe913	6	0
019f9bcd-b3bb-4a94-9e41-fcebff22a961	6	0
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	6	0
080c7109-9e3a-44a1-ac47-e9de0ad7b455	6	0
fc501c86-3082-42f5-a5d7-232e24214d21	6	0
e6bcdac0-f460-48c5-b4c6-d3de4894e040	6	0
c1024cc8-d271-412a-9f1f-a606e4b3408c	6	0
3ed7891f-c51a-4e60-aefa-949498db36c7	6	0
c9a9cce0-396e-45cc-a045-5ca431e6f434	6	0
d52be40b-6939-41d4-a93f-c52027dcfc9f	6	0
176e36a4-47b6-4707-9632-46b7039999eb	6	0
87592ff3-0d8b-4ad9-87a4-1f42b9a3da40	6	0
6d5cd030-7c15-45d7-8d1b-80f8d895a426	6	0
36ed4900-51da-475d-a7d2-d198403bc654	6	0
1dd259c1-1b5e-4306-a490-6486171b6f46	6	0
adcd2c9b-76ba-4703-bd32-f336fd99df42	6	0
8d0eeb71-6dad-49e8-b020-902b457ce577	6	0
c56da89b-a376-4427-b858-902854c31954	7	0
3171b596-e350-42d9-94e8-971e476909c2	7	0
bf370d51-dd16-4ac1-8d6b-c047be4dcb4f	7	0
7438ba06-a922-4565-8c5e-c4cbca49ec64	7	0
928c744e-d4e4-4591-ab1a-570dccf32e11	7	0
3d541bab-2998-4367-9137-e10f2b0d6c70	7	0
d0a56bd5-b31d-4c67-8af0-4848d7f79712	7	0
5941f130-5946-4ec3-b30f-44e4f9e60fde	7	0
2319cfea-0ab5-45c1-8434-dda2ebf87a2c	7	0
35fb9800-845b-4c24-8310-0b9411fb5f3a	7	1
4bdc6792-b55c-4165-a7f7-89fe61e447b7	7	0
9dc598ef-a55a-496c-b049-a86e36f4f52e	7	0
7f536a81-9d75-40ea-91b7-26d091667c72	7	0
f0aff911-b4f9-47c2-873c-035682feeecb	7	0
9642531c-1e0f-4ea3-a147-f1bc89b39439	7	0
e53f8a1b-b42b-4b8f-a84f-58fd53b52182	7	0
ff5f0a8f-3c39-44a1-a9b1-0458a3c7d0a8	8	0
714929b1-aebe-420e-8a90-692a354bc5f9	8	0
5066244a-9070-420e-81bf-1fbe0ddc9028	8	0
e181c7cc-29aa-4e95-8141-be486823be9c	8	0
10932cad-5b4f-4a4b-8fd7-846a14d30827	8	0
67f1d3ba-0273-43b4-9d92-7ca7b0807605	8	0
c7b14be5-72bb-453e-9b07-3b5ddece6d1c	8	0
61ea4579-714b-4024-9ced-6e9fcc0831d2	8	0
e4cdd2e6-d91a-4d2d-9a79-e4af1629256c	8	0
c001a96c-bbdb-44d9-9c6d-e43a43f7c2d6	8	0
e9c7000f-334e-47ec-ae95-efb5db0a2865	8	0
9a0bf99c-ca66-4fd6-87ae-9816c514bf31	8	0
77c1b8c0-e952-4be8-9a5e-df4406d82fda	8	0
1200e264-b71d-4962-952f-5681923cd536	8	0
7bfd0f30-eee9-4125-b447-166f6aaf0c38	8	0
ac1e9498-95d1-4a64-ad47-468f0acaa2ca	8	0
c450cf42-b50a-4a10-9ee1-9ff113dc49da	8	0
48848ff4-5636-4660-b9f1-089d2568d05d	9	0
88b0b7ca-42d8-44a3-8b27-78f57dada430	9	0
d69b0fd1-471b-404f-992a-00b79a626d66	9	0
b8b31d29-c55a-4ff6-81f9-c915469b9801	9	0
8e4fa96c-0888-4ea2-8902-182bca746aa8	9	0
4fa16655-4c81-41dd-bd5d-f4810f5784bd	9	0
00692473-839e-4b7f-9a60-6fd43a9da966	9	0
a09f322a-f2c3-4137-b193-eaa0e576916f	9	0
eea4d50d-c417-45cb-9608-b794a894828b	9	0
d4228403-55e0-49bd-b5a0-9cc9a46fbfe6	9	0
da6cec11-13bb-433c-84c9-2d0e8cb09888	9	0
81a51a04-efd4-481b-9b23-b241b65fb3fb	10	0
856c5137-c8a9-437c-8d2a-42c9418306ad	10	0
97c6438a-6917-46e1-a9fa-6863a30c9375	10	0
a4391511-8111-405c-9ef5-578ff17dba18	10	0
c03de426-62cb-437c-a6ad-08dd0f156ec0	10	0
f657a545-3055-44a4-bcef-769ae331923f	10	0
6b6729dd-5c30-4884-b755-ad7729a3d770	10	0
d7edcc43-5950-4003-8035-5ddff611d98b	10	0
a3bd97af-f903-4835-8a0f-dcaa977875e4	10	0
0999c5f9-f065-4b38-b52d-bebb9c0bdb18	10	0
ccc1e004-b6a0-4cd3-8c3d-e1fbb1830194	10	0
fb470077-1ba9-436e-a827-a572bd4fa557	10	0
4c38ff86-f09a-43e8-87b1-f8f9ee15cb4c	10	0
4532da78-69ef-4289-807d-609516b22731	10	0
4ac7e0b1-80e6-400a-b17a-b9b15c9f3324	10	0
1720286e-7d16-4b09-810c-8784cd1047c6	10	0
be05b4d1-6db7-47f9-8714-dcd59c624eeb	10	0
823103f1-1745-4683-802f-ab9e5d964bf1	10	0
e934cb41-0318-4f40-9e77-a1276aa38a9d	11	0
2c4b02da-15a7-4281-aa69-5a800c020ccc	11	0
0c96848c-a0f5-4420-869a-0fe278f9806f	11	0
e8bc8672-faea-4f4c-b003-82e9db5f9b02	11	0
f8a49357-efff-46c6-9346-c7431c2d0f7d	11	0
b28a7bdd-47ee-4106-84ae-5942aaccbef9	11	0
4a6412f7-0ab0-4c58-9821-699e6d7b1c09	11	0
d5d73ae5-f724-4db2-99bf-3b66ce8f7b5a	12	0
cdaa1bd5-d57e-4d79-8779-023885aeaf37	12	0
252779d7-9211-41c1-9d7b-88c60a2f4651	12	0
af9a1522-e9d2-4db5-bff7-1ded4351aa43	12	0
9738d588-b4a8-4d91-b870-bc7f37bf39cb	12	0
34457931-4769-412a-b07a-3610bef1392c	12	0
8c203f3b-94ff-4c21-9ca7-3e5290e120a1	12	0
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	12	0
7dbf5121-e23c-4ef4-bf7a-73ae3f86a874	12	0
744ffabb-c047-4cf7-887f-6c9cc236af9b	12	0
6d4ac37a-add0-4666-af29-e02dd112c489	13	0
99e07992-4e99-427b-b53f-5daed7bee852	13	0
2b45e1ea-32c8-4d27-aeac-47c707210c51	13	0
7150f0cd-4a23-4301-9c3d-bd0c7778c48a	13	0
91fbfea8-a0c8-4b02-b665-3b9e2b97c548	13	0
a9602108-5f1c-4c06-b5d6-655068e72bdf	13	0
a845c892-2d44-4509-8f92-367759176960	13	0
51ff99bf-96a3-4d0e-a459-efba0f9d6c51	13	0
78e3d926-ac02-4bb2-9e33-037f5ea3ce87	13	0
e061750b-071a-4041-a239-60f01f2aa900	13	0
c05854b8-9a22-4eca-8371-e34c8494e1e4	13	0
6098d463-ba39-40f5-aacb-5c9801bed788	13	0
49faca4e-b4db-4d41-9309-423271211bc2	13	0
bb44a91e-dadd-44b7-8401-73418178db4f	13	0
1cd929b3-9d98-4feb-93fc-3c48ba0e1064	13	0
a4224f06-5e35-4311-ae5b-2b477e76dc93	13	0
ab6c42a9-8545-4a2e-bb42-2a105858181d	13	0
cb7cca2b-6e5b-4a35-9497-ce87658167cb	13	0
b148b208-f81c-4d84-a406-772df7c1a4a6	13	0
4377ac19-c199-4c27-8706-0e977da947dd	13	0
c61e584b-547e-412b-b8b7-6d16798c6be5	14	1
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	17	3
c61e584b-547e-412b-b8b7-6d16798c6be5	17	2
0144ff95-5a0f-4b35-ace6-95f4a60c53ef	17	1
467f3301-3710-44df-9a0b-1c90e765ca83	18	1
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	20	2
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	21	2
3205d947-4b83-4783-85df-b241dff36fca	21	1
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	21	1
081f7bc8-03b3-453a-951b-ecacd1ef9953	21	1
9f1d620b-e587-4e46-9acf-0754059a5292	21	1
5c5f9972-a390-463b-8850-bb7fcbbc18c0	21	1
226eaebb-f428-4198-aaf3-9914bebf0e55	21	1
3454d6a4-19e8-4e78-a931-0360242538f8	22	1
01cb4769-1e28-4b69-bac9-5d4dc6a3fb14	22	1
d52be40b-6939-41d4-a93f-c52027dcfc9f	22	2
0eab8f58-43a4-4376-bef7-f9bfcc639dd4	22	1
deec0cae-a38c-4451-ab2f-ab82a7129c46	22	1
ba7f2ed3-abda-44b8-ab5b-1b472fb12f51	22	1
baedb644-22b1-49c5-91a2-8cc02d41b153	23	1
02f26556-cbf5-4a0f-b71e-28aafef81640	23	1
069bfcdb-9242-4219-a8ca-9eca0e6f8932	23	1
3205d947-4b83-4783-85df-b241dff36fca	24	2
33fe7281-7800-4600-8e8b-bffbd7d2dbbb	24	2
18c70a89-ccfd-44f8-800a-68e6efb4de2e	24	1
afb51585-cd15-4862-8833-cfb1b344cd99	24	1
9abdbd49-94dc-4585-a027-d00da9d1f391	1	0
0ea844e0-82c9-4318-b410-2a4029c35ae0	1	0
f29b9826-21fc-481a-9460-7f10c0b88724	1	0
88e9ffd0-b273-4038-a96e-f194c3b78d8d	1	0
3f65a5e6-1a71-426b-b6b7-b55f6f3752cc	1	0
d69a3e74-99b4-4b67-9999-1e48de379e54	1	0
69f989f3-e848-4083-8dd7-013ac74d4a11	1	0
956685dd-1a2e-411f-a6e1-bdad3fb73896	1	0
38bc65b5-56a1-4bff-9ae7-b4b842891b62	1	0
ce76ed35-9cfe-4d56-b841-bc9faeaee146	1	0
2c317644-5539-4ba8-bc27-6d7151007ee9	1	0
1375b3e7-717b-417c-a20a-7a72a4f15982	1	0
39ac923f-bfcd-4f71-b969-261d3f1a0593	1	0
e4ee354c-5f5c-45ea-8431-8ef8f003560f	1	0
514eb4f7-56fd-4cbb-8c81-3ee13438eb13	1	0
28c22366-7950-4c53-8b25-baf908e71265	1	0
c93c4600-d7bf-4590-886f-757f38e615e4	1	0
6dd12e2c-8e01-4999-ad7e-45a1bca4cbad	1	0
e7ea765d-97d7-4634-b47b-cac473ab16f1	1	0
3f32b16d-b478-4618-8b65-dcb6609da984	1	0
05c5c140-fef3-4c12-b634-a1811b4d2d50	1	0
fc1a8706-9e83-4752-b54e-d8effedaea30	1	0
55d70e88-30fc-4180-b911-c8260ca7a4b3	1	0
6e4b9778-1bf3-4002-b261-fbf42a3cd5a5	1	0
e375d010-fd7d-49f0-9ca5-abfdb66f3b63	1	0
e18046eb-d216-491c-bd6b-6a74407f3a23	1	0
c2e11444-fe54-4c3a-bd8c-92233254f353	1	0
c84cb905-2f59-4f59-a84e-d236e795236c	1	0
e5183cc3-7824-4305-a32f-354352d5454f	1	0
293085ac-402d-429e-9ca8-870fec95dea1	1	0
a37fdd19-4089-40b7-9e43-16846e79a599	1	0
48864aed-d824-4ef7-9795-df0ac6bc1fff	1	0
5f23cb83-ef3c-44bf-8af2-7b321416b0fa	1	0
613f5862-3ed2-4f20-ade9-c440ccedd7ad	1	0
325eb394-b130-4c74-9bc1-5aae21082b7c	1	0
07a48ef6-57f3-4775-bb23-62b229838a2f	1	0
5434056d-1a08-45c5-bc3b-9e45c7077530	1	0
9057d4ee-f655-4b55-b0a6-5f8118e68d6b	1	0
e7492691-6072-4feb-9b51-6d566bc6042e	1	0
20f9d46f-9496-4a37-a5a0-aef1d3e18555	1	0
07178582-ebdb-4bc3-b38b-c06f95ee65e2	3	0
13fcc93d-07d6-4c38-bd0c-e6cc60f49ea1	3	0
6ad7be9b-3426-4d81-aac1-cc60be45b191	3	0
2ba4a1d9-91cd-47b2-8b54-2b66ea9973eb	3	0
2cb21705-9af5-4a42-a167-9cf5d4b7e452	3	0
1996c917-a8e4-4e99-b054-639c4d9b38d2	3	0
4af62927-ccf6-4300-85df-1c1fc2f9f45a	4	0
387daf71-7103-49c5-bd88-4beb24a5bc44	4	0
1ed8ae2a-ad38-4c8f-9928-4e1b952c1a0a	4	0
c6fac623-e13f-437f-b2cf-e865297a6e3a	4	0
404d183c-af0b-4fb9-a32c-4ceaf24ecde5	4	0
612dbd3b-6fe9-4b93-9d2f-86d695763fbd	4	0
42e972b0-9a7b-4aec-93b4-c663bc40bfca	4	0
041c8239-2716-40f5-a246-4e86b9cff44c	4	0
7b4711b1-75f6-43d9-8183-9aec39fd2dee	4	1
4eddd612-e921-49aa-b4ce-c1540976cc8d	4	0
c3e24b9c-2bd1-4fc4-a55e-f48be04058e6	4	0
79a29291-7ef4-4c12-86fe-531df77276bf	4	1
a52482cb-ff4e-4483-a854-456704e1b862	4	0
afaaa296-f644-4195-91d7-0a17154cd45d	4	0
803d0ce7-88b6-42f4-8e06-ffcc85aaca11	5	0
fe3f8acd-3ee3-45b3-a732-dc60eb0d0d2e	5	0
ea3b2fb9-f85f-4954-b408-e1b410cb2a87	5	0
145f178a-0cfa-4239-8920-8377de6718df	5	0
57033a94-22e4-456e-8861-e21e0f63ce1f	5	0
7a261012-2ffb-4e4e-aaa5-a8e219f24218	5	0
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	5	0
18e2ecc7-01d9-49bd-8ef3-1f3e8a204d54	5	0
371225f8-e022-4688-8db6-2e197b108037	5	0
0322d9de-7862-439b-a78f-328a988c460f	5	0
78cf0901-6155-42b8-a23e-27d20ba307f7	5	0
1abba21b-63e6-4c4a-9910-70a51fa94299	5	0
d3d631ec-ee1f-402f-aab6-13401de6258a	5	0
3ab7bcf9-2e51-422c-b1f6-7a655a3090da	5	0
8af202d1-87c0-4f5b-9036-82b3d7f6adea	5	0
77f4b86f-86c0-4aa9-98cd-db5f53faef75	5	0
7fdaf5c0-4fa4-4a8f-9576-3ae2967c3909	5	0
1791d892-b194-4555-bcaa-e03ddd81ef8c	5	0
4bbd5a69-9f33-4d72-80a6-09a6c0eac31c	6	0
498d787d-69eb-46a8-ae00-28f51af29545	6	0
21f197bc-6e06-4efb-9879-21754d095abf	6	0
e6c315bd-69d8-47a0-8d71-b4ab47fc0b67	6	0
ab749864-d037-418c-8dfc-435580556cce	6	0
654c1872-b5d2-40ad-bb14-4ecee6f6217c	6	0
dfe56a6e-7106-47bb-bf4c-100185c40cf9	6	0
3326f43c-e43c-42ab-934a-641dd88dc5b3	6	0
41091523-3253-4fd7-b83a-db5886b0ad05	6	0
2c39bbe5-240b-4d40-9f62-492eb46ae14b	6	0
6d6c8348-ca27-46de-b42f-19df46c6e775	7	0
2351ce25-b4aa-43a6-9da7-dc63a17d5588	7	1
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	7	1
10788374-99fb-4ffb-8bfb-3a7813f8abfc	7	0
ddb42d92-addd-465f-b8fa-d8798305b1e0	7	0
fa757d8e-dd8a-4f61-b6ab-9cb2cbbd13f1	7	0
261e142e-d769-4018-b13d-ac2dd81678a5	7	0
f4d81610-e298-44d7-9073-07a2f8e1dd07	7	0
c264cc12-7a44-4236-8e7b-29dcffe765c0	7	0
e253ac7f-8474-46b6-bcfa-76ba8e30044c	7	0
5ebe4eaf-9346-4ed8-8604-3aa57aec8c58	7	0
54a33a25-c745-479f-b1c3-ba627aa637c9	7	0
f5a3ad08-8158-4e3f-836c-e43ecec65a27	8	0
a61e8b16-4566-495d-904e-5791f67c4378	8	0
2c93e8f5-c147-4522-bee5-7cfabdf6a517	8	0
e73b53ac-c63d-460c-9523-609cb86efe05	8	0
e4309837-bb68-462c-9be0-378293dc4019	8	0
dbcb06fe-e449-40f7-9532-58c4d8c301a3	8	0
2e4e3059-f525-43c3-80f7-e344bc29b1a2	8	0
6526b818-0470-4ff7-b26e-f90478900bcb	8	0
1b219451-7b80-40d0-9db1-e2414ae55681	9	0
bed27e34-f3c5-4254-aec1-05363d92e873	9	0
1d4c950f-1612-428d-a537-e61b4a668b74	9	0
7b203557-e87c-48cf-8160-619fc2f803a9	9	0
4043ee9d-a16b-457b-9c5f-e81bbcb1afdd	9	0
b38e2a7f-582e-4c3f-88aa-a4bbe64925c4	9	0
6a65040a-25f1-44b9-a595-6d74425aecc4	9	0
00dc4458-9419-47a7-a5b2-0b2a3b47105c	9	0
7b4711b1-75f6-43d9-8183-9aec39fd2dee	9	0
980a5d45-bd32-423b-83eb-50a2b4b51c54	9	0
8feb4cb2-4aad-4907-9ab0-b6aed6da3df7	9	0
144e2195-0a48-429e-a4cd-79fee80d39c0	9	0
fed3236b-5cbd-4135-b605-e69babb06c9a	9	0
5d89ad3f-6494-4554-9d43-a6f34a92fa21	10	0
78412d7d-b371-4b92-818d-62b43cbe9bd8	10	0
4e59a1ae-d67c-413a-bcff-9ddaff5ec92f	10	0
45111102-9fc7-4b15-a862-760d8e7f2470	10	0
31469c99-8f49-421d-8373-1a341d8b5963	10	0
2351ce25-b4aa-43a6-9da7-dc63a17d5588	10	0
c9d1b478-dc12-4ebb-a043-5fff729219e0	10	0
721e35d7-7367-4681-91ba-3f58fc6dd79c	10	0
2df81113-36e6-4328-8e52-c6f36a711690	10	0
2b406ca5-792c-45ed-b4c9-9f825fe0aeb9	10	0
8ef2955f-79ff-423c-a3da-208f222da23e	10	0
24b8efef-8341-4dac-babd-0f7fa2aeabdc	11	0
a00e81c5-2648-44c3-b75e-f0c4e7b9f5c8	11	0
03fcd378-880c-4476-8d8c-410f7f939db9	11	0
8565d76f-c016-47ae-bded-91436403bccc	11	0
e231b9cf-29ee-4eea-8f10-c5177d500b16	11	0
6b1bc498-8c49-4068-9560-6e5a035893d5	11	0
0a000ef5-f710-4608-b489-95a32d6f1578	11	0
34d0d6de-e29b-495b-b263-d21bea4770e4	11	0
7c422c16-f5b4-41d0-a7b3-3d1fc078f3dc	11	0
ce7548a6-df5e-42ec-b319-3806d7282e89	11	0
27e7a6c8-a609-454b-929d-3cc1e1f88066	12	0
1e7cbfe5-db38-48bc-9800-915a46827151	12	0
caa9ded0-f931-4aeb-b70f-753d2eda05e8	12	0
79a29291-7ef4-4c12-86fe-531df77276bf	12	0
9baad0db-bf94-41c8-9cca-277e4bfcf9f6	13	0
d7196ad6-855d-42ab-8231-d3db25147019	13	0
83365f02-180f-41b2-9b84-64caa69599fa	13	0
fda4ffce-abca-40d8-96bd-b5cca68d2341	13	0
8a87022f-31b1-4504-b089-dc78b81e0d27	13	0
aebf0e13-48cd-4ec4-8635-0ef01c9778ce	13	0
b0b19564-212b-4549-912d-262634e249d4	13	0
9b832008-8b58-4016-b716-f08e6da13959	13	0
3818befa-bd67-48a3-bb6c-ea5a8001f76f	13	0
e0dbd68f-aff5-44de-8ff4-651335f1699e	13	0
6594335b-3a50-487f-8899-361e86c6e1f7	13	0
b77bed1c-168c-4b07-b731-88002527e3c5	13	0
393b0f55-08ce-4d63-b3b5-fd39156ce464	13	0
2afbcd91-311d-4d7f-b100-57ebb1684950	13	0
70f77e1a-9787-4f39-a82c-9a8c36ee9253	13	0
391fe4d0-e459-45cb-9d7e-56472fa751a0	13	0
a28bc089-0eb5-4d76-bd29-12a4992c7c71	13	0
2d58e261-8012-434b-a6d5-f700ba9fb79b	13	0
3cc129a8-7ec5-46bb-b045-5bf23a43e3cf	13	0
a26be7ef-360f-4975-b63a-01a6644724f8	13	0
e23d656f-8c3e-4366-bbaf-190025163170	13	0
d0d381a3-011d-4d50-9eee-6d25cac79f33	13	0
76726aa3-83cd-4406-a13f-ebca190b4ed0	13	0
9795572c-0c9f-4f49-b7a0-d0e3f8e78d61	13	0
e85b69d6-3fa2-418d-a801-661a9988febb	13	0
5d96c2cc-4617-4b49-8068-3f2e9e13b461	13	0
cb97e6c5-3944-4fda-9b24-d594e1849f14	13	0
979d4728-f5ea-46dc-9471-ac3f09498a8a	13	0
264823e9-dfda-4a88-b0c4-90f695ac85ec	13	0
629be99e-7eaa-4abe-a141-95412f8b5cf1	13	0
6e702e79-7fd0-48b5-ba12-20e664220179	13	0
c0618a4a-4e73-4c62-ae71-428188e3d152	13	0
6d2a8e10-fe4c-448c-917a-c5a3daa4f0fe	13	0
ab58f521-3580-463c-a423-12b1783bb590	13	0
697736ac-1a9a-4a0a-8d79-b408a0fcafbe	13	0
41cf3794-1642-47d7-b466-28602faaa24c	13	0
dd6e9c86-f0d6-4976-a69e-32bf6d4653b5	13	0
2240bfcf-6b5b-4cfe-9bc7-a8d519f9f5a8	13	0
dff5dbdf-7bae-403d-b91a-140e9b1437f7	13	0
4eddd612-e921-49aa-b4ce-c1540976cc8d	14	1
4af62927-ccf6-4300-85df-1c1fc2f9f45a	16	1
c6fac623-e13f-437f-b2cf-e865297a6e3a	16	1
a52482cb-ff4e-4483-a854-456704e1b862	16	1
404d183c-af0b-4fb9-a32c-4ceaf24ecde5	17	1
4eddd612-e921-49aa-b4ce-c1540976cc8d	18	2
afaaa296-f644-4195-91d7-0a17154cd45d	22	1
612dbd3b-6fe9-4b93-9d2f-86d695763fbd	23	1
42e972b0-9a7b-4aec-93b4-c663bc40bfca	23	1
041c8239-2716-40f5-a246-4e86b9cff44c	23	1
7b4711b1-75f6-43d9-8183-9aec39fd2dee	23	2
387daf71-7103-49c5-bd88-4beb24a5bc44	24	1
1ed8ae2a-ad38-4c8f-9928-4e1b952c1a0a	24	1
c3e24b9c-2bd1-4fc4-a55e-f48be04058e6	24	1
79a29291-7ef4-4c12-86fe-531df77276bf	24	2
a96dffcb-fa2c-4ee3-a19e-e4ea9afc0023	1	0
125cd9fb-c7c6-4a4b-806b-3ca5bc9ec218	6	0
7d5602d0-c33d-4137-93cc-7f001453fabd	10	0
\.
INSERT INTO may_qa_glosario_sch_core.tbl_termino_etiquetas (termino_id, etiqueta_id, orden) SELECT termino_id, etiqueta_id, orden FROM _stg_tbl_termino_etiquetas ON CONFLICT DO NOTHING;
-- public.termino_maestros → may_qa_glosario_sch_core.tbl_termino_maestros (86 filas)
CREATE TEMP TABLE _stg_tbl_termino_maestros (LIKE may_qa_glosario_sch_core.tbl_termino_maestros) ON COMMIT DROP;
COPY _stg_tbl_termino_maestros (termino_id, maestro_id, orden) FROM stdin;
d69a3e74-99b4-4b67-9999-1e48de379e54	1	0
b77bed1c-168c-4b07-b731-88002527e3c5	1	0
393b0f55-08ce-4d63-b3b5-fd39156ce464	1	0
2afbcd91-311d-4d7f-b100-57ebb1684950	1	0
e23d656f-8c3e-4366-bbaf-190025163170	1	0
e85b69d6-3fa2-418d-a801-661a9988febb	1	0
5d96c2cc-4617-4b49-8068-3f2e9e13b461	1	0
5bdaa8dd-d10a-446f-b999-7b1975bf19e1	1	0
10788374-99fb-4ffb-8bfb-3a7813f8abfc	1	0
629be99e-7eaa-4abe-a141-95412f8b5cf1	1	0
6e702e79-7fd0-48b5-ba12-20e664220179	1	0
3ab7bcf9-2e51-422c-b1f6-7a655a3090da	1	0
77f4b86f-86c0-4aa9-98cd-db5f53faef75	1	0
41cf3794-1642-47d7-b466-28602faaa24c	1	0
a38a51f1-05a2-49ae-9b5e-1c237025bdc3	1	0
6098d463-ba39-40f5-aacb-5c9801bed788	1	0
1cd929b3-9d98-4feb-93fc-3c48ba0e1064	1	0
e09bc304-5146-49ae-b1ea-0952da8a029e	1	0
18ee3b43-b6dc-46ee-a491-070865869011	1	0
f75b11fd-6312-49cc-a239-bead1e8d4b2c	1	0
fde6f994-cfe0-4443-8075-e213405cefe2	1	0
71289ec9-3d91-4db9-ac8d-4b9a5bd0d265	1	0
199b6151-3a75-43c8-947a-de02a29f4159	1	0
e7ac4ff5-2eff-45df-b1bb-a5bb3a794dcd	1	0
25301206-6cc3-4a60-9330-6b05c6533ef8	1	0
43688de0-472a-47c5-90dc-000bb921d946	1	0
db284fd6-6424-4de5-99fc-55244c2934b4	1	0
f92e62a8-424e-427c-b4af-8ca7758ef77c	1	0
c65ca2b2-3c9d-49c4-84b8-bba8241e8e1e	1	0
d80d31b8-635a-4246-b54f-14ad8a6f6e37	1	0
f3810e3c-2e25-46a8-a41c-97d9aea69664	1	0
d2151e84-fed4-45c6-a448-81bd73d0b9ee	1	0
8914816b-4626-4599-877f-98ca1af1f052	1	0
7bfbc5cf-4bbd-4bc9-b39a-1236ac629940	1	0
8b0d67eb-c048-4412-be6c-87b3f57a0e89	1	0
bb8f6d12-4f68-4335-a7dd-c111f4baad28	1	0
cc88857b-05ee-4333-8514-838320775f60	1	0
a0a8426e-68d0-4ea8-aa47-f4a4dfcbb616	1	0
35e93f64-8590-4225-bed0-0fd6d7e972af	1	0
133e4395-58f4-47b5-9ce9-cd6f06c076b2	1	0
7dde307a-6882-47d7-8f30-c27f0d1817a9	1	0
52b95173-f65c-4f6a-98c0-c3e473e46798	1	0
672bb14a-6d84-48da-bb59-1f4a1f582315	1	0
ea677fc7-f5f7-4737-a4ea-611b8915d33a	1	0
978bbf94-9f13-42c2-b58c-ecaba813d23f	1	0
d1e3820e-5f2f-41ae-88c5-47d0dc70c04a	1	0
9cb95e2f-92a6-412d-8cfb-9ef066b35505	1	0
54dd51b5-de9c-47a7-ac8f-db288aa0d235	1	0
f4bddfde-e390-4564-b6ce-4e5f02076e0f	1	0
5353a285-0b21-4559-a7e8-e9ecc5d3ca6d	1	0
560ba3fb-0a79-4ae8-b895-0b93684a02dd	1	0
f5a3ad08-8158-4e3f-836c-e43ecec65a27	2	0
e429df0b-36de-4035-bdb3-68fc6d7fe913	2	0
cdaa1bd5-d57e-4d79-8779-023885aeaf37	2	0
b84da35a-cb32-4872-bfa4-42f9ec4a2c10	2	0
176e36a4-47b6-4707-9632-46b7039999eb	2	0
fde6f994-cfe0-4443-8075-e213405cefe2	2	1
c0abdd24-bed8-41a3-b9f3-e96380134084	2	0
835e7ca0-d43c-4f37-b34a-357c6e52e848	2	0
2b6079e7-9678-4cce-a2b3-38c8ebdab75e	2	0
db284fd6-6424-4de5-99fc-55244c2934b4	2	1
c3fdbfd2-cbcc-4a4f-8a65-88e2a5068b5d	2	0
162fe414-c107-43ab-885b-84ca3e97dc49	2	0
aaafac17-d36f-43a6-b714-761900be9270	2	0
8d3e85b7-3149-4c8b-8f0c-669420e6bff8	2	0
ab24f441-88fa-41c4-bd75-329d26c1d2fc	2	0
5e111960-30c1-4a79-9448-aade3eac7166	2	0
2da438cf-e4ff-42ab-9d96-330753c41554	2	0
54c95665-119b-4a6d-a401-7a7f3d1abc29	2	0
719cfe41-ac48-44da-a550-56f665c0c231	2	0
bd94cf74-4ba3-41d9-bcbf-cc51580fd3f6	2	0
c3f3471e-c75d-4565-9727-6ee9da50914b	2	0
d5157c64-ba43-4814-8c6b-8a2944308847	3	0
e36e4409-2f84-4cd7-be22-0488fa92b308	3	0
aebf0e13-48cd-4ec4-8635-0ef01c9778ce	4	0
2b45e1ea-32c8-4d27-aeac-47c707210c51	4	0
91fbfea8-a0c8-4b02-b665-3b9e2b97c548	4	0
e8bc8672-faea-4f4c-b003-82e9db5f9b02	4	0
cb7cca2b-6e5b-4a35-9497-ce87658167cb	4	0
4f916722-8b46-415f-91d5-4d8059827ef2	4	0
68c167e2-d50e-4e74-8b5f-fcf9e519eb41	4	0
59a49b15-f234-491f-8349-493ae498b8fc	4	0
ab1115fd-0473-4a60-81f5-21fc7bdee866	4	0
f3e0961e-aadd-4be1-882b-34341aca2e61	4	0
16fb12bd-227c-4bd9-847f-6468b69c2452	4	0
55f7d2ad-b94f-4da6-9daf-917100539ed6	4	0
\.
INSERT INTO may_qa_glosario_sch_core.tbl_termino_maestros (termino_id, maestro_id, orden) SELECT termino_id, maestro_id, orden FROM _stg_tbl_termino_maestros ON CONFLICT DO NOTHING;
-- public.sugerencia_opciones → may_qa_glosario_sch_core.tbl_sugerencia_opciones (257 filas)
CREATE TEMP TABLE _stg_tbl_sugerencia_opciones (LIKE may_qa_glosario_sch_core.tbl_sugerencia_opciones) ON COMMIT DROP;
COPY _stg_tbl_sugerencia_opciones (sugerencia_id, orden, columna, etiqueta, tabla, modulo, descripcion, n_tablas, otras_tablas, observacion) FROM stdin;
s000	0	CATEGORIA_PROVEED	Categoría Proveedor	CATEGORIA_PROVEED	AS	Nombre de la Categoría Proveedor	2	{GLOBALES_PY}	
s001	0	CONSECUTIVO	Consecutivo	CONSECUTIVO	AS	Se define por el usuario para llevar un sistema de numeración consecutivo	112	{FACTURA,ADMIN_COTIZANTE,ALARMA_BASE_COLUMNA,ALARMA_COLUMNA,ALARMA_PLANT_COL}	La columna aparece en 112 tablas: es un campo genérico.
s001	1	Consecutivo		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s001	2	ASIENTO_RECU_LINEA	Consecutivo	ASIENTO_RECU_LINEA	CG	Número que se le asigna a cada una de las línas del asiento recurrente.	1	{}	
s001	3	VALE	Consecutivo	DESG_IMPUESTO_CH	CH	Consecutivo del vale al que se crea el desglose de impuestos.	3	{DET_RETENCION_CH,DOCS_SOPORTE}	No está en una tabla maestra.
s002	0	CONTRIBUCION_VAC	Contribución Vacacional	CONTRIBUCION_VAC	CV	Código de la contribución vacacional	4	{CALC_VAC_DETALLE,CONTRIB_VAC_CONDIC,CONTRIB_VAC_FORM}	
s002	1	CONTRIBUCION_VACAC	Contribución Vacacional	REGIMEN_VAC_CONTRI	CV	Código de la contribución vacacional	1	{}	No está en una tabla maestra.
s003	0	COSTO_COMPARATIVO	Costo Comparativo	ARTICULO	CI	Tipo de costo comparativo empleado por el artículo	3	{GLOBALES_CI,SP_ARTICULO}	
s004	0	COSTO_FISCAL	Costo Fiscal	ARTICULO	CI	Tipo de costo físcal empleado por el artículo	4	{ARTICULO_SINCRO,GLOBALES_CI,SP_ARTICULO}	
s005	0	CALCULO_VACACIONAL		CALCULO_VACACIONAL	CV	Código del cálculo vacacional.	2	{CALC_VAC_DETALLE}	
s006	0	DEPARTAMENTO	Departamento	DEPARTAMENTO	AS	Nombre del departamento	23	{EMPLEADO,NIT,ORDEN_COMPRA,ADMINISTRADORA,CALCULO_VACACIONAL}	La columna aparece en 23 tablas: es un campo genérico.
s006	1	U_DEPTOIGSS	Departamento	U_SUCURSALES	''	Indica el departamento de la sucursal	1	{}	No está en una tabla maestra.
s007	0	DEVOLUCION		DEVOLUCION	CO	Código de la devolución de compra	4	{DEVOL_LIN_EMBARQUE,FACTURA_CANCELA,RUTA_CONSECUT_RT}	
s008	0	EMPLEADO	Empleado	EMPLEADO	CN,RH,GN	Código del empleado a ingresar.	61	{VENDEDOR,COBRADOR,ADICIONALEMPLEADO,ADMIN_COTIZANTE,ASIENTO_NOM_TMP}	La columna aparece en 61 tablas: es un campo genérico.
s009	0	FACTURA	Factura	FACTURA	FA	Código del documento a generar	21	{AUXILIAR_ANTICIPO_FAC,BLOQUEO_IMPRESO,DETALLE_FACTURA_RETENCION,FACTURA_ADUANA,FACTURA_ADUANA_CMP}	La columna aparece en 21 tablas: es un campo genérico.
s010	0	GRUPO	Grupo	GRUPO	PO	Indica el código del grupo de caja	10	{CAJERO,CIERRE_TIENDA,DET_MOV_APLICADO,DET_MOV_NOAPLICADO,GRUPO_CAJA}	
s011	0	INDICADOR		INDICADOR	PR	Código del indicador que se va a crear.	5	{INDICADOR_CR,INDICADOR_VALOR,INDICADOR_VALOR_CR,PRESUPUEST_PARTIDA}	
s012	0	LIQUIDACION		LIQUIDACION	RH	Código de Liquidación de empleados.	17	{CALC_LIQ_TEMPORAL,EMPLEADO_ACC_SALDO,EMPLEADO_NOMI_NETO,EMPLEADO_SALDO_VAC,LIQUIDACION_APORTE}	La columna aparece en 17 tablas: es un campo genérico.
s012	1	NUMERO_LIQUIDAC	Liquidación	HIST_CREDITO_EMP	CN	Número de liquidación de descuentos al cual se cargó el descuento	1	{}	No está en una tabla maestra.
s012	2	LIQUIDAC_COMPRA	Liquidación	LIQUIDAC_COMPRA	CO	Código de la liquidación de compra generada	5	{DOCUMENTOS_CP,LIQUIDAC_DETALLE,LIQUIDAC_GASTO,LIQUIDAC_MENSAJE}	
s013	0	LOCALIZACION	Localización	LOCALIZACION	AS	Código que se asignará a la localización	34	{ARTICULO_EXISTENCIA_LOTE,ARTICULO_RT,BODEGA_ASOC_RT,BOLETA_INV_FISICO,DESGLOSE_ART_TMP}	La columna aparece en 34 tablas: es un campo genérico.
s013	1	Localizacion		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s014	0	LIMITE_CREDITO	Límite Crédito	CLIENTE	CC,FA,GN	Se indica el límite de crédito para el cliente.	3	{DES_BON_CLIENTE,GLOBALES_FA}	
s014	1	LIM_CREDITO	Límite de crédito	PEDIDO_AUTORIZA	FA	Indica si el documento incumple con la condición de límite de crédito	1	{}	No está en una tabla maestra.
s015	0	META		META	BI	Indica el número de meta	2	{META_DETALLE}	
s016	0	PORC_DESCUENTO	Porcentaje Descuento	ORDEN_COMPRA	CO	Porcentaje de descuento general de la orden de compra	4	{DCTO_ART_X_CLI,DOCUMENTO_EMBARQUE,ORDEN_COMPRA_LINEA}	
s016	1	PORC_DCTO	Porcentaje Descuento	ESCALA_DCTO	FA	Porcentaje de descuento	1	{}	No está en una tabla maestra.
s017	0	REGIMEN_VACACIONAL	Regimen Vacacional	REGIMEN_VACACIONAL	CV	Código del Régimen vacacional	6	{CALCULO_VACACIONAL,EMPLEADO_ACC_PER,EMPLEADO_SALDO_VAC,EMPLEADO_VACACION,REGIMEN_VAC_CONTRI}	
s018	0	SALARIO_DIARIO_INT	Salario Diario Integrado	EMPLEADO	CN,RH,GN	Salario diario integrado para el empleado.	2	{EMPLEADO_ACC_PER}	
s019	0	VARIABLE_DECISION	Variable de decisión	CONCEPTO	CN	Almacena la variable de decisión del concepto.	2	{EMPLEADOS_X_RANGO}	
s019	1	CONCEPTO_USA	Variable de Decisión	CONC_FORM_CONCEPTO	CN	Código del concepto.	1	{}	No está en una tabla maestra.
s020	0	ACTIVO	Activo	ARTICULO	CI	Estado del artículo	43	{CLIENTE,PROVEEDOR,EMPLEADO,VENDEDOR,COBRADOR}	La columna aparece en 43 tablas: es un campo genérico.
s020	1	ESTA_ACTIVO	ACTIVO	EQUIPO	AM	Indica si el artículo esta activo o no	1	{}	No está en una tabla maestra.
s021	0	ARTICULO	Artículo	ARTICULO	CI	Código del artículo	161	{ALIAS_PRODUCCION,ARTICULO_ALTERNO,ARTICULO_ALTERNO_SINCRO,ARTICULO_COMPRA,ARTICULO_ESPE}	La columna aparece en 161 tablas: es un campo genérico.
s021	1	Articulo		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s021	2	ARTICULOS		REGLAS_PRECARGADAS_BONIF	FR		2	{REGLAS_PRECARGADAS_DESC}	No está en una tabla maestra.
s021	3	ART_GARANTIA	Artículo	GARANTIAS_DOC_CC	CC	Artículo que se va a utilizar para la garantía; solo se puede seleccionar uno de los artículos definidos en el módulo de Facturación.	1	{}	No está en una tabla maestra.
s022	0	ARTICULO	Artículo	ARTICULO	CI	Código del artículo	161	{ALIAS_PRODUCCION,ARTICULO_ALTERNO,ARTICULO_ALTERNO_SINCRO,ARTICULO_COMPRA,ARTICULO_ESPE}	La columna aparece en 161 tablas: es un campo genérico.
s022	1	Articulo		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s022	2	ARTICULOS		REGLAS_PRECARGADAS_BONIF	FR		2	{REGLAS_PRECARGADAS_DESC}	No está en una tabla maestra.
s022	3	ART_GARANTIA	Artículo	GARANTIAS_DOC_CC	CC	Artículo que se va a utilizar para la garantía; solo se puede seleccionar uno de los artículos definidos en el módulo de Facturación.	1	{}	No está en una tabla maestra.
s023	0	ARTICULO	Artículo	ARTICULO	CI	Código del artículo	161	{ALIAS_PRODUCCION,ARTICULO_ALTERNO,ARTICULO_ALTERNO_SINCRO,ARTICULO_COMPRA,ARTICULO_ESPE}	La columna aparece en 161 tablas: es un campo genérico.
s023	1	Articulo		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s023	2	ARTICULOS		REGLAS_PRECARGADAS_BONIF	FR		2	{REGLAS_PRECARGADAS_DESC}	No está en una tabla maestra.
s023	3	ART_GARANTIA	Artículo	GARANTIAS_DOC_CC	CC	Artículo que se va a utilizar para la garantía; solo se puede seleccionar uno de los artículos definidos en el módulo de Facturación.	1	{}	No está en una tabla maestra.
s024	0	ASIENTO	Asiento	EMBARQUE	CO	Código del asiento de recibo de mercadería generado	61	{ASIENTOS_DOC_POS,ASIENTO_DE_DIARIO,ASIENTO_FASE_PY,ASIENTO_MARCADO,ASIENTO_MAYORIZADO}	La columna aparece en 61 tablas: es un campo genérico.
s025	0	BODEGA	Bodega	BODEGA	AS	Identificación de las bodegas contenidas en la base de datos	65	{PEDIDO,ORDEN_COMPRA,ARTICULO_COMPRA,ARTICULO_EXISTENCIA,ARTICULO_EXISTENCIA_LOTE}	La columna aparece en 65 tablas: es un campo genérico.
s025	1	Bodega		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s026	0	CENTRO_COSTO	Centro de Costo	CENTRO_COSTO	AS	Nombre del Centro de Costo a ser Introducido	74	{EMPLEADO,ACTIVO_CENTRO,ASIENTO_DIST_LINEA,ASIENTO_RECU_LINEA,CAJA_CHICA}	La columna aparece en 74 tablas: es un campo genérico.
s026	1	CTR_NOMINA	Centro Costo	NOMINA	CN	Código del Centro de Costo al que se va a asociar la cuenta contable.	1	{}	
s026	2	centro_costo		HIST_DIFCAM_CB	CB	Centro de costo que registra diferencias de cambio.	2	{HIST_DIFCAM_CC}	No está en una tabla maestra.
s027	0	CENTRO_COSTO	Centro de Costo	CENTRO_COSTO	AS	Nombre del Centro de Costo a ser Introducido	74	{EMPLEADO,ACTIVO_CENTRO,ASIENTO_DIST_LINEA,ASIENTO_RECU_LINEA,CAJA_CHICA}	La columna aparece en 74 tablas: es un campo genérico.
s027	1	CTR_NOMINA	Centro Costo	NOMINA	CN	Código del Centro de Costo al que se va a asociar la cuenta contable.	1	{}	
s027	2	centro_costo		HIST_DIFCAM_CB	CB	Centro de costo que registra diferencias de cambio.	2	{HIST_DIFCAM_CC}	No está en una tabla maestra.
s028	0	CLIENTE	Cliente	CLIENTE	CC,FA,GN	Código del cliente que se va a ingresar.	60	{DIRECC_EMBARQUE,FACTURA,PEDIDO,AUTOR_VENTA,BOLETA_DESPACHO_AD}	La columna aparece en 60 tablas: es un campo genérico.
s028	1	GENERA_RECIBO_PAGO	CLIENTE	CLIENTE	CC,FA,GN	Indica si se debe de realizar un recibo de pago para DE	1	{}	
s029	0	COMPANIA	Compañía	COMPANIA	FR		65	{IMPUESTO,AGENTE_ASOC_RT,AGENTE_VISITA_RT,ARCHIVO_APLICADO,ARTICULO_ENSAMBLE}	La columna aparece en 65 tablas: es un campo genérico.
s029	1	COMPANIAS		GLOBALES_RUTEO	FR		1	{}	No está en una tabla maestra.
s029	2	Compania		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s029	3	CONJUNTO	Compañía	USUARIOS_APIGATEWAY	SG	Compañía en la que se desea realizar la restricción	1	{}	No está en una tabla maestra.
s030	0	CONCEPTO	Concepto	CONCEPTO	CN	Código del concepto.	37	{ADMIN_CONCEPTO,ASIENTO_NOM_TMP,CENTRO_CONCEPTO,CHEQUE,CODING_CARTA_RENTA}	La columna aparece en 37 tablas: es un campo genérico.
s030	1	CONCEPTO_VALE	Concepto	VALE	CH	Concepto por el cual se crea el vale.	1	{}	No está en una tabla maestra.
s030	2	REFERENCIA	Concepto	MOV_BANCOS	CB,GN	Referencia que se agrega al documento que se está creando.	1	{}	No está en una tabla maestra.
s031	0	CONTABILIDAD	CONTABILIDAD	ASIENTO_DE_DIARIO	CG	Indica la contabilidad para la cuál se está generando la transacción contable.	18	{ASIENTOS_CHEQUE,ASIENTO_DISTRIBUID,ASIENTO_FASE_PY,ASIENTO_MAYORIZADO,ASIENTO_RECURRENTE}	La columna aparece en 18 tablas: es un campo genérico.
s032	0	CUENTA_BANCO	Cuenta Bancaria	NOMINA	CN	Código o número que identifica la cuenta bancaria que está agregando.	1	{}	
s032	1	CUENTA_BANCARIA	Cuenta Bancaria	CONCEPTO_LIQUIDAC	CN	Código o número que identifica la cuenta bancaria que está agregando.	2	{CREDITO_EMPLEADO}	No está en una tabla maestra.
s032	2	cuenta_bancaria		HIST_DIFCAM_CB	CB	Cuenta bancaria que participa en el proceso de diferencias cambiarias.	1	{}	No está en una tabla maestra.
s032	3	CTA_BANCO	Cuenta Bancaria	MOV_COMPROMISO_PP	PY	Cuenta bancaria del cheque que se genera a partir del movimiento del subcontrato. Solo si se generá cheque este campo es registrado	1	{}	No está en una tabla maestra.
s032	4	CTA_BANCARIA	Cuenta Bancaria	DOCUMENTOS_CC	CC,GN	Código de la cuenta bancaría que se va a ver afectada por el documento de crédito (Depósito o Transferencia); que se crea.	1	{}	No está en una tabla maestra.
s033	0	CUENTA_CONTABLE	Cuenta Contable	CUENTA_CONTABLE	CG,PO	Almacena el código de la cuenta contable que forma parte del catálogo contable	54	{ASIENTO_DIST_LINEA,ASIENTO_NOM_TMP,ASIENTO_RECU_LINEA,CAJA_CHICA,CALC_LIQ_TEMPORAL}	La columna aparece en 54 tablas: es un campo genérico.
s033	1	CTA_NOMINA	Cuenta Contable	NOMINA	CN	Almacena el código de la cuenta contable que que se encuentra asociada con el centro de costo.	1	{}	
s033	2	cuenta_contable		HIST_DIFCAM_CB	CB	Cuenta contable que registra diferencias de cambio.	2	{HIST_DIFCAM_CC}	No está en una tabla maestra.
s034	0	CTA_CXC	Cuenta Cuentas por Cobrar	PAIS	AS	En la cuenta que se relacione con este concepto; se cargarán los montos debido a la emisión de documentos de crédito	2	{CATEGORIA_CLIENTE}	
s035	0	CTA_CXP	Cuenta Cuentas por Pagar	CATEGORIA_PROVEED	AS	Se refiere a la generación de compras a proveedores que no han sido pagados aún; es decir; compras a crédito	1	{}	
s036	0	DOCUMENTO	Código Documento	DOCUMENTO	CV,RH	Código del Documento.	3	{EMPLEADO_DOCUMENTO,SOLICITUD_RH_DOC}	
s036	1	IDENTIFICADOR	Código Documento	DOCUMENTOS_RH	RH	Código del Documento.	1	{}	No está en una tabla maestra.
s037	0	DOCUMENTO	Código Documento	DOCUMENTO	CV,RH	Código del Documento.	84	{ARTICULO_SERIE_POS,ASIENTOS_DOC_POS,ASIENTO_FASE_PY,AUDIT_CUPON,AUXILIAR_POS}	La columna aparece en 84 tablas: es un campo genérico.
s037	1	documento		HIST_DIFCAM_CC	CC	Numero de documento que aplicó en el proceso de diferencias cambiarias.	1	{}	No está en una tabla maestra.
s037	2	DOCUMENTO_CP	Documento	ACTIVO_MEJORA	AF	Factura creada en Cuentas por Pagar asociada a la adquisión del activo.	1	{}	No está en una tabla maestra.
s038	0	EMBARQUE	Embarque	EMBARQUE	CO	Código embarque ingresado	13	{DET_DOCUMENTO_EMBARQUE,DET_LIN_EMBARQUE,DEVOLUCION,DEVOL_LIN_EMBARQUE,EMBARQUE_DOC_CP}	
s039	0	ESTADO	Estado	ORDEN_COMPRA	CO	Estado de la orden de compra	118	{PEDIDO,EMBARQUE,IMPUESTO,ACUERDO_CLIENTE,APERTURA_CAJA}	La columna aparece en 118 tablas: es un campo genérico.
s039	1	Estado		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s039	2	estado		HIST_DIFCAM_CB	CB	Indica el estado en que se encuentra el proceso de diferencias cambiarias.	2	{HIST_DIFCAM_CC}	No está en una tabla maestra.
s039	3	ESTADO_ACTIVO_ANT	Estado	ACTIVO_ACCION	AF	Código del estado vence del activo al cual se va a aplicar la acción; editable para las acciones de Mantenimiento de un activo y Otros.	1	{}	No está en una tabla maestra.
s039	4	ESTADO_SOLICITUD	Estado	CHEQUE	CB	Indica si el cheque se encuentra aprobado o no.	1	{}	No está en una tabla maestra.
s039	5	ESTADO_LIQUIDAC	Estado	LIQUIDAC_COMPRA	CO	Estado de la liquidación	1	{}	No está en una tabla maestra.
s040	0	FECHA	Fecha	FECHA	BI	Indica la fecha en formato año; mes; día; horas	107	{FACTURA,ORDEN_COMPRA,ACTIVO_ACCION,ACTIVO_HIST_MANT,ACTIVO_HIST_REVAL}	La columna aparece en 107 tablas: es un campo genérico.
s040	1	Fecha		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s040	2	FECHA_HORA	Fecha	ACTIVO_HIST_REVAL	AF	Fecha en que se realiza el proceso de revaluación de activos.	1	{}	No está en una tabla maestra.
s040	3	FECHA_HORA_ULT	Fecha	CONSECUTIVO_FA	FA	Fecha y hora de la última modificación	1	{}	No está en una tabla maestra.
s040	4	FECHA_FINAL	Fecha	PRESUPUESTO_CONTAB	PR	Fecha del periódo que se detalla.	2	{PRESUPUEST_DETALLE}	No está en una tabla maestra.
s041	0	FECHA_OFRECIDA	Fecha Ofrecida	ORDEN_COMPRA	CO	Fecha ofrecida de la orden de compra; es decir; fecha en que el proveedor ofrece que lleguen los productos solicitados en la orden de compra	5	{EMBARQUE,ORDEN_CO_RM,SP_EMBARQUE,SP_ORDEN_COMPRA}	
s042	0	FECHA_REQUERIDA	Fecha Requerida	ORDEN_COMPRA	CO	Fecha requerida de la orden de compra	19	{EMBARQUE,ESTRUC_MANUFACTURA,ORDEN,ORDEN_COMPRA_LINEA,ORDEN_CO_LINEA_RM}	La columna aparece en 19 tablas: es un campo genérico.
s043	0	FECHA_REQ_EMBARQUE	Fecha Requerida Embarque	ORDEN_COMPRA	CO	Fecha requerida del embarque al que se va a asociar la orden de compra generada	1	{}	
s044	0	FLUJO_CAJA	Flujo de Caja	FLUJO_CAJA	CF	Codigo del Flujo de Caja	10	{CALCULO_FLUJO_CAJA,CHEQUES_RUBROS_CF,DETALLE_FLUJO_CAJA,DETALLE_FLUJO_CAJA_EJECUTA,FLUJO_CAJA_CUENTA_BANCO}	
s045	0	FORMATO	Formato	FORMATO	EV	Indica el código del formato	23	{CODIGO_RUBRO_ME,CONSECUTIVO_FA,CUENTA_BANCARIA,FORMATOS_ME,FORMATO_COLUMNA}	La columna aparece en 23 tablas: es un campo genérico.
s046	0	HORARIO	Horario	HORARIO	CN,RH	Código del horario.	7	{EMPLEADO,FACTOR_AJU_HORA,GRUPO_TRABAJO_PC,HORARIO_CONCEPTO,MARCA_RELOJ}	
s047	0	INCOTERMS	Incoterms	FACTURA	FA		9	{PEDIDO,DEVOLUCION,DOCS_SOPORTE,DOCUMENTOS_CC,DOCUMENTOS_CP}	
s048	0	TASA_INTERES_MORA	Interés Mora	CLIENTE	CC,FA,GN	Porcentaje de interes por mora del cliente	2	{PROVEEDOR}	
s049	0	INVERSION	Inversión	INVERSION	CF	Codigo de la Inversion	2	{DETALLE_INVERSION}	
s050	0	NOMINA	Nómina	NOMINA	CN	Código de la nómina.	32	{EMPLEADO,AUDIT_AJUSTES_NOMI,BENEFICIOS_ANTIGUE,CALCULO_VACACIONAL,CONCEPTO_USUARIO}	La columna aparece en 32 tablas: es un campo genérico.
s051	0	ORDEN_COMPRA	Orden Compra	ORDEN_COMPRA	CO	Código de orden de compra generado	19	{FACTURA,PEDIDO,ACTIVO_DESMANTELAMIENTO,ACTIVO_MEJORA,DET_DOCUMENTO_ORDEN}	La columna aparece en 19 tablas: es un campo genérico.
s052	0	PEDIDO		PEDIDO	FA	Código del Pedido	31	{FACTURA,ARTICULO_SERIE_POS,AUDITORIA_AD,BOLETA_DESPACHO_AD,DATOS_PM}	La columna aparece en 31 tablas: es un campo genérico.
s052	1	PEDIDOS		VERSION_PM	PM	Si existió algún pedido durante la carga de datos; coloca el módulo fuente	1	{}	No está en una tabla maestra.
s053	0	PRIORIDAD	Prioridad	ORDEN_COMPRA	CO	Prioridad de la orden de compra	16	{ARTICULO_ALTERNO,ARTICULO_ALTERNO_SINCRO,ARTICULO_FOTO,COD_OBSERVA_ISSS,CREDITO_EMPLEADO}	La columna aparece en 16 tablas: es un campo genérico.
s054	0	PUESTO	Puesto	PUESTO	CN,RH	Código del puesto	22	{EMPLEADO,CALCULO_VACACIONAL,CELULA_PUESTO,CONCEPTO_PUESTO,EMPLEADO_ACCIDENTE}	La columna aparece en 22 tablas: es un campo genérico.
s055	0	REPORTE		NOMINA	CN	Indica el código del reporte	12	{FORMATO_REPORTES,ITEMS_HACIENDA,REPORTES_CC,REPORTES_CONTABLES,REPORTES_CP}	
s056	0	SALDO	Saldo	CLIENTE	CC,FA,GN	Saldo en la moneda del cliente	20	{PROVEEDOR,CAJA_CHICA,CODIGO_RUBRO_ME,CUENTA_BANCARIA,CUPON}	La columna aparece en 20 tablas: es un campo genérico.
s057	0	SALDO_BANCOS	Saldo según Bancos	CUENTA_BANCARIA	CB,PO,GN	Saldo que posee la cuenta bancaria considerando los documentos registrados en bancos.	2	{CONCILIACION}	
s058	0	SALDO_NORMAL	Saldo Normal	CUENTA_CONTABLE	CG,PO	Determina el tipo de movimiento que acepta la cuenta; es decir; si su saldo es Acreedor o Deudor.	2	{CG_CERTIFICADO_RET}	
s059	0	SOLICITUD_OC	Solicitud de Compra	SOLICITUD_OC	CO	Código de la solicitud de compra generada	5	{PEDIDO_SUGERIDO,SOLICITUD_OC_IMP,SOLICITUD_OC_LINEA,SOLICITUD_ORDEN_CO}	
s060	0	TIPO_ASIENTO	Tipo de Asiento	TIPO_ASIENTO	CG,PO	Código que identifica el tipo de asiento que generará la transacción contable.	33	{ASIENTOS_CHEQUE,ASIENTOS_DOC_POS,ASIENTO_DE_DIARIO,ASIENTO_DISTRIBUID,ASIENTO_MAYORIZADO}	La columna aparece en 33 tablas: es un campo genérico.
s060	1	TIPO_ASIENTO_CON		GLOBALES_PY	PY	Tipo de asiento. Actualmente no se utiliza	1	{}	No está en una tabla maestra.
s061	0	TIPO_CAMBIO	Tipo Cambio	TIPO_CAMBIO	AS	Nombre del Tipo Cambio	34	{FACTURA,PEDIDO,CUENTA_CONTABLE,ACTIVO_HIST_REVAL,CIERRE_POS}	La columna aparece en 34 tablas: es un campo genérico.
s061	1	TIPO_DE_CAMBIO	Tipo de Cambio	ESTRUC_MANUFACTURA	AP	Tipo de cambio asociado	4	{GLOBALES_AP,OP_OPER_DET,ORDEN_PRODUCCION}	No está en una tabla maestra.
s061	2	TIPO_CAMBIO_DOLAR	Tipo Cambio	LIQUIDAC_COMPRA	CO	Tipo de cambio dólar para la liquidación; este lo define el usuario de forma manual	1	{}	No está en una tabla maestra.
s062	0	TIPO_TRANSACCION	Tipo Transacción	ARTICULO	CI	Columna que almacena el tipo de transacción IVA	6	{FACTURA_LINEA,PEDIDO_LINEA,SUBTIPO_DOC_CC,SUBTIPO_DOC_CP,TRANSACCION_MANT}	
s063	0	UNIDAD_MEDICION	Unidad de Medida	UNIDAD_MEDICION	AM	Código de la Unidad de Medida	3	{FACT_PROC_MEDIC,ORDEN_TRABAJO}	
s063	1	UNIDAD_MEDIDA	Unidad de Medida	CLASIFICACION	CI	Código de Unidad de medida asociada a la clasificación	7	{DETALLE_COMPLEMENTO_SUNAT,FASE_PY,OP_OPER_DET_DESPER,REPORTE_CUENTA20_PERU,UNIDAD_DE_MEDIDA}	No está en una tabla maestra.
s063	2	UNIDAD_DISTRIBUCIO	Unidad de Medida	FACTURA_LINEA	FA	Codigo de la unidad de distribución del artículo	1	{}	No está en una tabla maestra.
s063	3	UNIDAD_MEDIDA_COMP	Unidad de medida	ARTICULO_PROVEEDOR	CO	Unidad de medida en que se realizan las compras al proveedor; esta puede ser igual a la unidad de almacenamiento del artículo	1	{}	No está en una tabla maestra.
s064	0	USUARIO	Usuario	USUARIO	SG	Siglas con las que estará identificado el usuario	124	{FACTURA,PEDIDO,ORDEN_COMPRA,CUENTA_CONTABLE,AA_SERIE_CADENA_SINCRO}	La columna aparece en 124 tablas: es un campo genérico.
s064	1	Usuario		USUARIO_ACTUAL	SG	Indica el usuario actual	1	{}	No está en una tabla maestra.
s064	2	USUARIO_ANULA	Usuario	FACTURA	FA	Código del usuario del sistema que anula el documento	1	{}	
s064	3	USUARIO_AUTO_NO_FAC	Usuario	CONTRATO	AC	Indica el último usuario que realizó la acción de no autorizar el contrato	1	{}	No está en una tabla maestra.
s064	4	USUARIO_AUTORI_FAC	Usuario	CONTRATO	AC	Indica el último usuario que realizó la acción de  autorizar el contrato	1	{}	No está en una tabla maestra.
s064	5	USUARIO_MODIFICA	Usuario	CONTRATO	AC	Indica el último usuario que modificó el contrato	1	{}	No está en una tabla maestra.
s065	0	VACS_ADICIONALES	Vacaciones adicionales	EMPLEADO	CN,RH,GN	Vacaciones Adicionales.	1	{}	
s066	0	VALE	Vale	VALE	CH	Número (Consecutivo) que se coloca al vale que se va a crear.	5	{DESG_IMPUESTO_CH,DET_RETENCION_CH,DOCS_SOPORTE,VALE_MOV_PRES}	
s067	0	VERSION	Versión	CUENTA_CONTABLE	CG,PO	Número de versión asociado a la cuenta contable	58	{ACUERDO_CLIENTE,ALARMA_BASE,ALARMA_PLANTILLA,APLICA_ESQUEMA,ARCHIVO_DETALLE_FR}	La columna aparece en 58 tablas: es un campo genérico.
s067	1	VERSIONES		GLOBALES_AP	AP	Combinación de valores (S) y (N) que determinan la generación de nuevas versiones; ya sea por cambios en Costos; Tiempos; Otros; Recetas; Lotes; Recursos; Fechas. Los valores son definidos de izquierda a derecha de la siguiente forma: NNNNNNNNN 0 1 2 3 4 5 6 7 8 (0 Costo; 1 Receta; 2 Recursos; 3 Entradas; 4 Salidas; 5 Tiempos; 6 Lotes;7 Fechas; 8 Otros). De esta forma si se tiene el valor NSNSSNSSS se tienen marcados los checks de Entradas; Salidas; Recetas; Lotes y Fechas. Note que Entradas y Salidas siempre estan invisibles y siempre se marcan como S	1	{}	No está en una tabla maestra.
s068	0	CAPACIDAD		EQUIPO	AM	Capacidad máxima asociada al equipo	1	{}	No está en una tabla maestra.
s069	0	DESPACHO		DESPACHO	FA	Código del despacho generado	4	{DESPACHO_DETALLE,DESPACHO_DETALLE_SINCRO,DESPACHO_SINCRO}	
s070	0	HandHeld		JORNADA	FR		2	{TRASIEGO}	No está en una tabla maestra.
s070	1	HANDHELD		ARCHIVO_HANDHELD	FR		13	{CONFIG_HH,ERPADMIN.HISTORIAL_DESCUENTOS,GLOBALES_CONF_FR,HANDHELD_RT,HISTORIAL_DESCUENTOS}	No está en una tabla maestra.
s071	0	ACCION_PERSONAL	Número Acción	CALC_VAC_DETALLE	CV	Número consecutivo de acción de personal	1	{}	No está en una tabla maestra.
s072	0	ACTIVIDAD	Actividad Económica SGRL	ACT_ECONO_SGRL	CN	Actividad Económica SGRL	5	{CENTRO_TRABAJO,COTIZANTE,EXCEPCION_D104,PILA_HISTORICO_DET}	No está en una tabla maestra.
s073	0	ADELANTO		COMPROMISO_PP	PY	Adelanto que llevará el subcontrato al momento de crearse.	3	{MOD_COMPROMISO_PP,MOV_COMPROMISO_PP}	No está en una tabla maestra.
s074	0	AGENTE	AGENTE	AGENTE_ASOC_RT	FR		5	{AGENTE_RT,AGENTE_VISITA_RT,METAS_VENTA_COBRO,RUTA_ASIGNADA_RT}	No está en una tabla maestra.
s075	0	APLICACION	Aplicación Tipo Imp	AUDIT_TRANS_INV	CI	Notas de aplicación del documento	13	{AUDIT_TRANS_MANT,COBRO_POS,DEVOLUCION,DOCUMENTOS_CC,DOCUMENTOS_CP}	No está en una tabla maestra.
s076	0	APLICA	Aplicar	DET_MOD_RETENCION	AS	Indica para que tipo de transacción aplica la retención; es decir; compra; venta o ambas.	1	{}	No está en una tabla maestra.
s076	1	APLICAR	Aplicar	TIPO_ACCION_USUARIO	RH	Indica si el usuario tiene privilegios para aplicar acciones de personal de este tipo.	1	{}	No está en una tabla maestra.
s077	0	TIPO_GARANTIA	Artículo garantía	GARANTIAS_DOC_FA	FA	Tipo de Garantía	1	{}	No está en una tabla maestra.
s078	0	ATRIBUTO		ATRIBUTO	AS	Descripción del atributo	6	{ARTICULO_ESPE,ATRIBUTO_VALOR,ATRIB_EQUIPO,EMPLEADO_AUDITORIA,LOTE_ESPE}	
s079	0	BENEFICIARIO		DET_TRANS_CB	CB	Beneficiario que posee la transferencia; editable solo para las transferencias a terceros; sino se coloca el nombre de la compañía destino.	5	{DOCUMENTO_POS,EXT_MOV_APLICADO,EXT_MOV_NOAPLICADO,VALE}	No está en una tabla maestra.
s079	1	PAGADERO_A	Beneficiario	CHEQUE	CB	Beneficiario del cheque.	2	{MOV_BANCOS}	No está en una tabla maestra.
s080	0	CAJA		CAJA	FA	Código de la caja	39	{APERTURA_CAJA,ARTICULO_SERIE_POS,ASIENTOS_DOC_POS,AUDIT_CUPON,AUXILIAR_POS}	La columna aparece en 39 tablas: es un campo genérico.
s081	0	CLASIFICACION_ART	Clasificación Artículo	RETENCIONES	AS	Indica la clasificación por articulo	1	{}	No está en una tabla maestra.
s082	0	CLIENTE_REPORTE	Cliente Reporte	DOCUMENTOS_CC	CC,GN	Código del cliente reporte del documento; es decir; el cliente corporación del cliente origen del documento.	1	{}	No está en una tabla maestra.
s083	0	CLIENTES		REGLAS_PRECARGADAS_BONIF	FR		2	{REGLAS_PRECARGADAS_DESC}	No está en una tabla maestra.
s084	0	CLIENTES_INACTIVOS		GLOBALES_RUTEO	FR	Campo para el parametro de filtrado con clientes inactivos en carga HH	1	{}	No está en una tabla maestra.
s085	0	COBRO	COBRO	COBRO_POS	PO	Indica el consecutivo que se genera por cada cobro	3	{METAS_VENTA_COBRO,PAGO_POS}	No está en una tabla maestra.
s086	0	COLOR		ARTICULO	CI		2	{ARTICULO_COLOR}	
s087	0	COMBINACION		SP_PROBABILIDAD	CO		2	{SP_PROB_DETALLE}	No está en una tabla maestra.
s088	0	CONTRATO		CONTRATO	AC	Código del contrato	12	{FACTURA,PEDIDO,CONTRATO_LINEA,CONTRATO_LIN_DETALLE,DOCUMENTOS_CC}	
s089	0	CONVERSION	Conversión	CUENTA_CONTABLE	CG,PO	Se define el tipo de conversión que tendrá cada cuenta contable; y la forma en que se determinen las diferencias cambiarias; esto en cuanto a moneda se refiere.	2	{PARTIDA}	
s090	0	COSTO		ASOC_HERRAM	AM	Costo asociado a la herramienta en cuestion	6	{COSTO_COMPONENTE,FASE_PRESUP_PY,FORMATO_COLUMNA,FORMATO_PLANIFICACION,ME_PREVIA_MEDIO_PERU}	No está en una tabla maestra.
s091	0	CREDITO	Crédito	ASIENTOS_CHEQUE	CB	Monto en crédito que aplica para la línea que se ingresa.	11	{ASIENTO_FASE_PY,ASIENTO_RECU_LINEA,AUXILIAR_CC,AUXILIAR_CP,AUXILIAR_PARC_CC}	No está en una tabla maestra.
s092	0	CUENTA_GASTO	Cuenta Gasto	CENTRO_CUENTA	CG,PO,GN	Almacena el código de la cuenta contable donde se va registrar la copia del transacción contable; se registran los movimientos de ingresos.	1	{}	No está en una tabla maestra.
s093	0	CODIGO_BARRAS	Código barras	ACTIVO_DESMANTELAMIENTO	AF		7	{ACTIVO_MEJORA,ARTICULO_COLOR,ARTICULO_ESTILO,ARTICULO_TALLA,ART_UND_DISTRIBUCI}	No está en una tabla maestra.
s094	0	U_CODIGO		U_ACTIV_ECONOMICA	AS		3	{U_COD_AGRUPADOR,U_TIPO_DOCUMENTO}	No está en una tabla maestra.
s094	1	CODIGO	Código	ACTIVIDAD_COMERCIAL	AS	Código único de la activida comercial	70	{AEROPUERTOS_SUNAT,AGENTE_ASOC_RT,AUDITORIA_USUARIOS,AUTENTICACION,AUTENTICA_CATALOGO}	La columna aparece en 70 tablas: es un campo genérico. No está en una tabla maestra.
s094	2	COD_TIPO_ACTIVO	Código	ACTIVO_MEJORA	AF	Indica el código de activo de la tabla tipo activo fijo perú	1	{}	No está en una tabla maestra.
s094	3	MODELO_RETENCION	Código	MODELO_RETENCION	AS	Código del modelo de retención que se va a crear.	1	{}	
s094	4	FIADOR_ID	Código	FIADORES_DOC_CC	CC	Código que identifica al fiador del documento; puede ser uno cliente existente o puede agregar un fiador distinto.	1	{}	No está en una tabla maestra.
s094	5	GARANTIA_ID	Código	GARANTIAS_DOC_CC	CC	Código que identifica la garantía que se está aplicando al documento.	1	{}	No está en una tabla maestra.
s095	0	DATOS		INCONSISTENCIA_SINC_POS	PO	Indica los dattos que se obtienen de la inconsistencia	1	{}	No está en una tabla maestra.
s096	0	DEBITO	Débito	ASIENTOS_CHEQUE	CB	Monto en débito que aplica para la línea que se ingresa.	12	{ASIENTO_FASE_PY,ASIENTO_RECU_LINEA,AUXILIAR_CC,AUXILIAR_CP,AUXILIAR_PARC_CC}	No está en una tabla maestra.
s097	0	DEDUCCIONES		ME_PREVIA_BALANC_PERU	ME		1	{}	No está en una tabla maestra.
s098	0	DEPOSITO		DEPOSITO_POS	PO	Indica el consecutivo de deposito	1	{}	No está en una tabla maestra.
s098	1	MONTO_DEP	Depósito	TEXTOS_DOCS_CC	CC	Monto correspondiente a depósito	1	{}	No está en una tabla maestra.
s099	0	DEPRECIACION		ME_PREVIA_MEDIO_PERU	ME		1	{}	No está en una tabla maestra.
s100	0	DESCRIPCION_CUENTA		CG_CERTIFICADO_RET	CG	Indica la descripción del codigo de la cuenta contable	2	{ME_PREVIA_BALANC_PERU}	No está en una tabla maestra.
s101	0	DESCUENTO_LINEA	Descuento por Línea	CONTRATO_LINEA	AC	Indica el descuento que aplica para la línea	5	{DEVOL_LIN_EMBARQUE,DOCUMENTO_LINEA_ESPERA,DOC_POS_LINEA,EMBARQUE_LINEA}	No está en una tabla maestra.
s102	0	DESCUENTO_PRONTO_PAGO		GLOBALES_RUTEO	FR		1	{}	No está en una tabla maestra.
s103	0	DESTINO	Destino	LIQUIDAC_GASTO	CO	Destino del gasto que se va a aplicar en la liquidación	1	{}	No está en una tabla maestra.
s104	0	DEVOLUCION		DEVOLUCION	CO	Código de la devolución de compra	4	{DEVOL_LIN_EMBARQUE,FACTURA_CANCELA,RUTA_CONSECUT_RT}	
s105	0	DISENO		REPORTE_PANTALLA_PARAM	RP	Indica cual sera el diseño del reporte	1	{}	No está en una tabla maestra.
s106	0	DISTRIBUCION		DISTRIBUCION_ARTICULO	PO	Indica el monto para la distribución	2	{DISTRIBUCION_ARTICULO_PC}	No está en una tabla maestra.
s107	0	DIAS_VACACIONES		BENEFICIOS_ANTIGUE	RH	Días de Vacaciones	2	{SAL_DIARIO_INT_EMP}	No está en una tabla maestra.
s108	0	EDITABLE		CONSECUTIVO_CI	CI	Determina si el consecutivo puede editarse cuando se asocia a un documento	1	{}	No está en una tabla maestra.
s109	0	ESCALA		DES_BON_ESCALA_BONIFICACION	CR	Indica el número de la escala de la bonificación	2	{DES_BON_ESPECIFICACION_GRUPO}	No está en una tabla maestra.
s110	0	FECHA_REVISION	Fecha Revisión	DOCUMENTOS_CC	CC,GN	Fecha de revisión del documento; esta se puede ingresar o procesar en el proceso Manejo de días de revisión.	2	{DOCUMENTOS_CP}	No está en una tabla maestra.
s111	0	FILTROS		CUADRES_CG	CG	Campo perteneciente al cuadre de auxiliares; actualmente se almacena la palabra Filtros.	1	{}	No está en una tabla maestra.
s111	1	FILTRO		ALARMA	AL	Texto del Filtro aplicado para las columnas que conforman la alarma	2	{ALARMA_PLANTILLA}	No está en una tabla maestra.
s112	0	FUENTE		ASIENTO_DISTRIBUID	CG	Dato que se desee agregar por el cuál se origina la transación contable.	8	{ASIENTO_FASE_PY,CUADRE_CONTA,DETALLE_PREASIENTO,DIARIO,MAYOR}	No está en una tabla maestra.
s113	0	GARANTIA		RUTA_CONSECUT_RT	FR		1	{}	No está en una tabla maestra.
s114	0	GASTO_COMPRA	Gasto	LIQUIDAC_GASTO	CO	Código de gasto asociado a la línea; solo aplica cuando son gastos	1	{}	No está en una tabla maestra.
s115	0	INFORMACION		INFORMACION	CE,PP		8	{IMAGEN_CE,INFORMACION_GRUPO,NOTICIA,OFERTA,SCROLL}	
s116	0	INSTRUCCIONES		ORDEN_COMPRA	CO	Instrucciones de la orden de compra	1	{}	
s117	0	INTEGRACION_CONTA	Integración Contable	GLOBALES_AM	AM	Determina si se usa la integración con contabilidad	3	{GLOBALES_AP,GLOBALES_CI}	No está en una tabla maestra.
s118	0	INVENTARIO		RUTA_CONSECUT_RT	FR		1	{}	No está en una tabla maestra.
s119	0	INVENTARIO_SEGURIDAD		FORMATO_PLANIFICACION	CO		1	{}	No está en una tabla maestra.
s120	0	XML	Licencia	LICENCIA	SG	Contiene el xml de la licencia	1	{}	No está en una tabla maestra.
s121	0	LISTA_PRECIOS		GLOBALES_FA	FA	Lista de precios que se usará como default al crear un cliente	1	{}	No está en una tabla maestra.
s121	1	LISTA_PRECIO		LSTPRECIO_ALDO_RT	FR		1	{}	No está en una tabla maestra.
s122	0	LISTA_PRECIOS		GLOBALES_FA	FA	Lista de precios que se usará como default al crear un cliente	1	{}	No está en una tabla maestra.
s122	1	LISTA_PRECIO		LSTPRECIO_ALDO_RT	FR		1	{}	No está en una tabla maestra.
s123	0	Lote		TRASIEGO	FR		1	{}	No está en una tabla maestra.
s123	1	LOTE		LOTE	CI	Código a nivel interno del ERP del lote	39	{ARTICULO_EXISTENCIA_LOTE,BOLETA_INV_FISICO,DESGLOSE_ART_TMP,DESPACHO_DETALLE,DESPACHO_DETALLE_SINCRO}	La columna aparece en 39 tablas: es un campo genérico.
s124	0	MONTO	Monto	ACTIVO_HIST_MANT	AF	indica la descripcipin del codigo del activo	52	{CC_DET_RETENCION_PAR,CHEQUE,CHEQUES_RUBROS_CF,CIERRE_DESG_TARJ,COBRO_POS}	La columna aparece en 52 tablas: es un campo genérico. No está en una tabla maestra.
s124	1	MONTO_DOLAR	Monto	PRESUPUESTO_CONTAB	PR	Monto en moneda dolar que se asigna al presupuesto; fecha; centro de costo y cuenta contable.	2	{PRESUPUEST_DETALLE}	No está en una tabla maestra.
s124	2	MONTO_LOCAL	Monto	PRESUPUESTO_CONTAB	PR	Monto en moneda local que se asigna al presupuesto; fecha; centro de costo y cuenta contable.	2	{PRESUPUEST_DETALLE}	No está en una tabla maestra.
s125	0	NIVEL		CUENTA_CONTABLE	CG,PO	Describe el nivel de la cuenta	8	{ESTRUC_PROCESO_COSTEO,ORDEN_COMPONENTE,ORDEN_PC,SOLICITUD_AF_AUDIT,SOLICITUD_RH_AUDIT}	
s126	0	NOMBRE_ASIENTO		GLOBALES_CG	CG	Nombre que se le va a dar a los asientos(transacciones contables).	1	{}	No está en una tabla maestra.
s127	0	OBJETIVO		ALARMA_BASE	AL	Describe el objetivo para el cuál se genera la base	2	{ALARMA_PLANTILLA}	No está en una tabla maestra.
s128	0	SIN_OC		GLOBALES_FA	FA	Indicador que valida si el documento a generar posee la orden de compra	2	{PEDIDO_AUTORIZA}	No está en una tabla maestra.
s129	0	PAGO	Empleado con pago	DET_REG_BILLETE	PO		6	{ESTADO_EMPLEADO,INFO_DOC_SEGURO,INFO_REG_BILLETE,PAGO_POS,TIPO_AUSENCIA}	No está en una tabla maestra.
s130	0	PARAMETRO		REPORTE_PARAMETRO	RP	Indica el parametro que se utiliza para el reporte	1	{}	No está en una tabla maestra.
s130	1	PARAMETROS	Parámetros	OPCION_CONFIG	SG	Corresponde a los parámetros que debe definir el usuario. Cuando el módulo al cual se le asignó la opción configurada llama dicha opción; el sistema pide estos parámetros	1	{}	No está en una tabla maestra.
s131	0	PEDIDOS		VERSION_PM	PM	Si existió algún pedido durante la carga de datos; coloca el módulo fuente	1	{}	No está en una tabla maestra.
s131	1	PEDIDO		PEDIDO	FA	Código del Pedido	31	{FACTURA,ARTICULO_SERIE_POS,AUDITORIA_AD,BOLETA_DESPACHO_AD,DATOS_PM}	La columna aparece en 31 tablas: es un campo genérico.
s132	0	PERFIL		DETALLE_PERFIL_CLI	PO	Indica código de perfil del cliente	3	{DOCUMENTO_POS,PERFIL_CLIENTE}	No está en una tabla maestra.
s133	0	PLAZA	Código de la Plaza	PLAZA	CN,RH	Código de la Plaza.	3	{EMPLEADO,EMPLEADO_ACC_PER}	
s134	0	PORC_AJUSTE_COSTO	Porcentaje de ajuste costo	ARTICULO_PROVEEDOR	CO	Porcentaje de ajuste de costo para el proveedor	3	{ESTRUC_MANUFACTURA,ORDEN_PRODUCCION}	No está en una tabla maestra.
s135	0	PRECIO	Precio	ARTICULO_PRECIO	FA	Precio definido para el artículo.	4	{PEDIDO_INTERNET,PRECIO_ART_PROV,SP_PRECIO_ART_PROV}	No está en una tabla maestra.
s136	0	PRECIO_VENTA		DOC_POS_LINEA	PO	Indica el precio de venta del artículo	1	{}	No está en una tabla maestra.
s137	0	PRESUPUESTO		PRESUPUESTO	PR	Código que indentifica el presupuesto que se desea crear.	33	{ASIENTO_MOV_PRES,CONTRAREC_MOV_PRES,DESGLOSE_PRESUP,DETALLE_FLUJO,DETALLE_PRESUP}	La columna aparece en 33 tablas: es un campo genérico.
s138	0	PRINCIPAL		DD_MODULO_TABLA	RP	Indica si es la principal o no	2	{DD_PROPIETARIO_TABLA}	No está en una tabla maestra.
s139	0	PROCEDIMIENTO		PROCEDIMIENTO	AM	Código de procedimiento	13	{DOCS_PROCEDIM,FACT_PROC_MEDIC,OT_DETALLE,PROC_ARTICULO,PROC_EQUIPO}	
s140	0	EN_PROCESO		INICIAL_PM	PM	Indica la cantidad de este artículo que se encuentra en proceso	2	{VERSION_ART_PM}	No está en una tabla maestra.
s140	1	PROCESO		BITACORA_PROCESO	SG	Descripción algorítmica del proceso que se realizó	3	{DETALLE_PREASIENTO,PREASIENTO}	No está en una tabla maestra.
s141	0	RECIBO		EMPLEADO_NOMINA_CFDI	CN	Indica el recibo fiscal digital	6	{EMPLEADO_NOMINA_CFDI_CONCEPTO,LINEA_CONTEO_SINCRO,RECIBO_SINCRO,RUTA_CONSECUT_RT,UBICACION_SINCRO}	No está en una tabla maestra.
s142	0	REFERENCIA	Concepto	REFERENCIA	CR	Código de la referencia que se desea ingresar; este dato se debe insertar desde la base de datos; ya que no existe mantenimiento. Solo se debe de ingresar si se marca la opción de Referencia en Partidas en los parámetros.	41	{EMBARQUE,ASIENTOS_CHEQUE,ASIENTO_DIST_LINEA,ASIENTO_FASE_PY,ASIENTO_RECU_LINEA}	La columna aparece en 41 tablas: es un campo genérico.
s142	1	REFERENCIAS		LINEA_DEPOSITO	FR		1	{}	No está en una tabla maestra.
s142	2	REFERENCIA_LIQUID	Referencia	LIQUIDAC_COMPRA	CO	Referencia asociada a la liquidación de compra	1	{}	No está en una tabla maestra.
s143	0	REGLA		DES_BON_ESCALA_BONIFICACION	CR	Indica el código de la regla de la bonificación	9	{DES_BON_ESPECIFICACION_GRUPO,DES_BON_PAQUETE_REGLA,DES_BON_REGLA,DES_BON_REGLA_LOTE,ERPADMIN.HISTORIAL_DESCUENTOS}	No está en una tabla maestra.
s144	0	REINTEGRO	Porcentaje de la caja para reintegro	CAJA_CHICA	CH	Indica el porcentaje de caja chica que se considera para indicar que es preciso realizar un reintegro.	2	{VALE}	No está en una tabla maestra.
s145	0	RELACIONADO	Relacionado	PROVEEDOR	CO,CP,GN	Relacionado	1	{}	
s146	0	RESOLUCION	Resolución	CONSECUTIVO_FA	FA	Indica el código de la resolicion del documento	11	{CONSEC_CAJA_POS,DOCS_SOPORTE,DOCUMENTOS_CP,DOCUMENTO_EMBARQUE,DOCUMENTO_POS}	No está en una tabla maestra.
s147	0	RETENCION	RETENCION	CC_DET_RETENCION_PAR	CC	Codigo de la Retencion	9	{COMPROMISO_PP,CP_DET_RETENCION_PAR,DETALLE_FACTURA_RETENCION,DETALLE_RETENCION,DET_RETENCION_CH}	No está en una tabla maestra.
s147	1	RETENCIONES		COMPANIA_DESCRIPCION	FR		2	{GLOBALES_FA}	No está en una tabla maestra.
s148	0	RETENCIONES		COMPANIA_DESCRIPCION	FR		2	{GLOBALES_FA}	No está en una tabla maestra.
s148	1	RETENCION	RETENCION	CC_DET_RETENCION_PAR	CC	Codigo de la Retencion	9	{COMPROMISO_PP,CP_DET_RETENCION_PAR,DETALLE_FACTURA_RETENCION,DETALLE_RETENCION,DET_RETENCION_CH}	No está en una tabla maestra.
s149	0	SALARIO_INTEGRAL		PILA_HISTORICO_DET	CN		1	{}	No está en una tabla maestra.
s150	0	SALDO_LIBROS		CONCILIACION	CB	Saldo que existe hasta la fecha en libros.	1	{}	No está en una tabla maestra.
s151	0	SERVIDOR		GLOBALES_BI	BI	Es el nombre del servidor en parámetros del módulo de BI	1	{}	No está en una tabla maestra.
s152	0	SUCURSAL		NIT	AS		6	{ADMINISTRADORA,CAJA_POS,GRUPO,NIT_ME,RESOLUCION_DOC_ELECTRONICO}	
s153	0	SUPERVISOR	Usuario	SUPERVISOR	PO	Siglas con las que estará identificado el usuario	4	{AUDITORIA_AD,BITACORA,SUPERVISOR_AD}	
s154	0	SUSTITUTO		WIZ_EXP_PROD	PC	Indica si el artículo posee un artículo sustituto	1	{}	No está en una tabla maestra.
s155	0	TASA_IMPOSITIVA		FACTURA	FA	Indica la tasa impositiva	5	{PEDIDO,DOCUMENTOS_CC,DOCUMENTOS_CP,DOCUMENTO_EMBARQUE}	
s156	0	TEMPORAL	Estado Temporal	ESTADO_EMPLEADO	CN,RH	Indica si el estado del empleado es temporal.	1	{}	No está en una tabla maestra.
s157	0	TIPO_ARTICULO		FASE_DESGLOSE_PY	PY	Indica el tipo de artículo	2	{PROYECTO_ART_PRESUP_PY}	No está en una tabla maestra.
s158	0	TIPO_CONTABILIDAD		MEDIOS_ELECTRONICOS	ME		2	{PRESUPUESTO_BI}	No está en una tabla maestra.
s159	0	TIPO_CUENTA	Código Tipo Cta	TIPO_CUENTA	CB,CP	Código que se desea asignar al tipo de cuenta.	3	{CUENTA_BANCARIA,PROVEEDOR_ENTIDAD}	
s160	0	TIPO_ARTICULO		FASE_DESGLOSE_PY	PY	Indica el tipo de artículo	2	{PROYECTO_ART_PRESUP_PY}	No está en una tabla maestra.
s161	0	TITULO	Título	ALARMA	AL	Título que identifica la alarma	5	{EMPLEADO_ACADEMICO,INFO_NOTICIAS,MONITOR_COLUMNAS,TEXTO}	No está en una tabla maestra.
s162	0	TRANSACCION	Transacción	DET_MOV_APLICADO	CR	Indica el tipo de transacción (movimiento) que se va a realizar para la partida.	4	{DET_MOV_NOAPLICADO,ENC_MOV_APLICADO,ENC_MOV_NOAPLICADO}	No está en una tabla maestra.
s163	0	TRANSPORTISTA		COMPLEMENTO_SUNAT	AS	Código de Transportista	3	{DESPACHO,DESPACHO_SINCRO}	No está en una tabla maestra.
s164	0	TURNO		TURNO	PC	Código del turno ingresado	2	{OP_OPER_DET}	
s165	0	UNIDAD_DISTRIBUCIO	Unidad de Distribución	EMBARQUE_LINEA	CO	Código de unidad de distribución en la que el proveedor sumiestra el artículo de la línea de embarque	6	{LINEA_DOC_INV,ORDEN_COMPRA_LINEA,PEDIDO_LINEA,SOLICITUD_OC_LINEA,TRANSACCION_INV}	No está en una tabla maestra.
s165	1	UND_DISTRIBUCION	Unidad de Distribución	ART_UND_DISTRIBUCI	CI	Código de la unidad de distribución	1	{}	No está en una tabla maestra.
s166	0	SIN_VENCIMIENTO		RESOLUCION_DOC_ELECTRONICO	FA	Valida si tiene fecha de vencimiento	2	{RESOLUCION_POS}	No está en una tabla maestra.
s167	0	VENTA	VENTA	METAS_VENTA_COBRO	FR	Valor del meta de venta	1	{}	No está en una tabla maestra.
s168	0	ZONA		ZONA	AS	Identificación alfanumérica que sirve para distinguir a cada zona de la base de datos	6	{CLIENTE,FACTURA,PEDIDO,DES_BON_CLIENTE,PRONOSTICO_DETALLE}	
s169	0	AREA		DD_AREA	RP	Indica el código del area que se maneja	2	{DD_MODULO}	No está en una tabla maestra.
s170	0	AREA_FUNCIONAL	Área Funcional	CAJA_CHICA	CH	Nombre del departamento en el cuál va a funcionar la caja chica.	1	{}	No está en una tabla maestra.
\.
INSERT INTO may_qa_glosario_sch_core.tbl_sugerencia_opciones (sugerencia_id, orden, columna, etiqueta, tabla, modulo, descripcion, n_tablas, otras_tablas, observacion) SELECT sugerencia_id, orden, columna, etiqueta, tabla, modulo, descripcion, n_tablas, otras_tablas, observacion FROM _stg_tbl_sugerencia_opciones ON CONFLICT DO NOTHING;
COMMIT;
\echo 'Datos iniciales cargados.'
