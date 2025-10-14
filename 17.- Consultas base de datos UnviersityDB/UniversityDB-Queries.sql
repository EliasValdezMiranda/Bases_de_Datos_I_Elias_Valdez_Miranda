/*
Actividad 17 - Consultas base de datos UnviersityDB
Valdez Miranda Elias
Ingeniería en Sistemas de Información, Universidad de Sonora
Clave 4116: Bases de Datos I
Profesor Navarro Hernández Rene Francisco
13 de octubre de 2025
*/

-- Consulta # 1
SELECT
	name,
	id
FROM student
ORDER BY name ASC;

-- Consulta # 2
SELECT
	id,
	name
FROM student
WHERE tot_cred > 59;

-- Consulta # 3
SELECT
	name,
	id
FROM student
WHERE tot_cred BETWEEN 50 AND 100
  AND dept_name = 'Comp. Sci.';

-- Consulta # 4
SELECT *
FROM course
WHERE dept_name = 'Biology';

-- Consulta # 5
SELECT
	title,
	course_id
FROM course
WHERE credits = 4;

-- Consulta # 6
SELECT
	title,
	course_id
FROM course
WHERE dept_name IN ('Biology','History');

-- Consulta # 7
SELECT DISTINCT
	dept_name
FROM course
WHERE credits IN (4,3);

-- Consulta # 8
SELECT DISTINCT dept_name
FROM course
WHERE credits = 3 INTERSECT
	SELECT DISTINCT dept_name
	FROM course
	WHERE credits = 4;

-- Consulta # 9
SELECT
	name,
	course_id
FROM instructor
NATURAL JOIN teaches;

-- Consulta # 10
SELECT
	name,
	course_id
FROM instructor
NATURAL JOIN teaches
WHERE semester = 'Fall';

-- Consulta # 11
SELECT
	name,
	course_id
FROM instructor
NATURAL JOIN teaches
WHERE semester = 'Spring'
  AND salary < 80000;

-- Consulta # 12
SELECT
	name,
	title
FROM instructor
NATURAL JOIN teaches
NATURAL JOIN course
WHERE salary BETWEEN 75000 AND 85000;

-- Consulta # 13
SELECT
	name,
	title
FROM student
NATURAL JOIN takes
NATURAL JOIN course
WHERE student.dept_name = 'Comp. Sci.'
  AND takes.year = 2009;

-- Consulta # 14
SELECT name
FROM student
JOIN advisor
ON student.id = advisor.s_id;

-- Consulta # 15
SELECT name
FROM student
LEFT JOIN advisor
ON student.id = advisor.s_id
WHERE advisor.s_id IS NULL;

-- Consulta # 16
SELECT
	student.name AS estudiante,
	instructor.name AS asesor
FROM student
JOIN advisor
ON student.id = advisor.s_id
JOIN instructor
ON instructor.id = advisor.i_id
WHERE student.dept_name = 'Biology';

-- Consulta # 17
SELECT
	room_number,
	building,
	capacity
FROM classroom
NATURAL JOIN department
WHERE dept_name = 'Biology';

-- Consulta # 18
SELECT dept_name,COUNT(*)
FROM course
GROUP BY dept_name;

-- Consulta # 19
SELECT
	dept_name,
	MAX(budget) AS presupuesto
FROM department
GROUP BY dept_name
HAVING MAX(budget) = 
	(SELECT MAX(budget)
	FROM department);

-- Consulta # 20
SELECT ROUND(AVG(salary),2) AS salario_promedio
FROM instructor;

-- Consulta # 21
SELECT
	id,
	name,
	salary
FROM instructor
WHERE salary >
	(SELECT ROUND(AVG(salary),2) AS salario_promedio
	 FROM instructor);