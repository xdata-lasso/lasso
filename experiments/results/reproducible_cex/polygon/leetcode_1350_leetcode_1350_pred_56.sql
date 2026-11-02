-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (11, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (17, '18', 11);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (19, '20', 11);
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
(17, '18')
(19, '20')
*/