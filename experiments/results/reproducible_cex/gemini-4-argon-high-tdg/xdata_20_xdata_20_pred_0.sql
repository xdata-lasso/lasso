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
INSERT INTO department (dept_name, building, budget) VALUES ('DeptA', 'Bldg1', 50000);
INSERT INTO department (dept_name, building, budget) VALUES ('DeptB', 'Bldg2', 60000);
INSERT INTO department (dept_name, building, budget) VALUES ('DeptC', 'Bldg3', 70000);
INSERT INTO department (dept_name, building, budget) VALUES ('DeptD', 'Bldg4', 80000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C101', 'Intro A1', 'DeptA', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C102', 'Intro A2', 'DeptA', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C103', 'Adv A3', 'DeptA', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C104', 'Low A4', 'DeptA', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C201', 'B1', 'DeptB', 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C202', 'B2', 'DeptB', 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C203', 'B3', 'DeptB', 8);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C301', 'C1', 'DeptC', 5);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C302', 'C2', 'DeptC', 10);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C303', 'C3', 'DeptC', 10);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C401', 'D1', 'DeptD', 6);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C402', 'D2', 'DeptD', 10);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C403', 'D3', 'DeptD', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name, SUM(credits) FROM course INNER JOIN department USING (dept_name) WHERE credits >= 4 GROUP BY dept_name HAVING SUM(credits) < 25;

/*
Gold Result:
('DeptA', 13.0)
('DeptB', 24.0)
*/

-- Prediction Query
SELECT dept_name, SUM(credits) FROM course INNER JOIN department USING (dept_name) WHERE credits >= 4 GROUP BY dept_name HAVING SUM(credits) > 25;

/*
Prediction Result:
('DeptD', 26.0)
*/