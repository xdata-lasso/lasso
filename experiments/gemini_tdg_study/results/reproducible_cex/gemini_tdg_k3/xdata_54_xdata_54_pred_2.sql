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
INSERT INTO department (dept_name, building, budget) VALUES ('Math', 'Nevins', 80000.00);
INSERT INTO department (dept_name, building, budget) VALUES ('Music', 'Packard', 70000.00);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('MAT-101', 'Calculus', 'Math', 4);
INSERT INTO course (course_id, title, dept_name, credits) VALUES ('MUS-101', 'Music Theory', 'Music', 3);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('MAT-101', '1', 'Spring', 2010);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('MUS-101', '1', 'Spring', 2011);
INSERT INTO section (course_id, sec_id, semester, year) VALUES ('MAT-101', '2', 'Fall', 2010);
-- Person 1: Instructor in Math, but Student in Music (different departments, both valid in department table). Teaches Spring 2010.
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20001', 'David', 'Math', 65000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('20001', 'David', 'Music', 45);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20001', 'MAT-101', '1', 'Spring', 2010);
-- Person 2: Instructor and Student, but student.dept_name is NULL (inner join on student.dept_name = department.dept_name fails)
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20002', 'Eva', 'Math', 72000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('20002', 'Eva', NULL, 60);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20002', 'MAT-101', '1', 'Spring', 2010);
-- Person 3: Instructor and Student, teaches only Spring (2011), no 2010 section
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20003', 'Frank', 'Music', 55000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('20003', 'Frank', 'Music', 20);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20003', 'MUS-101', '1', 'Spring', 2011);
-- Person 4: Instructor and Student, teaches only Fall (2010), no Spring section
INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('20004', 'Grace', 'Math', 58000.00);
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES ('20004', 'Grace', 'Math', 10);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES ('20004', 'MAT-101', '2', 'Fall', 2010);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT instructor.name FROM instructor INNER JOIN student ON (instructor.ID = student.ID) INNER JOIN department ON (student.dept_name = department.dept_name) WHERE EXISTS(SELECT * FROM teaches AS t1 WHERE instructor.ID = t1.ID AND t1.semester = 'Spring' AND EXISTS(SELECT * FROM teaches AS t2 WHERE t2.ID = t1.ID AND t2.year = 2010));

/*
Gold Result:
('David',)
*/

-- Prediction Query
SELECT instructor.name FROM instructor NATURAL JOIN student WHERE EXISTS(SELECT * FROM teaches AS t1 WHERE EXISTS(SELECT * FROM teaches AS t2 WHERE t2.ID = t1.ID AND t2.year = 2010));

/*
Prediction Result:
('Frank',)
('Grace',)
*/