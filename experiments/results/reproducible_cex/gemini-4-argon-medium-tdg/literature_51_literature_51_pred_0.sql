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
-- Tests basic functionality, HAVING boundary conditions (SUM(I.SALARY) = 100, MAX(I.SALARY) = 75), and AND vs OR in HAVING.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1, 10, 1000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (2, 20, 2000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (3, 30, 3000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (4, 40, 4000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (101, 1001, 1, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (201, 2001, 2, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (301, 3001, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (401, 4001, 4, 3);
-- Dept 1: SUM = 101 (> 100), MAX = 74 (< 75) -> Passes
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (11, 111, 74, 1);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (12, 112, 27, 1);
-- Dept 2: SUM = 100 (Boundary fail for > 100), MAX = 60 (< 75) -> Fails
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (21, 211, 60, 2);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (22, 212, 40, 2);
-- Dept 3: SUM = 105 (> 100), MAX = 75 (Boundary fail for < 75) -> Fails
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (31, 311, 75, 3);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (32, 312, 30, 3);
-- Dept 4: SUM = 120 (> 100), MAX = 80 (Fails < 75) -> Fails
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (41, 411, 80, 4);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (42, 412, 40, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) > 100 AND MAX(I.SALARY) < 75;

/*
Gold Result:
(1, 101)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) >= 100 AND MAX(I.SALARY) < 75;

/*
Prediction Result:
(1, 101)
(2, 100)
*/