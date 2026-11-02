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
-- Tests basic matching, dept_name equality between course and instructor, year filtering (2008.0 vs others), and ordering with NULLs.
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B1', 'R1', 50);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B2', 'R2', 50);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B3', 'R3', 50);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('B4', 'R4', 50);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('CS', 'B1', 100000);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 'B2', 100000);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C1', 'CS', 'Algorithms', 4);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C2', 'CS', 'Databases', 4);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C3', 'Math', 'Calculus', 4);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('C4', 'CS', 'AI', 4);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('I1', 'CS', 'Turing', 90000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('I2', 'CS', 'Codd', 85000);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('I3', 'CS', NULL, 80000);
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('C1', 'S1', 'Fall', 2008.0, 'B1', 'R1', 'T1');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('C2', 'S2', 'Spring', 2009.0, 'B2', 'R2', 'T2');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('C3', 'S3', 'Winter', 2007.0, 'B3', 'R3', 'T3');
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('I1', 'C1', 'S1', 'Fall', 2008.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('I2', 'C1', 'S1', 'Fall', 2008.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('I3', 'C1', 'S1', 'Fall', 2008.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('I1', 'C2', 'S2', 'Spring', 2009.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('I1', 'C3', 'S3', 'Winter', 2007.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, name FROM (SELECT LHS.course_id AS course_id, LHS.title AS title, LHS.dept_name AS dept_name, LHS.credits AS credits, LHS.id AS id, LHS.name AS name, LHS.salary AS salary, LHS.sec_id AS sec_id, LHS.semester AS semester, LHS.year AS YEAR FROM (SELECT LHS.course_id AS course_id, LHS.title AS title, LHS.dept_name AS dept_name, LHS.credits AS credits, LHS.id AS id, LHS.name AS name, LHS.salary AS salary, RHS.sec_id AS sec_id, RHS.semester AS semester, RHS.year AS YEAR FROM (SELECT LHS.course_id AS course_id, LHS.title AS title, LHS.dept_name AS dept_name, LHS.credits AS credits, RHS.id AS id, RHS.name AS name, RHS.salary AS salary FROM course AS LHS INNER JOIN instructor AS RHS ON (LHS.dept_name = RHS.dept_name)) AS LHS INNER JOIN teaches AS RHS ON (LHS.course_id = RHS.course_id AND LHS.id = RHS.id)) AS LHS INNER JOIN (SELECT * FROM teaches WHERE (YEAR = 2008.0)) AS RHS ON (LHS.course_id = RHS.course_id AND LHS.id = RHS.id AND LHS.sec_id = RHS.sec_id AND LHS.semester = RHS.semester AND LHS.year = RHS.year)) ORDER BY title, name NULLS LAST;

/*
Gold Result:
('Algorithms', 'Codd')
('Algorithms', 'Turing')
('Algorithms', None)
*/

-- Prediction Query
SELECT T1.title, T3.name FROM course AS T1 JOIN teaches AS T2 ON T1.course_id = T2.course_id JOIN instructor AS T3 ON T2.id = T3.id WHERE YEAR = 2008 ORDER BY T1.title, T1.course_id NULLS LAST, T2.id NULLS LAST, T2.course_id NULLS LAST, T2.sec_id NULLS LAST, T2.semester NULLS LAST, T2.year NULLS LAST, T3.id NULLS LAST;

/*
Prediction Result:
('Algorithms', 'Turing')
('Algorithms', 'Codd')
('Algorithms', None)
*/