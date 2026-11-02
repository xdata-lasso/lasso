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
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'John', 'A', 'Doe', '1234567890', 'john@example.com', 'johnd', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Jane', 'B', 'Smith', '0987654321', 'jane@example.com', 'janes', 'pass2');
INSERT INTO Candidates (candidate_id, candidate_details) VALUES (1, 'Details 1');
INSERT INTO Candidates (candidate_id, candidate_details) VALUES (2, 'Details 2');
INSERT INTO Candidate_Assessments (candidate_id, qualification, assessment_date, asessment_outcome_code) VALUES (1, 'QualA', '2023-01-01 00:00:00', 'PASS');
INSERT INTO Candidate_Assessments (candidate_id, qualification, assessment_date, asessment_outcome_code) VALUES (2, 'QualA', '2023-01-01 00:00:00', 'PASS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT candidate_id_other AS candidate_id FROM (SELECT LHS.candidate_id AS candidate_id, LHS.qualification AS qualification, LHS.assessment_date AS assessment_date, LHS.asessment_outcome_code AS asessment_outcome_code, LHS.maxassessment_date AS maxassessment_date, RHS.candidate_id AS candidate_id_other, RHS.qualification AS qualification_other, RHS.assessment_date AS assessment_date_other, RHS.asessment_outcome_code AS asessment_outcome_code_other, RHS.maxassessment_date AS maxassessment_date_other FROM (SELECT candidate_id, qualification, assessment_date, asessment_outcome_code, MAX(assessment_date) OVER () AS maxassessment_date FROM candidate_assessments) AS LHS CROSS JOIN (SELECT candidate_id, qualification, assessment_date, asessment_outcome_code, MAX(assessment_date) OVER () AS maxassessment_date FROM candidate_assessments) AS RHS) WHERE (maxassessment_date <= assessment_date_other OR maxassessment_date <> maxassessment_date_other) ORDER BY candidate_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT candidate_id FROM candidate_assessments ORDER BY assessment_date DESC, candidate_assessments.candidate_id NULLS LAST, candidate_assessments.qualification NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/