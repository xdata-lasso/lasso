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
INSERT INTO department (dept_name, building, budget) VALUES (10, 100, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 200, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 5001, 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 5002, 20, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 5001, 20, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 9001, 60000, 10);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 9002, 75000, 20);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1001, 8001, 10, 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1002, 8002, 20, 60);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (301, 1, 2022, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (301, 2, 2023, 100, 11, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 200, 20, 3);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 301, 1, 2022, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 301, 2, 2023, 2, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (2, 101, 1, 2023, 1, 2);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1001, 301, 1, 2022, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1002, 301, 2, 2023, 3);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1001, 101, 1, 2023, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COURSE_ID, TITLE FROM COURSE;

/*
Gold Result:
(301, 5001)
(101, 5002)
(201, 5001)
*/

-- Prediction Query
SELECT COURSE_ID, TITLE FROM COURSE WHERE CREDITS > 3;

/*
Prediction Result:
(101, 5002)
*/