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
INSERT INTO department (dept_name, building, budget) VALUES (101, 1, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (102, 2, 60000);
INSERT INTO department (dept_name, building, budget) VALUES (103, 3, 70000);
INSERT INTO department (dept_name, building, budget) VALUES (104, 4, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 1001, 101, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 1002, 101, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 1003, 101, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (4, 1004, 101, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (5, 1005, 101, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (6, 1006, 101, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (7, 1007, 102, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (8, 1008, 102, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (9, 1009, 102, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (10, 1010, 102, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (11, 1011, 102, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (12, 1012, 102, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (13, 1013, 103, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (14, 1014, 103, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (15, 1015, 103, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (16, 1016, 103, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (17, 1017, 103, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (18, 1018, 104, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (19, 1019, 104, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (20, 1020, 104, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (21, 1021, 104, 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (22, 1022, 104, 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (23, 1023, 104, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 5;

/*
Gold Result:
(101, 11)
(104, 21)
*/

-- Prediction Query
SELECT C.DEPT_NAME, SUM(C.CREDITS) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING SUM(C.CREDITS) > 10 AND COUNT(C.CREDITS) > 8;

/*
Prediction Result:
*/