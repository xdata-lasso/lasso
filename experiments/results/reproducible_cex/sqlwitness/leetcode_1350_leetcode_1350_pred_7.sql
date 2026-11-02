-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default2', NULL), (1, 'default1', 1), (2, NULL, 0), (3, 'default2', NULL), (4, 'default1', 0);
INSERT INTO departments (id, name) VALUES (0, NULL), (1, 'default2'), (2, 'default1'), (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT B.ID, B.NAME FROM STUDENTS AS B LEFT JOIN DEPARTMENTS AS A ON B.DEPARTMENT_ID = A.ID WHERE A.ID IS NULL;

/*
Prediction Result:
(0, 'default2')
(3, 'default2')
*/