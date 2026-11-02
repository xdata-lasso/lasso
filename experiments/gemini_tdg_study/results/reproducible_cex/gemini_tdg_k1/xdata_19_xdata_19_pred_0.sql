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
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 'Taylor', 100000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 'Watson', 80000.00);
-- Group 'Alice': 1 student with NULL dept_name (COUNT(dept_name) = 0, COUNT(id) = 1 < 5)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10001', 'Alice', NULL, 30);
-- Group 'Bob': 3 students, 1 with NULL dept_name (COUNT(dept_name) = 2, COUNT(id) = 3 < 5)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10002', 'Bob', 'Comp. Sci.', 45);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10003', 'Bob', 'Math', 60);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10004', 'Bob', NULL, 15);
-- Group 'Charlie': exactly 5 students (COUNT(id) = 5, should be filtered out by HAVING COUNT(id) < 5)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10005', 'Charlie', 'Comp. Sci.', 90);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10006', 'Charlie', 'Comp. Sci.', 85);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10007', 'Charlie', 'Math', 70);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10008', 'Charlie', 'Math', 65);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10009', 'Charlie', 'Comp. Sci.', 100);
-- Group 'David': 2 students, all non-null dept_name (COUNT(dept_name) = 2, COUNT(id) = 2 < 5)
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10010', 'David', 'Comp. Sci.', 12);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('10011', 'David', 'Math', 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(dept_name) FROM student GROUP BY name HAVING COUNT(id) < 5;

/*
Gold Result:
(0,)
(2,)
(2,)
*/

-- Prediction Query
SELECT COUNT(dept_name) FROM student GROUP BY name HAVING COUNT(id) >= 5;

/*
Prediction Result:
(5,)
*/