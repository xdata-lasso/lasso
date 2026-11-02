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
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (301, 'Denise Rodriguez', 'Accept nearly upon imagine.', 'write');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1097, 'Cynthia Williams', 'Local current white fly position traditional become.', 'smile');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1098, 'Courtney Hall', 'Discussion school sure also TV individual study.', 'turn');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1099, 'Gary Kennedy', 'Young however many.', 'with');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1104, 'Andrea Peck', 'Card team budget year hotel camera without.', 'budget');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1105, 'Jason Mack', 'Series without leg.', 'almost');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1106, 'Veronica Brewer', 'Interest here discover leave choice country themselves.', 'table');
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1125, NULL, NULL, NULL);
INSERT INTO "courses" ("course_id", "course_name", "course_description", "other_details") VALUES (1126, NULL, NULL, NULL);
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1109, 'Keith', 'Frances Gibson', 'Wong', '493-929-6685x1612', 'foxallison@example.com', 'Ann Dixon', 'technology');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1101, 'Benjamin', 'Kelly Small', 'Higgins', '730-546-3745x49904', 'starkdaniel@example.net', 'Jody Palmer', 'about');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1102, 'Kenneth', 'Jonathan Nelson', 'Smith', '6177426841', 'ashleyhernandez@example.com', 'Anthony Ford', 'skill');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1103, 'Carrie', 'Erin Simon', 'Rogers', '+1-533-527-2795x687', 'nwilson@example.net', 'Miranda Foster', 'discover');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1110, 'Donna', 'Austin Wheeler', 'Taylor', '001-559-895-3428', 'nicholsmaria@example.org', 'Terry Lewis', 'fund');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1108, 'Christina', 'Michael Brennan', 'Holder', '740-889-2687x0568', 'nicholas99@example.org', 'Patrick Burgess', 'stand');
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1107, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "people" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (1100, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "students" ("student_id", "student_details") VALUES (1109, 'particular');
INSERT INTO "students" ("student_id", "student_details") VALUES (1101, 'baby');
INSERT INTO "students" ("student_id", "student_details") VALUES (1102, 'answer');
INSERT INTO "students" ("student_id", "student_details") VALUES (1103, 'land');
INSERT INTO "students" ("student_id", "student_details") VALUES (1110, 'man');
INSERT INTO "students" ("student_id", "student_details") VALUES (1108, 'none');
INSERT INTO "students" ("student_id", "student_details") VALUES (1107, NULL);
INSERT INTO "students" ("student_id", "student_details") VALUES (1100, NULL);
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1109, 301, '1989-08-15');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1101, 1097, '1989-08-16');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1102, 1098, '1989-08-17');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1103, 1099, '1989-08-18');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1108, 1104, '1997-05-24');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1110, 1106, '1997-05-26');
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1107, 1125, NULL);
INSERT INTO "student_course_registrations" ("student_id", "course_id", "registration_date") VALUES (1100, 1126, NULL);
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1109, 301, '1993-01-19');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1108, 301, '1993-01-20');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1107, 301, '1993-01-21');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1103, 301, '1993-01-22');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1110, 301, '1972-09-04');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1102, 301, '1972-09-05');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1101, 301, '1972-09-06');
INSERT INTO "student_course_attendance" ("student_id", "course_id", "date_of_attendance") VALUES (1100, 301, '1972-09-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM student_course_attendance WHERE (course_id = 301 AND course_id <> 1)) ORDER BY student_id DESC) LIMIT 1);

/*
Gold Result:
(1110,)
*/

-- Prediction Query
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC, student_course_attendance.student_id NULLS LAST, student_course_attendance.course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1103,)
*/