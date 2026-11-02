-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-55602865, 'cou_aa4396', 'cou_796e44', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-59984348, 'cou_aa4396', 'cou_7e0bd2', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-664303813, 'cou_aa4396', 'cou_7e0bd2', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1022641847, 'cou_aa4396', NULL, -1726781632);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (247012447, 'cou_aa4396', NULL, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1980249628, 'cou_aa4396', NULL, NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-734455130, 'cou_aa4396', NULL, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1744686505, 'cou_aa4396', NULL, 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 'cou_aa4396', 'cou_796e44', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (3, 'cou_aa4396', 'cou_796e44', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1633151678, 'cou_aa4396', 'cou_796e44', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-252690330, 'cou_aa4396', 'cou_796e44', 1);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-55602865, 'cou_aa4396', 'C', -59984348);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-664303813, 'cou_aa4396', 'A', -1022641847);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1726781632, 'cou_aa4396', 'O', 247012447);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (-1980249628, 'cou_aa4396', 'A', -734455130);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Gold Result:
('O',)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(None,)
('cou_796e44',)
('cou_7e0bd2',)
('A',)
('C',)
('O',)
*/