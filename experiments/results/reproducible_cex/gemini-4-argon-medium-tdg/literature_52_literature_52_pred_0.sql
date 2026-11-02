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
-- DATASET 1
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1, 101, 10000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (2, 102, 20000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (3, 103, 500000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (10, 1001, 1, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (11, 1002, 1, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (20, 2001, 2, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (30, 3001, 3, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (99, 9999, 99, 3);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 10, 1, 2020, 1, 100);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 10, 2, 2020, 1, 100);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 10, 3, 2020, 1, 100);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 10, 4, 2020, 1, 100);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1, 10, 5, 2020, 1, 100);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 1, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 2, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 3, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 4, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 5, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (2, 11, 6, 2021, 2, 101);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 1, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 2, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 3, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 4, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 5, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 6, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 7, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 8, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 9, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 10, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 11, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (3, 20, 12, 2020, 1, 102);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (4, 88, 1, 2020, 1, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(D.BUDGET) > 10;

/*
Gold Result:
(1, 110000)
(2, 240000)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(DISTINCT D.BUDGET) > 10;

/*
Prediction Result:
*/