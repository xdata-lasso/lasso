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
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1001, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 1002, 1, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 1003, 2, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (501, 9001, 75000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (502, 9002, 80000, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2010, 10, 100, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 2, 2010, 10, 101, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2009, 10, 102, 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 2, 2011, 10, 103, 4);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 1, 2010, 1, 801);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (501, 101, 2, 2010, 2, 802);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (502, 102, 1, 2009, 1, 803);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (502, 102, 2, 2011, 2, 804);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (701, 3001, 1, 30);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (701, 101, 1, 2010, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID = TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Gold Result:
(101, 1001, 501)
*/

-- Prediction Query
SELECT DISTINCT COURSE.COURSE_ID, COURSE.TITLE, TEACHES.ID FROM COURSE CROSS JOIN TEACHES WHERE COURSE.COURSE_ID >= TEACHES.COURSE_ID AND TEACHES.YEAR = 2010;

/*
Prediction Result:
(101, 1001, 501)
(102, 1002, 501)
(103, 1003, 501)
*/