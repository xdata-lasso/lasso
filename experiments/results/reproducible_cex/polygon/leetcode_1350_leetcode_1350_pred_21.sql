-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Departments" ("id", "name") VALUES (11, '13');
INSERT INTO "Departments" ("id", "name") VALUES (13, NULL);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (12, '15', 13);
INSERT INTO "Students" ("id", "name", "department_id") VALUES (16, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.NAME, S.ID FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON D.ID = S.DEPARTMENT_ID WHERE D.ID IS NULL;

/*
Prediction Result:
(None, 16)
*/