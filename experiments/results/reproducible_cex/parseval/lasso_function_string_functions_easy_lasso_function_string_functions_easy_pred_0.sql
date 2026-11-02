-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483648, 'stu_8cf6a6', '5k5swwqcgs', 247012447, '8c4pgu7vfe');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (2, 'stu_8cf6a6', 'hria2ypu', 1644814318, 'sr');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (3, 'stu_8cf6a6', 'wbbp6luhvdlt', -841692980, 'bnp');

INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (-2147483645, NULL, 'mdpos', -1576219117, '5u');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UPPER(first_name) FROM Students;

/*
Gold Result:
('STU_8CF6A6',)
(None,)
('STU_8CF6A6',)
('STU_8CF6A6',)
*/

-- Prediction Query
SELECT LOWER(first_name) FROM Students;

/*
Prediction Result:
('stu_8cf6a6',)
(None,)
('stu_8cf6a6',)
('stu_8cf6a6',)
*/