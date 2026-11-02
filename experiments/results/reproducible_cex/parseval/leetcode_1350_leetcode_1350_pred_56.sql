-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (3, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (2, 'd1__9f1672');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 's1__ef7bd4', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483647, 's1__7f857a', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483646, 's1__7f857a', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483645, 's1__7f857a', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 'stu_ea84a3', 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'stu_ea84a3', 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S1.ID, S1.NAME FROM STUDENTS AS S1 LEFT JOIN DEPARTMENTS AS D1 ON S1.DEPARTMENT_ID = D1.ID WHERE D1.NAME IS NULL;

/*
Prediction Result:
(-2147483647, 's1__7f857a')
(-2147483646, 's1__7f857a')
(-2147483645, 's1__7f857a')
(1, 's1__ef7bd4')
(3, 'stu_ea84a3')
*/