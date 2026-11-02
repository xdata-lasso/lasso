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
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1161, 'Kathleen Rodriguez', 'West side admit attack energy always art.', 'throughout');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1162, 'Mr. Joseph Levine DVM', 'Media pick may indeed reduce bar.', 'edge');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1163, 'Bonnie Valencia', 'Mrs check base bad TV window choice.', 'article');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1164, 'Holly Vega', 'Hospital plant strong race at recognize.', 'election');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1170, 'Douglas Williams', 'Surface unit hotel story for.', 'coach');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1171, 'Ryan Gutierrez', 'Evening avoid dark sister once choice clearly.', 'surface');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1172, 'Judy Adkins', 'Finish building group show later leg system.', 'rich');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1169, NULL, NULL, NULL);
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1166, 'Christopher', 'Patrick Yang', 'Norman', '9569481491', 'wileymichelle@example.com', 'Dr. Morgan Payne PhD', 'however');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1177, 'Ryan', 'Michael Miles', 'Adams', '250.279.2524x19138', 'christopher70@example.com', 'Timothy Johnson', 'time');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1167, 'Shawn', 'Troy Mills', 'Tanner', '8305756220', 'kellymueller@example.net', 'Makayla Steele', 'sing');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1168, 'Chelsea', 'Michelle Jackson', 'Wise', '236-854-1951x80238', 'stevenvargas@example.com', 'George Blake', 'short');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1165, 'Kevin', 'Michael Schmitt', 'Davis', '001-932-436-5199x41013', 'ramirezderrick@example.org', 'Devin Johnson', 'collection');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1174, 'Janet', 'Anthony Evans', 'Garcia', '851-907-0296', 'crystalpham@example.org', 'Alyssa Cochran', 'black');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1175, 'Jason', 'Carrie Crane', 'Leon', '9664253244', 'wcasey@example.com', 'Robert Ruiz', 'end');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1176, 'Melissa', 'Kristi Pierce', 'Brown', '9992934768', 'kcooper@example.net', 'Kevin Hall', 'realize');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1178, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1173, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "students" ("student_id", "student_details") VALUES (1166, 'food');
INSERT INTO "students" ("student_id", "student_details") VALUES (1178, 'body');
INSERT INTO "students" ("student_id", "student_details") VALUES (1167, 'describe');
INSERT INTO "students" ("student_id", "student_details") VALUES (1168, 'next');
INSERT INTO "students" ("student_id", "student_details") VALUES (1165, 'effect');
INSERT INTO "students" ("student_id", "student_details") VALUES (1174, 'exactly');
INSERT INTO "students" ("student_id", "student_details") VALUES (1175, 'team');
INSERT INTO "students" ("student_id", "student_details") VALUES (1176, 'strong');
INSERT INTO "students" ("student_id", "student_details") VALUES (1173, NULL);
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1166, 1161, '1989-01-12');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1167, 1163, '1985-08-06');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1168, 1164, '1985-08-07');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1173, 1169, '1985-08-08');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1165, 1162, '1989-01-12');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1174, 1170, '1989-01-10');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1175, 1171, '1989-01-11');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1176, 1172, '1985-08-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_details FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.student_id AS student_id, LHS.student_details AS student_details, RHS.course_id AS course_id, RHS.registration_date AS registration_date FROM students AS LHS INNER JOIN student_course_registrations AS RHS ON (LHS.student_id = RHS.student_id)) ORDER BY registration_date DESC) LIMIT 1);

/*
Gold Result:
('food',)
*/

-- Prediction Query
SELECT T2.student_details FROM student_course_registrations AS T1 JOIN students AS T2 ON T1.student_id = T2.student_id ORDER BY T1.registration_date DESC, T1.student_id NULLS LAST, T1.course_id NULLS LAST, T2.student_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('effect',)
*/