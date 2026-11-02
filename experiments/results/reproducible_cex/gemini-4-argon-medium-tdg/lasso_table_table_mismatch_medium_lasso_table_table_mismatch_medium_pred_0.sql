-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic selection, duplicate projection (SELECT vs SELECT DISTINCT), NULL values, and join-based mutants (students with 0, 1, and multiple enrollments).
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2021, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Alice', 'Johnson', 2022, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Bob', 'Williams', 2020, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Charlie', 'Brown', 2023, NULL);
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, NULL, 'Davis', 2021, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (102, 'MATH101', 'Calculus', 3, 'Math');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 101, 'Fall 2021', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (2, 1, 102, 'Spring 2022', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'CS';

/*
Gold Result:
('Alice',)
('Alice',)
(None,)
*/

-- Prediction Query
SELECT name FROM Professors WHERE department = 'CS';

/*
Prediction Result:
*/