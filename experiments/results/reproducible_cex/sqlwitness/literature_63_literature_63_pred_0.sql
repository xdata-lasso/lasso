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
INSERT INTO course (course_id, title, dept_name, credits) VALUES (NULL, 1, 1, 0), (0, NULL, 1, 0), (NULL, 1, 1, 1), (NULL, 1, NULL, NULL), (0, NULL, 0, 0), (NULL, NULL, 1, 1), (1, 0, NULL, 1), (1, 1, 0, NULL), (1, 1, NULL, NULL), (0, 1, 1, NULL), (1, 0, 1, NULL), (1, NULL, 0, 0), (NULL, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE);

/*
Gold Result:
(1,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE AS C CROSS JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A WHERE C.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(1,)
(0,)
(None,)
*/