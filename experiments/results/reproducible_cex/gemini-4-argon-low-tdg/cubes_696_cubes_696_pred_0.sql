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
-- Tests basic ascending ordering, duplicates (to kill SELECT DISTINCT mutants), and NULL handling in other_student_details
INSERT INTO "Addresses" ("address_id", "line_1", "city", "country") VALUES (1, '123 Main St', 'Metropolis', 'USA');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name", "other_student_details") VALUES (1, 1, 1, 'Alice', 'Smith', 'Zebra');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name", "other_student_details") VALUES (2, 1, 1, 'Bob', 'Jones', 'Apple');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name", "other_student_details") VALUES (3, 1, 1, 'Charlie', 'Brown', 'Apple');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name", "other_student_details") VALUES (4, 1, 1, 'David', 'Wilson', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_student_details FROM students ORDER BY other_student_details, students.student_id NULLS LAST;

/*
Gold Result:
(None,)
('Apple',)
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT other_student_details FROM Students ORDER BY other_student_details DESC, Students.student_id NULLS LAST;

/*
Prediction Result:
('Zebra',)
('Apple',)
('Apple',)
(None,)
*/