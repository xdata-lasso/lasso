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
-- Tests basic positive case, HAVING boundary conditions (SUM(salary) = 100, SUM(salary) = 101, MAX(salary) = 74, MAX(salary) = 75), and AND vs OR in HAVING.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1, 10, 1000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (2, 20, 2000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (3, 30, 3000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (4, 40, 4000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (101, 1, 1, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (102, 2, 2, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (103, 3, 3, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (104, 4, 4, 3);
-- Dept 1: SUM = 101 (> 100), MAX = 74 (< 75) -> Should be included
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (1, 1, 74, 1);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (2, 2, 27, 1);
-- Dept 2: SUM = 100 (fails > 100), MAX = 50 (< 75) -> Excluded
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (3, 3, 50, 2);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (4, 4, 50, 2);
-- Dept 3: SUM = 105 (> 100), MAX = 75 (fails < 75) -> Excluded
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (5, 5, 75, 3);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (6, 6, 30, 3);
-- Dept 4: SUM = 120 (> 100), MAX = 60 (< 75), MIN = 60 -> Included, distinguishes MAX vs MIN/AVG
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (7, 7, 60, 4);
INSERT INTO "instructor" ("ID", "name", "salary", "dept_name") VALUES (8, 8, 60, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) > 100 AND MAX(I.SALARY) < 75;

/*
Gold Result:
(1, 101)
(4, 120)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) >= 100 AND MAX(I.SALARY) < 75;

/*
Prediction Result:
(1, 101)
(2, 100)
(4, 120)
*/