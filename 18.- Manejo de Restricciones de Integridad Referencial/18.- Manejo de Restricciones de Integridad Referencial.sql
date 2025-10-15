/*
Actividad 18 - Manejo de Restricciones de Integridad Referencial
Valdez Miranda Elias
Ingeniería en Sistemas de Información, Universidad de Sonora
Clave 4116: Bases de Datos I
Profesor Navarro Hernández Rene Francisco
14 de octubre de 2025
*/


-- 1. Conexión al servidor PostgreSQL
/*
	No hay mucho por comentar en este primer paso de la actividad.
	Se creó una base de datos utilizando el asistente de pgAdmin4, 
	lo que generó la siguiente consulta para la creación de la
	base de datos.
*/
CREATE DATABASE universidad
    WITH
    OWNER = developer
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

GRANT ALL ON DATABASE universidad TO developer WITH GRANT OPTION;


-- 2. Creación de tablas con claves primarias
/*
	Para esta etapa, se ejecutaron las instrucciones provistas por
	la tarea para generar las tablas 'alumno' y 'carrera'.
*/
CREATE TABLE carrera (
    id_carrera SERIAL PRIMARY KEY,
    nombre_carrera VARCHAR(100) NOT NULL
);

CREATE TABLE alumno (
    matricula SERIAL PRIMARY KEY,
    nombre_alumno VARCHAR(100) NOT NULL,
    id_carrera INT
);
/*
	También se ejecutan dos consultas de selección para verificar la
	correcta creación de las tablas.
*/
SELECT * FROM carrera;
SELECT * FROM alumno;


-- 3. Agregar la clave foránea
/*
	Similar a la etapa anterior, se ejecutaron instrucciones provistas
	por la tarea, esta vez, para generar las claves foráneas y sus
	restricciones de integridad referencial en los comandos de
	eliminación y actualización.
*/
ALTER TABLE alumno
ADD CONSTRAINT fk_alumno_carrera
FOREIGN KEY (id_carrera)
REFERENCES carrera (id_carrera)
ON DELETE SET NULL
ON UPDATE CASCADE;


-- 4. Inserción de registros
/*
	En esta etapa se ejecutaron dos instrucciones de inserción, además
	de una instrucción de selección para contar con datos cuyo
	comportamiento será analizado al modificar las tablas.
*/
INSERT INTO carrera (nombre_carrera)
VALUES ('Ingeniería en Software'), ('Administración'), ('Arquitectura');

INSERT INTO alumno (nombre_alumno, id_carrera)
VALUES ('Ana Pérez', 1), ('Luis Gómez', 1), ('María Ruiz', 2);

SELECT * FROM alumno;


-- 5. Prueba de eliminación (ON DELETE SET NULL)
/*
	Continuando con lo descrito anteriormente, se ejecuta la siguiente
	instruccion:
*/
DELETE FROM carrera WHERE id_carrera = 1;
SELECT * FROM alumno;
/*
	¿Qué sucedió con los alumnos que estaban inscritos en la carrera eliminada?

	Los alumnos con la clave foránea eliminada tuvieron sus claves foraneas
	actualizadas, almacenando un valor NULL en lugar del valor que almacenaban
	previo a su eliminación (1). Esto se debe a la restricción impuesta
	en la etapa 3, donde forzamos al sistema a configurar el valor de las
	claves foraneas eliminadas como NULL.
*/


-- 6. Prueba de actualización (ON UPDATE CASCADE)
/*
	Para comprobar la restricción en la actualización de los valores,
	ejecutamos la siguiente instrucción:
*/
UPDATE carrera SET id_carrera = 5 WHERE id_carrera = 2;
SELECT * FROM alumno;
/*
	¿Cómo afectó el cambio a los alumnos que pertenecían a esa carrera?

	Los alumnos con la clave foránea actualizada tuvieron sus claves foraneas
	actualizadas al nuevo valor (el valor 2 se actualizó al valor 5). Esto
	se dio por la restricción de cascada impuesta en la actualización de la
	id primaria en la carrera.
*/


-- 7. Experimentación con otras opciones
/*
	Podemos observar las diferentes reglas al modificar la tabla para
	utilizar nuevas restricciones, pero, primero, es necesario volver a
	introducir los datos originales, por lo que ejecuté las siguientes
	instrucciones:
*/
DELETE FROM alumno;
DELETE FROM carrera;
/*
	Entonces, volví a introducir la información dada originalmente:
*/
INSERT INTO carrera (nombre_carrera)
VALUES ('Ingeniería en Software'), ('Administración'), ('Arquitectura');
/*
	Como la clave primaria de la tabla 'Carrera' es seria, necesité
	cambiar las claves foraneas en la segunda instrucción de inserción,
	manteniendo las relaciones originales con la carrera:
*/
INSERT INTO alumno (nombre_alumno, id_carrera)
VALUES ('Ana Pérez', 7), ('Luis Gómez', 7), ('María Ruiz', 8);
/*
	Con la infromación actualizada, ejecutpe la instrucción dada:
*/
ALTER TABLE alumno DROP CONSTRAINT fk_alumno_carrera;

ALTER TABLE alumno
ADD CONSTRAINT fk_alumno_carrera
FOREIGN KEY (id_carrera)
REFERENCES carrera (id_carrera)
ON DELETE CASCADE
ON UPDATE RESTRICT;
/*
	Así, probé la primera instrucción de eliminación con la clave primaria actualizada:
*/
DELETE FROM carrera WHERE id_carrera = 7;
SELECT * FROM alumno;
/*
	Esta vez, al obtener los registros de la tabla alumno, se puede observar únicamente
	una fila, lo que indica que aquellas filas con clave foránea cuya clave primaria fue
	eliminada también son eliminadas.
	A continuación, intenté ejecutar la instrucción de actualización:
*/
UPDATE carrera SET id_carrera = 5 WHERE id_carrera = 8;
SELECT * FROM alumno;
/*
	Sin embargo, obtuve el siguiente error:

	ERROR:  update or delete on table "carrera" violates RESTRICT setting of foreign key constraint
	"fk_alumno_carrera" on table "alumno" Key (id_carrera)=(8) is referenced from table "alumno". 

	SQL state: 23001
	Detail: Key (id_carrera)=(8) is referenced from table "alumno".

	Esto ocurre por la restricción que establecimos, restringiendo la actualización de claves
	foraneas.
*/


-- 8. Validación en pgAdmin 4
/*
	Verificando las propiedades de la tabla 'alumno' en pgAdmin4, se puede observer la restricción
	de clave foránea 'fk_alumno_carrera', clave que es validada, ademas de contar con eliminación
	de cascada y restricción en su actualización, como se impuso en la instrucción anterior.
	Al ver la información de la tabla 'alumno' en View/Edit Data, podemmos observar que,
	posterior a las instrucciones ejecutadas, solo permanece la fila con la clave foránea 8, pues
	las demas fueron eliminadas por la restricción de cascada, mientras que esta última se mantuvo
	de tal forma por su restricción de actualización.
*/

/*
	Incluye en el script la respuesta a las siguientes preguntas:
   - ¿Qué es una restricción de integridad referencial?
	Una restricción de integridad referencial es una regla impuesta sobre una clave foránea
	en una relación de base de datos. La restricción obliga que el valor de la clave foránea
	(en una tabla hija) pertenezca a una clave primaria (en una tabla padre) o que sea nulo,
	posibilitando también la ejecución de acciones a ejecutar al modificar las claves primarias
	de la tabla padre.
   
   - ¿Qué diferencia hay entre ON DELETE SET NULL, CASCADE y RESTRICT?
   La restricción SET NULL establece los valores de las claves foráneas cuya clave primaria
   fue eliminada como NULL, mientras que CASCADE elimina todas las filas que contengan la clave
   primaria eliminada. RESTRICT evita la eliminación de la clave primaria si existen claves
   foráneas que contengan dicho valor.

   - ¿Por qué son importantes estas restricciones en sistemas reales?
	Al eliminar una fila con una clave primaria, las filas con claves foráneas en otra tabla
	perderían las referencias, por lo que es importante establecer como se manejarán las
	relaciones. En algunos sistemas, al eliminar una fila en una tabla, se esperaría que
	se eliminaran todos los registros asociados a dicha fila, mientras en otros sería
	preferible vaciar la clave foránea para asignar un nuevo valor posteriormente.
	En caso de requerir la consistencia entre los registros existentes, se puede
	restringir la eliminación de las filas. Las diferentes restricciones ofrecen flexibilidad
	a la hora de hacer el sistema, permitiendo la decisión que mejor se ajuste a nuestras
	necesidades.
*/