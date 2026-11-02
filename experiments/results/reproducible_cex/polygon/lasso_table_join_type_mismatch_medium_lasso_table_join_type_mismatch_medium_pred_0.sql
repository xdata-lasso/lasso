-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (course_id) REFERENCES Courses (course_id), FOREIGN KEY (student_id) REFERENCES Students (student_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (13, '16', '16', 16, '16');
INSERT INTO "Students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (17, '16', '16', 16, '16');
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (30, NULL, '38', NULL, NULL);
INSERT INTO "Courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (16, '26', '27', 28, '29');
INSERT INTO "Enrollments" ("enrollment_id", "course_id", "student_id", "semester", "grade") VALUES (15, NULL, 13, '16', '16');
INSERT INTO "Enrollments" ("enrollment_id", "course_id", "student_id", "semester", "grade") VALUES (14, 16, 17, NULL, '25');
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (19, '16', '16', '1000-01-17', 16);
INSERT INTO "Professors" ("professor_id", "name", "department", "hire_date", "salary") VALUES (18, '16', '16', '1000-01-17', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.course_name, e.semester FROM Courses AS c LEFT JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Gold Result:
('27', None)
('38', None)
*/

-- Prediction Query
SELECT c.course_name, e.semester FROM Courses AS c INNER JOIN Enrollments AS e ON c.course_id = e.course_id;

/*
Prediction Result:
('27', None)
*/