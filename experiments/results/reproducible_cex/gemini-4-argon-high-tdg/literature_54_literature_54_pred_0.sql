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
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 104);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 105);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 106);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 107);
INSERT INTO department (dept_name, building, budget) VALUES (5, 50, 108);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 1, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 3, 2, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (202, 4, 2, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 5, 3, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (302, 6, 3, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 7, 4, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (501, 8, 5, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (502, 9, 5, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (503, 10, 5, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 100, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 201, 1, 101, 2, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (3, 301, 1, 102, 3, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (4, 401, 1, 103, 4, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 501, 1, 104, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) = 2;

/*
Gold Result:
(1, 7)
*/

-- Prediction Query
SELECT T.SEMESTER, SUM(C.CREDITS) FROM DEPARTMENT AS D INNER JOIN TEACHES AS T ON (D.BUDGET = T.YEAR + 4) INNER JOIN COURSE AS C ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY T.SEMESTER HAVING AVG(C.CREDITS) > 2 AND COUNT(D.BUILDING) >= 2;

/*
Prediction Result:
(1, 7)
(5, 12)
*/