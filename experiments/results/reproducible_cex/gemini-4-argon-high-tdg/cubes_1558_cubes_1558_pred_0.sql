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
INSERT INTO department (dept_name, building, budget) VALUES ('Bio', 'Watson', 90000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 'Taylor', 100000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 'Painter', 85000.00);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('P1', 'CS', 'Intro CS', 2);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('P2', 'Bio', 'Intro Bio', 4);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('P3', 'Math', 'Intro Math', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('P4', 'Math', 'Discrete Math', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C1', 'Bio', 'Zoology', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C2', 'CS', 'Algorithms', 4);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C3', 'Math', 'Calculus', 1);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C4', 'Math', 'Linear Algebra', 2);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C5', 'CS', 'Robotics', 2);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('C6', 'CS', 'Ethics', 2);
INSERT INTO prereq (course_id, prereq_id) VALUES ('C1', 'P1');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C1', 'P2');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C2', 'P1');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C2', 'P3');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C3', 'P2');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C3', 'P3');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C4', 'P4');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C5', 'P1');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C5', 'P2');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C5', 'P3');
INSERT INTO prereq (course_id, prereq_id) VALUES ('C6', 'P4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.course_id AS course_id, LHS.title AS title, LHS.dept_name AS dept_name, LHS.credits AS credits, RHS.n AS n FROM course AS LHS INNER JOIN (SELECT course_id, COUNT(*) AS n FROM prereq GROUP BY course_id) AS RHS ON (LHS.course_id = RHS.course_id)) WHERE (n = 2) ORDER BY title;

/*
Gold Result:
('Algorithms',)
('Calculus',)
('Zoology',)
*/

-- Prediction Query
SELECT T1.title FROM course AS T1 JOIN prereq AS T2 ON T1.course_id = T2.course_id GROUP BY T2.course_id HAVING COUNT(*) = 2;

/*
Prediction Result:
('Zoology',)
('Algorithms',)
('Calculus',)
*/