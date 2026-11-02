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
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (1, '101 Main St', 'Apt 1', 'Seattle', '98101', 'WA', 'USA');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (2, '202 Oak Ave', 'Suite B', 'Austin', '73301', 'TX', 'USA');
INSERT INTO Addresses (address_id, line_1, line_2, city, zip_postcode, state_province_county, country) VALUES (3, '303 Pine Rd', NULL, 'Boston', '02101', 'MA', 'USA');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (1, 'John', 'A', 'Doe', '555-0101', 'john@example.com', 'jdoe', 'pass1');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (2, 'Jane', 'B', 'Smith', '555-0102', 'jane@example.com', 'jsmith', 'pass2');
INSERT INTO People (person_id, first_name, middle_name, last_name, cell_mobile_number, email_address, login_name, password) VALUES (3, 'Bob', 'C', 'Brown', '555-0103', 'bob@example.com', 'bbrown', 'pass3');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (10, 1, 2, '2020-01-01 00:00:00', '2021-01-01 00:00:00');
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (20, 1, 3, '2021-02-01 00:00:00', NULL);
INSERT INTO People_Addresses (person_address_id, address_id, person_id, date_from, date_to) VALUES (30, 2, 1, '2019-05-01 00:00:00', '2022-05-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.person_address_id AS person_address_id, RHS.person_id AS person_id, RHS.date_from AS date_from, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN people_addresses AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY city;

/*
Gold Result:
('Austin',)
('Seattle',)
('Seattle',)
*/

-- Prediction Query
SELECT DISTINCT T1.city FROM addresses AS T1 JOIN people_addresses AS T2 ON T1.address_id = T2.address_id;

/*
Prediction Result:
('Seattle',)
('Austin',)
*/