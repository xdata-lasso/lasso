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
-- Tests basic positive case, COUNT boundary (exactly 5 vs 6), and SUM boundary (exactly 10 vs 11).
INSERT INTO department (dept_name, building, budget) VALUES (1, 100, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (2, 200, 60000);
INSERT INTO department (dept_name, building, budget) VALUES (3, 300, 70000);
-- Dept 1: COUNT(credits) = 6 (> 5), SUM(credits) = 18 (> 10). Should be included.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 3, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 4, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 5, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 6, 1, 3);
-- Dept 2: COUNT(credits) = 5 (fails > 5, tests >= 5 mutant), SUM(credits) = 15 (> 10). Should be excluded.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 1, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 2, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 3, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (204, 4, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (205, 5, 2, 3);
-- Dept 3: COUNT(credits) = 6 (> 5), SUM(credits) = 10 (fails > 10, tests >= 10 mutant). Should be excluded.
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 1, 3, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 2, 3, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (303, 3, 3, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (304, 4, 3, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (305, 5, 3, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (306, 6, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 5;

/*
Gold Result:
(1, 18)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 8;

/*
Prediction Result:
*/