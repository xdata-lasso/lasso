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
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1042, 'Elizabeth Chapman', 'Community avoid able late order.', 'structure');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('deep', 'Keith Brown', 'Allow explain executive teacher author.', 'food');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1043, 'Annette Farmer', 'Under skin person product value.', 'physical');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1044, 'Deborah Miller', 'Boy different chance enter central arrive.', 'smile');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1041, 'Nicholas Monroe', 'Wonder draw him task improve.', 'seven');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1050, 'Mary Grimes', 'Seat relate specific history professional star.', 'charge');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1051, 'John Cook', 'Manager already maybe opportunity.', 'it');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1052, 'Jamie Cantu', 'Them key moment lead.', 'truth');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1049, NULL, NULL, NULL);
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1045, 'Madison', 'James Nelson', 'Valencia', '390-927-8742x967', 'samuel71@example.org', 'Michael Perry', 'too');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1046, 'Samantha', 'Jessica George', 'Matthews', '(265)951-2567x468', 'jennifercollins@example.org', 'Mr. Jesus Thomas', 'join');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1047, 'Scott', 'Morgan Munoz', 'Smith', '954-851-6808', 'hdavis@example.com', 'Kyle Francis', 'grow');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1048, 'Taylor', 'Darryl Craig', 'Hubbard', '6384597703', 'hollanderic@example.net', 'Benjamin Barton', 'world');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1053, 'Diana', 'Michael Santos', 'Jones', '001-716-711-7240x0504', 'bailey40@example.net', 'David Campos', 'catch');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1054, 'Eric', 'Sarah Villarreal', 'Welch', '(923)486-9222x19693', 'khill@example.net', 'Melanie Taylor', 'believe');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1055, 'Terrance', 'Eugene Higgins', 'Mccall', '474.374.0748', 'lozanojulie@example.com', 'Mark Williams', 'where');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1056, 'Tanya', 'Shelia Johnson', 'Bright', '559.846.4743x671', 'catherinegomez@example.net', 'Amanda Diaz', 'find');
INSERT INTO "students" ("student_id", "student_details") VALUES (1045, 'store');
INSERT INTO "students" ("student_id", "student_details") VALUES (1046, 'movement');
INSERT INTO "students" ("student_id", "student_details") VALUES (1047, 'example');
INSERT INTO "students" ("student_id", "student_details") VALUES (1048, 'tend');
INSERT INTO "students" ("student_id", "student_details") VALUES (1053, 'general');
INSERT INTO "students" ("student_id", "student_details") VALUES (1054, 'small');
INSERT INTO "students" ("student_id", "student_details") VALUES (1055, 'just');
INSERT INTO "students" ("student_id", "student_details") VALUES (1056, 'continue');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1045, 1042, '1990-10-21');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1046, 1043, '1990-10-22');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1047, 1044, '1990-10-23');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1048, 1049, '1990-10-24');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1053, 1041, '1994-03-02');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1054, 1050, '1994-03-03');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1055, 1051, '1994-03-04');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1056, 1052, '1994-03-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT student_id, course_id, registration_date, COUNT(*) OVER () AS n FROM student_course_registrations) ORDER BY course_id) LIMIT 1);

/*
Gold Result:
(1053,)
*/

-- Prediction Query
SELECT student_id FROM student_course_registrations GROUP BY student_id ORDER BY COUNT(*), student_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1045,)
*/