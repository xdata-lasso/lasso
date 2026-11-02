-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default2', 1), (1, 'default1', 0), (2, 'default2', 1), (3, NULL, 0), (4, 'default2', 1), (5, 'default1', 1), (6, NULL, NULL), (7, 'default2', 1), (8, 'default1', 0), (9, 'default1', NULL), (10, NULL, NULL), (11, 'default1', NULL);
INSERT INTO departments (id, name) VALUES (0, 'default1'), (1, 'default2'), (2, NULL), (3, 'default2'), (4, 'default1'), (5, NULL), (6, 'default1'), (7, 'default1'), (8, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS WHERE NOT EXISTS(SELECT ID FROM DEPARTMENTS WHERE DEPARTMENTS.ID = STUDENTS.DEPARTMENT_ID);

/*
Prediction Result:
(6, None)
(9, 'default1')
(10, None)
(11, 'default1')
*/