-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', 0), (1, NULL, NULL), (2, 'default2', NULL);
INSERT INTO departments (id, name) VALUES (1, 'default2'), (0, NULL), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENTS.ID, STUDENTS.NAME FROM STUDENTS LEFT JOIN DEPARTMENTS AS D ON STUDENTS.DEPARTMENT_ID = D.ID WHERE D.ID IS NULL;

/*
Prediction Result:
(1, None)
(2, 'default2')
*/