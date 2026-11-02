# Evidencia 01 — Inventario y finalidad de los datos (Actividad 1)

## Objetivo
Identificar qué datos de `clientes` son personales, para qué se usan, si son necesarios, quién debe acceder y cuánto deben conservarse.

## Procedimiento
Se revisó cada columna contra los procesos del escenario (atención, facturación, analítica, DBA). Las retenciones son **propuestas técnicas sujetas a validación del área jurídica/privacidad**.

## Resultado
| Campo | ¿Dato personal? | Finalidad | ¿Necesario? | Nivel de acceso | Retención (propuesta) |
|---|---|---|---|---|---|
| id | Sí (identificador interno; vincula al titular) | Identificar el registro y relacionar tablas | Sí | Atención, Facturación; DBA (técnico) | Mientras exista la relación |
| nombre | Sí (directo) | Atención al cliente y facturación | Sí | Atención, Facturación | Relación + plazo legal/fiscal |
| correo | Sí (directo) | Contacto de soporte y envío de comprobantes | Sí | Atención, Facturación. Marketing solo con finalidad informada | Relación + plazo legal |
| telefono | Sí (directo) | Contacto de soporte | Opcional | Solo Atención | Relación; eliminar al cancelar |
| rfc | Sí (identifica a persona física; dato fiscal) | Facturación | Solo para facturación | Solo Facturación | Plazo fiscal (confirmar; comúnmente 5 años) |
| edad | Sí (indirecto, combinable) | Analítica (rangos) | No en forma individual | Analítica solo como rango | Dato derivado; no conservar si se puede calcular de otro dato |
| ciudad | Sí (indirecto, combinable) | Analítica; envíos | Sí en forma agregada | Analítica (agregado), Atención | Relación |
| codigo_postal | Sí (indirecto, combinable) | Domicilio fiscal (facturación); región en analítica | Facturación sí; analítica solo región | Facturación completo; Analítica solo región (2 dígitos) | Plazo fiscal / relación |
| fecha_alta | Sí, por asociación con el titular | Antigüedad y cálculo de retención | Sí | Atención, DBA, Dirección | Mientras corra el plazo de retención |

## Análisis
- Ninguno es dato sensible, pero **la combinación** edad + ciudad + CP puede reidentificar a una persona (cuasi-identificadores).
- RFC y teléfono son los de mayor exposición y los que menos áreas necesitan.
- Que el DBA pueda leer todo técnicamente no justifica usarlo para cualquier finalidad.

## Conclusión
Cada dato debe tener finalidad, responsable y plazo. Los campos sin finalidad clara (o con finalidad solo agregada) deben limitarse o transformarse.
