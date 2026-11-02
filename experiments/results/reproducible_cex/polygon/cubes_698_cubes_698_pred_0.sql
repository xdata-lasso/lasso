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
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (24, '32', '32', '32', '32', '32', '32', '32', '32');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (23, '32', '32', '32', '32', '32', '32', '32', '32');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES (32, '47', '48', '49');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES (31, '56', NULL, NULL);
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (26, '32', '32', '32');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (25, '32', '32', '32');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (27, 25, '32', '32', '32');
INSERT INTO "Sections" ("section_id", "course_id", "section_name", "section_description", "other_details") VALUES (30, 31, '50', '51', '52');
INSERT INTO "Sections" ("section_id", "course_id", "section_name", "section_description", "other_details") VALUES (29, 32, NULL, NULL, NULL);
INSERT INTO "Semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (34, '32', '32', '32');
INSERT INTO "Semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (33, '32', '32', '32');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (36, 23, NULL, '32', '32', '32', '32', '32', '32', 32, 32, '32');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (35, 23, 23, '32', '32', '32', '32', '32', '32', 32, 32, '32');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (37, 35, NULL, NULL, '32');
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (39, NULL, 31);
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (42, 32, '32');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (41, 32, '32');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT course_name, course_id FROM (SELECT course_id, course_name, course_description, other_details, section_id, section_name, section_description, other_details_other, COUNT(*) OVER () AS n FROM (SELECT LHS.course_id AS course_id, LHS.course_name AS course_name, LHS.course_description AS course_description, LHS.other_details AS other_details, RHS.section_id AS section_id, RHS.section_name AS section_name, RHS.section_description AS section_description, RHS.other_details AS other_details_other FROM courses AS LHS INNER JOIN sections AS RHS ON (LHS.course_id = RHS.course_id))) WHERE (n >= 2) ORDER BY course_name, course_id NULLS LAST;

/*
Gold Result:
('47', 32)
('56', 31)
*/

-- Prediction Query
SELECT T1.course_name, T1.course_id FROM Courses AS T1 JOIN Sections AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_id HAVING COUNT(*) <= 2;

/*
Prediction Result:
('56', 31)
('47', 32)
*/