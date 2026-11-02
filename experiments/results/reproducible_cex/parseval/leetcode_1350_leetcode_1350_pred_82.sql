-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, NULL);

INSERT INTO "departments" ("id", "name") VALUES (5, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (6, 'dep_4ca018');

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'stu_20d917', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT STUDENTS.ID AS ID, STUDENTS.NAME AS NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID WHERE DEPARTMENTS.NAME IS NULL;

/*
Prediction Result:
(1, 'stu_20d917')
*/