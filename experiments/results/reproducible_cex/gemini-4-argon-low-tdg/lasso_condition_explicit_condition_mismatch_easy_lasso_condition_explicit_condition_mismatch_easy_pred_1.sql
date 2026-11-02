-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard boolean logic (AND vs OR), inequality operators (<, >, <=, >=, !=), and column projection (first_name vs last_name).
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2022, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Bob', 'Jones', 2022, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Charlie', 'Brown', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'David', 'Wilson', 2023, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'Eve', 'Davis', 2021, 'History');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND major = 'CS';

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE major = 'CS' AND enrollment_year = 2021;

/*
Prediction Result:
('Charlie',)
*/