-- Schema DDL
CREATE TABLE "course" ("course_id" INTEGER, "title" TEXT(255), "dept_name" TEXT(255), "credits" INTEGER);

CREATE TABLE "department" ("dept_name" TEXT(255), "building" INTEGER, "budget" INTEGER);

CREATE TABLE "instructor" ("ID" INTEGER, "name" TEXT(255), "salary" INTEGER, "dept_name" TEXT(255));

CREATE TABLE "teaches" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "instructor" INTEGER);

CREATE TABLE "section" ("course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "building" INTEGER, "room_number" INTEGER, "time_slot_id" INTEGER);

CREATE TABLE "takes" ("ID" INTEGER, "course_id" INTEGER, "sec_id" INTEGER, "year" INTEGER, "grade" INTEGER);

CREATE TABLE "student" ("ID" INTEGER, "name" TEXT(255), "dept_name" TEXT(255), "tot_cred" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests HAVING boundary (> 4 vs >= 4, > 3, = 5) and DISTINCT in outer query (student qualifying in multiple groups)
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 100, 50000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 'C1', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 'C2', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (3, 'C3', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (4, 'C4', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (5, 'C5', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (6, 'C6', 'CS', 3);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 'Alice', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (2, 'Bob', 'CS', 20);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (3, 'Charlie', 'CS', 40);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (1, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (2, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (3, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (4, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (5, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (6, 1, 2023, 100, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (1, 1, 2024, 100, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (2, 1, 2024, 100, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (3, 1, 2024, 100, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (4, 1, 2024, 100, 10, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (5, 1, 2024, 100, 10, 2);
-- Student 1 has 5 takes in (2023, ts 1) and 5 takes in (2024, ts 2) -> Tests DISTINCT
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 1, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 2, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 3, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 4, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 5, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 1, 1, 2024, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 2, 1, 2024, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 3, 1, 2024, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 4, 1, 2024, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 5, 1, 2024, 90);
-- Student 2 has exactly 4 takes in (2023, ts 1) -> Should NOT be included
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (2, 1, 1, 2023, 80);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (2, 2, 1, 2023, 80);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (2, 3, 1, 2023, 80);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (2, 4, 1, 2023, 80);
-- Student 3 has 6 takes in (2023, ts 1) -> Tests > 4 vs = 5
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 1, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 2, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 3, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 4, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 5, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (3, 6, 1, 2023, 85);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 4) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Gold Result:
(1, 'Alice')
(3, 'Charlie')
*/

-- Prediction Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 5) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Prediction Result:
(3, 'Charlie')
*/