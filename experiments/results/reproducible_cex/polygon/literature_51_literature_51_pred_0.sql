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
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (29, 30, 44, 31);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (44, 44, NULL, 44);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (63, 64, 41, 65);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (44, NULL, NULL);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (41, 66, 67);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES (44, NULL, NULL);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (NULL, NULL, 100, 41);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (42, 43, NULL, 41);
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (NULL, NULL, 50, 44);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "section" ("course_id", "sec_id", "year", "building", "room_number", "time_slot_id") VALUES (44, 44, 44, 44, 44, 44);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (44, 44, 44, 44, 44);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (44, 44, 44, 44, 44);
INSERT INTO "takes" ("id", "course_id", "sec_id", "year", "grade") VALUES (44, 44, 44, 44, 44);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (44, 44, 44, 44);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (44, 44, 44, 44);
INSERT INTO "student" ("id", "name", "dept_name", "tot_cred") VALUES (44, 44, 44, 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) > 100 AND MAX(I.SALARY) < 75;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(I.SALARY) >= 100 AND MAX(I.SALARY) < 75;

/*
Prediction Result:
(44, 100)
*/