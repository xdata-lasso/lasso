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
-- Tests:
-- 1. Tie for maximum registration_date across multiple students (catches LIMIT 1 vs MAX).
-- 2. Reverse correlation between student_id and student_details to catch ORDER BY student_id vs ORDER BY student_details.
-- 3. Multiple tied winners sharing identical student_details to catch missing DISTINCT.
-- 4. A non-maximum registration_date (2023-01-01) to catch MIN vs MAX or <= vs >= mutations.
-- 5. An unregistered student with highest student_id to catch LEFT JOIN vs INNER JOIN or querying Students without joining registrations.
-- 6. Attendance record with a newer date than any registration_date to catch table confusion (Student_Course_Attendance vs Student_Course_Registrations).
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'Alice', 'A', 'Adams', '111-1111', 'alice@example.com', 'alice', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Bob', 'B', 'Baker', '222-2222', 'bob@example.com', 'bob', 'pass2');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (3, 'Charlie', 'C', 'Clark', '333-3333', 'charlie@example.com', 'charlie', 'pass3');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (4, 'David', 'D', 'Davis', '444-4444', 'david@example.com', 'david', 'pass4');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (5, 'Eve', 'E', 'Evans', '555-5555', 'eve@example.com', 'eve', 'pass5');
INSERT INTO Students (student_id, student_details) VALUES (1, 'Zeta_Tie');
INSERT INTO Students (student_id, student_details) VALUES (2, 'Alpha_Tie');
INSERT INTO Students (student_id, student_details) VALUES (3, 'Alpha_Tie');
INSERT INTO Students (student_id, student_details) VALUES (4, 'Beta_Loser');
INSERT INTO Students (student_id, student_details) VALUES (5, 'Omega_Unregistered');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('101', 'CS101', 'Intro to CS', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('102', 'CS102', 'Data Structures', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('103', 'CS103', 'Algorithms', 'None');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('104', 'CS104', 'Databases', 'None');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (1, 101, '2023-10-10 10:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (2, 102, '2023-10-10 10:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (3, 103, '2023-10-10 10:00:00');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (4, 104, '2023-01-01 08:00:00');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (4, 104, '2024-12-31 23:59:59');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT student_details FROM (SELECT LHS.student_id AS student_id, LHS.student_details AS student_details, LHS.course_id AS course_id, LHS.registration_date AS registration_date, LHS.maxregistration_date AS maxregistration_date, RHS.student_id AS student_id_other, RHS.course_id AS course_id_other, RHS.registration_date AS registration_date_other FROM (SELECT student_id, student_details, course_id, registration_date, MAX(registration_date) OVER () AS maxregistration_date FROM (SELECT LHS.student_id AS student_id, LHS.student_details AS student_details, RHS.course_id AS course_id, RHS.registration_date AS registration_date FROM students AS LHS INNER JOIN student_course_registrations AS RHS ON (LHS.student_id = RHS.student_id))) AS LHS CROSS JOIN student_course_registrations AS RHS) WHERE (registration_date >= maxregistration_date OR maxregistration_date < registration_date_other) ORDER BY student_details;

/*
Gold Result:
('Alpha_Tie',)
('Zeta_Tie',)
*/

-- Prediction Query
SELECT T2.student_details FROM student_course_registrations AS T1 JOIN students AS T2 ON T1.student_id = T2.student_id ORDER BY T1.registration_date DESC, T1.student_id NULLS LAST, T1.course_id NULLS LAST, T2.student_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta_Tie',)
*/