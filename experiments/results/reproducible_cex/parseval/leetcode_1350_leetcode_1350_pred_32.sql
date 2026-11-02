-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: departments --
INSERT INTO "departments" ("id", "name") VALUES (1, NULL);

INSERT INTO "departments" ("id", "name") VALUES (3, NULL);

INSERT INTO "departments" ("id", "name") VALUES (4, 'dep_4ca018');

INSERT INTO "departments" ("id", "name") VALUES (2, 'b_s_e9eb09');

INSERT INTO "departments" ("id", "name") VALUES (5, NULL);

INSERT INTO "departments" ("id", "name") VALUES (6, NULL);

-- Inserting into table: students --
INSERT INTO "students" ("id", "name", "department_id") VALUES (1, 'a_s_7e04fc', 1);

INSERT INTO "students" ("id", "name", "department_id") VALUES (3, 'a_s_cd4eb0', 1);

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
SELECT A.NAME, A.ID FROM STUDENTS AS A LEFT JOIN DEPARTMENTS AS B ON A.DEPARTMENT_ID = B.ID WHERE B.NAME IS NULL;

/*
Prediction Result:
('a_s_7e04fc', 1)
('a_s_cd4eb0', 3)
('stu_ea84a3', 4)
('stu_ea84a3', 5)
*/