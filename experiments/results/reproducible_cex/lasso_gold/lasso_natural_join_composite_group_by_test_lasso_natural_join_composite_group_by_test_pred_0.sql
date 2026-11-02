-- Schema DDL
CREATE TABLE department (dept_name TEXT, building INTEGER);

CREATE TABLE student (student_id INTEGER, dept_name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "department" ("dept_name", "building") VALUES ('Gabrielle Davis', 1022);
INSERT INTO "department" ("dept_name", "building") VALUES ('Gabrielle Davis', 1027.0);
INSERT INTO "department" ("dept_name", "building") VALUES ('Ryan Munoz', 1025);
INSERT INTO "department" ("dept_name", "building") VALUES ('Ryan Munoz', 1030.0);
INSERT INTO "department" ("dept_name", "building") VALUES ('Ryan Munoz', 1031.0);
INSERT INTO "student" ("student_id", "dept_name") VALUES (1024, 'Gabrielle Davis');
INSERT INTO "student" ("student_id", "dept_name") VALUES (1024, 'Ryan Munoz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id, student.dept_name HAVING COUNT(dept_name) >= 2;

/*
Gold Result:
(1024,)
(1024,)
*/

-- Prediction Query
SELECT student.student_id FROM department NATURAL JOIN student GROUP BY student.student_id HAVING COUNT(dept_name) >= 2;

/*
Prediction Result:
(1024,)
*/