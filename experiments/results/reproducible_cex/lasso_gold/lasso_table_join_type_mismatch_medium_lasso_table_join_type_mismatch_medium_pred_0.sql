-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1001, 'purpose', 'Patrick Sanchez', 1002, 'chair');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1008, 'purpose', 'Patrick Sanchez', 1002, 'chair');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1003, 'Jill', 'Rhodes', 1004, 'wait');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1006, 'Jill', 'Rhodes', 1004, 'wait');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1005, 1003, 1001, 'offer', 'begin');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1009, 1003, NULL, 'offer', 'begin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.course_name, e.semester FROM Courses AS c LEFT JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Gold Result:
('Patrick Sanchez', 'offer')
('Patrick Sanchez', None)
*/

-- Prediction Query
SELECT c.course_name, e.semester FROM Courses AS c INNER JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Prediction Result:
('Patrick Sanchez', 'offer')
*/