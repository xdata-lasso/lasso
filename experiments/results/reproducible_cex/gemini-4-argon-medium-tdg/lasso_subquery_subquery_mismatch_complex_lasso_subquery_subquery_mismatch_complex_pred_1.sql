-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for credits (3, 4, 5, NULL), un-enrolled students, and un-enrolled courses.
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2020, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Bob', 'Jones', 2021, 'Math');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (3, 'Charlie', 'Brown', 2022, 'Physics');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (4, 'Diana', 'Prince', 2023, 'History');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (5, 'Evan', 'Wright', 2020, 'Art');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (101, 'CS101', 'Intro to CS', 3, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (102, 'CS102', 'Data Structures', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (103, 'MATH201', 'Calculus', 5, 'Math');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (104, 'PHYS101', 'Mechanics', NULL, 'Physics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (105, 'HIST101', 'World History', 4, 'History');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1001, 1, 101, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1002, 2, 102, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1003, 3, 103, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1004, 4, 104, 'Fall 2023', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_code FROM Courses WHERE credits = 4);

/*
Prediction Result:
*/