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
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-101', 'Intro to CS', 'Comp. Sci.', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('CS-102', 'Data Structures', 'Comp. Sci.', 4);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('10101', 'Srinivasan', 'Comp. Sci.', 65000.00);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20202', 'Wu', 'Comp. Sci.', 75000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S1', 'Alice', 'Comp. Sci.', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S2', 'Bob', 'Comp. Sci.', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S3', 'Charlie', 'Comp. Sci.', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S4', 'Diana', 'Comp. Sci.', 30);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S5', 'Evan', 'Comp. Sci.', 30);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '1', 'Fall', 2020, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-102', '1', 'Fall', 2020, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '2', 'Fall', 2020, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '1', 'Spring', 2020, NULL, NULL, NULL);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS-101', '1', 'Fall', 2021, NULL, NULL, NULL);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('10101', 'CS-101', '1', 'Fall', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS-102', '1', 'Fall', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS-101', '2', 'Fall', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS-101', '1', 'Spring', 2020);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20202', 'CS-101', '1', 'Fall', 2021);
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S1', 'CS-101', '1', 'Fall', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S2', 'CS-102', '1', 'Fall', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S3', 'CS-101', '2', 'Fall', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S4', 'CS-101', '1', 'Spring', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S5', 'CS-101', '1', 'Fall', 2021, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT ID) FROM takes WHERE (course_id, sec_id, semester, year) IN (SELECT course_id, sec_id, semester, year FROM teaches WHERE teaches.ID = '10101');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT ID) FROM takes WHERE NOT (course_id, sec_id, semester, year) IN (SELECT course_id, sec_id, semester, year FROM teaches WHERE teaches.ID = '10101');

/*
Prediction Result:
(4,)
*/