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
SELECT A.ID AS ID, A.NAME AS NAME FROM STUDENTS AS A LEFT JOIN DEPARTMENTS AS B ON A.DEPARTMENT_ID = B.ID WHERE B.NAME IS NULL;

/*
Prediction Result:
(17, '18')
(19, '20')
*/