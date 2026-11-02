-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (13, '19');
INSERT INTO "Departments" ("id", "name") VALUES (12, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (21, '22', 12);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (11, '14', 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS P ON P.ID = S.DEPARTMENT_ID WHERE P.NAME IS NULL;

/*
Prediction Result:
(21, '22')
*/