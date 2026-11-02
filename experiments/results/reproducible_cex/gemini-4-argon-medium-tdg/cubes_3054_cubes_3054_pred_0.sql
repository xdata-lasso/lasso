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
-- DATASET 2
-- Tests duplicate rows, multiple addresses for the same student_id (catches GROUP BY student_id or DISTINCT mutations), and inverse ordering relationships between student_id, address_id, and monthly_rental.
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (100, '10 First St', '', '', 'CityA', 10001, 'StateA', 'CountryA', 'Detail A');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (200, '20 Second St', '', '', 'CityB', 20002, 'StateB', 'CountryB', 'Detail B');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (10, 100, 'David', '', 'Lee', '555-1111', 'david@example.com', '2019-01-01', '2023-01-01', 'Details 10');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (20, 200, 'Eva', '', 'Green', '555-2222', 'eva@example.com', '2020-01-01', '2024-01-01', 'Details 20');
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (20, 100, '2022-01-01', '2022-12-31', 500.00, 'Lease A');
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row');
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row');
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (10, 100, '2021-01-01', '2021-12-31', 950.00, 'Second Lease for Student 10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT student_id, address_id, date_address_from, date_address_to, monthly_rental, other_details FROM student_addresses ORDER BY student_id;

/*
Gold Result:
(10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row')
(10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row')
(10, 100, '2021-01-01', '2021-12-31', 950.0, 'Second Lease for Student 10')
(20, 100, '2022-01-01', '2022-12-31', 500.0, 'Lease A')
*/

-- Prediction Query
SELECT * FROM Student_Addresses ORDER BY monthly_rental DESC;

/*
Prediction Result:
(10, 100, '2021-01-01', '2021-12-31', 950.0, 'Second Lease for Student 10')
(10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row')
(10, 200, '2020-01-01', '2020-12-31', 900.75, 'Exact Duplicate Row')
(20, 100, '2022-01-01', '2022-12-31', 500.0, 'Lease A')
*/