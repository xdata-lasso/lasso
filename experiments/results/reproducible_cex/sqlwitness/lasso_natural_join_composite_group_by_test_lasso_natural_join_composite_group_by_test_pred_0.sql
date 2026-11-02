-- Schema DDL
CREATE TABLE department (dept_name TEXT, building INTEGER);

CREATE TABLE student (student_id INTEGER, dept_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO student (student_id, dept_name) VALUES (2, 'default2'), (3, 'default2'), (2, 'default1');
INSERT INTO department (dept_name, building) VALUES (NULL, NULL), ('default1', 1), ('default2', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id, student.dept_name HAVING COUNT(dept_name) >= 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id HAVING COUNT(dept_name) >= 2;

/*
Prediction Result:
(2,)
*/