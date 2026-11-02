-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, 'default1', NULL), (0, NULL, 0);
INSERT INTO departments (id, name) VALUES (0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT P.ID, P.NAME FROM STUDENTS AS P LEFT JOIN DEPARTMENTS AS Q ON P.DEPARTMENT_ID = Q.ID WHERE Q.ID IS NULL;

/*
Prediction Result:
(1, 'default1')
*/