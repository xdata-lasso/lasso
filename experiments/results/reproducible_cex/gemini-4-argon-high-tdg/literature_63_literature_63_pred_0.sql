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
INSERT INTO department (dept_name, building, budget) VALUES (10, 1001, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 1002, 60000);
INSERT INTO department (dept_name, building, budget) VALUES (30, 1003, 95000);
INSERT INTO department (dept_name, building, budget) VALUES (40, 1004, 40000);
INSERT INTO department (dept_name, building, budget) VALUES (50, 1005, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 201, 10, 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 202, 10, 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (103, 203, 10, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (104, 204, 20, 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (105, 205, 30, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (106, 206, 30, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (107, 207, 30, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (108, 208, 30, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (109, 209, 40, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (301, 401, 70000, 10);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (302, 402, 99000, 40);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (501, 601, 10, 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (502, 602, 30, 120);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 1001, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (105, 1, 2023, 1003, 20, 2);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (301, 101, 1, 2023, 1, 301);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (302, 105, 1, 2023, 1, 302);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (501, 101, 1, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (502, 105, 1, 2023, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE WHERE CREDITS = (SELECT MAX(CREDITS) FROM COURSE);

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE AS C CROSS JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A WHERE C.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
(10,)
(20,)
(30,)
(40,)
*/