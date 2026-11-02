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
-- Comprehensive test: Tests NOT EXISTS vs EXISTS/INNER JOIN, string predicates ('Master', 'Bachelor', 'PhD', 'Master of Science', 'master'), duplicates (SELECT vs SELECT DISTINCT), and ORDER BY (ASC vs DESC vs insertion order).
INSERT INTO "Departments" ("department_id", "department_name") VALUES (10, 'Computer Science');
INSERT INTO "Departments" ("department_id", "department_name") VALUES (20, 'Mathematics');
INSERT INTO "Departments" ("department_id", "department_name") VALUES (30, 'Physics');
INSERT INTO "Departments" ("department_id", "department_name") VALUES (40, 'Biology');
INSERT INTO "Departments" ("department_id", "department_name") VALUES (50, 'Chemistry');
INSERT INTO "Departments" ("department_id", "department_name") VALUES (60, 'Engineering');
INSERT INTO "Addresses" ("address_id", "city") VALUES (1, 'Boston');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name") VALUES (1, 1, 1, 'Alice');
INSERT INTO "Semesters" ("semester_id", "semester_name") VALUES (1, 'Fall 2023');
-- Unenrolled Master programs (inserted out of department_id order, with duplicates for dept 20)
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (1, 30, 'Master');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (2, 10, 'Master');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (3, 20, 'Master');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (4, 20, 'Master');
-- Enrolled Master program (should be excluded by NOT EXISTS)
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (5, 40, 'Master');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id") VALUES (1, 1, 1, 5);
-- Unenrolled non-Master programs (should be excluded by WHERE clause)
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (6, 50, 'Bachelor');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (7, 50, 'PhD');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (8, 50, 'Master of Science');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (9, 50, 'master');
-- Enrolled non-Master programs
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (10, 60, 'Bachelor');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name") VALUES (11, 60, 'PhD');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id") VALUES (2, 1, 1, 10);
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id") VALUES (3, 1, 1, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "department_id" AS "semester_id" FROM (SELECT * FROM "degree_programs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM "student_enrolment" AS "RHS" WHERE ("LHS"."degree_program_id" = "RHS"."degree_program_id"))) WHERE ("degree_summary_name" <> 'Bachelor' AND "degree_summary_name" = 'Master') ORDER BY semester_id;

/*
Gold Result:
(10,)
(20,)
(20,)
(30,)
*/

-- Prediction Query
SELECT DISTINCT T2.semester_id FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id WHERE degree_summary_name = 'Master' INTERSECT SELECT DISTINCT T2.semester_id FROM Degree_Programs AS T1 JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id WHERE degree_summary_name = 'Bachelor';

/*
Prediction Result:
(1,)
*/