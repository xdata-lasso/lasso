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
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (33, '55', '55', '55', '55', '55', '55', '55', '55');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (34, '55', '55', '55', '55', '55', '55', '55', '55');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES (24, '55', '55', '55');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (26, '55', '55', '55');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (25, '55', '55', '55');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (27, 25, '55', '55', '55');
INSERT INTO "Sections" ("section_id", "course_id", "section_name", "section_description", "other_details") VALUES (29, 24, '55', '55', '55');
INSERT INTO "Sections" ("section_id", "course_id", "section_name", "section_description", "other_details") VALUES (28, 24, '55', '55', '55');
INSERT INTO "Semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (30, '55', '55', '55');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (32, 33, 34, '55', '40', '41', '42', '43', '47', 44, 45, '46');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (31, 33, 34, '55', '48', '49', '50', '51', '47', 52, 53, '54');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (35, 31, 30, 27, '55');
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (36, 35, 24);
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (37, 55, '55');
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (37, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT LHS.student_id AS student_id, LHS.current_address_id AS current_address_id, LHS.permanent_address_id AS permanent_address_id, LHS.first_name AS first_name, LHS.middle_name AS middle_name, LHS.last_name AS last_name, LHS.cell_mobile_number AS cell_mobile_number, LHS.email_address AS email_address, LHS.ssn AS ssn, LHS.date_first_registered AS date_first_registered, LHS.date_left AS date_left, LHS.other_student_details AS other_student_details, RHS.student_id AS student_id_other, RHS.current_address_id AS current_address_id_other, RHS.permanent_address_id AS permanent_address_id_other, RHS.middle_name AS middle_name_other, RHS.last_name AS last_name_other, RHS.cell_mobile_number AS cell_mobile_number_other, RHS.email_address AS email_address_other, RHS.date_first_registered AS date_first_registered_other, RHS.date_left AS date_left_other, RHS.other_student_details AS other_student_details_other FROM students AS LHS INNER JOIN students AS RHS ON (LHS.first_name = RHS.first_name AND LHS.ssn = RHS.ssn)) ORDER BY first_name;

/*
Gold Result:
('55',)
('55',)
('55',)
('55',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE current_address_id <> permanent_address_id;

/*
Prediction Result:
('55',)
('55',)
*/