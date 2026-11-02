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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (NULL, 23, 32, -550);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (24, 25, NULL, -388);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (-388, -388, -388);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (-388, -388, -388);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (-388, -388, -388);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (-388, -388, -388, -388);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (-388, -388, -388, -388);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (-388, -388, -388, -388);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (-388, -388, -388, -388, -388, -388);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (-388, -388, -388, -388, -388);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (-388, -388, -388, -388, -388);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (-388, -388, -388, -388, -388);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (-388, -388, -388, -388);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (-388, -388, -388, -388);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (-388, -388, -388, -388);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE AS C CROSS JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A WHERE C.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(32,)
(None,)
*/