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
INSERT INTO "instructor" ("id", "name", "salary", "dept_name") VALUES (1001, 1002, 1003, 1004);
INSERT INTO "teaches" ("id", "course_id", "sec_id", "year", "semester", "instructor") VALUES (999, 1005, 1006, 1007, 1008, 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR LEFT OUTER JOIN TEACHES ON INSTRUCTOR.ID > TEACHES.ID;

/*
Gold Result:
(1001, 1002, 1005)
*/

-- Prediction Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR CROSS JOIN TEACHES WHERE INSTRUCTOR.ID = TEACHES.ID;

/*
Prediction Result:
*/