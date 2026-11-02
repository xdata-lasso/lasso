-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (11, '13');
INSERT INTO "Students" ("id", "name", "department_id") VALUES (12, '13', 11);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (14, '15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS WHERE DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM STUDENTS WHERE NOT DEPARTMENT_ID IN (SELECT ID FROM DEPARTMENTS));

/*
Prediction Result:
*/