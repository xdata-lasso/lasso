-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (10, 'Alice', 'Smith', 2022, 'CS');
INSERT INTO Students (student_id, first_name, last_name, enrollment_year, major) VALUES (20, 'Bob', 'Jones', 2023, 'Math');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Database Systems', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (2, 'CS102', 'Algorithms', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (3, 'CS103', 'Operating Systems', 3, 'CS');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (100, 10, 1, 'Fall 2023', 'A');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (101, 20, 1, 'Spring 2024', 'B');
INSERT INTO Enrollments (enrollment_id, student_id, course_id, semester, grade) VALUES (102, 10, 3, 'Fall 2023', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.course_name, e.semester FROM Courses AS c LEFT JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Gold Result:
('Database Systems', 'Fall 2023')
('Database Systems', 'Spring 2024')
('Algorithms', None)
('Operating Systems', 'Fall 2023')
*/

-- Prediction Query
SELECT c.course_name, e.semester FROM Courses AS c CROSS JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Prediction Result:
('Database Systems', 'Fall 2023')
('Database Systems', 'Spring 2024')
('Operating Systems', 'Fall 2023')
*/