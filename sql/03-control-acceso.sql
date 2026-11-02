-- LAB-03 / Actividad 4 - Control de acceso relacionado con la finalidad
DROP VIEW IF EXISTS v_analitica_clientes;
DROP ROLE IF EXISTS analista;
CREATE ROLE analista NOLOGIN;

CREATE VIEW v_analitica_clientes AS
SELECT ciudad,
       LEFT(codigo_postal,2) AS region_cp,
       CASE WHEN edad < 18 THEN 'Menor de 18' WHEN edad BETWEEN 18 AND 29 THEN '18-29'
            WHEN edad BETWEEN 30 AND 44 THEN '30-44' WHEN edad BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60 o más' END AS rango_edad
FROM clientes;

GRANT USAGE ON SCHEMA public TO analista;
GRANT SELECT ON v_analitica_clientes TO analista;
-- NO se otorga: GRANT SELECT ON clientes TO analista;
REVOKE ALL ON clientes FROM PUBLIC;   -- privacidad por defecto

-- Verificación de privilegios
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants WHERE grantee = 'analista';

-- Pruebas con el rol
SET ROLE analista;
SELECT * FROM v_analitica_clientes LIMIT 5;   -- debe funcionar
SELECT nombre, correo, rfc FROM clientes;     -- debe fallar: permission denied
RESET ROLE;

-- Prueba de privilegio por función
SELECT has_table_privilege('analista','clientes','SELECT')             AS puede_clientes,
       has_table_privilege('analista','v_analitica_clientes','SELECT') AS puede_vista;

/* ANÁLISIS (Act. 4)
1. El rol puede consultar ciudad, region_cp y rango_edad de v_analitica_clientes.
2. No puede consultar clientes directamente (permission denied).
3. No puede obtener nombre, correo ni RFC: la vista no los expone.
4. Principio de privacidad: minimización y limitación de finalidad.
5. Principio de seguridad: mínimo privilegio.
Nota: la vista incluye 'Menor de 18'; conviene revisarlo con privacidad/jurídico. */