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
-- DATASET 5
-- Tests GROUP BY ID, DEPT_NAME vs GROUP BY ID, and tests duplicate ID output when a student belongs to two departments.
-- Also kills mutants that use COUNT(DISTINCT dept_name) or COUNT(DISTINCT course_id).
INSERT INTO department (dept_name, building, budget) VALUES (10, 100, 10000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 200, 20000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 101, 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 102, 20, 3);
-- Course 1 has two sections in different years
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (1, 1, 2020, 100, 101, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (1, 1, 2021, 100, 101, 2);
-- Course 2 has one section
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (2, 1, 2020, 200, 101, 1);
-- Student 5001 takes the SAME course (course_id=1) twice in different years.
-- Count is 2, but COUNT(DISTINCT course_id) is 1, and COUNT(DISTINCT dept_name) is 1.
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (5001, 1, 10, 30);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (5001, 1, 1, 2020, 70);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (5001, 1, 1, 2021, 85);
-- Student 5002 has two records in STUDENT (dual major in dept 10 and dept 20), taking 1 course in each.
-- Grouping by (ID, DEPT_NAME) yields count=1 for each group (excluded). Grouping only by ID yields count=2 (falsely included).
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (5002, 2, 10, 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (5002, 2, 20, 30);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (5002, 1, 1, 2020, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (5002, 2, 1, 2020, 90);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID, DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(5001,)
*/

-- Prediction Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(5001,)
(5002,)
*/