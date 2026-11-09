# CHANGELOG

## 2026-10-30 — Brechas de la certificación Intelix (RF-15)
- Pedido: "corrige las brechas del certificador" (analizador.js --exposicion publica: No apto por INFRA4)
- Base de datos: sin cambios
- Infraestructura: el rol compartido de las Lambdas usa la política administrada AWSLambdaVPCAccessExecutionRole
  en lugar de la declaración VpcNetworkInterfaces con Resource '*' (INFRA4/R4); corregido en generate_sam.py
- Backend: GetHealthUseCase y GET /health (200 si Aurora responde, 503 si no, sin detalle del error) (DEVOPS3);
  tests de handlers de punta a punta (tests/unit/test_handlers.py)
- Cobertura: pytest-cov con fail_under = 80 en pyproject.toml; 92 % con la integración activa → backend/coverage.xml (COD6)
- R2 (SQL concatenado) queda abierto como falso positivo del certificador: el regex marca `%(nombre)s` de psycopg 3
  (consultas parametrizadas) y cualquier `+` en archivos que empiezan con `from __future__`
- Validación: ver .discovery/final-status.json · Despliegue: pendiente (dev espera .env.aws)
