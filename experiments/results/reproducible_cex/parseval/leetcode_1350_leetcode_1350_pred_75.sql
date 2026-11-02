-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (5, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (6, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 'dep_1d3d09');

INSERT INTO "departments" ("id", "name") VALUES (7, NULL);

INSERT INTO "departments" ("id", "name") VALUES (8, NULL);

INSERT INTO "departments" ("id", "name") VALUES (9, NULL);

INSERT INTO "departments" ("id", "name") VALUES (10, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'stu_8c1e28', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 'stu_ea84a3', 3);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'stu_ea84a3', 7);

INSERT INTO "students" ("id", "name", "department_id") VALUES (4, 'stu_ea84a3', 8);

INSERT INTO "students" ("id", "name", "department_id") VALUES (5, 'stu_ea84a3', 9);

INSERT INTO "students" ("id", "name", "department_id") VALUES (6, 'stu_ea84a3', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENTS.ID, STUDENTS.NAME FROM STUDENTS LEFT JOIN DEPARTMENTS ON STUDENTS.DEPARTMENT_ID = DEPARTMENTS.ID WHERE DEPARTMENTS.NAME IS NULL GROUP BY STUDENTS.ID;

/*
Prediction Result:
(1, 'stu_8c1e28')
(3, 'stu_ea84a3')
(4, 'stu_ea84a3')
(5, 'stu_ea84a3')
(6, 'stu_ea84a3')
*/