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
-- Tests:
-- 1. DISTINCT on outer SELECT (multiple courses in dept 10 have credits = 4).
-- 2. MAX(CREDITS) vs MIN/AVG/SUM/COUNT (dept 10 has credits 2, 3, 4; max is 4).
-- 3. HAVING COUNT(COURSE_ID) > 2 vs >= 2 (dept 20 has exactly 2 'CS' courses with higher credits 5).
-- 4. WHERE TITLE = 'CS' filter inside subquery (dept 10 has a non-'CS' course with credits 6; dept 20 has a non-'CS' course that would bring its total count to 3 if unfiltered).
-- 5. Outer query matching a department not qualifying in the subquery (dept 30 has a course with credits = 4).
-- 6. Outer query filtering (dept 40 has credits 3, should not be in result).
INSERT INTO department (dept_name, building, budget) VALUES (10, 1, 1000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 2, 2000);
INSERT INTO department (dept_name, building, budget) VALUES (30, 3, 3000);
INSERT INTO department (dept_name, building, budget) VALUES (40, 4, 4000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'CS', 10, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'CS', 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'CS', 10, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'Math', 10, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 'Math', 10, 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'CS', 20, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'CS', 20, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'Math', 20, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'Bio', 30, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 'Chem', 40, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Prediction Result:
(10,)
(10,)
(30,)
*/