-- Schema DDL
CREATE TABLE Students (student_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, enrollment_year INTEGER, major TEXT);

CREATE TABLE Courses (course_id INTEGER PRIMARY KEY, course_code TEXT, course_name TEXT, credits INTEGER, department TEXT);

CREATE TABLE Enrollments (enrollment_id INTEGER PRIMARY KEY, student_id INTEGER, course_id INTEGER, semester TEXT, grade TEXT, FOREIGN KEY (student_id) REFERENCES Students (student_id), FOREIGN KEY (course_id) REFERENCES Courses (course_id));

CREATE TABLE Professors (professor_id INTEGER PRIMARY KEY, name TEXT, department TEXT, hire_date DATE, salary REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1047, 'executive', 'Matthew Foster', 1055, 'newspaper');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1048, 'attorney', 'Judy Baker', 1064.0, 'enter');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1049, 'development', 'Justin Baker', 1073.0, 'on');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1050, 'white', 'Stephanie Ross', 1082.0, 'traditional');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1051, 'yes', 'Zachary Hicks', 1091.0, 'activity');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1052, 'our', 'Anthony Rodriguez', 1100.0, 'response');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1053, 'under', 'Rebecca Henderson', 1109.0, 'set');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1054, 'serious', 'James Ferrell', 1118.0, 'building');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1087, 'article', 'Philip Cannon', 1095, 'avoid');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1088, 'effect', 'John Pierce', 1104.0, 'second');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1089, 'your', 'Shane Henderson', 1113.0, 'program');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1090, 'bar', 'Joshua Blair', 1122.0, 'artist');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1091, 'bed', 'Eric Carney', 1131.0, 'drop');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1092, 'sign', 'Jessica Holmes', 1140.0, 'author');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1093, 'mention', 'Danny Morgan', 1149.0, 'western');
INSERT INTO "courses" ("course_id", "course_code", "course_name", "credits", "department") VALUES (1094, 'team', 'Crystal Robinson', 1158.0, 'almost');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1063, 'Erin', 'Liu', 1071, 'politics');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1064, 'Amanda', 'Baker', 1080.0, 'decide');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1065, 'Joseph', 'Mason', 1089.0, 'claim');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1066, 'Danielle', 'White', 1098.0, 'hour');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1067, 'Daniel', 'Gaines', 1107.0, 'sound');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1068, 'Ryan', 'Harrell', 1116.0, 'color');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1069, 'Shawn', 'Evans', 1125.0, 'notice');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1070, 'Stephanie', 'Fowler', 1134.0, 'start');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1103, 'Michele', 'Kennedy', 1111, 'shoulder');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1104, 'Chad', 'Mueller', 1120.0, 'arm');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1105, 'John', 'Aguirre', 1129.0, 'report');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1106, 'Elizabeth', 'Lee', 1138.0, 'ready');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1107, 'Jason', 'Davis', 1147.0, 'race');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1108, 'David', 'Jordan', 1156.0, 'billion');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1109, 'Selena', 'Henderson', 1165.0, 'ask');
INSERT INTO "students" ("student_id", "first_name", "last_name", "enrollment_year", "major") VALUES (1110, 'Ashley', 'Owens', 1174.0, 'interesting');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1079, 1063, 1047, 'wind', 'bag');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1080, 1064, 1048, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1081, 1065, 1049, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1082, 1066, 1050, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1083, 1067, 1051, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1084, 1068, 1052, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1085, 1069, 1053, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1086, 1070, 1054, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1119, 1103, 1087, 'wind', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1120, 1104, 1088, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1121, 1105, 1089, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1122, 1106, 1090, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1123, 1107, 1091, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1124, 1108, 1092, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1125, 1109, 1093, 'two', 'level');
INSERT INTO "enrollments" ("enrollment_id", "student_id", "course_id", "semester", "grade") VALUES (1126, 1110, 1094, 'two', 'level');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade ASC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Gold Result:
(1063,)
(1103,)
(1064,)
(1065,)
(1066,)
*/

-- Prediction Query
SELECT student_id FROM Enrollments ORDER BY semester DESC, grade DESC, Enrollments.enrollment_id NULLS LAST LIMIT 5;

/*
Prediction Result:
(1103,)
(1063,)
(1064,)
(1065,)
(1066,)
*/