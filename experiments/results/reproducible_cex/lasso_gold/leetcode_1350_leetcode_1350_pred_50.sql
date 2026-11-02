-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "departments" ("id", "name") VALUES (1017, 'Gina Moore');
INSERT INTO "departments" ("id", "name") VALUES (1020, 'Gina Moore');
INSERT INTO "students" ("id", "name", "department_id") VALUES (1018, 'Gabrielle Davis', NULL);
INSERT INTO "students" ("id", "name", "department_id") VALUES (1021, 'Gabrielle Davis', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S1.ID, S1.NAME FROM STUDENTS AS S1 LEFT JOIN DEPARTMENTS AS D1 ON S1.DEPARTMENT_ID = D1.ID WHERE D1.NAME IS NULL;

/*
Prediction Result:
(1018, 'Gabrielle Davis')
(1021, 'Gabrielle Davis')
*/