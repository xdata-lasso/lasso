-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', NULL), (1, NULL, NULL), (2, 'default2', 1), (3, 'default2', 0);
INSERT INTO departments (id, name) VALUES (1, 'default1'), (0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ID, A.NAME FROM STUDENTS AS A LEFT JOIN DEPARTMENTS AS B ON A.DEPARTMENT_ID = B.ID WHERE B.ID IS NULL;

/*
Prediction Result:
(0, 'default1')
(1, None)
*/