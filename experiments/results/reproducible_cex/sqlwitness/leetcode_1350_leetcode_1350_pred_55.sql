-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, NULL, 1), (0, NULL, 0), (2, 'default1', NULL);
INSERT INTO departments (id, name) VALUES (1, 'default2'), (0, NULL), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ST.ID, ST.NAME FROM STUDENTS AS ST WHERE NOT EXISTS(SELECT * FROM DEPARTMENTS AS D WHERE D.ID = ST.DEPARTMENT_ID);

/*
Prediction Result:
(2, 'default1')
*/