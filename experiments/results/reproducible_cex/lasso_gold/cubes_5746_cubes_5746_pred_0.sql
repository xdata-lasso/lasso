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
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1021, 'Ashley Landry', 'Final together someone.', 'so');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1022, 'Brittany Johnson', 'Together decide economic.', 'clear');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1023, 'Juan Jordan', 'Government nice themselves wind.', 'wish');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1024, 'Sarah', 'Sierra Johnson', 'Adams', '2735375433', 'jonathanfletcher@example.org', 'Jason Powell', 'power');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1025, 'Michelle', 'Evelyn Galvan', 'Cobb', '(454)614-5868x5014', 'michaeljones@example.net', 'Cameron Fisher', 'outside');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1026, 'Theresa', 'Sharon Cochran', 'Rodriguez', '3198655698', 'cindy14@example.net', 'Megan Orr', 'fish');
INSERT INTO "students" ("student_id", "student_details") VALUES (1024, 'into');
INSERT INTO "students" ("student_id", "student_details") VALUES (1025, 'official');
INSERT INTO "students" ("student_id", "student_details") VALUES (1026, 'these');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1024, 1021, NULL);
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1025, 1022, NULL);
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1026, 1023, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT student_details FROM (SELECT LHS.student_id AS student_id, LHS.student_details AS student_details, LHS.course_id AS course_id, LHS.registration_date AS registration_date, LHS.maxregistration_date AS maxregistration_date, RHS.student_id AS student_id_other, RHS.course_id AS course_id_other, RHS.registration_date AS registration_date_other FROM (SELECT student_id, student_details, course_id, registration_date, MAX(registration_date) OVER () AS maxregistration_date FROM (SELECT LHS.student_id AS student_id, LHS.student_details AS student_details, RHS.course_id AS course_id, RHS.registration_date AS registration_date FROM students AS LHS INNER JOIN student_course_registrations AS RHS ON (LHS.student_id = RHS.student_id))) AS LHS CROSS JOIN student_course_registrations AS RHS) WHERE (registration_date >= maxregistration_date OR maxregistration_date < registration_date_other) ORDER BY student_details;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.student_details FROM student_course_registrations AS T1 JOIN students AS T2 ON T1.student_id = T2.student_id ORDER BY T1.registration_date DESC, T1.student_id NULLS LAST, T1.course_id NULLS LAST, T2.student_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('into',)
*/