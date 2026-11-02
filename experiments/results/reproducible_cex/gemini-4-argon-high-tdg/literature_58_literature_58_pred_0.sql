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
-- DATASET 2
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1001, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 1002, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 1003, 1, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 101, 50000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 102, 55000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 103, 60000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 104, 65000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 105, 70000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 106, 75000, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2020, 10, 201, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2020, 10, 202, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 1, 2021, 10, 203, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 2020, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 101, 1, 2020, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (3, 101, 1, 2020, 1, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (4, 101, 1, 2020, 1, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 101, 1, 2020, 1, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 102, 1, 2020, 2, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 102, 1, 2020, 2, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (3, 102, 1, 2020, 2, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (4, 102, 1, 2020, 2, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 102, 1, 2020, 2, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (6, 102, 1, 2020, 2, 6);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 103, 1, 2021, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 103, 1, 2021, 1, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (3, 103, 1, 2021, 1, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (4, 103, 1, 2021, 1, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 103, 1, 2021, 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR, COURSE_ID HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Gold Result:
(4040,)
(2021,)
*/

-- Prediction Query
SELECT SUM(T) AS SU FROM (SELECT YEAR AS T FROM TEACHES NATURAL JOIN INSTRUCTOR GROUP BY YEAR HAVING COUNT(ID) > 4) AS TEMP GROUP BY T;

/*
Prediction Result:
(2020,)
(2021,)
*/