-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', NULL), (1, 'default1', NULL), (2, 'default2', 1);
INSERT INTO departments (id, name) VALUES (1, 'default1'), (0, 'default2'), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT STUDENTS.ID AS ID, STUDENTS.NAME AS NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID WHERE DEPARTMENTS.NAME IS NULL;

/*
Prediction Result:
(0, 'default1')
(1, 'default1')
*/