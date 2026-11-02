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
-- DATASET 2
-- Tests duplicate last_name preservation (SELECT vs SELECT DISTINCT), ordering (ASC vs DESC), and NULL last_name handling (NULLS LAST).
INSERT INTO "Addresses" ("address_id", "line_1", "city", "state_province_county", "country") VALUES (10, '10 Pine St', 'Charlotte', 'NorthCarolina', 'USA');
-- Multiple unenrolled students in NorthCarolina with identical last names, distinct last names, and a NULL last name
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name") VALUES (10, 10, 10, 'Zack', 'Zimmerman');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name") VALUES (11, 10, 10, 'Aaron', 'Abbott');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name") VALUES (12, 10, 10, 'Amy', 'Abbott');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name") VALUES (13, 10, 10, 'Mystery', NULL);
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "last_name") VALUES (14, 10, 10, 'Bella', 'Benson');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "last_name" FROM (SELECT "student_id", "current_address_id", "permanent_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details", "current_address_id" AS "address_id" FROM (SELECT "LHS"."student_id" AS "student_id", "LHS"."current_address_id" AS "current_address_id", "LHS"."permanent_address_id" AS "permanent_address_id", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."cell_mobile_number" AS "cell_mobile_number", "LHS"."email_address" AS "email_address", "LHS"."ssn" AS "ssn", "LHS"."date_first_registered" AS "date_first_registered", "LHS"."date_left" AS "date_left", "LHS"."other_student_details" AS "other_student_details", "RHS"."line_1" AS "line_1", "RHS"."line_2" AS "line_2", "RHS"."line_3" AS "line_3", "RHS"."city" AS "city", "RHS"."zip_postcode" AS "zip_postcode", "RHS"."state_province_county" AS "state_province_county", "RHS"."country" AS "country", "RHS"."other_address_details" AS "other_address_details" FROM (SELECT * FROM "students" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM "student_enrolment" AS "RHS" WHERE ("LHS"."student_id" = "RHS"."student_id"))) AS "LHS" INNER JOIN "addresses" AS "RHS" ON ("LHS"."current_address_id" = "RHS"."address_id"))) WHERE ("state_province_county" = 'NorthCarolina') ORDER BY last_name, "last_name" NULLS LAST;

/*
Gold Result:
(None,)
('Abbott',)
('Abbott',)
('Benson',)
('Zimmerman',)
*/

-- Prediction Query
SELECT T1.last_name FROM Students AS T1 JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id WHERE T2.state_province_county = 'NorthCarolina' EXCEPT SELECT DISTINCT T3.last_name FROM Students AS T3 JOIN Student_Enrolment AS T4 ON T3.student_id = T4.student_id;

/*
Prediction Result:
(None,)
('Abbott',)
('Benson',)
('Zimmerman',)
*/