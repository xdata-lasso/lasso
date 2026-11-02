-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic substring matching positions: exact match, prefix ('Data%'), suffix ('%Data'), middle ('%Data%'), and non-matching strings.
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Data', 3, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (2, 'CS102', 'Data Structures', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (3, 'CS103', 'Big Data', 3, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (4, 'CS104', 'Advanced Database Systems', 4, 'CS');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (5, 'CS105', 'Algorithms', 4, 'CS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM Courses WHERE course_name LIKE '%Data%';

/*
Gold Result:
('Data',)
('Data Structures',)
('Big Data',)
('Advanced Database Systems',)
*/

-- Prediction Query
SELECT course_name FROM Courses WHERE course_name = '%Data%';

/*
Prediction Result:
*/