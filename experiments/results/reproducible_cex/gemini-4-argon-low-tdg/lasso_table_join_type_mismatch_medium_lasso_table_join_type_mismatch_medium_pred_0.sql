-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (1, 'Alice', 'Smith', 2021, 'Computer Science');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (2, 'Bob', 'Jones', 2022, 'Mathematics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (10, 'CS101', 'Intro to CS', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (20, 'MATH101', 'Calculus I', 4, 'Mathematics');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (30, 'PHYS101', 'Physics I', 4, 'Physics');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (100, 1, 10, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (101, 2, 10, 'Fall 2023', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (102, 1, 20, 'Spring 2024', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.course_name, e.semester FROM Courses AS c LEFT JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Gold Result:
('Intro to CS', 'Fall 2023')
('Intro to CS', 'Fall 2023')
('Calculus I', 'Spring 2024')
('Physics I', None)
*/

-- Prediction Query
SELECT c.course_name, e.semester FROM Courses AS c INNER JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Prediction Result:
('Intro to CS', 'Fall 2023')
('Intro to CS', 'Fall 2023')
('Calculus I', 'Spring 2024')
*/