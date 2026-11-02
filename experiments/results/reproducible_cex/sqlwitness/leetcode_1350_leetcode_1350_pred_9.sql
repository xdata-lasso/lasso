-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, 'default2', 2), (2, 'default2', NULL), (0, 'default1', 1), (3, 'default1', 2), (4, NULL, 1), (5, 'default2', 0);
INSERT INTO departments (id, name) VALUES (0, 'default1'), (1, 'default1'), (2, 'default1'), (3, 'default2'), (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS AS A WHERE NOT EXISTS(SELECT 1 FROM DEPARTMENTS AS B WHERE B.ID = A.DEPARTMENT_ID);

/*
Prediction Result:
(2, 'default2')
*/