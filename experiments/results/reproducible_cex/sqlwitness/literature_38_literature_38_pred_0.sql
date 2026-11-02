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
INSERT INTO department (dept_name, building, budget) VALUES (NULL, 10, 4), ('default2', 1, 1), ('default1', 9, 5), ('default1', 11, 10), ('default2', NULL, 4), (NULL, 7, 4), ('default1', 9, 4), (NULL, 7, 10), ('default2', 9, 4), (NULL, 7, 7), ('default1', 8, 6), ('default1', 9, 8), (NULL, 9, 5), (NULL, 6, 1), ('default2', 9, 10), ('default1', 9, 8), (NULL, 5, 10), ('default2', 8, 1), ('default1', 0, 10), ('default1', 7, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (NULL, 'default1', 'default1', 0), (11, 'default2', 'default1', 11), (NULL, 'default2', 'default2', 4), (9, 'default2', 'default1', 5), (7, 'default2', 'default2', 1), (4, NULL, 'default1', 0), (11, 'default1', 'default1', 11), (1, 'default1', 'default2', 11), (0, 'default2', 'default2', 9), (0, 'default2', 'default2', 8), (8, 'default2', 'default2', 1), (6, NULL, 'default1', 5), (11, 'default2', 'default2', 6), (9, 'default1', 'default1', NULL), (8, 'default1', 'default1', 5), (4, 'default1', 'default2', 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 5;

/*
Gold Result:
('default2', 255)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(DISTINCT C.CREDITS) > 8;

/*
Prediction Result:
*/