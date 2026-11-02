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
INSERT INTO Addresses (address_id, line_1, city, country, other_address_details) VALUES (1, '123 Main St', 'Boston', 'USA', 'Addr_Detail_1');
INSERT INTO Addresses (address_id, line_1, city, country, other_address_details) VALUES (2, '456 Oak Ave', 'Boston', 'USA', 'Addr_Detail_2');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (1, 1, 1, 'Charlie', 'C', 'Clark', '555-0001', 'c@edu.com', '111-11-1111', '2020-09-01 00:00:00', NULL, 'Zeta_Details');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (2, 1, 2, 'Alice', 'A', 'Adams', '555-0002', 'a@edu.com', '222-22-2222', '2019-09-01 00:00:00', '2023-05-01 00:00:00', 'Alpha_Details');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (3, 2, 1, 'Bob', 'B', 'Baker', '555-0003', 'b@edu.com', '333-33-3333', '2021-01-15 00:00:00', '2022-05-01 00:00:00', 'Alpha_Details');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (4, NULL, NULL, 'David', NULL, 'Davis', NULL, NULL, NULL, NULL, NULL, 'Beta_Details');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_student_details FROM students ORDER BY other_student_details, students.student_id NULLS LAST;

/*
Gold Result:
('Alpha_Details',)
('Alpha_Details',)
('Beta_Details',)
('Zeta_Details',)
*/

-- Prediction Query
SELECT other_student_details FROM Students ORDER BY other_student_details DESC, Students.student_id NULLS LAST;

/*
Prediction Result:
('Zeta_Details',)
('Beta_Details',)
('Alpha_Details',)
('Alpha_Details',)
*/