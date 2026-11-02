-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic UPPER() functionality, duplicate handling (SELECT vs SELECT DISTINCT), and case folding duplicates.
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'alice', 'smith', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'ALICE', 'jones', 2022, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Bob', 'Brown', 2020, 'Physics');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UPPER(first_name) FROM Students;

/*
Gold Result:
('ALICE',)
('ALICE',)
('BOB',)
*/

-- Prediction Query
SELECT LOWER(first_name) FROM Students;

/*
Prediction Result:
('alice',)
('alice',)
('bob',)
*/