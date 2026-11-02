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
INSERT INTO department (dept_name, building, budget) VALUES (1, 101, 1000);
INSERT INTO department (dept_name, building, budget) VALUES (2, 102, 2000);
INSERT INTO department (dept_name, building, budget) VALUES (3, 103, 3000);
INSERT INTO department (dept_name, building, budget) VALUES (4, 104, 4000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'CS', 1, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'CS', 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 'CS', 1, 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 'MATH', 1, 50);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'CS', 2, 20);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 'CS', 2, 20);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 'MATH', 2, 20);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 'BIO', 3, 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 'BIO', 3, 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 'CS', 4, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (402, 'BIO', 4, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (403, 'BIO', 4, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Prediction Result:
(1,)
(3,)
(3,)
*/