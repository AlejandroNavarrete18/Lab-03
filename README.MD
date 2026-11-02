# LAB-03 — Privacidad, cumplimiento y gobierno de los datos
**Materia:*Gestion de Seguridad y Fundamentos de Base de Datos* **Motor:** PostgreSQL 16 · **Alumno:** Navarrete Diaz Luis Alejandro

## 1. Introducción
Una base de datos técnicamente bien configurada puede incumplir privacidad si recolecta datos innecesarios, los reutiliza sin informar, los conserva sin límite o permite acceso amplio. El caso es Comercializadora Norte S.A. de C.V. (tabla `clientes`), con procesos de atención, facturación, analítica y DBA. Marco de referencia: LFPDPPP. El DBA implementa controles técnicos y **escala** las decisiones jurídicas.

## 2. Inventario de datos
Los 9 campos son datos personales (directos o indirectos); ninguno sensible. `edad`, `ciudad` y `codigo_postal` son cuasi-identificadores. Detalle en [evidencias/01](evidencias/01-inventario-datos.md).

## 3. Finalidades
Atención: nombre, correo, teléfono. Facturación: nombre, RFC, CP. Analítica: ciudad, rango de edad y región de CP, de forma agregada. Marketing: solo con finalidad informada y consentimiento.

## 4. Minimización
`clientes_soporte` pasa de 9 a 4 campos (sin RFC, edad, CP). Analítica no recibe identificadores. Se proponen campos a eliminar en nuevos diseños: salario, estado civil, ocupación, edad redundante. Ver comentarios de `sql/01` y `sql/02` y `evidencias/12-privacidad-diseno.md`.

## 5. Control de acceso
Rol `analista` con `SELECT` solo sobre `v_analitica_clientes`; sin acceso a `clientes`; `REVOKE` a PUBLIC. Aplica minimización (privacidad) y mínimo privilegio (seguridad). Ver `sql/03-control-acceso.sql` y comentarios del script.

## 6. Derechos ARCO
- **Acceso:** `SELECT id, nombre, correo, telefono, rfc, edad, ciudad, codigo_postal, fecha_alta FROM clientes WHERE correo = 'ana@example.com';` Además del resultado, la organización debe informar finalidades, origen, transferencias, plazo de conservación y cómo ejercer otros derechos. Técnicamente: verificar identidad, buscar en todas las tablas y sistemas (no solo `clientes`) y registrar la solicitud.
- **Rectificación:** `UPDATE clientes SET correo = 'nuevo-correo@example.com' WHERE id = 1;` (propagar a `clientes_soporte` y otras copias). Se comprueba la autorización con un folio de solicitud validado; sí debe registrarse quién hizo el cambio (usuario, fecha, valor anterior/nuevo) porque la trazabilidad demuestra cumplimiento y permite investigar o revertir.
- **Cancelación:** no basta `DELETE`; hay que mapear respaldos, réplicas, reportes, exportaciones, copias de desarrollo, auditoría y sistemas externos. Ver `evidencias/08-ciclo-vida.md`.
- **Oposición:** no implica borrar todo; se conserva lo necesario (legal/relación) y se bloquea la finalidad secundaria (columna o tabla de oposiciones, vistas que las filtran). La decisión final es de privacidad/jurídico con el propietario de los datos. Ver `evidencias/08-ciclo-vida.md`.

## 7. Retención
Se determina con la finalidad vigente, obligaciones legales/fiscales/contractuales y riesgo; debe documentarse dato, plazo, fundamento, responsable, revisión y acción al vencer. La conservación indefinida contradice la minimización. Ver `evidencias/10-retencion.md`.

## 8. Gobierno de datos
Matriz completa en [evidencias/11](evidencias/11-gobierno-datos.md). Resumen: Atención → nombre/correo/teléfono; Facturación → RFC y CP; Analítica → datos agregados; DBA → custodio técnico; Dirección → aprueba políticas.

## 9. Evaluación integral
Se identificaron 13 riesgos. Principales: analítica con acceso directo a `clientes`, 12 años sin retención, dev con datos reales, marketing sin finalidad documentada, falta de catálogo y de auditoría. Ver `evidencias/14-evaluacion-integral.md`.

## 10. Conclusiones
La seguridad protege el dato; la privacidad decide si debe existir, quién lo usa, para qué y cuánto tiempo. El DBA traduce esos principios a diseño de tablas, vistas, roles, auditoría y ciclo de vida, sin sustituir al área jurídica.

---
## Preguntas de reflexión
1. **No.** Puede estar bien protegida y aun así tener datos innecesarios, usos sin base o retención excesiva.
2. Porque limita quién ve datos personales y reduce exposición, aun entre usuarios internos.
3. La finalidad es una decisión del negocio y jurídica (base legal, aviso, consentimiento); el DBA no es el propietario de los datos.
4. Violan minimización y mínimo privilegio; los ambientes de desarrollo suelen tener menos controles.
5. Contiene datos reales, sin controles de producción, con mayor probabilidad de fuga y fuera del ciclo de vida.
6. Porque cada dato debe tener una fecha de salida; sin retención no hay eliminación ordenada.
7. Se decide qué columnas existen, qué es opcional, cómo se separan finalidades y qué se conserva desde el diseño.
8. Roles mínimos, vistas, REVOKE a PUBLIC, cifrado en tránsito y reposo, enmascarado, auditoría, datos sintéticos en dev, retención automatizada.
9. Dónde están los datos del titular (catálogo), claves de búsqueda, tablas/copias/respaldos, plazos de retención y obligaciones de conservación.
10. **DBA:** implementa y custodia técnicamente. **Privacidad:** define procesos y atiende titulares. **Jurídico:** interpreta la norma, bases y plazos. **Propietario:** decide uso, finalidad y accesos del dato.

## Estructura
```
lab-03-privacidad-cumplimiento/
├── README.md
├── sql/ (01-minimizacion, 02-finalidad, 03-control-acceso)
└── evidencias/ (01, 05, 08, 10, 11, 12, 14, 15)
```
