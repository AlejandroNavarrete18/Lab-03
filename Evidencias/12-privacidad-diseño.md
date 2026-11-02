# Evidencia 12 — Privacidad por diseño (Actividad 12)

## Objetivo
Evaluar un diseño que guarda todos los datos «por si acaso».

## Procedimiento
Se analizó la propuesta de tabla con ~13+ campos (incluye salario, estado civil, fecha de nacimiento, ocupación).

## Resultado
1. **Problemas:** recolección excesiva, sin finalidad, tipos `TEXT` sin restricciones, sin PK/NOT NULL, sin retención ni responsables, datos sensibles/financieros (salario, estado civil), redundancia (`edad` y `fecha_nacimiento`), todo en una tabla sin separación por finalidad.
2. **Principio ignorado:** minimización (también necesidad, finalidad y privacidad por diseño).
3. **Preguntas previas:** ¿para qué se usa cada campo? ¿Hay base jurídica? ¿Qué proceso falla sin él? ¿Quién accede? ¿Cuánto se conserva? ¿Es opcional? ¿Está en el aviso de privacidad?
4. **Eliminaría:** salario, estado civil, ocupación, `edad` (derivable), `fecha_nacimiento` completa, dirección completa, salvo justificación.
5. **Requieren justificación:** rfc (solo si factura), teléfono, código postal, dirección (si hay envío).
6. **Privacidad por defecto:** campos opcionales NULL/apagados, tablas separadas por finalidad, `REVOKE` a PUBLIC, roles mínimos, consentimientos en `false` por defecto, retención y expiración configuradas.

```sql
CREATE TABLE clientes (
  id BIGSERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  correo VARCHAR(150) NOT NULL UNIQUE,
  telefono VARCHAR(20),
  ciudad VARCHAR(80),
  acepta_promociones BOOLEAN NOT NULL DEFAULT false,
  fecha_alta DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE TABLE clientes_fiscal (   -- acceso solo Facturación
  id_cliente BIGINT PRIMARY KEY REFERENCES clientes(id),
  rfc VARCHAR(13) NOT NULL, codigo_postal VARCHAR(5) NOT NULL
);
```
## Análisis
Guardar «por si acaso» incrementa riesgo y obligaciones sin aportar valor demostrable.

## Conclusión
El diseño de la base de datos es el primer control de privacidad.
