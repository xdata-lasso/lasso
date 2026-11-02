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
-- DATASET 2
-- Tests semester predicate, correlation, and non-teaching instructors:
-- 1. Instructors teaching only in 'Fall', 'Winter', 'Summer' (kills semester != 'Spring', OR mutations, or missing semester filter).
-- 2. Instructor teaching in both 'Spring' and 'Fall' (kills mutants requiring ONLY Spring or NOT EXISTS Fall).
-- 3. Instructor teaching nothing (kills NOT EXISTS or LEFT JOIN without NULL check).
-- 4. Unassigned 'Spring' section (kills uncorrelated EXISTS or missing instructor.ID = teaches.ID predicate).
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C1', 'Course 1', NULL, 3);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I1', 'SpringOnly', NULL, 40000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I2', 'FallOnly', NULL, 40000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I3', 'WinterOnly', NULL, 40000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I4', 'SummerOnly', NULL, 40000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I5', 'SpringAndFall', NULL, 40000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I6', 'NoTeach', NULL, 40000);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('C1', '1', 'Spring', 2021, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('C1', '1', 'Fall', 2021, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('C1', '1', 'Winter', 2021, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('C1', '1', 'Summer', 2021, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('C1', '2', 'Spring', 2021, NULL, NULL, NULL);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I1', 'C1', '1', 'Spring', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I2', 'C1', '1', 'Fall', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I3', 'C1', '1', 'Winter', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I4', 'C1', '1', 'Summer', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I5', 'C1', '1', 'Spring', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('I5', 'C1', '1', 'Fall', 2021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE EXISTS(SELECT * FROM teaches INNER JOIN section ON (teaches.course_id = section.course_id AND teaches.sec_id = section.sec_id AND teaches.semester = section.semester AND teaches.year = section.year) WHERE instructor.ID = teaches.ID AND teaches.semester = 'Spring');

/*
Gold Result:
('SpringOnly',)
('SpringAndFall',)
*/

-- Prediction Query
SELECT name FROM instructor;

/*
Prediction Result:
('SpringOnly',)
('FallOnly',)
('WinterOnly',)
('SummerOnly',)
('SpringAndFall',)
('NoTeach',)
*/