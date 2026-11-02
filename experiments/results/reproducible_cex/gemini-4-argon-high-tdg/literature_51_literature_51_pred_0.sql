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
-- DATASET 2
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 1000);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 2000);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 3000);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 4000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 501, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 502, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 503, 3, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 504, 4, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (11, 601, 50, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (12, 602, 50, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (21, 603, 50, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (22, 604, 51, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (31, 605, 75, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (32, 606, 40, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (41, 607, 74, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (42, 608, 40, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) > 100 AND MAX(I.SALARY) < 75;

/*
Gold Result:
(2, 101)
(4, 114)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) >= 100 AND MAX(I.SALARY) < 75;

/*
Prediction Result:
(1, 100)
(2, 101)
(4, 114)
*/