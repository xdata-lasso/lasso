-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, 'default1', 1), (0, NULL, NULL), (2, 'default2', 0), (3, NULL, 0), (4, 'default2', NULL);
INSERT INTO departments (id, name) VALUES (0, 'default2'), (1, 'default1'), (2, 'default1'), (3, 'default1'), (4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL GROUP BY S.ID;

/*
Prediction Result:
(0, None)
(4, 'default2')
*/