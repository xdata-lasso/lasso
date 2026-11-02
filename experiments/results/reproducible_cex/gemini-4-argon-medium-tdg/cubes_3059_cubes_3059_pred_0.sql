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
-- Tests basic matching, multiple 'Lyla' teachers with the same zip_postcode (to kill SELECT DISTINCT mutants), ordering of zip_postcode (to kill DESC/missing ORDER BY mutants), and filtering out non-Lyla teachers, students named 'Lyla', and teachers where 'Lyla' is in middle_name or last_name.
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, '100 Main St', 'Apt 1', '', 'Springfield', 50000, 'IL', 'USA', 'Details 1');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, '200 Oak Ave', 'Suite B', '', 'Shelbyville', 10000, 'IL', 'USA', 'Details 2');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, '300 Pine Rd', '', '', 'Capital City', 90000, 'IL', 'USA', 'Details 3');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, '400 Elm St', '', '', 'Ogdenville', 20000, 'IL', 'USA', 'Details 4');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (1, 1, 'Lyla', 'Marie', 'Smith', 1, '555-0101', 'lyla.smith@school.edu', 'Full-time');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (2, 2, 'Lyla', 'Grace', 'Jones', 1, '555-0102', 'lyla.jones@school.edu', 'Part-time');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (3, 2, 'Lyla', 'Ann', 'Brown', 1, '555-0103', 'lyla.brown@school.edu', 'Adjunct');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (4, 3, 'John', 'Lyla', 'Lyla', 0, '555-0104', 'john.lyla@school.edu', 'Wrong name column');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1, 4, 'Lyla', 'May', 'Davis', '555-0201', 'lyla.student@school.edu', '2020-09-01 00:00:00', '2024-06-01 00:00:00', 'Student named Lyla');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_postcode" FROM (SELECT "LHS"."teacher_id" AS "teacher_id", "LHS"."address_id" AS "address_id", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."gender" AS "gender", "LHS"."cell_mobile_number" AS "cell_mobile_number", "LHS"."email_address" AS "email_address", "LHS"."other_details" AS "other_details", "RHS"."line_1" AS "line_1", "RHS"."line_2" AS "line_2", "RHS"."line_3" AS "line_3", "RHS"."city" AS "city", "RHS"."zip_postcode" AS "zip_postcode", "RHS"."state_province_county" AS "state_province_county", "RHS"."country" AS "country", "RHS"."other_address_details" AS "other_address_details" FROM (SELECT * FROM "teachers" WHERE ("first_name" = 'Lyla')) AS LHS LEFT JOIN addresses AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY zip_postcode;

/*
Gold Result:
(10000,)
(10000,)
(50000,)
*/

-- Prediction Query
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id = T2.address_id WHERE T2.first_name = 'Lyla';

/*
Prediction Result:
(50000,)
(10000,)
(10000,)
*/