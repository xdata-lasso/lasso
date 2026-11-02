-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, 'stu_69fbcf', '5k5swwqcgs', 247012447, 'Physics');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (2, 'stu_69fbcf', '8c4pgu7vfe', -1633151678, 'Physics');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (3, 'stu_69fbcf', 'a2y', 1115440883, 'Physics');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483645, 'stu_69fbcf', 'hsrwbbp', 13244799, 'stu_a0be9a');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483644, NULL, 'hvdltt', -1610064545, 'Physics');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (4, 'n', 'rmdp', 2026480202, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Students WHERE major = 'Physics';

/*
Gold Result:
('stu_69fbcf',)
(None,)
('stu_69fbcf',)
('stu_69fbcf',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE major = 'Physics' AND enrollment_year = 2020 AND last_name LIKE 'A%';

/*
Prediction Result:
*/