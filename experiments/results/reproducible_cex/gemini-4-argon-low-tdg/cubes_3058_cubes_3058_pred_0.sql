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
INSERT INTO Addresses (address_id, line_1, city, zip_postcode) VALUES (1, '100 Main St', 'Boston', 918);
INSERT INTO Addresses (address_id, line_1, city, zip_postcode) VALUES (2, '200 Oak St', 'Boston', 918);
INSERT INTO Addresses (address_id, line_1, city, zip_postcode) VALUES (3, '300 Pine St', 'Boston', 917);
INSERT INTO Addresses (address_id, line_1, city, zip_postcode) VALUES (4, '400 Elm St', 'Boston', 919);
INSERT INTO Teachers (teacher_id, address_id, first_name, last_name, email_address) VALUES (1, 1, 'John', 'Doe', 'z_john@school.edu');
INSERT INTO Teachers (teacher_id, address_id, first_name, last_name, email_address) VALUES (2, 1, 'Jane', 'Doe', 'a_jane@school.edu');
INSERT INTO Teachers (teacher_id, address_id, first_name, last_name, email_address) VALUES (3, 3, 'Bob', 'Smith', 'bob_917@school.edu');
INSERT INTO Teachers (teacher_id, address_id, first_name, last_name, email_address) VALUES (4, 99, 'Ghost', 'Teacher', 'ghost@school.edu');
INSERT INTO Students (student_id, address_id, first_name, last_name, email_address) VALUES (1, 1, 'Student', 'One', 'student1@school.edu');
INSERT INTO Students (student_id, address_id, first_name, last_name, email_address) VALUES (2, 2, 'Student', 'Two', 'student2@school.edu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT email_address FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.teacher_id AS teacher_id, RHS.first_name AS first_name, RHS.middle_name AS middle_name, RHS.last_name AS last_name, RHS.gender AS gender, RHS.cell_mobile_number AS cell_mobile_number, RHS.email_address AS email_address, RHS.other_details AS other_details FROM (SELECT * FROM addresses WHERE (zip_postcode = 918)) AS LHS LEFT JOIN teachers AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY email_address;

/*
Gold Result:
(None,)
('a_jane@school.edu',)
('z_john@school.edu',)
*/

-- Prediction Query
SELECT T2.email_address FROM Addresses AS T1 JOIN Teachers AS T2 ON T1.address_id = T2.address_id WHERE T1.zip_postcode = '918';

/*
Prediction Result:
('z_john@school.edu',)
('a_jane@school.edu',)
*/