-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (9, 'CS', 'CS15', 2022, 'CS');
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (8, 'CS', 'CS17', 2022, 'CS16');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (10, 'CS', 'CS', 4844561014153251464, 'CS');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (12, 8, 10, 'CS', 'CS');
INSERT INTO "Enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (11, 8, 10, 'CS', 'CS');
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (14, 'CS', 'CS', '9999-12-31', 4844561014153251464);
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (13, 'CS', 'CS', '9999-12-31', 4844561014153251464);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND major = 'CS';

/*
Gold Result:
('CS',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE enrollment_year = 2022 AND first_name = 'CS';

/*
Prediction Result:
('CS',)
('CS',)
*/