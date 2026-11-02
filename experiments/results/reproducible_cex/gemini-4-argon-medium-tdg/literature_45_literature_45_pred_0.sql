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
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 101, 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 102, 90000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 103, 50000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (10, 'Intro to CS', 'Comp. Sci.', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (20, 'Algorithms', 'Comp. Sci.', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (30, 'Operating Systems', 'Comp. Sci.', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (40, 'Mechanics', 'Physics', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES (50, 'World History', 'History', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Gold Result:
('Comp. Sci.',)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
('Comp. Sci.',)
('History',)
('Physics',)
*/