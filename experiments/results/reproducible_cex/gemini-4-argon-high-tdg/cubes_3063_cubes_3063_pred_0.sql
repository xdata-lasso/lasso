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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (10, '10 Main St', NULL, NULL, 'Boston', 10001, 'MA', 'USA', NULL);
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (20, '20 Oak St', NULL, NULL, 'Boston', 10002, 'MA', 'USA', NULL);
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (30, '30 Pine St', NULL, NULL, 'Boston', 10003, 'MA', 'USA', NULL);
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (40, '40 Elm St', NULL, NULL, 'Boston', 10004, 'MA', 'USA', NULL);
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (50, '50 Maple St', NULL, NULL, 'Boston', 10005, 'MA', 'USA', NULL);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (1, 10, 'Alice', 'A', 'Medhurst', 2, '555-0101', 'alice@school.edu', 'Senior');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (2, 20, 'Bob', 'B', 'Medhurst', 1, '555-0102', 'bob@school.edu', 'Junior');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (3, 30, 'Charlie', 'C', 'Medhurst', 1, '555-0103', 'charlie@school.edu', 'Tenure');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (4, 40, 'David', 'D', 'Adams', 0, '555-0104', 'david@school.edu', 'Adjunct');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (5, 50, 'Eve', 'E', 'Zimmerman', 3, '555-0105', 'eve@school.edu', 'Head');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "gender" FROM "teachers" WHERE ("last_name" = 'Medhurst') ORDER BY gender;

/*
Gold Result:
(1,)
(1,)
(2,)
*/

-- Prediction Query
SELECT gender FROM TEACHERS WHERE last_name = 'Medhurst';

/*
Prediction Result:
(2,)
(1,)
(1,)
*/