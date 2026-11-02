-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Departments (id, name) VALUES (1, 'Physics');
INSERT INTO Departments (id, name) VALUES (NULL, 'Unassigned');
INSERT INTO Students (id, name, department_id) VALUES (1, 'Frank', 1);
INSERT INTO Students (id, name, department_id) VALUES (2, 'Grace', 2);
INSERT INTO Students (id, name, department_id) VALUES (3, 'Heidi', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENTS.ID, STUDENTS.NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID WHERE DEPARTMENTS.ID IS NULL;

/*
Prediction Result:
(3, 'Heidi')
*/