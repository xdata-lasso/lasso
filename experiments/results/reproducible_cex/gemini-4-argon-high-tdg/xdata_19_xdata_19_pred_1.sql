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
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 'Gates', 100000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 'Hilbert', 80000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S01', 'Alice', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S02', 'Alice', 'CS', 60);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S03', 'Alice', 'CS', 90);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S04', 'Alice', 'CS', 120);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S05', 'Bob', 'CS', 10);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S06', 'Bob', 'CS', 20);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S07', 'Bob', 'Math', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S08', 'Bob', 'Math', 40);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S09', 'Bob', 'Math', 50);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S10', 'Charlie', 'CS', 15);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S11', 'Charlie', 'CS', 25);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S12', 'Charlie', 'CS', 35);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S13', 'Charlie', 'Math', 45);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S14', 'Charlie', 'Math', 55);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S15', 'Charlie', 'Math', 65);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I01', 'ProfX', 'CS', 50000.00);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('I02', 'ProfX', 'Math', 60000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(dept_name) FROM student GROUP BY name HAVING COUNT(id) < 5;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(dept_name) FROM student GROUP BY name HAVING COUNT(id) = 5;

/*
Prediction Result:
(5,)
*/