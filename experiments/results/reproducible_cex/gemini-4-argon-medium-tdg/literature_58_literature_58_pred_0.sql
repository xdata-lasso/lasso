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
-- DATASET 1
-- Tests: COUNT(ID) vs COUNT(DISTINCT ID), HAVING boundary (> 4 vs >= 4 vs = 4 vs > 5), outer SUM(T) vs AVG(T)/MAX(T), and outer GROUP BY T.
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 1000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 3, 1, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 100, 50000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 101, 50000, 1);
-- Group (year=2020, course_id=101): 5 rows, 1 distinct ID. (Count = 5 > 4)
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 2, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 3, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 4, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 5, 2020, 1, 1);
-- Group (year=2020, course_id=102): 6 rows, 1 distinct ID. (Count = 6 > 4)
-- Combined with course 101, year 2020 appears twice in TEMP, so outer SUM(T) = 4040.
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 1, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 2, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 3, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 4, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 5, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 6, 2020, 1, 2);
-- Group (year=2021, course_id=103): 4 rows (Boundary test for HAVING > 4 vs >= 4).
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 103, 1, 2021, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 103, 2, 2021, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 103, 3, 2021, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 103, 4, 2021, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(4040,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(2020,)
*/