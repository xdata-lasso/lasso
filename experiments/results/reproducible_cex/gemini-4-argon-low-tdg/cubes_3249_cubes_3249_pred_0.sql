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
-- DATASET 2
-- Tests string matching sensitivity (case sensitivity, substring matching, whitespace) and ORDER BY ASC vs DESC
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (10, 'Bob', 'Brown');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (20, 'Charlie', 'Davis');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (30, 'Eve', 'White');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (40, 'Frank', 'Black');
INSERT INTO "People" ("person_id", "first_name", "last_name") VALUES (50, 'Grace', 'Green');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (10, 'Details 10');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (20, 'Details 20');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (30, 'Details 30');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (40, 'Details 40');
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (50, 'Details 50');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (30, 'QualA', '2023-05-01', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (10, 'QualB', '2023-05-02', 'Pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (20, 'QualC', '2023-05-03', 'pass');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (40, 'QualD', '2023-05-04', 'PASS');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (50, 'QualE', '2023-05-05', 'Passed');
INSERT INTO "Candidate_Assessments" ("candidate_id", "qualification", "assessment_date", "asessment_outcome_code") VALUES (50, 'QualF', '2023-05-06', 'Pass ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "candidate_id" FROM "candidate_assessments" WHERE ("asessment_outcome_code" = 'Pass') ORDER BY candidate_id, candidate_assessments.qualification NULLS LAST;

/*
Gold Result:
(10,)
(30,)
*/

-- Prediction Query
SELECT candidate_id FROM candidate_assessments WHERE asessment_outcome_code = 'Pass';

/*
Prediction Result:
(30,)
(10,)
*/