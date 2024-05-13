


DROP TABLE albumes;
DROP TABLE artistas;
DROP TABLE canciones; 
DROP TABLE generos;
DROP TABLE LISTAS_DE_REPRODUCCION;
DROP TABLE TIPOS_MEDIO; 
 -- DROP TABLE Artistas CASCADE CONSTRAINTS;
 
 
 -- Insertar datos en la tabla ARTISTAS
INSERT INTO ARTISTAS (ID, NOMBRE) VALUES (1, 'Artista1');
INSERT INTO ARTISTAS (ID, NOMBRE) VALUES (2, 'Artista2');
INSERT INTO ARTISTAS (ID, NOMBRE) VALUES (3, 'Artista3');

-- Insertar datos en la tabla GENEROS
INSERT INTO GENEROS (ID, NOMBRE) VALUES (1, 'Rock');
INSERT INTO GENEROS (ID, NOMBRE) VALUES (2, 'Pop');
INSERT INTO GENEROS (ID, NOMBRE) VALUES (3, 'Electr�nica');

-- Insertar datos en la tabla TIPOS_MEDIO
INSERT INTO TIPOS_MEDIO (ID, NOMBRE) VALUES (1, 'CD');
INSERT INTO TIPOS_MEDIO (ID, NOMBRE) VALUES (2, 'Vinilo');
INSERT INTO TIPOS_MEDIO (ID, NOMBRE) VALUES (3, 'Digital');

-- Insertar datos en la tabla ALBUMES
INSERT INTO ALBUMES (ID, TITULO, ARTISTA_ID) VALUES (1, 'Album1', 1);
INSERT INTO ALBUMES (ID, TITULO, ARTISTA_ID) VALUES (2, 'Album2', 2);
INSERT INTO ALBUMES (ID, TITULO, ARTISTA_ID) VALUES (3, 'Album3', 3);

-- Insertar datos en la tabla CANCIONES
INSERT INTO CANCIONES (ID, NOMBRE, ALBUM_ID, MEDIO_ID, GENERO_ID, COMPOSITOR, MILISEGUNDOS, BYTES, PRECIO_UNITARIO)
VALUES (1, 'Cancion1', 1, 3, 1, 'Compositor1', 300000, 5000000, 1.99);

INSERT INTO CANCIONES (ID, NOMBRE, ALBUM_ID, MEDIO_ID, GENERO_ID, COMPOSITOR, MILISEGUNDOS, BYTES, PRECIO_UNITARIO)
VALUES (2, 'Cancion2', 1, 3, 1, 'Compositor2', 250000, 4000000, 1.49);

INSERT INTO CANCIONES (ID, NOMBRE, ALBUM_ID, MEDIO_ID, GENERO_ID, COMPOSITOR, MILISEGUNDOS, BYTES, PRECIO_UNITARIO)
VALUES (3, 'Cancion3', 2, 3, 2, 'Compositor3', 320000, 5500000, 2.29);

-- Insertar datos en la tabla LISTAS_DE_REPRODUCCION
INSERT INTO LISTAS_DE_REPRODUCCION (ID, NOMBRE) VALUES (1, 'Lista1');
INSERT INTO LISTAS_DE_REPRODUCCION (ID, NOMBRE) VALUES (2, 'Lista2');

-- Insertar datos en la tabla CANCIONES_EN_LISTA
INSERT INTO CANCIONES_EN_LISTA (LISTA_ID, CANCION_ID) VALUES (1, 1);
INSERT INTO CANCIONES_EN_LISTA (LISTA_ID, CANCION_ID) VALUES (1, 2);
INSERT INTO CANCIONES_EN_LISTA (LISTA_ID, CANCION_ID) VALUES (2, 3);


-- El nombre de los compositores de rock que tienen 6 o m�s canciones
SELECT CANCIONES.COMPOSITOR
FROM CANCIONES
JOIN GENEROS ON CANCIONES.GENERO_ID = GENEROS.ID
WHERE GENEROS.NOMBRE = 'Rock'
GROUP BY CANCIONES.COMPOSITOR
HAVING COUNT(*) >= 6;
-- Los g�neros que tienen m�s de 50 canciones. Debe aparecer en nombre del genero y el n�mero de canciones que tiene
SELECT generos.nombre, COUNT(*) AS numero_canciones
FROM generos
JOIN canciones ON generos.id = canciones.genero_id
GROUP BY generos.nombre
HAVING COUNT(*) >= 50;
-- El top 3 artistas que tienen m�s �lbumes. Debe aparecer el nombre del artista y el nombre de los albumes
SELECT artistas.nombre, count(albumes.id) as NumAlbumes
FROM artistas, albumes
WHERE artistas.id = albumes.artista_id
GROUP BY artistas.nombre
ORDER BY NumAlbumes DESC
FETCH FIRST 3 ROWS ONLY;
-- El top 5 de canciones que aparecen en m�s listas de reproducci�n. Debe aparecer el nombre de las canciones y el nombre de las listas.
SELECT canciones.nombre , count( canciones.id) as NumCanciones
FROM listas_de_reproduccion, canciones_en_lista, canciones
WHERE listas_de_reproduccion.id = canciones_en_lista.lista_id and
            canciones.id = canciones_en_lista.cancion_id
GROUP BY canciones.nombre
ORDER BY NumCanciones DESC
FETCH FIRST 5 ROWS ONLY;


select * from  canciones;
select * from  artistas;
select * from  albumes;
select * from  canciones_en_lista;

