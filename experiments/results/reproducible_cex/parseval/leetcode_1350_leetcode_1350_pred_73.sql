-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (2, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (3, 'p_s_ac537d');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 's_s_a4c6d6', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (2, 's_s_a4c6d6', 1);

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
SELECT S.ID, S.NAME FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS P ON P.ID = S.DEPARTMENT_ID WHERE P.NAME IS NULL;

/*
Prediction Result:
(1, 's_s_a4c6d6')
(2, 's_s_a4c6d6')
(4, 'stu_ea84a3')
(5, 'stu_ea84a3')
*/