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
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (10, '10 Bahnhofstrasse', 'Apt 1', 'Zurich', '8001', 'ZH', 'Switzerland');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (20, '20 Beacon St', 'Suite 2', 'Boston', '02108', 'MA', 'USA');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (30, '30 Gran Via', 'Floor 3', 'Madrid', '28013', 'MD', 'Spain');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (40, '40 Congress Ave', 'Unit 4', 'Austin', '78701', 'TX', 'USA');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (100, 'Alice', 'M', 'Smith', '555-0100', 'alice@example.com', 'alices', 'pass100');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (200, 'Bob', 'J', 'Jones', '555-0200', 'bob@example.com', 'bobj', 'pass200');
INSERT INTO Students (student_id, student_details) VALUES (100, 'Undergraduate CS');
INSERT INTO Students (student_id, student_details) VALUES (200, 'Graduate Math');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (1000, 10, 100, '2021-01-01 00:00:00', '2022-01-01 00:00:00');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (2000, 20, 100, '2022-01-02 00:00:00', '2023-01-01 00:00:00');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (3000, 30, 200, '2021-06-01 00:00:00', '2023-06-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT city FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.student_id AS student_id, LHS.student_details AS student_details, RHS.person_address_id AS person_address_id, RHS.person_id AS person_id, RHS.date_from AS date_from, RHS.date_to AS date_to FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.student_id AS student_id, RHS.student_details AS student_details FROM addresses AS LHS CROSS JOIN students AS RHS) AS LHS INNER JOIN people_addresses AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY city;

/*
Gold Result:
('Boston',)
('Madrid',)
('Zurich',)
*/

-- Prediction Query
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id JOIN students AS T3 ON T2.person_id = T3.student_id;

/*
Prediction Result:
('Zurich',)
('Boston',)
('Madrid',)
*/