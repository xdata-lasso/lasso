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
-- Tests: Missing DISTINCT, ORDER BY CREDITS DESC LIMIT 1 mutations, and general filtering (MIN vs MAX, <, <=, !=).
-- Dept 10 has two courses with max credits (tests DISTINCT).
-- Dept 20 also has max credits (tests LIMIT 1).
-- Dept 30 has fewer credits (tests filtering).
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (10, 1, 1000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (20, 2, 2000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (30, 3, 3000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (101, 1, 10, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (102, 2, 10, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (103, 3, 20, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (104, 4, 30, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE);

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE AS C CROSS JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A WHERE C.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(10,)
(20,)
(30,)
*/