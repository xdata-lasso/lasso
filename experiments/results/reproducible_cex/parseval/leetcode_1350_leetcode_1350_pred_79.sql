-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (-2147483648, 'dep_9d4340');

INSERT INTO "departments" ("id", "name") VALUES (1, 'dep_53bc26');

INSERT INTO "departments" ("id", "name") VALUES (-2147483646, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 'dep_4ca018');

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'stu_cda5de', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483647, NULL, 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483646, NULL, 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483645, 'stu_ea84a3', 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483644, NULL, 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483643, NULL, -2147483646);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483642, 'stu_ea84a3', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
WITH FILTER AS (SELECT STUDENTS.NAME AS NAME, STUDENTS.ID AS ID, DEPARTMENTS.NAME AS DEPARTMENT FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID) SELECT NAME, ID FROM FILTER WHERE DEPARTMENT IS NULL;

/*
Prediction Result:
(None, -2147483643)
*/