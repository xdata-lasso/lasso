-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (id, name, department_id) VALUES (1, 'Alice', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
(1, 'Alice')
*/

-- Prediction Query
SELECT S.NAME, S.ID FROM STUDENTS AS S WHERE NOT S.DEPARTMENT_ID IN (SELECT ID FROM DEPARTMENTS);

/*
Prediction Result:
('Alice', 1)
*/