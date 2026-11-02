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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1001, 'purpose', 'brother', 'ago', 'Johnberg', '97031', 'Connecticut', 'Philippines', '600 Jeffery Parkways
New Jamesside, MT 29394');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1003, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1005, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1002, 1001, 1003, 'Shane', 'Sean Blake', 'Moore', '(254)923-5116x15594', 'dudleynicholas@example.net', 'finally', '1970-01-01', '1971-02-02', 'themselves');
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1004, 1001, 1005, 'Shane', 'Stacey Ward', 'Lee', '903-741-3164', 'mitchellclark@example.com', 'finally', '1972-03-03', '1973-04-04', 'science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT LHS.student_id AS student_id, LHS.current_address_id AS current_address_id, LHS.permanent_address_id AS permanent_address_id, LHS.first_name AS first_name, LHS.middle_name AS middle_name, LHS.last_name AS last_name, LHS.cell_mobile_number AS cell_mobile_number, LHS.email_address AS email_address, LHS.ssn AS ssn, LHS.date_first_registered AS date_first_registered, LHS.date_left AS date_left, LHS.other_student_details AS other_student_details, RHS.student_id AS student_id_other, RHS.current_address_id AS current_address_id_other, RHS.permanent_address_id AS permanent_address_id_other, RHS.middle_name AS middle_name_other, RHS.last_name AS last_name_other, RHS.cell_mobile_number AS cell_mobile_number_other, RHS.email_address AS email_address_other, RHS.date_first_registered AS date_first_registered_other, RHS.date_left AS date_left_other, RHS.other_student_details AS other_student_details_other FROM students AS LHS INNER JOIN students AS RHS ON (LHS.first_name = RHS.first_name AND LHS.ssn = RHS.ssn)) ORDER BY first_name;

/*
Gold Result:
('Shane',)
('Shane',)
('Shane',)
('Shane',)
*/

-- Prediction Query
SELECT first_name FROM Students WHERE current_address_id <> permanent_address_id;

/*
Prediction Result:
('Shane',)
('Shane',)
*/