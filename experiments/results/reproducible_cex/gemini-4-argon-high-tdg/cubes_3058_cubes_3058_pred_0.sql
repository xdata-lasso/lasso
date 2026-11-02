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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Oak St', 'Apt 1', 'Floor 1', 'Springfield', 918, 'IL', 'USA', 'North');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, '20 Pine St', 'Apt 2', 'Floor 2', 'Springfield', 918, 'IL', 'USA', 'South');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (3, '30 Maple St', 'Apt 3', 'Floor 3', 'Springfield', 918, 'IL', 'USA', 'East');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (4, '40 Cedar St', 'Apt 4', 'Floor 4', 'Springfield', 918, 'IL', 'USA', 'West');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (5, '50 Birch St', 'Apt 5', 'Floor 5', 'Shelbyville', 917, 'IL', 'USA', 'Boundary Low');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (6, '60 Elm St', 'Apt 6', 'Floor 6', 'Shelbyville', 919, 'IL', 'USA', 'Boundary High');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (7, '70 Walnut St', 'Apt 7', 'Floor 7', 'Shelbyville', NULL, 'IL', 'USA', 'Null Zip');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (918, '918 Fake Zip St', 'Apt 8', 'Floor 8', 'Capital City', 500, 'IL', 'USA', 'ID is 918');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (20, 1, 'Dan', 'D', 'Davis', 1, '555-0103', 'c_teacher@school.org', 'Teacher at addr 1');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (40, 2, 'Bob', 'B', 'Baker', 1, '555-0101', 'a_teacher@school.org', 'Teacher at addr 2');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (10, 3, 'Carl', 'C', 'Clark', 1, '555-0104', 'd_teacher@school.org', 'Teacher at addr 3');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (30, 4, 'Ann', 'A', 'Adams', 0, '555-0102', 'b_teacher@school.org', 'Teacher at addr 4');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (918, 5, 'Eve', 'E', 'Evans', 0, '555-0917', 'zip917_teacher@school.org', 'Teacher ID 918 at zip 917');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (60, 6, 'Frank', 'F', 'Foster', 1, '555-0919', 'zip919_teacher@school.org', 'Teacher at zip 919');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (70, 7, 'Grace', 'G', 'Green', 0, '555-0000', 'nullzip_teacher@school.org', 'Teacher at null zip');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (80, 918, 'Hank', 'H', 'Hill', 1, '555-0500', 'addr918_teacher@school.org', 'Teacher at address_id 918');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (1, 1, 'Sam', 'S', 'Smith', '555-9999', 'student_at_918@school.org', '2020-09-01 00:00:00', '2024-06-01 00:00:00', 'Student not teacher');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.teacher_id AS teacher_id, RHS.first_name AS first_name, RHS.middle_name AS middle_name, RHS.last_name AS last_name, RHS.gender AS gender, RHS.cell_mobile_number AS cell_mobile_number, RHS.email_address AS email_address, RHS.other_details AS other_details FROM (SELECT * FROM addresses WHERE (zip_postcode = 918)) AS LHS LEFT JOIN teachers AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY email_address;

/*
Gold Result:
('a_teacher@school.org',)
('b_teacher@school.org',)
('c_teacher@school.org',)
('d_teacher@school.org',)
*/

-- Prediction Query
SELECT T2.email_address FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id = T2.address_id WHERE T1.zip_postcode = '918';

/*
Prediction Result:
('d_teacher@school.org',)
('c_teacher@school.org',)
('b_teacher@school.org',)
('a_teacher@school.org',)
*/