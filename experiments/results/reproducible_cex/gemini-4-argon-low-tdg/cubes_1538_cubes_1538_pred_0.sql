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
-- Tests standard anti-join, ordering, duplicate names across untaught/taught instructors, and multiple teaches per instructor.
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('CS', 'Watson', 100000.0);
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('Math', 'Taylor', 80000.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('Watson', '101', 50.0);
INSERT INTO "classroom" ("building", "room_number", "capacity") VALUES ('Taylor', '202', 40.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('CS101', 'CS', 'Intro to CS', 4.0);
INSERT INTO "course" ("course_id", "dept_name", "title", "credits") VALUES ('MATH101', 'Math', 'Calculus', 4.0);
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('CS101', '1', 'Fall', 2023.0, 'Watson', '101', 'A');
INSERT INTO "section" ("course_id", "sec_id", "semester", "year", "building", "room_number", "time_slot_id") VALUES ('MATH101', '2', 'Spring', 2024.0, 'Taylor', '202', 'B');
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('101', 'CS', 'Zack', 70000.0);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('102', 'CS', 'Alice', 80000.0);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('103', 'Math', 'Alice', 85000.0);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('104', 'Math', 'Bob', 90000.0);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('105', 'CS', 'Bob', 65000.0);
INSERT INTO "instructor" ("ID", "dept_name", "name", "salary") VALUES ('106', 'Math', 'Charlie', 75000.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('104', 'CS101', '1', 'Fall', 2023.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('106', 'CS101', '1', 'Fall', 2023.0);
INSERT INTO "teaches" ("ID", "course_id", "sec_id", "semester", "year") VALUES ('106', 'MATH101', '2', 'Spring', 2024.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM instructor AS LHS WHERE NOT EXISTS(SELECT 1 FROM teaches AS RHS WHERE (LHS.id = RHS.id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM instructor WHERE NOT id IN (SELECT id FROM teaches);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
('Bob',)
*/