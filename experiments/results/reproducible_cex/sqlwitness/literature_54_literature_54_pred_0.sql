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
INSERT INTO teaches (id, course_id, sec_id, year, semester, instructor) VALUES (5, NULL, 4, 4, NULL, 2), (4, 3, 2, 1, NULL, 1), (5, 2, NULL, 4, 1, 3), (1, 0, 2, 5, 0, 2), (5, 0, NULL, 2, 2, 2);
INSERT INTO department (dept_name, building, budget) VALUES (5, 5, 5), (2, 1, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 2, 2, 1), (5, 1, 5, 4), (3, 4, 3, 2), (2, 0, 4, 1), (4, 4, 4, 5), (NULL, 4, 2, 1), (0, 2, 5, 4);
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
(None, 10)
*/