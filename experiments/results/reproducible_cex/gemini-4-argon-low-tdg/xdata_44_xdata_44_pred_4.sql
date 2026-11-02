-- Schema DDL
CREATE TABLE classroom (building TEXT(15), room_number TEXT(7), capacity REAL(4, 0), PRIMARY KEY (building, room_number));

CREATE TABLE department (dept_name TEXT(20) PRIMARY KEY, building TEXT(15), budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE course (course_id TEXT(8) PRIMARY KEY, title TEXT(50), dept_name TEXT(20), credits REAL(2, 0) CHECK (credits > 0), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE instructor (ID TEXT(5) PRIMARY KEY, name TEXT(20) NOT NULL, dept_name TEXT(20), salary REAL(8, 2) CHECK (salary > 29000), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE section (course_id TEXT(8), sec_id TEXT(8), semester TEXT(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), year REAL(4, 0) CHECK (year > 1701 AND year < 2100), building TEXT(15), room_number TEXT(7), time_slot_id TEXT(4), PRIMARY KEY (course_id, sec_id, semester, year), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number) ON delete SET NULL);

CREATE TABLE teaches (ID TEXT(5), course_id TEXT(8), sec_id TEXT(8), semester TEXT(6), year REAL(4, 0), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES instructor (ID) ON delete CASCADE);

CREATE TABLE student (ID TEXT(5) PRIMARY KEY, name TEXT(20) NOT NULL, dept_name TEXT(20), tot_cred REAL(3, 0) CHECK (tot_cred >= 0), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE takes (ID TEXT(5), course_id TEXT(8), sec_id TEXT(8), semester TEXT(6), year REAL(4, 0), grade TEXT(2), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE advisor (s_ID TEXT(5) PRIMARY KEY, i_ID TEXT(5), FOREIGN KEY (i_ID) REFERENCES instructor (ID) ON delete SET NULL, FOREIGN KEY (s_ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE time_slot (time_slot_id TEXT(4), day TEXT(1), start_hr REAL(2) CHECK (start_hr >= 0 AND start_hr < 24), start_min REAL(2) CHECK (start_min >= 0 AND start_min < 60), end_hr REAL(2) CHECK (end_hr >= 0 AND end_hr < 24), end_min REAL(2) CHECK (end_min >= 0 AND end_min < 60), PRIMARY KEY (time_slot_id, day, start_hr, start_min));

CREATE TABLE prereq (course_id TEXT(8), prereq_id TEXT(8), PRIMARY KEY (course_id, prereq_id), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (prereq_id) REFERENCES course (course_id));

CREATE TABLE grade_value (grade TEXT(2) PRIMARY KEY, value REAL(4, 2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests cardinality and duplicate elimination:
-- 1. Instructor teaching multiple sections in 'Spring' (kills INNER JOIN without DISTINCT vs EXISTS).
-- 2. Two distinct instructors with the exact same name teaching in 'Spring' (kills SELECT DISTINCT name vs SELECT name with EXISTS).
-- 3. Instructor with NULL dept_name and NULL classroom fields in section (kills mutants introducing unnecessary INNER JOINs to department or classroom).
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 'Taylor', 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS101', 'Intro to CS', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS102', 'Data Structures', NULL, 4);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I1', 'Alice', 'CS', 50000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I2', 'Bob', 'CS', 60000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I3', 'Bob', NULL, 65000);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS101', '1', 'Spring', 2020, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS102', '1', 'Spring', 2020, NULL, NULL, NULL);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I1', 'CS101', '1', 'Spring', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I1', 'CS102', '1', 'Spring', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I2', 'CS101', '1', 'Spring', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I3', 'CS102', '1', 'Spring', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE EXISTS(SELECT * FROM teaches INNER JOIN section ON (teaches.course_id = section.course_id AND teaches.sec_id = section.sec_id AND teaches.semester = section.semester AND teaches.year = section.year) WHERE instructor.ID = teaches.ID AND teaches.semester = 'Spring');

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
*/

-- Prediction Query
SELECT name FROM instructor WHERE EXISTS(SELECT * FROM teaches INNER JOIN section ON (teaches.course_id = section.course_id AND teaches.sec_id = section.sec_id AND teaches.semester = section.semester AND teaches.year = section.year) WHERE instructor.ID = teaches.ID AND teaches.semester < 'Spring');

/*
Prediction Result:
*/