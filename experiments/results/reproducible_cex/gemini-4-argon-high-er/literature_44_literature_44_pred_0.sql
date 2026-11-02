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
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 1, 10000);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 'Alice', 'CS', 30);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro to CS', 'CS', 4);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 2, 2023, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 3, 2023, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 4, 2023, 1, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 5, 2023, 1, 10, 1);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 1, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 2, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 3, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 4, 2023, 4);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 101, 5, 2023, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 4) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Gold Result:
(1, 'Alice')
*/

-- Prediction Query
WITH S AS (SELECT ID, TIME_SLOT_ID, YEAR FROM TAKES NATURAL JOIN SECTION GROUP BY ID, TIME_SLOT_ID, YEAR HAVING COUNT(TIME_SLOT_ID) > 5) SELECT DISTINCT ID, NAME FROM S NATURAL JOIN STUDENT;

/*
Prediction Result:
*/