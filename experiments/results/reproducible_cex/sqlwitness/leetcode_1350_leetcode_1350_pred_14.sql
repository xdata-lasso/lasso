-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, 'default2', 1), (0, 'default1', NULL), (2, 'default1', NULL), (3, 'default1', 0);
INSERT INTO departments (id, name) VALUES (1, 'default2'), (0, 'default2'), (2, NULL), (3, NULL), (4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS WHERE NOT ID IN (SELECT S.ID FROM STUDENTS AS S JOIN DEPARTMENTS AS D ON D.ID = S.DEPARTMENT_ID);

/*
Prediction Result:
(0, 'default1')
(2, 'default1')
*/