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
INSERT INTO People (person_id, first_name, last_name) VALUES (120, 'Alice', 'Smith');
INSERT INTO People (person_id, first_name, last_name) VALUES (121, 'Bob', 'Jones');
INSERT INTO People (person_id, first_name, last_name) VALUES (122, 'Charlie', 'Brown');
INSERT INTO Students (student_id, student_details) VALUES (120, 'Detail 120');
INSERT INTO Students (student_id, student_details) VALUES (121, 'Detail 121');
INSERT INTO Students (student_id, student_details) VALUES (122, 'Detail 122');
INSERT INTO Courses (course_id, course_name) VALUES ('100', 'Physics');
INSERT INTO Courses (course_id, course_name) VALUES ('200', 'Chemistry');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (120, 100, '2023-01-01');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (121, 200, '2023-01-02');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (120, 200, '2023-02-01');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (121, 100, '2023-02-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_id FROM (SELECT course_id FROM student_course_attendance INTERSECT SELECT course_id FROM student_course_registrations WHERE (student_id = 121)) ORDER BY course_id;

/*
Gold Result:
(200,)
*/

-- Prediction Query
SELECT course_id FROM student_course_registrations WHERE student_id = 121 UNION SELECT course_id FROM student_course_attendance WHERE student_id = 121;

/*
Prediction Result:
(100,)
(200,)
*/