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
INSERT INTO department (dept_name, building, budget) VALUES ('Biology', 'BuildB', 50000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Statistics', 'BuildA', 10000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Psychology', 'BuildZ', 90000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Zoology', 'BuildC', 20000.00);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('101', 'Biology', 'Intro Bio', 4);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('102', 'Statistics', 'Applied Stats', 1);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('201', 'Psychology', 'Cognitive Psych', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('301', 'Zoology', 'Animal Behavior', 2);
INSERT INTO classroom (building, room_number, capacity) VALUES ('BuildA', '100', 50);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('102', '1', 'Fall', 2023, 'BuildA', '100', 'TS1');
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('I1', 'Statistics', 'Dr. Stat', 80000.00);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('S1', 'Statistics', 'Alice', 30);
INSERT INTO prereq (course_id, prereq_id) VALUES ('102', '101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "course" WHERE ("dept_name" = 'Statistics' OR "dept_name" = 'Psychology')) ORDER BY dept_name) LIMIT 1);

/*
Gold Result:
('Cognitive Psych',)
*/

-- Prediction Query
SELECT title FROM course WHERE dept_name = 'Statistics' INTERSECT SELECT title FROM course WHERE dept_name = 'Psychology';

/*
Prediction Result:
*/