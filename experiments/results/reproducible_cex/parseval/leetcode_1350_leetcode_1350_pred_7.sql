-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (3, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (2, 'b_s_f4ccc8');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'a_s_1778db', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483647, 'a_s_6bb35b', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483646, 'a_s_6bb35b', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (-2147483645, 'a_s_6bb35b', 1);

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
SELECT A.ID AS ID, A.NAME AS NAME FROM STUDENTS AS A LEFT JOIN DEPARTMENTS AS B ON A.DEPARTMENT_ID = B.ID WHERE B.NAME IS NULL;

/*
Prediction Result:
(-2147483647, 'a_s_6bb35b')
(-2147483646, 'a_s_6bb35b')
(-2147483645, 'a_s_6bb35b')
(1, 'a_s_1778db')
(3, 'stu_ea84a3')
*/