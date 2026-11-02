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
-- Tests COUNT(DISTINCT department_name) vs COUNT(DISTINCT department_id), COUNT(*), or COUNT(degree_program_id).
-- Also tests WHERE filter (exact match 'engineer' vs LIKE '%engineer%', case sensitivity, or missing WHERE).
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (1, 'engineer', 'Engineering Dept 1', 'D1');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (2, 'engineer', 'Engineering Dept 2', 'D2');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (3, 'science', 'Science Dept', 'D3');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (4, 'software engineer', 'Software Engineering', 'D4');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (5, 'Engineer', 'Capitalized Engineer', 'D5');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (101, 1, 'BSc Eng', 'engineer', 'P1');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (102, 1, 'MSc Eng', 'Master of Engineering', 'P2');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (103, 2, 'PhD Eng', 'Doctor of Engineering', 'P3');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (104, 3, 'engineer', 'BSc Science', 'P4');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (105, 4, 'BSc SE', 'Bachelor of SE', 'P5');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (106, 5, 'BSc CapEng', 'Bachelor of CapEng', 'P6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count___" FROM (SELECT COUNT(DISTINCT "department_name") AS "n_distinct" FROM (SELECT * FROM (SELECT "LHS"."degree_program_id" AS "degree_program_id", "LHS"."department_id" AS "department_id", "LHS"."degree_summary_name" AS "degree_summary_name", "LHS"."degree_summary_description" AS "degree_summary_description", "LHS"."other_details" AS "other_details", "RHS"."department_name" AS "department_name", "RHS"."department_description" AS "department_description", "RHS"."other_details" AS "other_details_other" FROM "degree_programs" AS "LHS" INNER JOIN "departments" AS "RHS" ON ("LHS"."department_id" = "RHS"."department_id")) WHERE ("department_name" = 'engineer'))) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Departments AS T1 JOIN Degree_Programs AS T2 ON T1.department_id = T2.department_id WHERE T1.department_name = 'engineer';

/*
Prediction Result:
(3,)
*/