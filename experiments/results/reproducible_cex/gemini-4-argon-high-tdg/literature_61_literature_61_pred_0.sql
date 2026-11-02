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
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 60000);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 70000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (501, 1001, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (502, 1002, 2, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (503, 1003, 3, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (501, 1, 2021, 10, 101, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (502, 2, 2022, 20, 202, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (503, 3, 2023, 30, 303, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (10, 101, 5000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (20, 102, 6000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (30, 103, 7000, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (10, 501, 1, 2021, 1, 91);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (20, 502, 2, 2022, 2, 92);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (30, 503, 3, 2023, 3, 93);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR LEFT OUTER JOIN TEACHES ON INSTRUCTOR.ID > TEACHES.ID;

/*
Gold Result:
(10, 101, None)
(20, 102, 501)
(30, 103, 501)
(30, 103, 502)
*/

-- Prediction Query
SELECT DISTINCT INSTRUCTOR.ID, INSTRUCTOR.NAME, TEACHES.COURSE_ID FROM INSTRUCTOR CROSS JOIN TEACHES WHERE INSTRUCTOR.ID = TEACHES.ID;

/*
Prediction Result:
(10, 101, 501)
(20, 102, 502)
(30, 103, 503)
*/