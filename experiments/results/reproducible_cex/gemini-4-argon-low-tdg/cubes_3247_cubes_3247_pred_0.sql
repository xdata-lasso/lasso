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
-- Tests NULL handling in NOT IN vs NOT EXISTS, and multiple attendance records per student:
-- 1. A row in Student_Course_Attendance with a NULL student_id -> A mutant using `WHERE student_id NOT IN (SELECT student_id FROM Student_Course_Attendance)` will evaluate to UNKNOWN and return 0 rows, whereas the Reference Query (NOT EXISTS) will still return Student 2.
-- 2. Student 1 has multiple attendance records -> Catches mutants that use RIGHT/FULL/INNER JOIN without DISTINCT.
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'John', 'M', 'Doe', '123-4567', 'john@example.com', 'jdoe', 'pwd1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Jane', 'A', 'Smith', '234-5678', 'jane@example.com', 'jsmith', 'pwd2');
INSERT INTO Students (student_id, student_details) VALUES (1, 'Attended multiple courses');
INSERT INTO Students (student_id, student_details) VALUES (2, 'Attended no courses');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('10', 'Math', 'Algebra', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('20', 'Science', 'Physics', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('30', 'History', 'World History', 'None');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (1, 10, '2023-02-01 08:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (NULL, 20, '2023-02-01 09:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (2, 30, '2023-02-01 10:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (1, 10, '2023-02-05 08:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (1, 20, '2023-02-06 09:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (NULL, 30, '2023-02-07 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id FROM (SELECT * FROM students AS LHS WHERE NOT EXISTS(SELECT 1 FROM student_course_attendance AS RHS WHERE (LHS.student_id = RHS.student_id))) ORDER BY student_id;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT student_id FROM students WHERE NOT student_id IN (SELECT student_id FROM student_course_attendance);

/*
Prediction Result:
*/