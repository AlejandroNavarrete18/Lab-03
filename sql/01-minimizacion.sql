-- LAB-03 / Actividad 2 - Minimización de datos
-- (Preparación: solo si no conservas la tabla clientes de LAB-01)
-- 8.1 Estructura mínima (con PK y NOT NULL)
DROP TABLE IF EXISTS clientes_soporte;
CREATE TABLE clientes_soporte (
  id       BIGINT PRIMARY KEY,
  nombre   VARCHAR(120) NOT NULL,
  correo   VARCHAR(150) NOT NULL,
  telefono VARCHAR(20)
);
INSERT INTO clientes_soporte (id, nombre, correo, telefono)
SELECT id, nombre, correo, telefono FROM clientes;

SELECT * FROM clientes_soporte LIMIT 10;
SELECT count(*) AS total_soporte FROM clientes_soporte;

/* ANÁLISIS (Act. 2)
1. ¿Todos necesarios para soporte? No: solo id, nombre, correo, telefono.
2. RFC: no hay razón; es dato fiscal exclusivo de facturación.
3. Edad: no es necesaria para atención.
4. Código postal: no, salvo caso justificado y documentado (p. ej. envíos).
5. Principio: minimización (también necesidad y proporcionalidad).
Resultado: se pasó de 9 a 5 columnas, reduciendo la superficie de exposición. */