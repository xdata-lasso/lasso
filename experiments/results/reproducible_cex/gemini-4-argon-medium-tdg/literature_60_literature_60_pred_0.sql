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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (101, 501, 10, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (102, 502, 20, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (103, 503, 30, 3);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (9001, 101, 1, 2010, 1, 8001);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (9001, 101, 2, 2010, 2, 8002);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (9002, 101, 3, 2009, 1, 8003);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (9003, 102, 1, 2011, 1, 8004);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "year", "semester", "instructor") VALUES (9004, 999, 1, 2010, 1, 8005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID = TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Gold Result:
(101, 501, 9001)
*/

-- Prediction Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID >= TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Prediction Result:
(101, 501, 9001)
(102, 502, 9001)
(103, 503, 9001)
*/