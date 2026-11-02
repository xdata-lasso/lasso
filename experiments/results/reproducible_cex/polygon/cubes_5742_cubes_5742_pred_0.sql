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
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city", "zip_postcode", "state_province_county", "country") VALUES (15, '19', '19', '19', '19', '19', '19');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city", "zip_postcode", "state_province_county", "country") VALUES (14, '19', '19', '19', '19', '19', '19');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (19, '19', '19', '19', '19', '19', '19', '19');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (20, '19', '19', '19', '19', '19', '19', '19');
INSERT INTO "Students" ("student_id", "student_details") VALUES (19, '19');
INSERT INTO "Students" ("student_id", "student_details") VALUES (20, '19');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('16', '19', '19', '19');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('301', '19', '19', '19');
INSERT INTO "People_Addresses" ("person_address_id", "address_id", "person_id", "date_from", "date_to") VALUES (19, 14, 20, 19, 19);
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (19, 16, 19);
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (20, 301, 19);
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (19, 301, -55);
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (20, 301, -55);
INSERT INTO "Candidates" ("candidate_id", "candidate_details") VALUES (19, '19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT student_id, course_id, date_of_attendance, MAX(date_of_attendance) OVER () AS maxdate_of_attendance FROM student_course_attendance) WHERE (course_id = 301 AND maxdate_of_attendance <= date_of_attendance) ORDER BY student_id;

/*
Gold Result:
(19,)
(20,)
*/

-- Prediction Query
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC, student_course_attendance.student_id NULLS LAST, student_course_attendance.course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(19,)
*/