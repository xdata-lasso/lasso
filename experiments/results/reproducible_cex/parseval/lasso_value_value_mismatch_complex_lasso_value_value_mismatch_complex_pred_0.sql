-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1, '5k5swwqcgs', '9n8', 1610062532, 'pgu7vfe4');

-- Inserting into table: courses --
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (-2147483648, 'hria2ypuzhs', 'rwbbp6luhvd', -1377057208, 'ilbnp');

-- Inserting into table: enrollments --
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483648, 1, -2147483648, 'mdpos', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (2, 1, -2147483648, 'e5u', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (3, 1, -2147483648, '6klfa9', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483645, 1, -2147483648, '00t5c4ecigc', 'enr_bbaf12');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (-2147483644, 1, -2147483648, '6nium52zb', 'A');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (4, 1, -2147483648, 'nrqrofqy', 'B');

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (5, 1, -2147483648, 'swwqcgsk', NULL);

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (6, 1, -2147483648, 'pgu7vfe4', NULL);

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (7, 1, -2147483648, 'a2y', NULL);

INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (8, 1, -2147483648, 'hsrwbbp', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments WHERE grade = 'A' OR grade = 'B';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments WHERE grade = 'C' OR grade = 'D';

/*
Prediction Result:
*/