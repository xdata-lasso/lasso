-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', 0), (1, NULL, 0), (2, 'default2', NULL);
INSERT INTO departments (id, name) VALUES (0, NULL), (1, 'default2'), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS AS S WHERE NOT ID IN (SELECT S.ID AS ID FROM STUDENTS AS S JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID);

/*
Prediction Result:
(2, 'default2')
*/