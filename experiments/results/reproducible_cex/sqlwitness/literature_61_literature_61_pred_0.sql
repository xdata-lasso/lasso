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
INSERT INTO teaches (id, course_id, sec_id, year, semester, instructor) VALUES (1, 1, NULL, NULL, 0, NULL), (NULL, NULL, 1, 0, 0, 0);
INSERT INTO instructor (id, name, salary, dept_name) VALUES (0, 1, 1, 0), (0, 1, 0, 0), (0, 0, 0, NULL), (NULL, NULL, NULL, NULL), (1, 0, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR LEFT OUTER JOIN TEACHES ON INSTRUCTOR.ID > TEACHES.ID;

/*
Gold Result:
(0, 1, None)
(0, 0, None)
(None, None, None)
(1, 0, None)
*/

-- Prediction Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR CROSS JOIN TEACHES WHERE INSTRUCTOR.ID = TEACHES.ID;

/*
Prediction Result:
(1, 0, 1)
*/