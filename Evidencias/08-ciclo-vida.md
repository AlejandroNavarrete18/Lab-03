# Evidencia 08 — Cancelación y ciclo de vida (Actividades 8 y 9)

## Objetivo
Entender el alcance real de una cancelación y de una oposición.

## Procedimiento
Antes de cualquier `DELETE` se mapeó dónde existen datos del titular.

## Resultado — Mapa
```
clientes (fuente)
 ├── tablas relacionadas (clientes_soporte, facturas, pedidos, auditoría)
 ├── respaldos (completos/incrementales, retención propia)
 ├── réplicas (streaming/lógicas, lectura)
 ├── copias de analítica / reportes
 ├── exportaciones (CSV, Excel, correos adjuntos)
 ├── ambientes dev/pruebas con copia real
 └── sistemas externos (marketing, facturación, proveedores/encargados)
```
**Pregunta: ¿por qué un DELETE no elimina todo?** Porque el dato está replicado en respaldos (inmutables hasta que expiren), réplicas, copias de desarrollo, reportes y exportaciones, y puede haber sido transferido a terceros. Además, hay datos que deben conservarse por obligación legal (p. ej. fiscal), y los logs/WAL pueden contener el valor. Por eso se requieren: catálogo de datos, políticas de expiración de respaldos, bloqueo de datos mientras expire el plazo y notificación a encargados.

### Actividad 9 — Oposición
¿Eliminar todo de inmediato? **No.** Oposición no equivale a cancelación.
1. **Debe mantenerse:** datos necesarios para la relación o la ley (facturación, historial fiscal).
2. **Debe dejar de usarse:** correo/perfil para promociones o analítica individual.
3. **Mecanismos técnicos:** columna `acepta_promociones` / tabla `oposiciones(id_cliente, finalidad, fecha)`, vistas que filtran oposiciones, roles por finalidad, listas de supresión en marketing.
4. **Por qué no solo el DBA:** requiere evaluar la base jurídica, excepciones y obligaciones; decide privacidad/jurídico con el propietario de los datos; el DBA implementa.

## Análisis
Cancelación y oposición tienen efectos distintos en el ciclo de vida del dato.

## Conclusión
Eliminar es un proceso transversal, no una sentencia SQL.
