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
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', 'alice', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Bob', 'J', 'Jones', '555-0102', 'bob@example.com', 'bob', 'pass2');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (3, 'Carol', 'A', 'White', '555-0103', 'carol@example.com', 'carol', 'pass3');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (4, 'David', 'K', 'Brown', '555-0104', 'david@example.com', 'david', 'pass4');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (5, 'Eve', 'L', 'Green', '555-0105', 'eve@example.com', 'eve', 'pass5');
INSERT INTO Students (student_id, student_details) VALUES (1, 'Full-time');
INSERT INTO Students (student_id, student_details) VALUES (2, 'Part-time');
INSERT INTO Students (student_id, student_details) VALUES (3, 'Full-time');
INSERT INTO Students (student_id, student_details) VALUES (4, 'Exchange');
INSERT INTO Students (student_id, student_details) VALUES (5, 'Unregistered Student');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('10', 'Databases', 'Intro to SQL', 'Core');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('20', 'Algorithms', 'Data Structures', 'Core');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('30', 'Networks', 'Computer Networks', 'Elective');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('40', 'Compilers', 'Compiler Design', 'Elective');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('50', 'Operating Systems', 'OS Internals', 'Core');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (4, 10, '2023-03-01 10:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (2, 40, '2023-04-01 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (1, 30, '2023-01-15 08:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (3, 20, '2023-02-10 11:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (1, 10, '2023-03-05 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (3, 20, '2023-02-15 11:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, course_id, registration_date FROM (SELECT * FROM student_course_registrations AS LHS WHERE NOT EXISTS(SELECT 1 FROM student_course_attendance AS RHS WHERE (LHS.student_id = RHS.student_id))) ORDER BY student_id, course_id NULLS LAST, registration_date NULLS LAST;

/*
Gold Result:
(2, 40, '2023-04-01 09:00:00')
(4, 10, '2023-03-01 10:00:00')
*/

-- Prediction Query
SELECT * FROM student_course_registrations WHERE NOT student_id IN (SELECT student_id FROM student_course_attendance);

/*
Prediction Result:
(4, 10, '2023-03-01 10:00:00')
(2, 40, '2023-04-01 09:00:00')
*/