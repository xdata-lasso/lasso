-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, '5k5swwqcgs', '9n8', 1610062532, 'pgu7vfe4');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', -1377057208, 'ilbnp');

-- Inserting into table: enrollments --
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483648, -2147483648, -2147483648, 'mdpos', 'enr_b597af');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483647, -2147483648, -2147483648, '5u', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483646, -2147483648, -2147483648, 'klfa9000t', NULL);

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483645, -2147483648, -2147483648, '4ecigce376n', 'enr_b597af');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (2, -2147483648, -2147483648, '52zb', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'B' THEN 3 ELSE 0 END FROM Enrollments;

/*
Gold Result:
(0,)
(4,)
(0,)
(0,)
(3,)
*/

-- Prediction Query
SELECT CASE WHEN grade = 'A' THEN 4 WHEN grade = 'C' THEN 3 ELSE 0 END FROM Enrollments;

/*
Prediction Result:
(0,)
(4,)
(0,)
(0,)
(0,)
*/