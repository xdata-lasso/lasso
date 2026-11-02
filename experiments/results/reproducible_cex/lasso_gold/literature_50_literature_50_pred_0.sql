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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1001, 1007, 1013, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1004.0, 1012.0, 1013, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1007.0, 1017.0, 1013, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1010.0, 1022.0, 1013, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1013.0, 1027.0, 1013, 2);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1016.0, 1032.0, 1013, 2);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1013, 1014, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 5;

/*
Gold Result:
(1013, 12)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 8;

/*
Prediction Result:
*/