-- Schema DDL
CREATE TABLE "classroom" ("building" TEXT(15) UNIQUE, "room_number" TEXT(7) UNIQUE, "capacity" REAL(4, 0), PRIMARY KEY ("building", "room_number"));

CREATE TABLE "department" ("dept_name" TEXT(20) PRIMARY KEY, "building" TEXT(15), "budget" REAL(12, 2));

CREATE TABLE "course" ("course_id" TEXT(8) PRIMARY KEY, "dept_name" TEXT(20), "title" TEXT(50), "credits" REAL(2, 0), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "instructor" ("ID" TEXT(5) PRIMARY KEY, "dept_name" TEXT(20), "name" TEXT(20), "salary" REAL(8, 2), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "section" ("course_id" TEXT(8) UNIQUE, "sec_id" TEXT(8) UNIQUE, "semester" TEXT(6) UNIQUE, "year" REAL(4, 0) UNIQUE, "building" TEXT(15), "room_number" TEXT(7), "time_slot_id" TEXT(4), PRIMARY KEY ("course_id", "sec_id", "semester", "year"), FOREIGN KEY ("building") REFERENCES "classroom" ("building"), FOREIGN KEY ("room_number") REFERENCES "classroom" ("room_number"), FOREIGN KEY ("course_id") REFERENCES "course" ("course_id"));

CREATE TABLE "teaches" ("ID" TEXT(5), "course_id" TEXT(8), "sec_id" TEXT(8), "semester" TEXT(6), "year" REAL(4, 0), PRIMARY KEY ("ID", "course_id", "sec_id", "semester", "year"), FOREIGN KEY ("ID") REFERENCES "instructor" ("ID"), FOREIGN KEY ("course_id") REFERENCES "section" ("course_id"), FOREIGN KEY ("sec_id") REFERENCES "section" ("sec_id"), FOREIGN KEY ("semester") REFERENCES "section" ("semester"), FOREIGN KEY ("year") REFERENCES "section" ("year"));

CREATE TABLE "student" ("ID" TEXT(5) PRIMARY KEY, "dept_name" TEXT(20), "name" TEXT(20), "tot_cred" REAL(3, 0), FOREIGN KEY ("dept_name") REFERENCES "department" ("dept_name"));

CREATE TABLE "takes" ("ID" TEXT(5), "course_id" TEXT(8), "sec_id" TEXT(8), "semester" TEXT(6), "year" REAL(4, 0), "grade" TEXT(2), PRIMARY KEY ("ID", "course_id", "sec_id", "semester", "year"), FOREIGN KEY ("ID") REFERENCES "student" ("ID"), FOREIGN KEY ("course_id") REFERENCES "section" ("course_id"), FOREIGN KEY ("sec_id") REFERENCES "section" ("sec_id"), FOREIGN KEY ("semester") REFERENCES "section" ("semester"), FOREIGN KEY ("year") REFERENCES "section" ("year"));

CREATE TABLE "advisor" ("s_ID" TEXT(5) PRIMARY KEY, "i_ID" TEXT(5), FOREIGN KEY ("s_ID") REFERENCES "student" ("ID"), FOREIGN KEY ("i_ID") REFERENCES "instructor" ("ID"));

CREATE TABLE "time_slot" ("time_slot_id" TEXT(4), "day" TEXT(1), "start_hr" REAL(2), "start_min" REAL(2), "end_hr" REAL(2), "end_min" REAL(2), PRIMARY KEY ("time_slot_id", "day", "start_hr", "start_min"));

CREATE TABLE "prereq" ("course_id" TEXT(8), "prereq_id" TEXT(8), PRIMARY KEY ("course_id", "prereq_id"), FOREIGN KEY ("prereq_id") REFERENCES "course" ("course_id"), FOREIGN KEY ("course_id") REFERENCES "course" ("course_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(dept_name) vs COUNT(name) vs COUNT(tot_cred) by including NULLs in student columns.
-- 2. ORDER BY count___ ASC vs DESC.
-- 3. ORDER BY dept_name ASC vs DESC, and NULLS LAST vs NULLS FIRST when counts are tied.
-- 4. Unreferenced department (History) to catch mutants using LEFT JOIN from department to student.
-- 5. Confounding data in instructor and course tables to catch mutants querying the wrong table.
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 'Taylor', 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 'Watson', 70000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 'Painter', 50000);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S1', 'Physics', 'Alice', 30);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S2', 'Comp. Sci.', NULL, NULL);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S3', NULL, 'Bob', 40);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S4', 'Physics', 'Alice', 30);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S5', NULL, 'Charlie', 50);
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('I1', 'History', 'Prof. X', 80000);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C1', 'History', 'World History', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, dept_name FROM (SELECT dept_name, COUNT(*) AS n FROM student GROUP BY dept_name) ORDER BY count___, dept_name NULLS LAST;

/*
Gold Result:
(1, 'Comp. Sci.')
(2, 'Physics')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), dept_name FROM student GROUP BY dept_name;

/*
Prediction Result:
(2, None)
(1, 'Comp. Sci.')
(2, 'Physics')
*/