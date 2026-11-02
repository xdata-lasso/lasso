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
INSERT INTO department (dept_name, building, budget) VALUES (1, 10, 100000);
INSERT INTO department (dept_name, building, budget) VALUES (2, 20, 100000);
INSERT INTO department (dept_name, building, budget) VALUES (3, 30, 100000);
INSERT INTO department (dept_name, building, budget) VALUES (4, 40, 100000);
INSERT INTO department (dept_name, building, budget) VALUES (5, 50, 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 1, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 2, 2, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (301, 3, 3, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (401, 4, 4, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (501, 5, 5, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (1, 101, 50000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (2, 102, 60000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (3, 103, 70000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (4, 104, 80000, 1);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (5, 201, 35000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (6, 202, 45000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (7, 203, 55000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (8, 204, 65000, 2);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (9, 301, 20000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (10, 302, 30000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (11, 303, 40000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (12, 304, 50000, 3);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (13, 401, 60000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (14, 402, 70000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (15, 403, 80000, 4);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (16, 501, 60000, 5);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (17, 502, 70000, 5);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (18, 503, 80000, 5);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (19, 504, 90000, 5);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (20, 505, 100000, 5);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 10, 1, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (201, 1, 2023, 20, 1, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (301, 1, 2023, 30, 1, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (401, 1, 2023, 40, 1, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (501, 1, 2023, 50, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (1, 101, 1, 2023, 1, 1);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (5, 201, 1, 2023, 1, 5);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (9, 301, 1, 2023, 1, 9);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (13, 401, 1, 2023, 1, 13);
INSERT INTO teaches (ID, course_id, sec_id, year, semester, instructor) VALUES (16, 501, 1, 2023, 1, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) = 4;

/*
Gold Result:
(1, 65000.0)
*/

-- Prediction Query
SELECT C.DEPT_NAME, AVG(I.SALARY) FROM COURSE AS C INNER JOIN DEPARTMENT AS D ON (C.DEPT_NAME = D.DEPT_NAME) INNER JOIN TEACHES AS T ON (C.COURSE_ID = T.COURSE_ID) INNER JOIN INSTRUCTOR AS I ON (D.DEPT_NAME = I.DEPT_NAME) GROUP BY C.DEPT_NAME HAVING AVG(I.SALARY) > 50000 AND COUNT(DISTINCT I.SALARY) > 4;

/*
Prediction Result:
(5, 80000.0)
*/