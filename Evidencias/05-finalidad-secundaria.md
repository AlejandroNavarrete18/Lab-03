# Evidencia 05 — Finalidad secundaria (Actividad 5)

## Objetivo
Analizar el uso de datos de clientes para promociones personalizadas.

## Procedimiento
Se evaluó la propuesta «promociones personalizadas por edad, ciudad y comportamiento de compra» contra finalidad, base jurídica y minimización.

## Resultado
1. **¿Tener los datos permite usarlos para cualquier fin?** No. Solo para finalidades informadas en el aviso de privacidad y compatibles con las que motivaron la recolección.
2. **Preguntas previas:** ¿Está en el aviso de privacidad? ¿Es finalidad compatible o requiere nuevo consentimiento? ¿Hay mecanismo de oposición/baja? ¿Quién es el propietario de la decisión? ¿Se usará perfilado? ¿Hay terceros/transferencias? ¿Cuánto se conserva? ¿Hay impacto en menores?
3. **Datos necesarios:** correo (canal), rango de edad, ciudad, y un indicador/segmento de comportamiento de compra. No: RFC, teléfono (salvo que ese canal se autorice), fecha exacta.
4. **¿Acceso directo a `clientes`?** No. Marketing recibe una vista/tabla preparada.
5. **Controles técnicos:** vista limitada, rol propio, bandera `acepta_promociones` filtrada en la vista, exclusión de oposiciones, enmascarado o seudónimo para segmentación, auditoría de consultas/exportaciones, y límites de exportación.

```sql
-- Propuesta (no ejecutada sin aprobación de privacidad)
CREATE VIEW v_marketing_segmentos AS
SELECT id AS id_seudonimo, correo, ciudad,
       CASE WHEN edad BETWEEN 18 AND 29 THEN '18-29' WHEN edad BETWEEN 30 AND 44 THEN '30-44'
            WHEN edad BETWEEN 45 AND 59 THEN '45-59' ELSE '60 o más' END AS rango_edad
FROM clientes
WHERE acepta_promociones IS TRUE;   -- columna a crear si privacidad lo aprueba
```

## Análisis
Es una finalidad secundaria: el DBA no decide si procede; solo implementa las restricciones técnicas resultantes.

## Conclusión
Primero la base jurídica y la finalidad; después el acceso.