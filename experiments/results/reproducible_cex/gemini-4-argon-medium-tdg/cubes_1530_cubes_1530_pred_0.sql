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
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 'Taylor', 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 'Painter', 50000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 'Watson', 70000);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Taylor', '3128', 70);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Painter', '514', 10);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Watson', '100', 30);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('CS-101', 'Comp. Sci.', 'Intro to CS', 4);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('CS-315', 'Comp. Sci.', 'Robotics', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('HIS-351', 'History', 'World History', 3);
INSERT INTO course (course_id, dept_name, title, credits) VALUES ('PHY-101', 'Physics', 'Physical Principles', 4);
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('10101', 'Comp. Sci.', 'Srinivasan', 65000);
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('12121', 'Physics', 'Wu', 90000);
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('15151', 'History', 'Mozart', 40000);
INSERT INTO instructor (ID, dept_name, name, salary) VALUES ('22222', 'Physics', 'Einstein', 95000);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '1', 'Fall', 2017, 'Taylor', '3128', 'A');
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-315', '2', 'Spring', 2018, 'Painter', '514', 'B');
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('HIS-351', '3', 'Summer', 2019, 'Watson', '100', 'C');
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('10101', 'CS-315', '2', 'Spring', 2018);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('10101', 'CS-101', '1', 'Fall', 2017);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('12121', 'HIS-351', '3', 'Summer', 2019);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('10101', 'History', 'FakeSrinivasan', 30);
INSERT INTO student (ID, dept_name, name, tot_cred) VALUES ('99999', 'Comp. Sci.', 'Zhang', 102);
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('10101', 'HIS-351', '3', 'Summer', 2019, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('99999', 'CS-101', '1', 'Fall', 2017, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, course_id FROM (SELECT LHS.id AS id, LHS.course_id AS course_id, LHS.sec_id AS sec_id, LHS.semester AS semester, LHS.year AS YEAR, RHS.name AS name, RHS.dept_name AS dept_name, RHS.salary AS salary FROM teaches AS LHS INNER JOIN instructor AS RHS ON (LHS.id = RHS.id)) ORDER BY name, course_id NULLS LAST;

/*
Gold Result:
('Srinivasan', 'CS-101')
('Srinivasan', 'CS-315')
('Wu', 'HIS-351')
*/

-- Prediction Query
SELECT name, course_id FROM instructor AS T1 JOIN teaches AS T2 ON T1.ID = T2.ID;

/*
Prediction Result:
('Srinivasan', 'CS-315')
('Srinivasan', 'CS-101')
('Wu', 'HIS-351')
*/