-- LAB-03 / Actividad 3 - Separación por finalidad (analítica)
-- Clientes por ciudad (agregado)
SELECT ciudad, COUNT(*) AS cantidad_clientes
FROM clientes GROUP BY ciudad ORDER BY cantidad_clientes DESC;

-- Rangos de edad
SELECT CASE
         WHEN edad < 18 THEN 'Menor de 18'
         WHEN edad BETWEEN 18 AND 29 THEN '18-29'
         WHEN edad BETWEEN 30 AND 44 THEN '30-44'
         WHEN edad BETWEEN 45 AND 59 THEN '45-59'
         ELSE '60 o más' END AS rango_edad,
       COUNT(*) AS cantidad
FROM clientes
GROUP BY 1 ORDER BY rango_edad;

-- Región del código postal (primeros 2 dígitos = menor granularidad)
SELECT LEFT(codigo_postal,2) AS region_cp, COUNT(*) AS cantidad
FROM clientes GROUP BY 1 ORDER BY cantidad DESC;

-- Combinación completa que necesita analítica, sin identificadores
SELECT ciudad, LEFT(codigo_postal,2) AS region_cp,
       CASE WHEN edad < 18 THEN 'Menor de 18' WHEN edad BETWEEN 18 AND 29 THEN '18-29'
            WHEN edad BETWEEN 30 AND 44 THEN '30-44' WHEN edad BETWEEN 45 AND 59 THEN '45-59'
            ELSE '60 o más' END AS rango_edad,
       COUNT(*) AS cantidad
FROM clientes GROUP BY 1,2,3
HAVING COUNT(*) >= 5      -- umbral mínimo para reducir reidentificación en grupos pequeños
ORDER BY cantidad DESC;

/* ANÁLISIS (Act. 3)
¿Por qué esta información puede ser más apropiada para analítica que entregar directamente la tabla completa de clientes?
Analítica solo necesita estadísticas; el agregado cumple la finalidad sin identificar personas
(minimización y limitación de finalidad), reduce el daño ante fuga o mal uso y evita reutilizar
datos para otros fines. No es anonimización perfecta: los grupos pequeños pueden reidentificar
(por eso el HAVING) y la anonimización no sustituye las obligaciones de privacidad. */
