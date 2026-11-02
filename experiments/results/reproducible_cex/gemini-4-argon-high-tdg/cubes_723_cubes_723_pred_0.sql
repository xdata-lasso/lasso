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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Main St', 'Apt 1', 'Floor 1', 'Boston', '02101', 'MA', 'USA', 'Near park');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, '20 Oak Ave', 'Suite 2', 'Floor 2', 'Austin', '73301', 'TX', 'USA', 'Corner lot');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (3, '30 Pine Rd', 'Unit 3', 'Floor 3', 'Seattle', '98101', 'WA', 'USA', 'Downtown');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (1, 1, 1, 'Charlie', 'M', 'Adams', '555-0101', 'charlie@example.com', '900-00-0001', '2020-09-01 08:00:00', '2024-05-15 17:00:00', 'Senior');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (2, 1, 2, 'Bob', 'A', 'Zimmerman', '555-0102', 'bob1@example.com', '500-00-0002', '2021-09-01 08:00:00', '2023-05-15 17:00:00', 'Transfer');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (3, 2, 3, 'Bob', 'B', 'Baker', '555-0103', 'bob2@example.com', '500-00-0002', '2022-01-10 09:00:00', '2024-06-01 12:00:00', 'Duplicate record');
INSERT INTO Students (student_id, permanent_address_id, current_address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, ssn, date_first_registered, date_left, other_student_details) VALUES (4, 3, 3, 'Alice', 'C', 'Miller', '555-0104', 'alice@example.com', '700-00-0004', '2019-09-01 08:00:00', '2023-05-15 17:00:00', 'Honors');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT LHS.student_id AS student_id, LHS.current_address_id AS current_address_id, LHS.permanent_address_id AS permanent_address_id, LHS.first_name AS first_name, LHS.middle_name AS middle_name, LHS.last_name AS last_name, LHS.cell_mobile_number AS cell_mobile_number, LHS.email_address AS email_address, LHS.ssn AS ssn, LHS.date_first_registered AS date_first_registered, LHS.date_left AS date_left, LHS.other_student_details AS other_student_details, RHS.student_id AS student_id_other, RHS.current_address_id AS current_address_id_other, RHS.permanent_address_id AS permanent_address_id_other, RHS.middle_name AS middle_name_other, RHS.last_name AS last_name_other, RHS.cell_mobile_number AS cell_mobile_number_other, RHS.email_address AS email_address_other, RHS.date_first_registered AS date_first_registered_other, RHS.date_left AS date_left_other, RHS.other_student_details AS other_student_details_other FROM students AS LHS INNER JOIN students AS RHS ON (LHS.first_name = RHS.first_name AND LHS.ssn = RHS.ssn)) ORDER BY first_name;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Bob',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE current_address_id <> permanent_address_id;

/*
Prediction Result:
('Bob',)
('Bob',)
*/