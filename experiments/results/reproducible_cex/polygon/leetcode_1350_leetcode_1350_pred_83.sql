-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (29, NULL);
INSERT INTO "Departments" ("id", "name") VALUES (16, '29');
INSERT INTO "Students" ("id", "name", "department_id") VALUES (19, '20', NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (17, '21', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT S.DEPARTMENT_ID FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL) SELECT DISTINCT S.ID, S.NAME FROM STUDENTS AS S JOIN CTE ON S.DEPARTMENT_ID = CTE.DEPARTMENT_ID;

/*
Prediction Result:
(17, '21')
*/