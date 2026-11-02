-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (10, NULL);
INSERT INTO "Departments" ("id", "name") VALUES (9, '10');
INSERT INTO "Students" ("id", "name", "department_id") VALUES (17, '18', 10);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (12, '13', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENTS.ID, STUDENTS.NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON DEPARTMENTS.ID = STUDENTS.DEPARTMENT_ID WHERE DEPARTMENTS.NAME IS NULL;

/*
Prediction Result:
(12, '13')
(17, '18')
*/