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
-- Tests ORDER BY student_id DESC, LIMIT 1, filtering out non-301 courses, and registrations without attendance.
INSERT INTO People (person_id, first_name, last_name) VALUES (10, 'Alice', 'Smith');
INSERT INTO People (person_id, first_name, last_name) VALUES (20, 'Bob', 'Jones');
INSERT INTO People (person_id, first_name, last_name) VALUES (30, 'Charlie', 'Brown');
INSERT INTO People (person_id, first_name, last_name) VALUES (40, 'Diana', 'Prince');
INSERT INTO Students (student_id, student_details) VALUES (10, 'Freshman');
INSERT INTO Students (student_id, student_details) VALUES (20, 'Sophomore');
INSERT INTO Students (student_id, student_details) VALUES (30, 'Junior');
INSERT INTO Students (student_id, student_details) VALUES (40, 'Senior');
INSERT INTO Courses (course_id, course_name) VALUES ('1', 'Intro to Logic');
INSERT INTO Courses (course_id, course_name) VALUES ('301', 'Database Systems');
INSERT INTO Courses (course_id, course_name) VALUES ('302', 'Operating Systems');
INSERT INTO Courses (course_id, course_name) VALUES ('303', 'Algorithms');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (10, 301, '2023-01-01 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (20, 302, '2023-01-02 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (30, 1, '2023-01-03 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (40, 303, '2023-01-04 09:00:00');
-- Student 10 and 20 attend 301. Student 30 attends 1 (has higher student_id than 20). Student 40 registered for 303, no attendance.
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (10, 301, '2023-02-10 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (20, 301, '2023-02-01 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (30, 1, '2023-02-15 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM student_course_attendance WHERE (course_id = 301 AND course_id <> 1)) ORDER BY student_id DESC) LIMIT 1);

/*
Gold Result:
(20,)
*/

-- Prediction Query
SELECT student_id FROM student_course_attendance WHERE course_id = 301 ORDER BY date_of_attendance DESC, student_course_attendance.student_id NULLS LAST, student_course_attendance.course_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/