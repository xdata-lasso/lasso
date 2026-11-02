-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (2, 'd_s_3a0bfd');

INSERT INTO "departments" ("id", "name") VALUES (7, NULL);

INSERT INTO "departments" ("id", "name") VALUES (8, NULL);

INSERT INTO "departments" ("id", "name") VALUES (9, NULL);

INSERT INTO "departments" ("id", "name") VALUES (10, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 's_s_13bf50', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 's_s_13bf50', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'stu_ea84a3', 2);

INSERT INTO "students" ("id", "name", "department_id") VALUES (4, 'stu_ea84a3', 7);

INSERT INTO "students" ("id", "name", "department_id") VALUES (5, 'stu_ea84a3', 8);

INSERT INTO "students" ("id", "name", "department_id") VALUES (6, 'stu_ea84a3', 9);

INSERT INTO "students" ("id", "name", "department_id") VALUES (7, 'stu_ea84a3', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID WHERE D.NAME IS NULL GROUP BY S.ID;

/*
Prediction Result:
(1, 's_s_13bf50')
(2, 's_s_13bf50')
(4, 'stu_ea84a3')
(5, 'stu_ea84a3')
(6, 'stu_ea84a3')
(7, 'stu_ea84a3')
*/