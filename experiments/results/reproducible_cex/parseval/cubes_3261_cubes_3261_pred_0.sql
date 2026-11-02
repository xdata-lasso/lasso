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
-- Inserting into table: people --
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1, 'peo_13b308', 'peo_a2556c', 'peo_04078f', 'peo_8bae35', 'stanley.monahan@example.org', 'peo_c36f2c', 'peo_644dc3');

INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (2, 'peo_13b308', 'peo_a2556c', 'peo_04078f', 'peo_8bae35', 'stanley.monahan@example.org', 'peo_c36f2c', 'peo_644dc3');

INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (3, 'peo_13b308', 'peo_a2556c', 'peo_04078f', 'peo_8bae35', 'peo_83cdb9', 'peo_c36f2c', 'peo_644dc3');

INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (4, 'peo_13b308', 'peo_a2556c', 'peo_04078f', 'peo_8bae35', NULL, 'peo_c36f2c', 'peo_644dc3');

-- Inserting into table: candidates --
INSERT INTO "candidates" ("candidate_id", "candidate_details") VALUES (1, 'can_b30fef');

INSERT INTO "candidates" ("candidate_id", "candidate_details") VALUES (3, 'can_b30fef');

INSERT INTO "candidates" ("candidate_id", "candidate_details") VALUES (4, 'can_b30fef');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "person_id" AS "candidate_id" FROM (SELECT "LHS"."candidate_id" AS "candidate_id", "LHS"."candidate_details" AS "candidate_details", "RHS"."person_id" AS "person_id", "RHS"."first_name" AS "first_name", "RHS"."middle_name" AS "middle_name", "RHS"."last_name" AS "last_name", "RHS"."cell_mobile_number" AS "cell_mobile_number", "RHS"."email_address" AS "email_address", "RHS"."login_name" AS "login_name", "RHS"."password" AS "password" FROM "candidates" AS "LHS" CROSS JOIN (SELECT * FROM "people" WHERE ("email_address" = 'stanley.monahan@example.org')) AS RHS) ORDER BY candidate_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT T2.candidate_id FROM people AS T1 JOIN candidates AS T2 ON T1.person_id = T2.candidate_id WHERE T1.email_address = 'stanley.monahan@example.org';

/*
Prediction Result:
(1,)
*/