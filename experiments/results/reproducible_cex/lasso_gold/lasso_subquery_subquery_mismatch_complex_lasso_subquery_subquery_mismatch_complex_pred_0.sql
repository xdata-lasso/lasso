-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1001, 'purpose', 'Patrick Sanchez', 4, 'chair');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1002, 'Jill', 'Rhodes', 1003, 'wait');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1004, 1002, 1001, 'offer', 'begin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 4);

/*
Gold Result:
(1002,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE course_id IN (SELECT course_id FROM Courses WHERE credits = 3);

/*
Prediction Result:
*/