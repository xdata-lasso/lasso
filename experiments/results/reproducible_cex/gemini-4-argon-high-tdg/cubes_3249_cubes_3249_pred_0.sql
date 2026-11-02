-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(80), "line_2" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "People" ("person_id" INTEGER PRIMARY KEY, "first_name" TEXT(255), "middle_name" TEXT(255), "last_name" TEXT(255), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "login_name" TEXT(40), "password" TEXT(40));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "student_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Courses" ("course_id" TEXT(100) PRIMARY KEY, "course_name" TEXT(120), "course_description" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "People_Addresses" ("person_address_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "person_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("person_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Student_Course_Registrations" ("student_id" INTEGER UNIQUE, "course_id" INTEGER UNIQUE, "registration_date" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("course_id") REFERENCES "Courses" ("course_id"), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"));

CREATE TABLE "Student_Course_Attendance" ("student_id" INTEGER, "course_id" INTEGER, "date_of_attendance" DATETIME, PRIMARY KEY ("student_id", "course_id"), FOREIGN KEY ("student_id") REFERENCES "Student_Course_Registrations" ("student_id"), FOREIGN KEY ("course_id") REFERENCES "Student_Course_Registrations" ("course_id"));

CREATE TABLE "Candidates" ("candidate_id" INTEGER PRIMARY KEY, "candidate_details" TEXT(255), FOREIGN KEY ("candidate_id") REFERENCES "People" ("person_id"));

CREATE TABLE "Candidate_Assessments" ("candidate_id" INTEGER, "qualification" TEXT(15), "assessment_date" DATETIME, "asessment_outcome_code" TEXT(15), PRIMARY KEY ("candidate_id", "qualification"), FOREIGN KEY ("candidate_id") REFERENCES "Candidates" ("candidate_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (10, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', 'asmith', 'pw1');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (20, 'Bob', 'J', 'Jones', '555-0102', 'bob@example.com', 'bjones', 'pw2');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (30, 'Charlie', 'K', 'Brown', '555-0103', 'charlie@example.com', 'cbrown', 'pw3');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (40, 'Diana', 'L', 'Prince', '555-0104', 'diana@example.com', 'dprince', 'pw4');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (50, 'Evan', 'N', 'Wright', '555-0105', 'evan@example.com', 'ewright', 'pw5');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (60, 'Fiona', 'P', 'Green', '555-0106', 'fiona@example.com', 'fgreen', 'pw6');
INSERT INTO "Students" ("student_id", "student_details") VALUES (60, 'Pass');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (30, 'Fail');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (10, 'Standard Candidate');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (20, 'Pass');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (40, 'Pass');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (50, 'Pending Candidate');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (30, 'A_Cert', '2020-01-01 09:00:00', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (10, 'Z_Cert', '2023-06-15 14:30:00', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (10, 'M_Cert', '2022-03-10 11:00:00', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (10, 'F_Cert', '2021-01-01 08:00:00', 'Fail');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (20, 'Pass', '2021-05-05 10:00:00', 'Fail');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (50, 'B_Cert', '2022-07-01 16:00:00', 'Pending');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "candidate_id" FROM "candidate_assessments" WHERE ("asessment_outcome_code" = 'Pass') ORDER BY candidate_id, candidate_assessments.qualification NULLS LAST;

/*
Gold Result:
(10,)
(10,)
(30,)
*/

-- Prediction Query
SELECT candidate_id FROM candidate_assessments WHERE asessment_outcome_code = 'Pass';

/*
Prediction Result:
(30,)
(10,)
(10,)
*/