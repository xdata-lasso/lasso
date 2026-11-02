-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (1, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (1, 'Alice', 1);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (2, 'Bob', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
WITH FILTER AS (SELECT STUDENTS.NAME AS NAME, STUDENTS.ID AS ID, DEPARTMENTS.NAME AS DEPARTMENT FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID) SELECT NAME, ID FROM FILTER WHERE DEPARTMENT IS NULL;

/*
Prediction Result:
('Alice', 1)
('Bob', 2)
*/