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
-- Tests basic ordering (out of order relative to student_id and email_address), duplicates (DISTINCT vs ALL), and table confusion (Teachers vs Students).
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (1, '123 Main St', 'Springfield', 12345, 'USA');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name", "cell_mobile_number", "email_address") VALUES (1, 1, 'Alice', 'Smith', '555-0300', 'charlie@school.edu');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name", "cell_mobile_number", "email_address") VALUES (2, 1, 'Bob', 'Jones', '555-0100', 'bob@school.edu');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name", "cell_mobile_number", "email_address") VALUES (3, 1, 'Charlie', 'Brown', '555-0200', 'alice@school.edu');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name", "cell_mobile_number", "email_address") VALUES (4, 1, 'David', 'Smith', '555-0100', 'bob@school.edu');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name", "cell_mobile_number", "email_address") VALUES (1, 1, 'Prof', 'Xavier', '555-0001', 'xavier@school.edu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cell_mobile_number, email_address FROM students ORDER BY cell_mobile_number;

/*
Gold Result:
('555-0100', 'bob@school.edu')
('555-0100', 'bob@school.edu')
('555-0200', 'alice@school.edu')
('555-0300', 'charlie@school.edu')
*/

-- Prediction Query
SELECT cell_mobile_number, email_address FROM STUDENTS;

/*
Prediction Result:
('555-0300', 'charlie@school.edu')
('555-0100', 'bob@school.edu')
('555-0200', 'alice@school.edu')
('555-0100', 'bob@school.edu')
*/