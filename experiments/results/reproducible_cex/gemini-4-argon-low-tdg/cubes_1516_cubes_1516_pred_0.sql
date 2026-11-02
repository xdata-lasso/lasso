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
-- 1. COUNT(DISTINCT dept_name) vs COUNT(dept_name) or COUNT(*) (courses C1, C2 share same credits and dept_name).
-- 2. Outer SELECT DISTINCT vs SELECT ALL (credits 3 and 4 both yield n_distinct = 1).
-- 3. GROUP BY credits vs GROUP BY dept_name or no GROUP BY.
-- 4. ORDER BY ascending vs descending or insertion order (credits 5 inserted first with count 2, credits 3 and 4 with count 1).
-- 5. Querying 'course' vs 'department' (D4 has no courses).
INSERT INTO department (dept_name, building, budget) VALUES ('D1', 'B1', 1000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('D2', 'B2', 2000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('D3', 'B3', 3000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('D4', 'B4', 4000.00);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C5_1', 'D1', 'Course 5_1', 5);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C5_2', 'D2', 'Course 5_2', 5);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C3_1', 'D1', 'Course 3_1', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C3_2', 'D1', 'Course 3_2', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C4_1', 'D3', 'Course 4_1', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_dept_name_ FROM (SELECT credits, COUNT(DISTINCT dept_name) AS n_distinct FROM course GROUP BY credits) ORDER BY count_distinct_dept_name_;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT dept_name) FROM course;

/*
Prediction Result:
(3,)
*/