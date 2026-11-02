-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(80), "line_2" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "People" ("person_id" INTEGER PRIMARY KEY, "first_name" TEXT(255), "middle_name" TEXT(255), "last_name" TEXT(255), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "login_name" TEXT(40), "password" TEXT(40));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "student_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Courses" ("course_id" TEXT(100) PRIMARY KEY, "course_name" TEXT(120), "course_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "People_Addresses" ("person_address_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "person_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("person_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Student_Course_Registrations" ("student_id" INTEGER UNIQUE, "course_id" INTEGER UNIQUE, "registration_date" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"));

CREATE TABLE "Student_Course_Attendance" ("student_id" INTEGER, "course_id" INTEGER, "date_of_attendance" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("student_id") REFERENCES "Student_Course_Registrations" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Student_Course_Registrations" ("course_id"));

CREATE TABLE "Candidates" ("candidate_id" INTEGER PRIMARY KEY, "candidate_details" TEXT(255), FOREIGN KEY ("candidate_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Candidate_Assessments" ("candidate_id" INTEGER, "qualification" TEXT(15), "assessment_date" DATETIME, "asessment_outcome_code" TEXT(15), PRIMARY KEY ("candidate_id", "qualification"), FOREIGN KEY ("candidate_id") REFERENCES "Candidates" ("candidate_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (10, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', 'alice', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (18, 'Bob', 'J', 'Jones', '555-0102', 'bob@example.com', 'bob', 'pass2');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (25, 'Charlie', 'K', 'Brown', '555-0103', 'charlie@example.com', 'charlie', 'pass3');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (50, 'Diana', 'L', 'Prince', '555-0104', 'diana@example.com', 'diana', 'pass4');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (60, 'Evan', 'P', 'Wright', '555-0105', 'evan@example.com', 'evan', 'pass5');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (70, 'Fiona', 'Q', 'Green', '555-0106', 'fiona@example.com', 'fiona', 'pass6');
INSERT INTO Students (student_id, student_details) VALUES (10, 'Undergraduate');
INSERT INTO Students (student_id, student_details) VALUES (18, 'Graduate');
INSERT INTO Students (student_id, student_details) VALUES (25, 'Undergraduate');
INSERT INTO Students (student_id, student_details) VALUES (50, 'Graduate');
INSERT INTO Students (student_id, student_details) VALUES (60, 'Exchange');
INSERT INTO Students (student_id, student_details) VALUES (70, 'Undergraduate');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('1', 'Intro CS', 'Basic CS', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('300', 'Algorithms', 'Core CS', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('301', 'Databases', 'SQL and Relational Algebra', 'Core');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('302', 'Operating Systems', 'Kernel and Processes', 'Core');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('400', 'Networks', 'TCP/IP', 'Elective');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('500', 'Compilers', 'Parsing and Codegen', 'Elective');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (10, 301, '2023-01-01 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (18, 302, '2023-01-02 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (25, 300, '2023-01-03 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (50, 1, '2023-01-04 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (60, 400, '2023-01-05 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (70, 500, '2023-01-06 09:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (10, 301, '2023-05-01 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (25, 301, '2023-03-01 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (18, 301, '2023-01-15 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (50, 1, '2023-06-01 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (60, 300, '2023-06-02 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (70, 302, '2023-06-03 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM student_course_attendance WHERE (course_id = 301 AND course_id <> 1)) ORDER BY student_id DESC) LIMIT 1);

/*
Gold Result:
(25,)
*/

-- Prediction Query
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC, student_course_attendance.student_id NULLS LAST, student_course_attendance.course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/