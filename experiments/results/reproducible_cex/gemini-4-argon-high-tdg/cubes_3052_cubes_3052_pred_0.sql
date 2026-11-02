-- Schema DDL
CREATE TABLE "Ref_Address_Types" ("address_type_code" TEXT(15) PRIMARY KEY, "address_type_description" TEXT(80));

CREATE TABLE "Ref_Detention_Type" ("detention_type_code" TEXT(10) PRIMARY KEY, "detention_type_description" TEXT(80));

CREATE TABLE "Ref_Incident_Type" ("incident_type_code" TEXT(10) PRIMARY KEY, "incident_type_description" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(40), "last_name" TEXT(40), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "date_first_rental" DATETIME, "date_left_university" DATETIME, "other_student_details" TEXT(255), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Assessment_Notes" ("teacher_id" INTEGER, "student_id" INTEGER, "notes_id" INTEGER, "date_of_notes" DATETIME, "text_of_notes" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("teacher_id") REFERENCES "Teachers" ("teacher_id"), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"));

CREATE TABLE "Behavior_Incident" ("incident_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "incident_type_code" TEXT(10), "date_incident_start" DATETIME, "date_incident_end" DATETIME, "incident_summary" TEXT(255), "recommendations" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("incident_type_code") REFERENCES "Ref_Incident_Type" ("incident_type_code"));

CREATE TABLE "Detention" ("detention_id" INTEGER PRIMARY KEY, "teacher_id" INTEGER, "detention_type_code" TEXT(10), "datetime_detention_start" DATETIME, "datetime_detention_end" DATETIME, "detention_summary" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("teacher_id") REFERENCES "Teachers" ("teacher_id"), FOREIGN KEY ("detention_type_code") REFERENCES "Ref_Detention_Type" ("detention_type_code"));

CREATE TABLE "Student_Addresses" ("student_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "date_address_to" DATETIME, "monthly_rental" REAL(19, 4), "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Students_in_Detention" ("student_id" INTEGER, "detention_id" INTEGER, "incident_id" INTEGER, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("detention_id") REFERENCES "Detention" ("detention_id"), FOREIGN KEY ("incident_id") REFERENCES "Behavior_Incident" ("incident_id"));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(120), "line_2" TEXT(120), "line_3" TEXT(120), "city" TEXT(80), "zip_postcode" INTEGER, "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Teachers" ("teacher_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "gender" INTEGER, "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "other_details" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, 'Pine St', 'Apt 1', 'Bldg A', 'Boston', 2101, 'MA', 'USA', 'Near park');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, 'Maple Ave', 'Suite 2', 'Bldg B', 'Austin', 73301, 'TX', 'USA', 'Downtown');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (3, 'Oak Blvd', 'Unit 3', 'Bldg C', 'Denver', 80201, 'CO', 'USA', 'Suburb');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (4, 'Elm Way', 'Floor 4', 'Bldg D', 'Seattle', 98101, 'WA', 'USA', 'Unrented');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (10, 1, 'Alice', 'M', 'Smith', '555-0101', 'alice@example.com', '2021-09-01 00:00:00', '2025-05-15 00:00:00', 'Honors');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (20, 2, 'Bob', 'J', 'Jones', '555-0102', 'bob@example.com', '2021-09-01 00:00:00', '2025-05-15 00:00:00', 'Athletics');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (30, 3, 'Carol', 'K', 'White', '555-0103', 'carol@example.com', '2022-01-10 00:00:00', '2026-05-15 00:00:00', 'Transfer');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (10, 1, '2021-09-01 00:00:00', '2022-05-31 00:00:00', 100.0, 'Fall/Spring');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (20, 1, '2022-06-01 00:00:00', '2022-08-31 00:00:00', 100.0, 'Summer');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (30, 1, '2022-09-01 00:00:00', '2023-05-31 00:00:00', 400.0, 'Renovated');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (10, 2, '2022-09-01 00:00:00', '2023-05-31 00:00:00', 250.0, 'Lease 1');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (20, 2, '2023-06-01 00:00:00', '2024-05-31 00:00:00', 350.0, 'Lease 2');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (30, 3, '2023-09-01 00:00:00', '2024-05-31 00:00:00', 150.0, 'Single lease');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT line_1, meanmonthly_rental AS avg_t2_monthly_rental_ FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, LHS.student_id AS student_id, LHS.date_address_from AS date_address_from, LHS.date_address_to AS date_address_to, LHS.monthly_rental AS monthly_rental, LHS.other_details AS other_details, RHS.meanmonthly_rental AS meanmonthly_rental FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.student_id AS student_id, RHS.date_address_from AS date_address_from, RHS.date_address_to AS date_address_to, RHS.monthly_rental AS monthly_rental, RHS.other_details AS other_details FROM addresses AS LHS INNER JOIN student_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, AVG(monthly_rental) AS meanmonthly_rental FROM student_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY line_1;

/*
Gold Result:
('Maple Ave', 300.0)
('Oak Blvd', 150.0)
('Pine St', 200.0)
*/

-- Prediction Query
SELECT T1.line_1, AVG(T2.monthly_rental) FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id = T2.address_id GROUP BY T2.address_id;

/*
Prediction Result:
('Pine St', 200.0)
('Maple Ave', 300.0)
('Oak Blvd', 150.0)
*/