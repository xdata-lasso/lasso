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
INSERT INTO department (dept_name, building, budget) VALUES ('D_Full', 'B1', 1000);
INSERT INTO department (dept_name, building, budget) VALUES ('D_NoCourse', 'B2', 2000);
INSERT INTO department (dept_name, building, budget) VALUES ('D_NoStudent', 'B3', 3000);
INSERT INTO department (dept_name, building, budget) VALUES ('D_Empty', 'B4', 4000);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C_Full', 'Course 1', 'D_Full', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C_NoStu', 'Course 2', 'D_NoStudent', 3);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('C_NullDept', 'Course 3', NULL, 3);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('C_Full', '1', 'Fall', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('C_NoStu', '1', 'Fall', 2020);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('C_NullDept', '1', 'Fall', 2020);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S_Full', 'Alice', 'D_Full', 10);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S_NoTakes', 'Bob', 'D_Full', 10);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S_NoCourse', 'Charlie', 'D_NoCourse', 10);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('S_NullDept', 'David', NULL, 10);
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S_Full', 'C_Full', '1', 'Fall', 2020, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S_NoCourse', 'C_Full', '1', 'Fall', 2020, 'B');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES ('S_NullDept', 'C_NullDept', '1', 'Fall', 2020, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT * FROM COURSE INNER JOIN DEPARTMENT ON COURSE.dept_name = DEPARTMENT.dept_name INNER JOIN STUDENT ON STUDENT.dept_name = DEPARTMENT.dept_name INNER JOIN TAKES ON TAKES.ID = STUDENT.ID;

/*
Gold Result:
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_Full', 'Alice', 'D_Full', 10.0, 'S_Full', 'C_Full', '1', 'Fall', 2020.0, 'A')
*/

-- Prediction Query
SELECT * FROM COURSE INNER JOIN DEPARTMENT ON COURSE.dept_name = DEPARTMENT.dept_name INNER JOIN STUDENT ON STUDENT.dept_name = DEPARTMENT.dept_name INNER JOIN TAKES ON TRUE;

/*
Prediction Result:
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_Full', 'Alice', 'D_Full', 10.0, 'S_Full', 'C_Full', '1', 'Fall', 2020.0, 'A')
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_NoTakes', 'Bob', 'D_Full', 10.0, 'S_Full', 'C_Full', '1', 'Fall', 2020.0, 'A')
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_Full', 'Alice', 'D_Full', 10.0, 'S_NoCourse', 'C_Full', '1', 'Fall', 2020.0, 'B')
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_NoTakes', 'Bob', 'D_Full', 10.0, 'S_NoCourse', 'C_Full', '1', 'Fall', 2020.0, 'B')
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_Full', 'Alice', 'D_Full', 10.0, 'S_NullDept', 'C_NullDept', '1', 'Fall', 2020.0, 'C')
('C_Full', 'Course 1', 'D_Full', 3.0, 'D_Full', 'B1', 1000.0, 'S_NoTakes', 'Bob', 'D_Full', 10.0, 'S_NullDept', 'C_NullDept', '1', 'Fall', 2020.0, 'C')
*/