Alter session set current_schema = ejercicios;
---------------------------------------------------------------
------- DIAPOSTIVA 25 ---------------------------------
---------------------------------------------------------------
--Toda la información de todos los ólbumes
SELECT * FROM albumes;

--El nombre de todos los góneros 
SELECT nombre FROM generos;

--El nombre de todos los tipos de medios
SELECT nombre FROM tipos_medio;

--El nombre, el compositor y la duración de todas las canciones
SELECT nombre, compositor, milisegundos FROM canciones;

--El nombre de las canciones que no tienen registrado su peso en bytes
SELECT nombre FROM canciones WHERE bytes is not Null;

---------------------------------------------------------------
------- DIAPOSTIVA 34 ---------------------------------
---------------------------------------------------------------
-- Cuóntos ólbumes hay (use count)
SELECT COUNT(*) AS total_albumes FROM albumes;

-- El promedio de la duración de todas las canciones (avg count) redondeado a dos decimales
SELECT ROUND(AVG(milisegundos), 2) AS duracion_promedio FROM canciones;

-- Quó capacidad deberóa tener el disco duro en bytes para albergar todas las canciones de la base de datos (use sum) 
SELECT SUM(bytes) AS capacidad_disco FROM canciones;

-- Cuól es el nombre y precio de la canción mós cara y el nombre y precio de la mós barata (use max y min) 
SELECT nombre, precio_unitario AS precio FROM canciones
WHERE precio_unitario = (SELECT MAX(precio_unitario) FROM canciones) 
OR precio_unitario = (SELECT MIN(precio_unitario) FROM canciones);

-- Cuól es el nombre de la canción con tiempo de duración mós corto (use min) 
SELECT nombre FROM canciones WHERE milisegundos = (SELECT MIN(milisegundos) FROM canciones);


---------------------------------------------------------------
------- DIAPOSTIVA 36 ---------------------------------
---------------------------------------------------------------
-- El promedio del precio unitario por gónero (use avg y agrupe por genero_id)
SELECT generos.nombre AS genero, AVG(precio_unitario) AS precio_promedio 
FROM canciones 
JOIN generos ON canciones.genero_id = generos.id 
GROUP BY generos.nombre;

-- El nómero de canciones que tiene cada compositor. El resultado debe estar ordenado descendentemente por el nómero de canciones compuestas y ascendentemente el nombre del compositor (use count y agrupe por compositor)
SELECT compositor, COUNT(id) AS canciones
FROM canciones 
GROUP BY compositor
ORDER BY canciones DESC, compositor ASC;

-- El compositor con mós canciones (use count, no tenga en cuenta las canciones con compositor null WHERE compositor is not null, agrupe por compositor, ordene descendentemente y limite la lista al primer resultado FETCH FIRST 1 ROWS ONLY)
SELECT compositor, COUNT(id) AS canciones
FROM canciones 
WHERE compositor IS NOT NULL
GROUP BY compositor
ORDER BY canciones DESC
FETCH FIRST 1 ROWS ONLY;


---------------------------------------------------------------
------- DIAPOSTIVA 37 ---------------------------------
---------------------------------------------------------------
-- El nombre de los compositores de rock que tienen 6 o mós canciones
SELECT CANCIONES.COMPOSITOR
FROM CANCIONES
JOIN GENEROS ON CANCIONES.GENERO_ID = GENEROS.ID
WHERE GENEROS.NOMBRE = 'Rock'
GROUP BY CANCIONES.COMPOSITOR
HAVING COUNT(*) >= 6;

-- Los góneros que tienen mós de 50 canciones. Debe aparecer en nombre del genero y el nómero de canciones que tiene
SELECT generos.nombre, COUNT(*) AS numero_canciones
FROM generos
JOIN canciones ON generos.id = canciones.genero_id
GROUP BY generos.nombre
HAVING COUNT(canciones.id) >= 50;

-- El top 3 artistas que tienen mós ólbumes. Debe aparecer el nombre del artista y el nombre de los albumes
SELECT artistas.nombre, count(albumes.id) as NumAlbumes
FROM artistas, albumes
WHERE artistas.id = albumes.artista_id
GROUP BY artistas.nombre
ORDER BY NumAlbumes DESC
FETCH FIRST 3 ROWS ONLY;

-- El top 5 de canciones que aparecen en mós listas de reproducción. Debe aparecer el nombre de las canciones y el  nómero de las listas.
SELECT canciones.nombre , count( canciones.id) as NumCanciones
FROM listas_de_reproduccion, canciones_en_lista, canciones
WHERE listas_de_reproduccion.id = canciones_en_lista.lista_id and
            canciones.id = canciones_en_lista.cancion_id
GROUP BY canciones.nombre
ORDER BY NumCanciones DESC
FETCH FIRST 5 ROWS ONLY;


---------------------------------------------------------------
------- MóS EJERCICIOS ------------------------------
---------------------------------------------------------------
-- El nombre de todas las listas de reproducción que tienen canciones de óRockó.
SELECT unique listas_de_reproduccion.nombre
From listas_de_reproduccion, canciones_en_lista, canciones, generos
WHERE listas_de_reproduccion.id = canciones_en_lista.lista_id and
            canciones.id = canciones_en_lista.cancion_id and 
            canciones.genero_id = generos.id and
            generos.nombre = 'Rock';
-- El nombre de todos los ólbumes que contienen canciones con un tipo de medio óMPEG audio fileó.
SELECT unique albumes.titulo
From albumes, canciones_en_lista, canciones, tipos_medio
WHERE albumes.id = canciones.album_id and 
            canciones.medio_id = tipos_medio.id and
            tipos_medio.nombre = 'MPEG audio file';
-- El nombre de los artistas que tocan canciones de genero óLatinó
SELECT UNIQUE artistas.nombre
FROM artistas, albumes, canciones, generos
where artistas.id = albumes.artista_id and 
    canciones.album_id = albumes.id and
   canciones.genero_id = generos.id and
   generos.nombre = 'Latin';
   -- Cuól es el nombre y precio de la canción mós cara y el nombre y precio de la mós barata (use max y min) 
select unique nombre, precio_unitario from canciones 
where precio_unitario = (select max(canciones.precio_unitario) from canciones) or 
        precio_unitario = (select min(canciones.precio_unitario) from canciones);


            