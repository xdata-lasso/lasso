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
-- Tests standard join condition boundaries: INSTRUCTOR.ID > TEACHES.ID, INSTRUCTOR.ID = TEACHES.ID, and INSTRUCTOR.ID < TEACHES.ID.
-- Kills mutants altering '>' to '>=', '=', '<', '<=', or '!='.
-- Also tests LEFT OUTER JOIN preservation when no TEACHES row matches (ID=10) vs INNER JOIN, RIGHT JOIN, or FULL JOIN (TEACHES ID=30 is unmatched).
INSERT INTO department (dept_name, building, budget) VALUES (1, 100, 50000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 2, 1, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 3, 1, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2023, 100, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (103, 1, 2023, 100, 10, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (10, 111, 60000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (20, 222, 70000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (30, 333, 80000, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (10, 101, 1, 2023, 1, 10);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (20, 102, 1, 2023, 1, 20);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (30, 103, 1, 2023, 1, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR LEFT OUTER JOIN TEACHES ON INSTRUCTOR.ID > TEACHES.ID;

/*
Gold Result:
(10, 111, None)
(20, 222, 101)
(30, 333, 101)
(30, 333, 102)
*/

-- Prediction Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR CROSS JOIN TEACHES WHERE INSTRUCTOR.ID = TEACHES.ID;

/*
Prediction Result:
(10, 111, 101)
(20, 222, 102)
(30, 333, 103)
*/