/*
Actividad 19 - Integridad Referencial: ON DELETE
Valdez Miranda Elias
Ingeniería en Sistemas de Información, Universidad de Sonora
Clave 4116: Bases de Datos I
Profesor Navarro Hernández Rene Francisco
16 de octubre de 2025
*/


-- 1. Crear una base de datos, por simplicidad llámala test.
/*
	Utilizamos pgAdmin4 para la creación de la base de datos.
	Se le asignaron todos los privilegios al desarrollador.
	Posteriormente, para entrar a la base de datos desde la
	línea de comandos, se utilizó la siguiente instrucción:
	
	psql -p 5433 -d test -U developer -W

	NOTA: Al tener configurado el puerto de mi base de datos
	como 5433, necesito agregar el parámetro adicional de
	puerto para conectarme a la base de datos.
*/


-- 2. Ejecutar script init.sql, para crear las tablas department y employee.
/*
	Como la terminal se encontraba en la carpeta 'constraints' descrita
	en la actividad, para ejecutar el script de inicialización, utilicé
	el siguiente comando:

	\i init.sql
*/


-- 3. Ejecutar script populate_tables.sql para insertar datos en ambas tablas.
/*
	Nuevamente, como la terminal se encontraba en la carpeta 'constraints',
	se pudo ejecutar el script de inserción con el siguiente comando:
	
	\i populate_tables.sql
*/


-- 4. Verifica que las tablas tienen datos haciendo una combinación de ambas.
/*
	Para verificar la correcta populación de las tablas, se utiliza
	el siguiente comando:
*/
SELECT emp_id, first_name, last_name, dept_id, dept_name
FROM employee e LEFT JOIN department d USING (dept_id);
/*
	Pudimos confirmar la correcta inserción de los datos.
*/


-- 5. Vamos a borrar el departamento de finanzas. Ejecuta el siguiente comando y registra el resultado.
DELETE FROM dept WHERE department_id = 3;
/*
	La restricción de la clave foranea evita que se elimine (RESTRICT)
*/

-- 6. Borrar ambas tablas de la base de datos utilizando el script droptables.sql.
-- (OMITIDO)

-- 7. Verifica que las tablas no existen.
-- (OMITIDO)

-- 8. Ejecutar script set_default.sql para regenerar ambas tablas.
/*
	Como el script 'set_default.sql' contiene instrucciones para la eliminación
	de las tablas, omitimos su eliminación por medio del script 'droptables.sql',
	y, en su lugar, ejecutamos el script mencionado:

	\i set_default.sql
*/

-- 9. Verifica que las tablas tienen datos haciendo una combinación de ambas. Guarda los resultados.
SELECT emp_id, first_name, last_name, dept_id, dept_name
FROM employee e LEFT JOIN department d USING (dept_id);
/*
	Pudimos confirmar la correcta inserción de los datos.
*/

-- 10. Vamos a volver a borrar el departamento de finanzas. Ejecuta el siguiente comando y registra el resultado.
DELETE FROM department
WHERE dept_id = 3;
/*
	A diferencia del resultado original, pudimos observar la eliminación de la fila
	con la clave 3, esto por la nueva restricción con la que contaba (SET DEFAULT)
*/

-- 11. Verifica que las tablas tienen datos haciendo una combinación de ambas. Compara los resultados con los obtenidos en el punto 9.
SELECT emp_id, first_name, last_name, dept_id, dept_name
FROM employee e LEFT JOIN department d USING (dept_id);
/*
	¿Qué diferencias se observan?
	Los empleados (Tanney) con la id de departamento 3 tuvieron su clave foránea
	actualizada al valor 0, el que corresponde al departamento de STAFF.
*/

-- 12. Borrar ambas tablas de la base de datos utilizando el script droptables.sql.
-- (OMITIDO)

-- 13. Verifica que las tablas no existen.
-- (OMITIDO)

-- 14.- Ejecutar script set_null.sql para para regenerar ambas tablas.
/*
	Como el script 'set_null.sql' contiene instrucciones para la eliminación
	de las tablas, omitimos su eliminación por medio del script 'droptables.sql',
	y, en su lugar, ejecutamos el script mencionado:

	\i set_null.sql
*/

-- 15. Verifica que las tablas tienen datos haciendo una combinación de ambas. Guarda los resultados.
SELECT emp_id, first_name, last_name, dept_id, dept_name
FROM employee e LEFT JOIN department d USING (dept_id);
/*
	Pudimos confirmar la correcta inserción de los datos.
*/

-- 16. Vamos a volver a borrar el departamento de finanzas. Ejecuta el siguiente comando y registra el resultado.
DELETE FROM department
WHERE dept_id = 3;
/*
	Nuevamente, pudimos observar la eliminación de la fila
	con la clave 3, esto por la nueva restricción con la que cuenta (SET NULL)
*/

-- 17. 17. Hacer una combinación de ambas. Compara los resultados con los obtenidos en el punto 15.
SELECT emp_id, first_name, last_name, dept_id, dept_name
FROM employee e LEFT JOIN department d USING (dept_id);

/*
	¿Qué diferencias se observan?
	Los empleados (Tanney) con la id de departamento 3 tuvieron su clave foránea
	eliminada y remplazada con un valor nulo, por lo que, al hacer la consulta de
	selección, se presenta la fila de los empleados sin valores en la clave foránea
	ni en el nombre del departamento.
*/
