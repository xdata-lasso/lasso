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
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (22, '37', '37', '37', '37', '37', '37', '37', '37');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (21, '37', '37', '37', '37', '37', '37', '37', '37');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES (24, '37', '37', '37');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES (23, '37', '37', '37');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (26, '37', '37', '37');
INSERT INTO "Departments" ("department_id", "department_name", "department_description", "other_details") VALUES (25, '37', '37', '37');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (28, 25, '37', '37', '37');
INSERT INTO "Degree_Programs" ("degree_program_id", "department_id", "degree_summary_name", "degree_summary_description", "other_details") VALUES (27, NULL, '37', '37', '37');
INSERT INTO "Sections" ("section_id", "course_id", "section_name", "section_description", "other_details") VALUES (30, 24, '37', '37', '37');
INSERT INTO "Semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (32, '37', '37', '37');
INSERT INTO "Semesters" ("semester_id", "semester_name", "semester_description", "other_details") VALUES (31, '37', '37', '37');
INSERT INTO "Students" ("student_id", "permanent_address_id", "current_address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "ssn", "date_first_registered", "date_left", "other_student_details") VALUES (33, 21, 22, '37', '37', '37', '37', '37', '37', 37, 37, '37');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (35, 33, NULL, 28, '37');
INSERT INTO "Student_Enrolment" ("student_enrolment_id", "student_id", "semester_id", "degree_program_id", "other_details") VALUES (34, 33, NULL, 27, '37');
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (39, 34, 23);
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (36, 35, 23);
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (38, NULL, '43');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (37, NULL, NULL);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (37, 39);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (38, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transcript_date, n AS transcript_id FROM (SELECT transcript_id, transcript_date, other_details, transcript_id AS n FROM (SELECT LHS.transcript_id AS transcript_id, LHS.transcript_date AS transcript_date, LHS.other_details AS other_details, LHS.n AS n FROM (SELECT transcript_id, transcript_date, other_details, COUNT(*) OVER () AS n FROM transcripts) AS LHS INNER JOIN (SELECT transcript_id, COUNT(*) AS n FROM transcript_contents GROUP BY transcript_id) AS RHS ON (LHS.transcript_id = RHS.n AND LHS.n = RHS.transcript_id))) ORDER BY transcript_date, transcript_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.transcript_date, T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id ORDER BY COUNT(*) ASC, T2.transcript_date NULLS LAST, T1.transcript_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, 37)
*/