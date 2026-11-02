# Evidencia 14 — Evaluación integral (Actividad 14)

## Objetivo
Identificar riesgos del escenario de 50,000 clientes.

## Procedimiento
Se analizó cada afirmación del escenario frente a los principios de privacidad y seguridad.

## Resultado
| # | Problema | Principio afectado | Riesgo | Control propuesto |
|---|---|---|---|---|
| 1 | Analítica consulta directamente `clientes` | Mínimo privilegio / minimización | Acceso a PII innecesaria | Vista agregada + rol `analista` |
| 2 | Analítica solo genera estadísticas mensuales | Necesidad / proporcionalidad | Exposición de RFC, correo, teléfono | Entregar tabla agregada o resumen mensual |
| 3 | Datos con 12 años de antigüedad | Retención / limitación de conservación | Fuga masiva de datos obsoletos | Política de retención y purga |
| 4 | Sin política de retención documentada | Ciclo de vida / responsabilidad | Incumplimiento y falta de criterio | Definir plazos con jurídico; automatizar |
| 5 | Desarrolladores reciben copias completas | Minimización / mínimo privilegio | Fuga desde ambientes menos protegidos | Datos sintéticos o enmascarados |
| 6 | Copias de desarrollo con datos reales | Seguridad y privacidad por diseño | Incidente fuera de producción | Enmascarado, seudonimización, borrado de copias |
| 7 | Marketing usa correos sin finalidad documentada | Finalidad / consentimiento | Uso secundario no autorizado | Revisar aviso; vista con consentimiento y oposición |
| 8 | Sin documentación de finalidad por dato | Gobierno de datos / transparencia | No se puede justificar el tratamiento | Catálogo e inventario de datos |
| 9 | No hay propietarios ni custodios identificados | Responsabilidad / rendición de cuentas | Decisiones sin dueño | Matriz de gobierno |
| 10 | Sin auditoría ni trazabilidad mencionada | Trazabilidad | Imposible detectar abuso | Logging, pgaudit/triggers |
| 11 | RFC accesible a todos | Confidencialidad / mínimo privilegio | Robo de identidad/fraude fiscal | Rol de facturación, cifrado de columna |
| 12 | Sin proceso de atención ARCO claro | Derechos del titular | No poder responder en plazo | Procedimiento + inventario |
| 13 | Respaldos/réplicas sin ciclo de vida definido | Retención / eliminación | Datos «eliminados» persisten | Retención de respaldos, mapa de copias |

## Análisis
Los hallazgos mezclan fallas de acceso, de finalidad y de ciclo de vida, no solo configuración técnica.

## Conclusión
Se requieren controles técnicos y administrativos coordinados; los 13 hallazgos superan el mínimo de 10.
