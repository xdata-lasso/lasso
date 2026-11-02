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
INSERT INTO department (dept_name, building, budget) VALUES (9, 1, 10), (0, 1, 9), (4, 8, 5), (10, 11, 7), (8, NULL, 9), (0, 1, 8), (0, 11, 5), (11, 9, 0);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (9, 1, 0, 9), (9, 5, 7, 0), (4, 0, 10, NULL), (8, 1, 10, 1), (5, 1, 6, 7), (9, 9, 10, 9), (4, 4, 5, NULL), (4, 10, 10, 7), (6, 1, 0, 0), (6, 0, 8, 4), (5, 10, 8, 9), (10, 10, 7, 10), (0, 11, 10, 9), (6, 10, 6, 4), (11, 6, 6, 10), (NULL, 11, 9, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 5;

/*
Gold Result:
(0, 27)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 8;

/*
Prediction Result:
*/