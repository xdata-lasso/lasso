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
INSERT INTO teaches (id, course_id, sec_id, year, semester, instructor) VALUES (9, 0, 100001, NULL, 100000, 0), (10, 10, 9, 11, 11, 11), (100000, 100000, 100001, 99999, 10, 9), (11, 10, 1, 100000, 99999, 100000), (10, NULL, 9, 1, NULL, NULL), (11, NULL, 100000, 1, 100000, 1), (0, 10, 1, 100000, 100001, 9), (100000, 100001, 100001, 100001, 99999, NULL), (NULL, 1, 9, 0, 99999, 9), (100000, NULL, 0, 1, 0, NULL), (10, 10, 11, 9, 99999, 1), (100000, 99999, NULL, 10, NULL, 1), (11, 11, 100000, 11, NULL, NULL), (10, 100001, 0, 1, 0, 1), (100000, NULL, 99999, 99999, 10, 100001), (10, 0, 10, 1, 99999, NULL), (9, 100000, 10, NULL, 9, 100000);
INSERT INTO department (dept_name, building, budget) VALUES (10, 11, 99999), (1, 9, 100000), (10, 10, 1), (10, 100000, 100001), (NULL, 0, 11), (100001, NULL, 1), (9, 0, NULL), (100000, 10, 100000), (100000, 11, 0), (NULL, 0, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (0, 11, 11, 9), (0, 100001, 11, 0), (9, 100001, 0, NULL), (100000, NULL, 10, 1), (11, 9, 1, 9), (10, 1, 9, 100000), (100001, 0, 99999, 9), (100001, 100001, 99999, 100000), (1, 10, 100000, 100000), (NULL, 99999, NULL, 0), (0, 11, 1, 9), (11, NULL, 9, 10), (100000, 100000, 100000, 0), (99999, 11, 1, 99999), (100000, 100001, 11, NULL), (9, 100000, NULL, 0), (100001, 0, 10, 100000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(D.BUDGET) > 10;

/*
Gold Result:
(10, 800004)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(DISTINCT D.BUDGET) > 10;

/*
Prediction Result:
*/