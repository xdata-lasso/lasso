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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (NULL, NULL, 13, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (5, NULL, 14, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (5, NULL, 5, 3);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (5, 5, 5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (5, 5, 5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (5, 5, 5);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (5, 5, 5, 5);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (5, 5, 5, 5);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (5, 5, 5, 5);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (5, 5, 5, 5, 5, 5);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (5, 5, 5, 5, 5);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (5, 5, 5, 5, 5);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (5, 5, 5, 5, 5);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (5, 5, 5, 5);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (5, 5, 5, 5);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (5, 5, 5, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COURSE_ID, TITLE FROM COURSE;

/*
Gold Result:
(None, None)
(5, None)
(5, None)
*/

-- Prediction Query
SELECT COURSE_ID, TITLE FROM COURSE WHERE CREDITS > 3;

/*
Prediction Result:
(None, None)
(5, None)
*/