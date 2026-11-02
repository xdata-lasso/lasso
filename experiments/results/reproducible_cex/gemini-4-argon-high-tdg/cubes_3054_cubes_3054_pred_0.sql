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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (10, '10 Oak St', 'Apt 1', NULL, 'Boston', 2101, 'MA', 'USA', 'Addr Detail 10');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (20, '20 Pine St', 'Apt 2', NULL, 'Chicago', 60601, 'IL', 'USA', 'Addr Detail 20');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (30, '30 Elm St', 'Apt 3', NULL, 'Austin', 73301, 'TX', 'USA', 'Addr Detail 30');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (40, '40 Maple St', 'Apt 4', NULL, 'Seattle', 98101, 'WA', 'USA', 'Addr Detail 40');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (2, 40, 'Alice', 'M', 'Smith', '555-0102', 'alice@example.edu', '2019-09-01 00:00:00', '2023-05-15 00:00:00', 'Student Detail 2');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (5, 30, 'Bob', 'J', 'Jones', '555-0105', 'bob@example.edu', '2018-09-01 00:00:00', '2022-05-15 00:00:00', 'Student Detail 5');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (10, 10, 'Charlie', 'K', 'Brown', '555-0110', 'charlie@example.edu', '2020-09-01 00:00:00', '2024-05-15 00:00:00', 'Student Detail 10');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (15, 20, 'Diana', 'L', 'Prince', '555-0115', 'diana@example.edu', '2021-09-01 00:00:00', NULL, 'Student Detail 15');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (10, 20, '2021-09-10 00:00:00', '2022-08-31 00:00:00', 450.75, 'Mu rental record');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (2, 30, '2022-05-01 00:00:00', '2023-01-01 00:00:00', 850.50, 'Zeta rental record');
INSERT INTO Student_Addresses (student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details) VALUES (5, 10, '2020-01-15 00:00:00', '2024-06-30 00:00:00', 1200.00, 'Alpha rental record');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details FROM student_addresses ORDER BY student_id;

/*
Gold Result:
(2, 30, '2022-05-01 00:00:00', '2023-01-01 00:00:00', 850.5, 'Zeta rental record')
(5, 10, '2020-01-15 00:00:00', '2024-06-30 00:00:00', 1200.0, 'Alpha rental record')
(10, 20, '2021-09-10 00:00:00', '2022-08-31 00:00:00', 450.75, 'Mu rental record')
*/

-- Prediction Query
SELECT * FROM Student_Addresses ORDER BY monthly_rental DESC;

/*
Prediction Result:
(5, 10, '2020-01-15 00:00:00', '2024-06-30 00:00:00', 1200.0, 'Alpha rental record')
(2, 30, '2022-05-01 00:00:00', '2023-01-01 00:00:00', 850.5, 'Zeta rental record')
(10, 20, '2021-09-10 00:00:00', '2022-08-31 00:00:00', 450.75, 'Mu rental record')
*/