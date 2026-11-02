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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '99 Wrong Join Rd', NULL, NULL, 'WrongCity', 99999, 'CA', 'USA', 'Matches teacher_id 1');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, '88 Wrong Join Ave', NULL, NULL, 'WrongTown', 88888, 'CA', 'USA', 'Matches teacher_id 2');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (10, '100 Alpha St', 'Suite A', NULL, 'Alpha', 50000, 'NY', 'USA', 'Lyla 1 address');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (20, '200 Zeta St', 'Apt 2', NULL, 'Zeta', 10000, 'TX', 'USA', 'Lyla 2 address');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (15, '150 Beta St', NULL, NULL, 'Beta', 30000, 'FL', 'USA', 'Lyla 3 address');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (30, '300 Gamma St', NULL, NULL, 'Gamma', 20000, 'WA', 'USA', 'Non-Lyla teacher address');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (40, '400 Delta St', NULL, NULL, 'Delta', 40000, 'OR', 'USA', 'Student Lyla address');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (50, '500 Unused St', NULL, NULL, 'Omega', 60000, 'NV', 'USA', 'Unused address');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (1, 10, 'Lyla', 'Marie', 'Smith', 1, '555-0101', 'lyla.smith@school.edu', 'Active');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (2, 20, 'Lyla', 'Anne', 'Jones', 1, '555-0102', 'lyla.jones@school.edu', 'Active');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (3, 15, 'Lyla', 'Grace', 'Brown', 1, '555-0103', 'lyla.brown@school.edu', 'Active');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (4, 30, 'John', 'Lyla', 'Lyla', 0, '555-0104', 'john.lyla@school.edu', 'Lyla');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (5, 30, 'lyla', 'Rose', 'Taylor', 1, '555-0105', 'lowercase@school.edu', 'Lowercase first name');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (6, 30, 'LylaMay', 'Jane', 'Wilson', 1, '555-0106', 'lylamay@school.edu', 'Prefix match');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (1, 40, 'Lyla', 'May', 'Student', '555-0201', 'lyla.student@uni.edu', '2021-09-01 00:00:00', NULL, 'Student named Lyla');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_postcode" FROM (SELECT "LHS"."teacher_id" AS "teacher_id", "LHS"."address_id" AS "address_id", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."gender" AS "gender", "LHS"."cell_mobile_number" AS "cell_mobile_number", "LHS"."email_address" AS "email_address", "LHS"."other_details" AS "other_details", "RHS"."line_1" AS "line_1", "RHS"."line_2" AS "line_2", "RHS"."line_3" AS "line_3", "RHS"."city" AS "city", "RHS"."zip_postcode" AS "zip_postcode", "RHS"."state_province_county" AS "state_province_county", "RHS"."country" AS "country", "RHS"."other_address_details" AS "other_address_details" FROM (SELECT * FROM "teachers" WHERE ("first_name" = 'Lyla')) AS LHS LEFT JOIN addresses AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY zip_postcode;

/*
Gold Result:
(10000,)
(30000,)
(50000,)
*/

-- Prediction Query
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'Lyla';

/*
Prediction Result:
(50000,)
(10000,)
(30000,)
*/