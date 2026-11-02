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
-- Target: Partial composite key matches (e.g., missing sec_id, semester, year, or course_id in join/IN condition), untaught sections (LEFT JOIN vs INNER JOIN), and students taking no courses (student vs takes table).
INSERT INTO department (dept_name, building, budget) VALUES ('CS', 'Taylor', 100000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS101', 'Intro', 'CS', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS102', 'Algo', 'CS', 4);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('10101', 'Srinivasan', 'CS', 65000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20202', 'Wu', 'CS', 70000);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS101', '1', 'Fall', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS101', '2', 'Fall', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS101', '1', 'Spring', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS101', '1', 'Fall', 2021);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS102', '1', 'Fall', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('CS102', '2', 'Spring', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('10101', 'CS101', '1', 'Fall', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS101', '2', 'Fall', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS101', '1', 'Spring', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS101', '1', 'Fall', 2021);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS102', '1', 'Fall', 2020);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S1', 'Alice', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S2', 'Bob', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S3', 'Charlie', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S4', 'David', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S5', 'Eve', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S6', 'Frank', 'CS', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S7', 'Grace', 'CS', 0);
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S1', 'CS101', '1', 'Fall', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S2', 'CS101', '2', 'Fall', 2020, 'B');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S3', 'CS101', '1', 'Spring', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S4', 'CS101', '1', 'Fall', 2021, 'C');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S5', 'CS102', '1', 'Fall', 2020, 'B');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S6', 'CS102', '2', 'Spring', 2021, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT ID) FROM takes WHERE NOT (course_id, sec_id, semester, year) IN (SELECT course_id, sec_id, semester, year FROM teaches WHERE teaches.ID = '10101');

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT ID) FROM takes WHERE NOT (course_id, semester, year) IN (SELECT course_id, semester, year FROM teaches WHERE teaches.ID = '10101');

/*
Prediction Result:
(4,)
*/