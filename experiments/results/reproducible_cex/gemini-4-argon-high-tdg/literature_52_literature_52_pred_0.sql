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
INSERT INTO department (dept_name, building, budget) VALUES (10, 1, 10000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 2, 15000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1001, 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 2001, 20, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 2002, 20, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (203, 2003, 20, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 1, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 2, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 3, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 4, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 5, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 6, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 7, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 8, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 9, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 10, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 11, 2020, 1, 501);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (502, 201, 1, 2021, 2, 502);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (503, 201, 2, 2021, 2, 503);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (504, 201, 3, 2021, 2, 504);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (505, 201, 4, 2021, 2, 505);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (506, 202, 1, 2021, 2, 506);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (507, 202, 2, 2021, 2, 507);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (508, 202, 3, 2021, 2, 508);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (509, 202, 4, 2021, 2, 509);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (510, 203, 1, 2021, 2, 510);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (511, 203, 2, 2021, 2, 511);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (512, 203, 3, 2021, 2, 512);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (513, 203, 4, 2021, 2, 513);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(D.BUDGET) > 10;

/*
Gold Result:
(10, 110000)
(20, 180000)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(DISTINCT D.BUDGET) > 10;

/*
Prediction Result:
*/