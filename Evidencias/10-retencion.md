# Evidencia 10 — Política de retención (Actividad 10)

## Objetivo
Evaluar «conservar todo indefinidamente».

## Procedimiento
Análisis frente a minimización y ciclo de vida.

## Resultado
1. **¿Compatible con minimización?** No: conserva datos sin necesidad ni finalidad vigente.
2. **Riesgos:** mayor impacto de fugas, datos desactualizados/inexactos, costos de almacenamiento y respaldo, dificultad para atender ARCO, incumplimiento legal, mayor superficie de ataque y uso para fines no informados.
3. **Qué determinar:** finalidad vigente, obligaciones legales/fiscales/contractuales, plazos de prescripción, necesidad operativa, riesgo, y qué ocurre al vencer (borrado, anonimización o archivo).
4. **Qué documentar:** dato, finalidad, fundamento (ley/contrato), plazo, responsable que aprobó, fecha de revisión, acción al vencer, y alcance (respaldos, réplicas, dev).

Ejemplo técnico (propuesta): 
```sql
-- Candidatos a revisión de retención (sin relación activa > N años) 
SELECT id FROM clientes WHERE fecha_alta < now() - interval '5 years'; -- plazo a validar
```
## Análisis
Los 12 años actuales sin política de retención son un hallazgo de riesgo. 

## Conclusión
La retención forma parte del ciclo de vida: cada dato debe tener fecha de salida.