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
-- DATASET 3
-- Tests ORDER BY transcript_date, transcript_id NULLS LAST, including tie-breaking, anti-correlated IDs/dates, and NULL transcript_dates.
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (301, NULL, NULL);
INSERT INTO "Student_Enrolment_Courses" ("student_course_id", "student_enrolment_id", "course_id") VALUES (302, NULL, NULL);
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (50, '2022-01-10 00:00:00', 'Earliest date, highest ID');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (40, '2022-06-15 12:00:00', 'Tied date, higher ID');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (10, '2022-06-15 12:00:00', 'Tied date, lower ID');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (30, NULL, 'NULL date, higher ID');
INSERT INTO "Transcripts" ("transcript_id", "transcript_date", "other_details") VALUES (20, NULL, 'NULL date, lower ID');
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (50, 301);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (50, 302);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (40, 301);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (40, 302);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (10, 301);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (10, 302);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (30, 301);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (30, 302);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (20, 301);
INSERT INTO "Transcript_Contents" ("transcript_id", "student_course_id") VALUES (20, 302);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transcript_date, transcript_id FROM (SELECT LHS.transcript_id AS transcript_id, LHS.transcript_date AS transcript_date, LHS.other_details AS other_details, RHS.n AS n FROM transcripts AS LHS INNER JOIN (SELECT transcript_id, COUNT(*) AS n FROM transcript_contents GROUP BY transcript_id) AS RHS ON (LHS.transcript_id = RHS.transcript_id)) WHERE (n >= 2) ORDER BY transcript_date, transcript_id NULLS LAST;

/*
Gold Result:
(None, 20)
(None, 30)
('2022-01-10 00:00:00', 50)
('2022-06-15 12:00:00', 10)
('2022-06-15 12:00:00', 40)
*/

-- Prediction Query
SELECT T2.transcript_date, T1.transcript_id FROM Transcript_Contents AS T1 JOIN Transcripts AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('2022-06-15 12:00:00', 10)
(None, 20)
(None, 30)
('2022-06-15 12:00:00', 40)
('2022-01-10 00:00:00', 50)
*/