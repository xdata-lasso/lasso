-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1001, 'purpose', 'Megan Mcclain', 1009, 'throw');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1002, 'brother', 'Javier Johnson', 1018.0, 'guy');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1003, 'ago', 'Jonathan Johnson', 1027.0, 'PM');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1004, 'site', 'Matthew Gardner', 1036.0, 'everything');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1005, 'face', 'Kevin Pacheco', 1045.0, 'surface');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1006, 'election', 'Robert Wolfe', 1054.0, 'animal');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1007, 'dog', 'Christopher Bernard', 1063.0, 'show');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1008, 'chair', 'Brandon Davis', 1072.0, 'machine');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1017, 'Amanda', 'Bush', 1025, 'prove');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1018, 'Teresa', 'Williams', 1034.0, 'they');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1019, 'Nicholas', 'Perez', 1043.0, 'his');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1020, 'Andrea', 'Roberts', 1052.0, 'commercial');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1021, 'Maria', 'Miller', 1061.0, 'hospital');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1022, 'Christine', 'Hall', 1070.0, 'hear');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1023, 'Michelle', 'Garcia', 1079.0, 'determine');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1024, 'Barbara', 'Ramirez', 1088.0, 'religious');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1033, 1017, 1001, 'example', 'none');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1034, 1018, 1002, 'science', 'shoulder');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1035, 1019, 1003, 'write', 'common');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1036, 1020, 1004, 'result', 'maintain');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1037, 1021, 1005, 'raise', 'hundred');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1038, 1022, 1006, 'away', 'expect');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1039, 1023, 1007, 'politics', 'wish');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1040, 1024, 1008, 'Congress', 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(1019,)
(1018,)
(1020,)
(1021,)
(1023,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester ASC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(1024,)
(1022,)
(1017,)
(1023,)
(1021,)
*/