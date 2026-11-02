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
INSERT INTO Addresses (address_id, line_1, city, country) VALUES (1, '123 Main St', 'Springfield', 'USA');
INSERT INTO Addresses (address_id, line_1, city, country) VALUES (2, '456 Oak Ave', 'Metropolis', 'USA');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (1, 1, 1, 'Zara', 'M', 'Smith', '111-1111', 'zara@example.com', '100-01', '2020-01-01', '2024-01-01', 'None');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (2, 1, 2, 'Alice', 'A', 'Jones', '222-2222', 'alice1@example.com', '200-02', '2020-01-01', '2024-01-01', 'None');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (3, 2, 1, 'Alice', 'B', 'Brown', '333-3333', 'alice2@example.com', '200-02', '2021-01-01', '2025-01-01', 'Other');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (4, 2, 2, 'Bob', NULL, 'White', '444-4444', 'bob@example.com', NULL, '2021-01-01', NULL, NULL);
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (5, 1, 1, NULL, 'C', 'Green', '555-5555', 'null@example.com', '500-05', '2021-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT LHS.student_id AS student_id, LHS.current_address_id AS current_address_id, LHS.permanent_address_id AS permanent_address_id, LHS.first_name AS first_name, LHS.middle_name AS middle_name, LHS.last_name AS last_name, LHS.cell_mobile_number AS cell_mobile_number, LHS.email_address AS email_address, LHS.ssn AS ssn, LHS.date_first_registered AS date_first_registered, LHS.date_left AS date_left, LHS.other_student_details AS other_student_details, RHS.student_id AS student_id_other, RHS.current_address_id AS current_address_id_other, RHS.permanent_address_id AS permanent_address_id_other, RHS.middle_name AS middle_name_other, RHS.last_name AS last_name_other, RHS.cell_mobile_number AS cell_mobile_number_other, RHS.email_address AS email_address_other, RHS.date_first_registered AS date_first_registered_other, RHS.date_left AS date_left_other, RHS.other_student_details AS other_student_details_other FROM students AS LHS INNER JOIN students AS RHS ON (LHS.first_name = RHS.first_name AND LHS.ssn = RHS.ssn)) ORDER BY first_name;

/*
Gold Result:
('Alice',)
('Alice',)
('Alice',)
('Alice',)
('Zara',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE current_address_id <> permanent_address_id;

/*
Prediction Result:
('Alice',)
('Alice',)
*/