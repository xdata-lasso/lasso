-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (3, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (2, 'dep_1507ef');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'stu_16566a', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'stu_f14fb1', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 'stu_ea84a3', 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (4, 'stu_ea84a3', 5);

INSERT INTO "students" ("id", "name", "department_id") VALUES (5, 'stu_ea84a3', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENTS.ID, STUDENTS.NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON DEPARTMENTS.ID = STUDENTS.DEPARTMENT_ID WHERE DEPARTMENTS.NAME IS NULL;

/*
Prediction Result:
(1, 'stu_16566a')
(3, 'stu_f14fb1')
(4, 'stu_ea84a3')
(5, 'stu_ea84a3')
*/