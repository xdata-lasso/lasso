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
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -55602865, -59984348);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -664303813, -1022641847);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 1, -1726781632, 247012447);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (NULL, 1, -1980249628, -734455130);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, NULL, 1744686505, -1633151678);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COURSE_ID, TITLE FROM COURSE;

/*
Gold Result:
(1, 1)
(1, 1)
(1, 1)
(None, 1)
(1, None)
*/

-- Prediction Query
SELECT COURSE_ID, TITLE FROM COURSE WHERE CREDITS > 3;

/*
Prediction Result:
(1, 1)
*/