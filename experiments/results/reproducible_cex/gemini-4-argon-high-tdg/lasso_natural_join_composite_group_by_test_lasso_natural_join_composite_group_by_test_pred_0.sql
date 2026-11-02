-- Schema DDL
CREATE TABLE department (dept_name TEXT, building INTEGER);

CREATE TABLE student (student_id INTEGER, dept_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO department (dept_name, building) VALUES ('CS', 10);
INSERT INTO department (dept_name, building) VALUES ('Math', 20);
INSERT INTO department (dept_name, building) VALUES ('Bio', 30);
INSERT INTO student (student_id, dept_name) VALUES (301, 'CS');
INSERT INTO student (student_id, dept_name) VALUES (301, 'Math');
INSERT INTO student (student_id, dept_name) VALUES (302, 'Bio');
INSERT INTO student (student_id, dept_name) VALUES (302, 'Bio');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id, student.dept_name HAVING COUNT(dept_name) >= 2;

/*
Gold Result:
(302,)
*/

-- Prediction Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id HAVING COUNT(dept_name) >= 2;

/*
Prediction Result:
(301,)
(302,)
*/