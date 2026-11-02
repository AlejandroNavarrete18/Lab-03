# Evidencia 15 — Arquitectura de datos protegidos (Actividad 15)

## Objetivo
Separar la información por finalidad con controles de privacidad.

## Procedimiento
Propuesta conceptual por esquemas dentro de PostgreSQL 16 (o bases separadas).

## Resultado
```
                BASE DE DATOS
   ┌──────────────┼───────────────────────┐
   ▼              ▼                       ▼
 operacion      analitica              auditoria
 (soporte,      (vistas/tablas         (eventos de acceso,
 facturación)   agregadas)             cambios, ARCO)
   │              ▲
   └── ETL con minimización/agregación ┘
```
| Control | Implementación |
|---|---|
| **Acceso** | Roles por función (`rol_soporte`, `rol_facturacion`, `analista`, `rol_marketing`); `REVOKE ALL FROM PUBLIC`; sin acceso directo a tablas base |
| **Minimización** | Un esquema por finalidad; solo columnas necesarias; `clientes_fiscal` separada |
| **Protección de información sensible** | Cifrado en tránsito (TLS) y de columnas críticas (pgcrypto), enmascarado en vistas, datos sintéticos en dev |
| **Retención** | Campo `fecha_alta`/`fecha_baja`, tarea programada de purga, vencimiento de respaldos |
| **Trazabilidad** | Tabla `auditoria` + triggers/pgaudit; logs de conexiones; `id_solicitud` ARCO |
| **Eliminación** | Procedimiento que cubre tablas, réplicas, copias analíticas, exportaciones, y respaldos por expiración |
| **Atención de solicitudes** | Catálogo de datos, vista `v_titular_datos`, registro de solicitudes y plazos, flujo con privacidad/jurídico |

```sql
CREATE SCHEMA operacion; CREATE SCHEMA analitica; CREATE SCHEMA auditoria;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT USAGE ON SCHEMA analitica TO analista;
```
## Análisis
La separación por finalidad hace que los controles de acceso, retención y eliminación sean más simples y verificables.

## Conclusión
Los principios de privacidad se convierten en esquemas, roles, vistas, auditoría y procesos.
