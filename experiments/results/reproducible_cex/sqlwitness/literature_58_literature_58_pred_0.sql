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
INSERT INTO teaches (id, course_id, sec_id, year, semester, instructor) VALUES (5, 5, 5, 4, 4, 0), (3, 3, 0, 4, 3, NULL), (5, 0, 1, 4, NULL, 3), (3, NULL, NULL, 0, 4, 5), (5, 5, 3, NULL, 4, 4);
INSERT INTO instructor (id, name, salary, dept_name) VALUES (0, 5, NULL, NULL), (3, 1, 1, 3), (4, 5, 1, 3), (5, NULL, NULL, 4), (NULL, NULL, NULL, NULL), (0, 3, 5, NULL), (0, 1, 0, 0), (NULL, 0, 3, NULL), (1, 1, 5, 1), (3, 4, 3, NULL), (4, 5, NULL, 1), (5, 4, 5, 1), (4, 1, 5, NULL), (0, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(4,)
*/