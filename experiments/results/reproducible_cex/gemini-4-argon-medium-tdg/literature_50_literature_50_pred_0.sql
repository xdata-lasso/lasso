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
-- Tests standard valid groups, boundary conditions (SUM=10, SUM=11, COUNT=5, COUNT=6), AND vs OR in HAVING, and DISTINCT in aggregates.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1, 10, 100);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (2, 20, 200);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (3, 30, 300);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (4, 40, 400);
-- Dept 1: COUNT(credits) = 6, SUM(credits) = 12 (Valid, duplicate credit values to kill DISTINCT mutants)
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (101, 1, 1, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (102, 2, 1, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (103, 3, 1, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (104, 4, 1, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (105, 5, 1, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (106, 6, 1, 2);
-- Dept 2: COUNT(credits) = 6, SUM(credits) = 10 (Fails SUM > 10 boundary, kills >= 10 and OR mutants)
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (201, 1, 2, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (202, 2, 2, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (203, 3, 2, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (204, 4, 2, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (205, 5, 2, 1);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (206, 6, 2, 1);
-- Dept 3: COUNT(credits) = 5, SUM(credits) = 15 (Fails COUNT > 5 boundary, kills >= 5 and OR mutants)
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (301, 1, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (302, 2, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (303, 3, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (304, 4, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (305, 5, 3, 3);
-- Dept 4: COUNT(credits) = 6, SUM(credits) = 11 (Exact boundary pass for both > 10 and > 5, all distinct credits)
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (401, 1, 4, 0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (402, 2, 4, 1);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (403, 3, 4, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (404, 4, 4, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (405, 5, 4, 4);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (406, 6, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 5;

/*
Gold Result:
(1, 12)
(4, 11)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 8;

/*
Prediction Result:
*/