-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'John', 'Doe', 2023, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Intro to CS', 4, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (1, 1, 1, 'Fall 2023', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'C' OR grade = 'D';

/*
Prediction Result:
*/