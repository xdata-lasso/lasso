-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(255), "line_2" TEXT(255), "line_3" TEXT(255), "city" TEXT(255), "zip_postcode" TEXT(20), "state_province_county" TEXT(255), "country" TEXT(255), "other_address_details" TEXT(255));

CREATE TABLE "Courses" ("course_id" INTEGER PRIMARY KEY, "course_name" TEXT(255), "course_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Departments" ("department_id" INTEGER PRIMARY KEY, "department_name" TEXT(255), "department_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Degree_Programs" ("degree_program_id" INTEGER PRIMARY KEY, "department_id" INTEGER, "degree_summary_name" TEXT(255), "degree_summary_description" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("department_id") REFERENCES "Departments" ("department_id"));

CREATE TABLE "Sections" ("section_id" INTEGER PRIMARY KEY, "course_id" INTEGER, "section_name" TEXT(255), "section_description" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Semesters" ("semester_id" INTEGER PRIMARY KEY, "semester_name" TEXT(255), "semester_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "permanent_address_id" INTEGER, "current_address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(40), "last_name" TEXT(40), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "ssn" TEXT(40), "date_first_registered" DATETIME, "date_left" DATETIME, "other_student_details" TEXT(255), FOREIGN KEY ("permanent_address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("current_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Student_Enrolment" ("student_enrolment_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "semester_id" INTEGER, "degree_program_id" INTEGER, "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("semester_id") REFERENCES "Semesters" ("semester_id"), FOREIGN KEY ("degree_program_id") REFERENCES "Degree_Programs" ("degree_program_id"));

CREATE TABLE "Student_Enrolment_Courses" ("student_course_id" INTEGER PRIMARY KEY, "student_enrolment_id" INTEGER, "course_id" INTEGER, FOREIGN KEY ("student_enrolment_id") REFERENCES "Student_Enrolment" ("student_enrolment_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"));

CREATE TABLE "Transcripts" ("transcript_id" INTEGER PRIMARY KEY, "transcript_date" DATETIME, "other_details" TEXT(255));

CREATE TABLE "Transcript_Contents" ("transcript_id" INTEGER, "student_course_id" INTEGER, FOREIGN KEY ("transcript_id") REFERENCES "Transcripts" ("transcript_id"), FOREIGN KEY ("student_course_id") REFERENCES "Student_Enrolment_Courses" ("student_course_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Main St', NULL, NULL, 'Boston', '02101', 'MA', 'USA', 'Addr Detail 1');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, '20 Oak Ave', NULL, NULL, 'Cambridge', '02139', 'MA', 'USA', 'Addr Detail 2');
INSERT INTO Departments (department_id, department_name, department_description, other_details) VALUES (1, 'Computer Science', 'CS Dept', 'Dept Detail 1');
INSERT INTO Degree_Programs (degree_program_id, department_id, degree_summary_name, degree_summary_description, other_details) VALUES (1, 1, 'BSc CS', 'Bachelors in CS', 'Deg Detail 1');
INSERT INTO Semesters (semester_id, semester_name, semester_description, other_details) VALUES (1, 'Fall 2023', 'Fall Term', 'Sem Detail 1');
INSERT INTO Semesters (semester_id, semester_name, semester_description, other_details) VALUES (2, 'Spring 2024', 'Spring Term', 'Sem Detail 2');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (1, 1, 1, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', '111-11-1111', '2021-09-01 00:00:00', NULL, 'Detail Z');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (2, 1, 2, 'Bob', 'J', 'Jones', '555-0102', 'bob@example.com', '222-22-2222', '2020-09-01 00:00:00', '2023-05-15 00:00:00', 'Detail A');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (3, NULL, NULL, 'Charlie', NULL, 'Brown', '555-0103', 'charlie@example.com', '333-33-3333', '2022-01-10 00:00:00', NULL, 'Detail A');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (4, 2, NULL, 'David', 'K', 'Taylor', '555-0104', 'david@example.com', '444-44-4444', '2019-09-01 00:00:00', '2022-06-01 00:00:00', 'Detail M');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id, other_details) VALUES (1, 1, 1, 1, 'Enrol Detail 1');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id, other_details) VALUES (2, 1, 2, 1, 'Enrol Detail 2');
INSERT INTO Student_Enrolment (student_enrolment_id, student_id, semester_id, degree_program_id, other_details) VALUES (3, 2, 1, 1, 'Enrol Detail 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_student_details FROM students ORDER BY other_student_details, students.student_id NULLS LAST;

/*
Gold Result:
('Detail A',)
('Detail A',)
('Detail M',)
('Detail Z',)
*/

-- Prediction Query
SELECT other_student_details FROM Students ORDER BY other_student_details DESC, Students.student_id NULLS LAST;

/*
Prediction Result:
('Detail Z',)
('Detail M',)
('Detail A',)
('Detail A',)
*/