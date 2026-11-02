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
INSERT INTO department (dept_name, building, budget) VALUES ('A', 1, 100);
INSERT INTO department (dept_name, building, budget) VALUES ('B', 1, 100);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (10, 'C1', 'A', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (20, 'C2', 'B', 3);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 'S1', 'A', 10);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (1, 'S1', 'B', 10);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (10, 1, 2020, 1, 101, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (20, 1, 2020, 1, 101, 1);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 10, 1, 2020, 1);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (1, 20, 1, 2020, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(1,)
*/