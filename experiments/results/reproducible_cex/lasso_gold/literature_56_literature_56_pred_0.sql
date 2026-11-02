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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1124, 'CS', 1127, 1128);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1127.0, 'CS', 1127, 1137.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1130.0, 'CS', 1127, 1146.0);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1133, 'CS', 1127, 1146.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1127, 1131, 1132);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1127, 1134, 1132);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Gold Result:
(1127,)
*/

-- Prediction Query
SELECT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE NATURAL JOIN DEPARTMENT WHERE TITLE = 'CS' GROUP BY DEPT_NAME HAVING COUNT(COURSE_ID) > 2);

/*
Prediction Result:
(1127,)
(1127,)
*/