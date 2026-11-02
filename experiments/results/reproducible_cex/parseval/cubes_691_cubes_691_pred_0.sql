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
-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483648, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: students --
INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (1, -2147483648, -2147483648, NULL, 'stu_bce5a9', 'Ward', 'stu_16fd85', 'stu_b0fcc4', 'stu_c61cfe', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (-2147483647, -2147483648, -2147483648, NULL, 'stu_bce5a9', 'Ward', 'stu_16fd85', 'stu_b0fcc4', 'stu_c61cfe', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (2, -2147483648, -2147483648, 'Timmothy', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (3, -2147483648, -2147483648, 'Timmothy', 'stu_bce5a9', 'Ward', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (4, -2147483648, -2147483648, 'Timmothy', 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (5, -2147483648, -2147483648, 'stu_dc5c98', 'stu_bce5a9', 'Ward', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (6, -2147483648, -2147483648, 'stu_dc5c98', 'stu_bce5a9', 'stu_6fdaa1', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (7, -2147483648, -2147483648, 'stu_dc5c98', 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (8, -2147483648, -2147483648, NULL, 'stu_bce5a9', 'stu_6fdaa1', 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (9, -2147483648, -2147483648, NULL, 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', 'stu_c61cfe', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (10, -2147483648, -2147483648, NULL, 'stu_bce5a9', 'Ward', NULL, 'stu_b0fcc4', 'stu_c61cfe', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00', 'stu_713836');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cell_mobile_number" FROM "students" WHERE ("first_name" = 'Timmothy' OR "last_name" = 'Ward') ORDER BY cell_mobile_number, students.student_id NULLS LAST;

/*
Gold Result:
(None,)
('stu_16fd85',)
('stu_16fd85',)
('stu_46e6b9',)
('stu_46e6b9',)
('stu_46e6b9',)
('stu_46e6b9',)
*/

-- Prediction Query
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward';

/*
Prediction Result:
('stu_46e6b9',)
*/