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
-- Tests OR vs AND, WHERE clause filtering, column swapping (first_name vs middle_name vs last_name), and projection vs other columns (email, ssn).
INSERT INTO "Students" ("student_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn") VALUES (1, 'Timmothy', 'A', 'Smith', '555-0103', 'tim@example.com', '111-11-1111');
INSERT INTO "Students" ("student_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn") VALUES (2, 'John', 'B', 'Ward', '555-0101', 'john@example.com', '222-22-2222');
INSERT INTO "Students" ("student_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn") VALUES (3, 'Timmothy', 'C', 'Ward', '555-0102', 'timward@example.com', '333-33-3333');
INSERT INTO "Students" ("student_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn") VALUES (4, 'Alice', 'Timmothy', 'Doe', '555-0100', 'alice@example.com', '444-44-4444');
INSERT INTO "Students" ("student_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn") VALUES (5, 'Ward', 'D', 'Timmothy', '555-0104', 'ward@example.com', '555-55-5555');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cell_mobile_number" FROM "students" WHERE ("first_name" = 'Timmothy' OR "last_name" = 'Ward') ORDER BY cell_mobile_number, students.student_id NULLS LAST;

/*
Gold Result:
('555-0101',)
('555-0102',)
('555-0103',)
*/

-- Prediction Query
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward';

/*
Prediction Result:
('555-0102',)
*/