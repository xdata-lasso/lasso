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
INSERT INTO department (dept_name, building, budget) VALUES (1, 1, 10000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 1, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 1, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 2, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 3, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 4, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 5, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 6, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 7, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 8, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 9, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 10, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 11, 2020, 1, 1);
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