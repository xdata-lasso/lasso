-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 't2__02b4b2');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 't1__209110', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 't1__209110', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'stu_ea84a3', 3);

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
SELECT T1.ID, T1.NAME FROM STUDENTS AS T1 LEFT JOIN DEPARTMENTS AS T2 ON T2.ID = T1.DEPARTMENT_ID WHERE T2.NAME IS NULL;

/*
Prediction Result:
(1, 't1__209110')
(2, 't1__209110')
(4, 'stu_ea84a3')
(5, 'stu_ea84a3')
*/