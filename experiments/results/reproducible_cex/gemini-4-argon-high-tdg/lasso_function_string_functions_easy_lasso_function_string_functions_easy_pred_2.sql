-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'alice', 'Smith', 2020, 'Computer Science');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'ALICE', 'Jones', 2021, 'Mathematics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Bob', 'Brown', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Bob', 'Davis', 2023, 'History');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Intro to CS', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (102, 'MA101', 'Calculus', 3, 'Mathematics');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1001, 2, 101, 'Fall 2021', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1002, 3, 101, 'Fall 2022', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1003, 3, 102, 'Spring 2023', 'A');
INSERT INTO Professors (professor_id, name, department, hire_date, salary) VALUES (501, 'Dr. Eve', 'Computer Science', '2015-08-15', 95000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UPPER(first_name) FROM Students;

/*
Gold Result:
('ALICE',)
('ALICE',)
('BOB',)
('BOB',)
*/

-- Prediction Query
SELECT LENGTH(first_name) FROM Students;

/*
Prediction Result:
(5,)
(5,)
(3,)
(3,)
*/