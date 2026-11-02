-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (1, 'CS101', 'Data', 3, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (2, 'CS102', 'Data Structures', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (3, 'CS103', 'Big Data', 3, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (4, 'CS104', 'Intro to Data Science', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (5, 'CS105', 'Relational Databases', 3, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (6, 'CS106', 'Algorithms', 4, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (7, 'CS107', 'Dat', 2, 'Computer Science');
INSERT INTO Courses (course_id, course_code, course_name, credits, department) VALUES (8, 'CS108', 'ata', 2, 'Computer Science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_name FROM Courses WHERE course_name LIKE '%Data%';

/*
Gold Result:
('Data',)
('Data Structures',)
('Big Data',)
('Intro to Data Science',)
('Relational Databases',)
*/

-- Prediction Query
SELECT course_name FROM Courses WHERE course_name = '%Data%';

/*
Prediction Result:
*/