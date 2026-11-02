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
-- Tests basic filtering (Pass vs Fail, pass, NULL), duplicates (SELECT vs SELECT DISTINCT), and ordering by candidate_id.
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (1, 'Alice', 'Smith');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (2, 'Bob', 'Jones');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (3, 'Charlie', 'Brown');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (4, 'Diana', 'Prince');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (1, 'Details 1');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (2, 'Details 2');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (3, 'Details 3');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (4, 'Details 4');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (3, 'Q1', '2023-01-01', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (1, 'Q2', '2023-01-02', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (1, 'Q1', '2023-01-03', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (1, 'Q3', '2023-01-04', 'Fail');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (2, 'Q1', '2023-01-05', 'Fail');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (2, 'Q2', '2023-01-06', 'pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (2, 'Q3', '2023-01-07', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "candidate_id" FROM "candidate_assessments" WHERE ("asessment_outcome_code" = 'Pass') ORDER BY candidate_id, candidate_assessments.qualification NULLS LAST;

/*
Gold Result:
(1,)
(1,)
(3,)
*/

-- Prediction Query
SELECT candidate_id FROM candidate_assessments WHERE asessment_outcome_code = 'Pass';

/*
Prediction Result:
(3,)
(1,)
(1,)
*/