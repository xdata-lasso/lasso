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
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (9, 'Alice', 'A', 'Smith', '111-1111', 'alice@example.com', 'alice', 'pass');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (10, 'Bob', 'B', 'Jones', '222-2222', 'bob@example.com', 'bob', 'pass');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (15, 'Charlie', 'C', 'Brown', '333-3333', 'charlie@example.com', 'charlie', 'pass');
INSERT INTO "People" ("person_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "login_name", "password") VALUES (20, 'David', 'D', 'Wilson', '444-4444', 'david@example.com', 'david', 'pass');
INSERT INTO "Students" ("student_id", "student_details") VALUES (9, 'Student 9');
INSERT INTO "Students" ("student_id", "student_details") VALUES (10, 'Student 10');
INSERT INTO "Students" ("student_id", "student_details") VALUES (15, 'Student 15');
INSERT INTO "Students" ("student_id", "student_details") VALUES (20, 'Student 20');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('1', 'Course 1', 'Desc 1', 'Other 1');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('301', 'Course 301', 'Desc 301', 'Other 301');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('302', 'Course 302', 'Desc 302', 'Other 302');
INSERT INTO "Courses" ("course_id", "course_name", "course_description", "other_details") VALUES ('400', 'Course 400', 'Desc 400', 'Other 400');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (9, 301, '2023-01-01 10:00:00');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (10, 302, '2023-01-02 10:00:00');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (15, 400, '2023-01-03 10:00:00');
INSERT INTO "Student_Course_Registrations" ("student_id", "course_id", "registration_date") VALUES (20, 1, '2023-01-04 10:00:00');
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (9, 301, '2023-02-15 09:00:00');
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (10, 301, '2023-02-10 09:00:00');
INSERT INTO "Student_Course_Attendance" ("student_id", "course_id", "date_of_attendance") VALUES (20, 1, '2023-02-20 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM student_course_attendance WHERE (course_id = 301 AND course_id <> 1)) ORDER BY student_id DESC) LIMIT 1);

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC, student_course_attendance.student_id NULLS LAST, student_course_attendance.course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(9,)
*/