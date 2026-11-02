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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (629, 25, 26, 27);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (17, 630, NULL, NULL, NULL, NULL);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (30, 628, 22, 2010, 23, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID = TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID >= TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Prediction Result:
(629, 25, 30)
*/