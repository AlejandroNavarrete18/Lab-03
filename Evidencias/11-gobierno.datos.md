# Evidencia 11 — Gobierno de datos y controles (Actividades 11 y 13)

## Objetivo
Relacionar datos, finalidad, responsables y controles.

## Procedimiento
Se asignó cada dato a roles según necesidad funcional.

## Resultado — Matriz de gobierno
| Dato | Finalidad | Responsable (owner) | Usuarios autorizados | Protección | Retención | Acción al finalizar |
|---|---|---|---|---|---|---|
| nombre | Atención y facturación | Operaciones / Atención | Atención, Facturación | Roles, vista por área, auditoría | Relación + plazo legal | Eliminar o bloquear tras plazo |
| correo | Contacto y envío de comprobantes | Atención al cliente | Atención, Facturación; Marketing solo vía vista y consentimiento | Roles, vistas, cifrado en reposo/tránsito | Relación + plazo legal | Eliminar; respetar oposición |
| telefono | Contacto de soporte | Atención al cliente | Atención | Rol exclusivo, enmascarado en reportes | Relación | Eliminar al cancelar |
| rfc | Facturación | Finanzas / Facturación | Facturación | Rol exclusivo, cifrado de columna, auditoría | Plazo fiscal (a validar) | Bloquear y eliminar al vencer |
| edad | Analítica | Analítica / Dirección | Analítica (solo rango) | Vista con rangos | Derivada; solo agregada | Eliminar valor exacto / anonimizar |
| ciudad | Analítica y envíos | Analítica / Logística | Analítica (agregado), Atención | Vista | Relación | Anonimizar/eliminar |
| codigo_postal | Domicilio fiscal; región analítica | Finanzas / Analítica | Facturación (completo), Analítica (2 dígitos) | Vista, generalización | Plazo fiscal | Eliminar o generalizar |
El **DBA** es custodio técnico: implementa permisos, respaldos y auditoría, pero no es dueño de los datos. **Dirección** aprueba políticas, sin acceso operativo individual.

## Actividad 13 — Controles técnicos vs administrativos
| Medida | Técnico | Administrativo | Justificación |
|---|:-:|:-:|---|
| Crear roles de PostgreSQL | ✔ | | Implementación técnica de permisos |
| Política de retención | | ✔ | Documento/decisión organizacional; el borrado automático sería su implementación técnica |
| Cifrado de datos | ✔ | | Protección criptográfica (la gestión de llaves tiene parte administrativa) |
| Procedimiento para solicitudes ARCO | | ✔ | Proceso, responsables y plazos (con apoyo técnico) |
| Vista con información limitada | ✔ | | Restringe columnas; deriva de una decisión administrativa de finalidad |
| Clasificación de información | | ✔ | Política y criterios; se implementa técnicamente con etiquetas/catálogo (ambos) |
| Registro de auditoría | ✔ | ✔ | Técnico: logs y triggers. Administrativo: definir qué se audita y quién revisa |
| Política de control de acceso | | ✔ | Define quién accede; se materializa con roles y GRANT (ambos) |

## Análisis
Los controles técnicos sin controles administrativos carecen de criterio, y viceversa.

## Conclusión
El acceso debe responder a una necesidad funcional documentada.
