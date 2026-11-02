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
-- Tests WHERE boundary (credits > 2 vs >= 2), HAVING boundary (SUM > 3 vs >= 3), and COUNT(credits) vs COUNT(DISTINCT credits).
INSERT INTO department (dept_name, building, budget) VALUES ('Comp. Sci.', 'Taylor', 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 'Watson', 90000);
INSERT INTO department (dept_name, building, budget) VALUES ('Music', 'Packard', 50000);
INSERT INTO department (dept_name, building, budget) VALUES ('History', 'Painter', 60000);
-- Comp. Sci.: two courses with 3 credits (tests COUNT vs COUNT DISTINCT, and SUM = 6 > 3) and one with 2 credits (filtered by WHERE credits > '2')
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-101', 'Intro to CS', 'Comp. Sci.', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-102', 'Data Structures', 'Comp. Sci.', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-103', 'CS Seminar', 'Comp. Sci.', 2);
-- Physics: one course with 3 credits (passes WHERE, but SUM(credits) = 3, which fails HAVING SUM(credits) > 3)
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('PHY-101', 'Mechanics', 'Physics', 3);
-- Music: two courses with 2 credits (if WHERE is mutated to >= 2 or omitted, SUM = 4 > 3; under Gold Query, filtered out)
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('MUS-101', 'Theory I', 'Music', 2);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('MUS-102', 'Theory II', 'Music', 2);
-- History: one course with 4 credits (passes WHERE and HAVING with count = 1, testing HAVING COUNT > 1 vs HAVING SUM > 3)
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('HIS-101', 'World History', 'History', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM (SELECT dept_name, COUNT(credits) FROM course WHERE credits > '2' GROUP BY dept_name HAVING SUM(credits) > 3) AS foo;

/*
Gold Result:
('Comp. Sci.', 2)
('History', 1)
*/

-- Prediction Query
SELECT * FROM (SELECT dept_name, COUNT(credits) FROM course WHERE credits > '2' GROUP BY dept_name HAVING SUM(credits) = 3) AS foo;

/*
Prediction Result:
('Physics', 1)
*/