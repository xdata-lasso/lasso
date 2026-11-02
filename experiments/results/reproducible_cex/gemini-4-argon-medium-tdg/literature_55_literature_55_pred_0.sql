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
-- DATASET 4
-- Tests GROUP BY (ID, dept_name) vs GROUP BY (ID) vs GROUP BY (dept_name).
-- Case A: Two different students in the same department each take 1 course. (Kills GROUP BY dept_name only).
-- Case B: One student registered under two departments takes 1 course in each. (Kills GROUP BY ID only).
INSERT INTO department (dept_name, building, budget) VALUES (10, 100, 50000);
INSERT INTO department (dept_name, building, budget) VALUES (20, 200, 60000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 1, 10, 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 2, 20, 3);
-- Case A students (IDs 1 and 2 in dept 10)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 11, 10, 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (2, 22, 10, 30);
-- Case B student (ID 3 in both dept 10 and dept 20)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (3, 33, 10, 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (3, 33, 20, 30);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (201, 1, 2023, 200, 20, 2);
-- IDs 1 and 2 each take 1 course in dept 10 (total for dept 10 is 2, but per student is 1)
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 1, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (2, 101, 1, 2023, 4);
-- ID 3 takes 1 course in dept 10 and 1 course in dept 20 (total for ID 3 is 2, but per (ID, dept_name) is 1)
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 101, 1, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 201, 1, 2023, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID, DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(3,)
*/