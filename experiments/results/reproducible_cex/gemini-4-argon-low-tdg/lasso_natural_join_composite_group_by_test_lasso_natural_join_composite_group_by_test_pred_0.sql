-- Schema DDL
CREATE TABLE department (dept_name TEXT, building INTEGER);

CREATE TABLE student (student_id INTEGER, dept_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO department (dept_name, building) VALUES ('History', 10);
INSERT INTO department (dept_name, building) VALUES ('Art', 20);
INSERT INTO student (student_id, dept_name) VALUES (10, 'History');
INSERT INTO student (student_id, dept_name) VALUES (10, 'Art');
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
(10,)
*/