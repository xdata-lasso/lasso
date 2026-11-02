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
-- DATASET 4
INSERT INTO department (dept_name, building, budget) VALUES (10, 100, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (20, 200, 2024);
INSERT INTO department (dept_name, building, budget) VALUES (30, 300, 2020);
INSERT INTO department (dept_name, building, budget) VALUES (40, 400, 2016);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 101, 10, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 102, 20, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 103, 30, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (4, 104, 40, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (5, 105, 10, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 1, 2020, 1, 1000);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 1, 1, 2020, 2, 1000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) = 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) >= 2;

/*
Prediction Result:
(1, 9)
(2, 9)
*/