-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Departments (id, name) VALUES (1, 'Math');
INSERT INTO Students (id, name, department_id) VALUES (1, 'Alice', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS AS S WHERE NOT EXISTS(SELECT 1 FROM DEPARTMENTS AS D WHERE D.ID = S.DEPARTMENT_ID);

/*
Prediction Result:
(1, 'Alice')
*/