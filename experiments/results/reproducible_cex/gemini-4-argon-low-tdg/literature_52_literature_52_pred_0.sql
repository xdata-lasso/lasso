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
-- Tests basic positive case: COUNT(D.BUDGET) = 11 (> 10) and SUM(D.BUDGET) = 110000 (> 100000).
-- Also tests SUM(DISTINCT D.BUDGET) vs SUM(D.BUDGET) since individual budget is 10000 (<= 100000).
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 10000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 1, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 2023, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 101, 2, 2023, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (3, 101, 3, 2023, 1, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (4, 101, 4, 2023, 1, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 101, 5, 2023, 1, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (6, 102, 1, 2023, 1, 6);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (7, 102, 2, 2023, 1, 7);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (8, 102, 3, 2023, 1, 8);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (9, 102, 4, 2023, 1, 9);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (10, 102, 5, 2023, 1, 10);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (11, 102, 6, 2023, 1, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(D.BUDGET) > 10;

/*
Gold Result:
(1, 110000)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(DISTINCT D.BUDGET) > 10;

/*
Prediction Result:
*/