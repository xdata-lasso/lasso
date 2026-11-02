-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (15, '16');
INSERT INTO "Departments" ("id", "name") VALUES (14, '16');
INSERT INTO "Students" ("id", "name", "department_id") VALUES (17, '18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT ID, NAME FROM STUDENTS WHERE DEPARTMENT_ID IN (SELECT DISTINCT A.DEPARTMENT_ID FROM STUDENTS AS A LEFT JOIN DEPARTMENTS AS B ON A.DEPARTMENT_ID = B.ID WHERE B.ID IS NULL);

/*
Prediction Result:
*/