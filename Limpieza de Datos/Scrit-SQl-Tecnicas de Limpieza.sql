--------------------------------------------------------
--Parte UNO
--------------------------------------------------------
--------------------------------------------------------
--Parte A  Eliminar registros duplicados- Ejemplo SLIDES 
           -- Tabla CANCIONES
--------------------------------------------------------
--Paso 1. . Buscar registros de canciones con el mismo nombre
SELECT  nombre, count(id) as cantidad FROM canciones
GROUP BY nombre
HAVING COUNT(id) > 2
ORDER BY cantidad DESC;

--Paso 2. Revisar los registros de la tabla

SELECT *  FROM canciones
WHERE nombre IN(
SELECT  nombre FROM canciones
GROUP BY nombre
HAVING COUNT(id) > 2
)
ORDER BY nombre;


--Paso 3. Enumerar  los registros duplicados para la cancion 2 Minutes To Midnight
SELECT nombre,rowid AS rid,
           ROW_NUMBER() OVER (PARTITION BY nombre ORDER BY rowid) AS rn
 FROM canciones
 WHERE nombre like '2 Mi%';


--Paso 4. Eliminar Registros solo para la cancion 2 Minutes To Midnight
DELETE FROM canciones
WHERE rowid IN (
    SELECT rid
    FROM (
                 SELECT nombre , rowid AS rid,
                    ROW_NUMBER() OVER (PARTITION BY nombre ORDER BY  rowid)  rn
                 FROM canciones
                 WHERE nombre like '2 Mi%'
                 ORDER BY nombre 
    )
    WHERE rn > 1
);
--Paso 5. Verificar que solo me queda un resgitro de la cancion 2 Minutes To Midnight
SELECT * FROM canciones
WHERE nombre like '2 Mi%';

--Paso 6. No confirmamo borrado, benedo tener todos los regsitros de la cancion 2 Minutes To Midnight
SELECT * FROM canciones
WHERE nombre like '2 Mi%';

--------------------------------------------------------
--Parte B  Manejar Valores Nullos 
           -- Tabla CANCIONES
--------------------------------------------------------

--Paso 1. Consultar  campos con registros nulos

SELECT  * FROM canciones
WHERE compositor IS NULL;

--Paso 1  Dependiendo del tipo de atributo, reemplazar el valor. Para el caso : “Unknow”
UPDATE canciones
SET compositor='Unknow' 
WHERE compositor IS NULL;


--------------------------------------------------------
--Parte C  Eliminar caracteres Especiales 
           -- Tabla CANCIONES
--------------------------------------------------------
--Paso 1. Definir Expresión regular con los carateres que queremos: sólo permite números , letras , espacios y dieresis

SELECT REGEXP_REPLACE ( 'God Gaves Rock n Roll To You $5#@@@@', 
'[^a-zA-Z0-9áéíóúÁÉÍÓÚüÜñÑ ]', '')  as salida FROM DUAL;


--Paso 2. Actualizar Registros
-- Antes
SELECT * FROM  canciones WHERE  id IN (3401,3402,3403,3405,3406,3407,3408,3409,3410,3411,3412,3413,3414,3415);
--
UPDATE canciones
SET nombre = REGEXP_REPLACE(nombre, '[^a-zA-Z0-9áéíóúÁÉÍÓÚüÜñÑ ]', '')
WHERE  id IN (3401,3402,3403,3405,3406,3407,3408,3409,3410,3411,3412,3413,3414,3415);

--Despues
SELECT * FROM  canciones WHERE  id IN (3401,3402,3403,3405,3406,3407,3408,3409,3410,3411,3412,3413,3414,3415);

--------------------------------------------------------
--Parte D  Tratar Valores Atipicos 
           -- Tabla CANCIONES
--------------------------------------------------------
--Paso 1 Buscar mas de 3 Desviaciones. Para el ejemplo vamos a trabajar  sobre el campo de milisegundos en la tabla canciones
SELECT  id, nombre , milisegundos 
,round((SELECT  AVG(milisegundos) FROM canciones),0)  media
,round((SELECT 3 * STDDEV(milisegundos) FROM canciones),0) desviacion
FROM canciones
WHERE milisegundos > (
  SELECT AVG(milisegundos) + 3 * STDDEV(milisegundos)
  FROM canciones
)
ORDER BY milisegundos DESC ;

--Paso 2- Borrar valores atipicos
DELETE FROM canciones
WHERE milisegundos > (
  SELECT AVG(milisegundos) + 3 * STDDEV(milisegundos)
  FROM canciones
);


--------------------------------------------------------
--Parte E  Validacion de Datos 
           -- Tabla CANCIONES
           --Requiere haber borrado duplicados Parte A
--------------------------------------------------------
-- Paso 1 Verificar integridad de referencias externas
--Tabla padre: canciones
--Tabla hija: canciones_en_lista

SELECT * FROM canciones_en_lista
WHERE CANCION_ID NOT IN(
SELECT id FROM canciones
);


--Paso 2 Contar registros por categoria
--Caso1. Contar las canciones por “Genero” 
SELECT g.nombre,count(c.id) as total
FROM canciones c
INNER JOIN  generos g ON (c.genero_id=g.id)
GROUP BY g.nombre
ORDER BY total desc;

--Caso2. Contar las canciones por “Genero” y “Medio”
 
SELECT g.nombre as genero,t.nombre as medio,
count(c.id) as total
FROM canciones c
INNER JOIN  generos g ON (c.genero_id=g.id)
inner JOIN tipos_medio t  ON (c.medio_id=t.id)
GROUP BY g.nombre,t.nombre
ORDER BY g.nombre;

--------------------------------------------------------
--Parte F  Normalizacion 
           -- Tabla CANCIONES
--------------------------------------------------------
--Caso 1 z-score
SELECT id, nombre, milisegundos, round((SELECT AVG(milisegundos)AS mean FROM canciones),0) media,
round((SELECT STDDEV(milisegundos)  FROM canciones),0) desviacion,
round(((milisegundos - (SELECT AVG(milisegundos)AS mean FROM canciones)) /
(SELECT STDDEV(milisegundos)  FROM canciones)),2)as zscore
FROM canciones
ORDER BY  milisegundos desc;


--Caso 2- Min-Max
SELECT id,nombre, milisegundos, round(((milisegundos - (SELECT MIN(milisegundos) FROM canciones)) / 
((SELECT MAX(milisegundos) FROM canciones) - (SELECT MIN(milisegundos)FROM canciones))),2)
AS normalized_value
FROM canciones;

-- Crear una columa para colocar los valores de Milisegundos Normalizados
ALTER TABLE canciones add milisegundosnormalized number(5,3);

UPDATE canciones
SET milisegundosnormalized =
round(((milisegundos - (SELECT MIN(milisegundos) FROM canciones)) / 
((SELECT MAX(milisegundos) FROM canciones) - (SELECT MIN(milisegundos)FROM canciones))),2)
WHERE  milisegundosnormalized IS NULL;

-- Verificar datos
SELECT * FROM canciones;


