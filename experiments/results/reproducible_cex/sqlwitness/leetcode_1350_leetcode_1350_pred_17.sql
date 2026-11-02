-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', 1), (1, 'default1', NULL), (2, 'default2', 1), (3, 'default2', 1), (4, 'default1', NULL), (5, 'default2', NULL);
INSERT INTO departments (id, name) VALUES (1, 'default2'), (0, 'default2'), (2, NULL), (3, 'default1'), (4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL ORDER BY S.DEPARTMENT_ID ASC, S.id NULLS LAST, D.id NULLS LAST;

/*
Prediction Result:
(1, 'default1')
(4, 'default1')
(5, 'default2')
*/