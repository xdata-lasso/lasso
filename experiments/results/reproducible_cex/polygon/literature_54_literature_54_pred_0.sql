-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" INTEGER, "dept_name" INTEGER, "credits" INTEGER);

CREATE TABLE "department" ("dept_name" INTEGER, "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" INTEGER, "salary" INTEGER, "dept_name" INTEGER);

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "semester" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" INTEGER, "dept_name" INTEGER, "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (45, 46, 104, -631);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (NULL, NULL, 104, 12279);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (104, 104, 49, 104);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (104, 99, 912);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (104, 38, 910);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (NULL, NULL, 910);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (104, 104, 104, 104);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (104, 104, 104, 104);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (104, 104, 104, 104);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (30, NULL, 32, 906, 33, NULL);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (104, 104, 104, 907, 104, 104);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (NULL, 101, 102, 908, 33, NULL);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (104, 104, 104, 104, 104, 104);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (104, 104, 104, 104, 104, 104);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (104, 104, 104, 104, 104, 104);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (104, 104, 104, 104, 104);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (104, 104, 104, 104, 104);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (104, 104, 104, 104, 104);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (104, 104, 104, 104);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (104, 104, 104, 104);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (104, 104, 104, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) = 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) >= 2;

/*
Prediction Result:
(33, 23296)
*/