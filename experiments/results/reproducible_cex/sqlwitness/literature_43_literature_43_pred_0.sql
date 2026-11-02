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
INSERT INTO teaches (id, course_id, sec_id, year, instructor) VALUES (4, NULL, 4, 3, 1), (NULL, 1, 3, 4, NULL), (0, 3, 1, NULL, 5), (4, 1, 5, 3, 4), (1, 3, 4, NULL, 3);
INSERT INTO instructor (id, name, salary, dept_name) VALUES (4, 'default2', 1, 'default2'), (5, 'default1', 0, 'default1'), (3, 'default1', 1, 'default2'), (1, 'default2', NULL, 'default2'), (4, 'default2', 5, NULL), (NULL, NULL, 4, 'default2'), (0, NULL, 0, NULL), (4, NULL, 0, NULL), (4, NULL, 4, 'default1'), (0, 'default1', 0, 'default2'), (NULL, NULL, 5, 'default2'), (5, NULL, 5, NULL);
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
(3,)
*/