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
-- Tests ties across different departments, duplicate max-credit courses within the same department (tests DISTINCT),
-- and a department that has greater SUM(credits) and COUNT(course) than the department with the single MAX(credits) course.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('CS', 101, 100000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 102, 80000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('History', 103, 50000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Physics', 104, 90000);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (1, 'Intro to CS', 'CS', 5);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (2, 'Algorithms', 'CS', 5);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (3, 'Calculus', 'Math', 5);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (4, 'World History', 'History', 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (5, 'Modern History', 'History', 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (6, 'Ancient History', 'History', 3);
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES (7, 'European History', 'History', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Gold Result:
('CS',)
('Math',)
*/

-- Prediction Query
SELECT DISTINCT DEPT_NAME FROM COURSE JOIN (SELECT MAX(CREDITS) AS MAX_CREDITS FROM COURSE GROUP BY DEPT_NAME) AS A ON COURSE.CREDITS = A.MAX_CREDITS;

/*
Prediction Result:
('CS',)
('Math',)
('History',)
*/