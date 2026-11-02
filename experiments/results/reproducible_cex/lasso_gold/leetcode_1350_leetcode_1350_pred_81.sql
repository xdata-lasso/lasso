-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "students" ("id", "name", "department_id") VALUES (1026, 'Ryan Munoz', NULL);
INSERT INTO "students" ("id", "name", "department_id") VALUES (1028, 'Ryan Munoz', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
(1026, 'Ryan Munoz')
(1028, 'Ryan Munoz')
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT DEPARTMENT_ID FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.ID IS NULL) SELECT DISTINCT ID, NAME FROM STUDENTS WHERE DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM CTE);

/*
Prediction Result:
*/