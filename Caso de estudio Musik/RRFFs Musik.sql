Alter session set current_schema = ejercicios;

--Cuántos álbumes hay (use count)
select count(*) from albumes ;
-- El promedio de la duración de todas las canciones (avg count)
select avg(milisegundos) from canciones;
select round(avg(milisegundos),2) from canciones;
-- Qué capacidad debería tener el disco duro en bytes para albergar todas las canciones de la base de datos (use sum) 
select sum(bytes) from canciones;
-- Cuál es el nombre y precio de la canción más cara y el nombre y precio de la más barata (use max y min) 
select nombre, precio_unitario as precioMinimo from canciones
where precio_unitario = (Select MAX(precio_unitario) from canciones) or precio_unitario = (Select min(precio_unitario) from canciones);
-- Cuál es el nombre de la canción con tiempo de duración mas corto (use min) 
select nombre from canciones where canciones.milisegundos = (Select min(milisegundos) from canciones);


-- El promedio del precio unitario por genero (use avg y agrupe por genero_id)
select generos.nombre, avg(precio_unitario) from canciones, genero;
-- El número de canciones que tiene cada compositor. El resultado debe estar ordenado descendentemente por el número de canciones compuestas y ascendentemente el nombre del compositor (use count y agrupe por compositor)
-- El compositor con más canciones (use count, no tenga en cuenta las canciones con compositor null WHERE compositor is not null, agrupe por compositor, ordene descendentemente y limite la lista al primer resultado FETCH FIRST 1 ROWS ONLY)







-- El nombre de los compositores de rock que tienen 6 o más canciones
SELECT CANCIONES.COMPOSITOR
FROM CANCIONES
JOIN GENEROS ON CANCIONES.GENERO_ID = GENEROS.ID
WHERE GENEROS.NOMBRE = 'Rock'
GROUP BY CANCIONES.COMPOSITOR
HAVING COUNT(*) >= 6;
-- Los géneros que tienen más de 50 canciones. Debe aparecer en nombre del genero y el número de canciones que tiene
SELECT generos.nombre, COUNT(*) AS numero_canciones
FROM generos
JOIN canciones ON generos.id = canciones.genero_id
GROUP BY generos.nombre
HAVING COUNT(*) >= 50;
-- El top 3 artistas que tienen más álbumes. Debe aparecer el nombre del artista y el nombre de los albumes
SELECT artistas.nombre, count(albumes.id) as NumAlbumes
FROM artistas, albumes
WHERE artistas.id = albumes.artista_id
GROUP BY artistas.nombre
ORDER BY NumAlbumes DESC
FETCH FIRST 3 ROWS ONLY;
-- El top 5 de canciones que aparecen en más listas de reproducción. Debe aparecer el nombre de las canciones y el nombre de las listas.
SELECT canciones.nombre , count( canciones.id) as NumCanciones
FROM listas_de_reproduccion, canciones_en_lista, canciones
WHERE listas_de_reproduccion.id = canciones_en_lista.lista_id and
            canciones.id = canciones_en_lista.cancion_id
GROUP BY canciones.nombre
ORDER BY NumCanciones DESC
FETCH FIRST 5 ROWS ONLY;

-- El nombre de todas las listas de reproducción que tienen canciones de ‘Rock’.
SELECT unique listas_de_reproduccion.nombre
From listas_de_reproduccion, canciones_en_lista, canciones, generos
WHERE listas_de_reproduccion.id = canciones_en_lista.lista_id and
            canciones.id = canciones_en_lista.cancion_id and 
            canciones.genero_id = generos.id and
            generos.nombre = 'Rock';
-- El nombre de todos los álbumes que contienen canciones con un tipo de medio ‘MPEG audio file’.
SELECT unique albumes.titulo
From albumes, canciones_en_lista, canciones, tipos_medio
WHERE albumes.id = canciones.album_id and 
            canciones.medio_id = tipos_medio.id and
            tipos_medio.nombre = 'MPEG audio file';
-- El nombre de los artistas que tocan canciones de genero ‘Latin’
SELECT UNIQUE artistas.nombre
FROM artistas, albumes, canciones, generos
where artistas.id = albumes.artista_id and 
    canciones.album_id = albumes.id and
   canciones.genero_id = generos.id and
   generos.nombre = 'Latin';
   -- Cuál es el nombre y precio de la canción más cara y el nombre y precio de la más barata (use max y min) 
select unique nombre, precio_unitario from canciones 
where precio_unitario = (select max(canciones.precio_unitario) from canciones) or 
        precio_unitario = (select min(canciones.precio_unitario) from canciones);


            