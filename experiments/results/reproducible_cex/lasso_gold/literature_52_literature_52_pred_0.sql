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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1001, 1002, 1003, 1004);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1005, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1010.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1015.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1020.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1025.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1030.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1035.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1040.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1045.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1050.0, 9091);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1003, 1055.0, 9091);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1016, 1001, 1017, 1018, 1019, 1020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(D.BUDGET) > 10;

/*
Gold Result:
(1003, 100001)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(D.BUDGET) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) GROUP BY C.DEPT_NAME HAVING SUM(D.BUDGET) > 100000 AND COUNT(DISTINCT D.BUDGET) > 10;

/*
Prediction Result:
*/