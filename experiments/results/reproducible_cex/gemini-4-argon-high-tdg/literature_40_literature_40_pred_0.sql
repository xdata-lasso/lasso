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
-- DATASET 8
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 501, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 502, 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (101, 'Intro to CS', 'CS', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (102, 'Compilers', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (201, 'Algebra', 'Math', 3);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (101, 1, 2023, 501, 10, 1);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (102, 1, 2023, 501, 11, 2);
INSERT INTO section (course_id, sec_id, year, building, room_number, time_slot_id) VALUES (201, 1, 2023, 502, 20, 3);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (70, 'Olivia', 'CS', 60);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (70, 'Olivia', 'Math', 60);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES (71, 'Paul', 'CS', 45);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (70, 101, 1, 2023, 90);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (70, 201, 1, 2023, 92);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (71, 101, 1, 2023, 85);
INSERT INTO takes (ID, course_id, sec_id, year, grade) VALUES (71, 102, 1, 2023, 87);
INSERT INTO instructor (ID, name, salary, dept_name) VALUES (80, 'Prof Smith', 95000, 'CS');
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (80, 101, 1, 2023, 80);
INSERT INTO teaches (ID, course_id, sec_id, year, instructor) VALUES (80, 102, 1, 2023, 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID, STUDENT.DEPT_NAME HAVING COUNT(DEPT_NAME) >= 2;

/*
Gold Result:
(71,)
*/

-- Prediction Query
SELECT STUDENT.ID FROM COURSE NATURAL JOIN DEPARTMENT NATURAL JOIN STUDENT NATURAL JOIN TAKES NATURAL JOIN SECTION GROUP BY STUDENT.ID HAVING COUNT(DEPT_NAME) >= 2;

/*
Prediction Result:
(70,)
(71,)
*/