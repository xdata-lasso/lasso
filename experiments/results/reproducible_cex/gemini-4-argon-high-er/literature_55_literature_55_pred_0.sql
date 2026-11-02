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
INSERT INTO department (dept_name, building, budget) VALUES (1, 1, 1);
INSERT INTO department (dept_name, building, budget) VALUES (2, 2, 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (1, 1, 1, 1);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (2, 2, 2, 2);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 1, 1, 1);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 1, 2, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (1, 1, 1, 1, 1, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (2, 2, 2, 2, 2, 2);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 1, 1, 1, 1);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 2, 2, 2, 2);
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
(1,)
*/