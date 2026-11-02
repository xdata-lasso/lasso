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
-- 1. Missing DISTINCT (Dept 10 has two courses tied for max credits).
-- 2. ORDER BY CREDITS DESC LIMIT 1 instead of MAX() (Both Dept 10 and Dept 20 have max credits).
-- 3. GROUP BY DEPT_NAME HAVING SUM(CREDITS) / COUNT(*) (Dept 30 has highest sum and count of credits, but not the max single course credit).
-- 4. Unnecessary JOIN with department (Dept 20 is in course table with max credits, but missing from department table).
-- 5. Querying wrong table like department or instructor (Dept 40 is in department/instructor with high values, but has no courses).
INSERT INTO department (dept_name, building, budget) VALUES (10, 1, 1000);
INSERT INTO department (dept_name, building, budget) VALUES (30, 2, 5000);
INSERT INTO department (dept_name, building, budget) VALUES (40, 3, 9999);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 10, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 10, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 3, 20, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 4, 30, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 5, 30, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 6, 30, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 1, 9999, 40);
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