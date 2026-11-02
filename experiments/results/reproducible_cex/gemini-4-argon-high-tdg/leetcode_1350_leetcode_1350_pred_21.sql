-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Departments (id, name) VALUES (1, 'Computer Science');
INSERT INTO Students (id, name, department_id) VALUES (1, 'Alice', NULL);
INSERT INTO Students (id, name, department_id) VALUES (2, 'Bob', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ID, T1.NAME FROM STUDENTS AS T1 LEFT JOIN DEPARTMENTS AS T2 ON T1.DEPARTMENT_ID = T2.ID WHERE T2.ID IS NULL;

/*
Prediction Result:
(1, 'Alice')
(2, 'Bob')
*/