-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 1000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 'C1', 'CS', 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 'C2', 'CS', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 'C3', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (4, 'C4', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (5, 'C5', 'CS', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (6, 'C6', 'CS', 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('CS', 21)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/