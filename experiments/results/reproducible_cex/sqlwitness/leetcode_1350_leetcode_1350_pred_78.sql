-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, 'default2', 1), (0, 'default2', NULL), (2, NULL, NULL), (3, NULL, 1), (4, NULL, 0);
INSERT INTO departments (id, name) VALUES (0, 'default2'), (1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON D.ID = S.DEPARTMENT_ID WHERE D.ID IS NULL ORDER BY S.ID ASC, D.id NULLS LAST;

/*
Prediction Result:
(0, 'default2')
(2, None)
*/