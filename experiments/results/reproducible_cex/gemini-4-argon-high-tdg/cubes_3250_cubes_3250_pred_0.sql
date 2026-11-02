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
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'Apt 1', 'Boston', '02101', 'MA', 'USA');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (2, '20 Oak Ave', 'Suite 5', 'Seattle', '98101', 'WA', 'USA');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'Zoe', 'A', 'Anderson', '555-0101', 'zoe@example.com', 'zoea', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Alice', 'Z', 'Zimmer', '555-0102', 'alicez@example.com', 'alicez', 'pass2');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (3, 'Bob', 'M', 'Miller', '555-0103', 'bob1@example.com', 'bob1', 'pass3');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (4, 'Bob', 'N', 'Miller', '555-0104', 'bob2@example.com', 'bob2', 'pass4');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (10, 'Alice', 'B', 'Adams', '555-0110', 'alicea@example.com', 'alicea', 'pass10');
INSERT INTO Students (student_id, student_details) VALUES (1, 'Full-time');
INSERT INTO Students (student_id, student_details) VALUES (2, 'Part-time');
INSERT INTO Courses (course_id, course_name, course_description, other_details) VALUES ('101', 'Database Systems', 'Intro to SQL', 'Fall');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (1, 1, 1, '2020-01-01', '2021-01-01');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (2, 2, 1, '2021-01-02', '2022-01-01');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (3, 1, 2, '2020-05-01', '2022-05-01');
INSERT INTO Student_Course_Registrations (student_id, course_id, registration_date) VALUES (1, 101, '2020-08-15');
INSERT INTO Student_Course_Attendance (student_id, course_id, date_of_attendance) VALUES (1, 101, '2020-09-01');
INSERT INTO Candidates (candidate_id, candidate_details) VALUES (2, 'Referred');
INSERT INTO Candidates (candidate_id, candidate_details) VALUES (3, 'Direct');
INSERT INTO Candidate_Assessments (candidate_id, qualification, assessment_date, asessment_outcome_code) VALUES (2, 'SQL-Cert', '2021-03-10', 'PASS');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM people ORDER BY first_name, people.person_id NULLS LAST;

/*
Gold Result:
('Alice', 'Zimmer')
('Alice', 'Adams')
('Bob', 'Miller')
('Bob', 'Miller')
('Zoe', 'Anderson')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name FROM candidates AS T1 JOIN people AS T2 ON T1.candidate_id = T2.person_id;

/*
Prediction Result:
('Alice', 'Zimmer')
('Bob', 'Miller')
*/