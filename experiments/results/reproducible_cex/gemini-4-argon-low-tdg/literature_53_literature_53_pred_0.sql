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
-- Tests HAVING boundaries, DISTINCT vs non-DISTINCT count, and AVG(salary) vs AVG(DISTINCT salary)
INSERT INTO department (dept_name, building, budget) VALUES (1, 1, 100);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 2020, 1, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 1, 40000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 2, 50000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 3, 60000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 4, 70000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 5, 40000, 1);
INSERT INTO department (dept_name, building, budget) VALUES (2, 1, 100);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 1, 2, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (6, 201, 1, 2020, 1, 6);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 6, 35000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (7, 7, 45000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (8, 8, 55000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (9, 9, 65000, 2);
INSERT INTO department (dept_name, building, budget) VALUES (3, 1, 100);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 1, 3, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (10, 301, 1, 2020, 1, 10);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (10, 10, 60000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (11, 11, 70000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (12, 12, 80000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (13, 13, 80000, 3);
INSERT INTO department (dept_name, building, budget) VALUES (4, 1, 100);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 1, 4, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (14, 401, 1, 2020, 1, 14);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (14, 14, 60000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (15, 15, 70000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (16, 16, 80000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (17, 17, 90000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (18, 18, 100000, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
(1, 52000.0)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
(4, 80000.0)
*/