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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1027, 1029, 1031, 1);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1027, 1029, 1031, 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1027, 1029, 1031, 5);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1031, 1033, 0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (1038.0, 1038.0, 0);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (1035, 1036, 1037, -4, 1038, 1039);
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
(1038, 9)
*/