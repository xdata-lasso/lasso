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
INSERT INTO department (dept_name, building, budget) VALUES (1, 100, 1000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 'CS', 1, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 'CS', 1, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 'CS', 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Prediction Result:
(1,)
(1,)
(1,)
*/