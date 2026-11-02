-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (13, '15');
INSERT INTO "Departments" ("id", "name") VALUES (12, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (15, NULL, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (24, '25', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM (SELECT S.ID, S.NAME AS NAME, D.NAME AS DEPARTMENT FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID) AS TMP WHERE DEPARTMENT IS NULL;

/*
Prediction Result:
(15, None)
(24, '25')
*/