-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, NULL, 0), (0, NULL, NULL), (2, 'default1', 1), (3, 'default1', 0), (4, 'default2', NULL), (5, NULL, 1);
INSERT INTO departments (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDS.ID, STUDS.NAME FROM STUDENTS AS STUDS LEFT JOIN DEPARTMENTS AS DEPS ON STUDS.DEPARTMENT_ID = DEPS.ID WHERE DEPS.ID IS NULL;

/*
Prediction Result:
(0, None)
(4, 'default2')
*/