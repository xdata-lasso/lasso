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
-- Tests basic column projection, distinct column values (course_id != title != dept_name != credits),
-- multiple rows (to catch LIMIT 1 or aggregations), and unreferenced courses (to catch inner joins with section/teaches/takes).
INSERT INTO department (dept_name, building, budget) VALUES (10, 100, 50000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 201, 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 202, 10, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COURSE_ID, TITLE FROM COURSE;

/*
Gold Result:
(101, 201)
(102, 202)
*/

-- Prediction Query
SELECT COURSE_ID, TITLE FROM COURSE WHERE CREDITS > 3;

/*
Prediction Result:
(102, 202)
*/