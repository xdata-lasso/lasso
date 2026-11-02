-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, NULL, NULL), (1, 'default2', 1), (2, 'default2', 0), (3, NULL, NULL), (4, 'default2', 0), (5, 'default1', 0), (6, NULL, NULL), (7, NULL, 1), (8, NULL, 1);
INSERT INTO departments (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default2'), (3, NULL), (4, NULL), (5, 'default2'), (6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT S.DEPARTMENT_ID FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL) SELECT DISTINCT S.ID, S.NAME FROM STUDENTS AS S JOIN CTE ON S.DEPARTMENT_ID = CTE.DEPARTMENT_ID;

/*
Prediction Result:
(1, 'default2')
(7, None)
(8, None)
*/