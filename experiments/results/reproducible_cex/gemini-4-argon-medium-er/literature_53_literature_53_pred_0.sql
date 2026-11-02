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
INSERT INTO department (dept_name, building, budget) VALUES (1, 1, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 1, 1, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 1, 1, 2023, 1, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 1, 60000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 2, 70000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 3, 80000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 4, 90000, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
(1, 75000.0)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
*/