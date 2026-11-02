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
-- General comprehensive dataset:
-- 1. 'Comp. Sci.' shares 'Taylor' with 'Math' (kills missing dept_name filter in JOIN).
-- 2. 'Taylor' has two rooms with identical room_number ('101') as 'Watson' (kills COUNT(DISTINCT room_number) if unfiltered, and tests >1 count).
-- 3. 'Taylor' has rooms with identical capacities (50) (kills COUNT(DISTINCT capacity) or COUNT(DISTINCT building)).
-- 4. One room in 'Taylor' has NULL capacity (kills COUNT(capacity)).
-- 5. 'Comp. Sci.' has courses/sections in 'Watson', while 'Math' has sections in 'Taylor' (kills queries joining via course/section instead of department->classroom).
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 'Taylor', 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 'Taylor', 80000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 'Watson', 90000);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Taylor', '101', 50);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Taylor', '102', 50);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Taylor', '103', NULL);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Watson', '101', 30);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Watson', '201', 40);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-101', 'Intro to CS', 'Comp. Sci.', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-102', 'Data Structures', 'Comp. Sci.', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('MATH-101', 'Calculus', 'Math', 3);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '1', 'Fall', 2020, 'Watson', '101', 'A');
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '2', 'Spring', 2021, 'Watson', '101', 'B');
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-102', '1', 'Fall', 2020, 'Taylor', '101', 'C');
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('MATH-101', '1', 'Fall', 2020, 'Taylor', '102', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(room_number) FROM classroom WHERE building = (SELECT d.building FROM department AS d WHERE dept_name = 'Comp. Sci.');

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(room_number) FROM classroom WHERE building < (SELECT d.building FROM department AS d WHERE dept_name = 'Comp. Sci.');

/*
Prediction Result:
(0,)
*/