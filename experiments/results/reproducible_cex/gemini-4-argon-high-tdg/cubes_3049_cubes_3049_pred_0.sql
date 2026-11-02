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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Main St', NULL, NULL, 'Boston', 2101, 'MA', 'USA', 'Addr 1');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (101, 1, 'Alice', 'M', 'Smith', 1, '555-0101', 'alice@school.edu', 'Teacher Detail 101');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (102, 1, 'Bob', 'N', 'Jones', 0, '555-0102', 'bob@school.edu', 'Teacher Detail 102');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (103, 1, 'Carol', 'O', 'White', 1, '555-0103', 'carol@school.edu', 'Teacher Detail 103');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (201, 1, 'Dan', 'P', 'Brown', '555-0201', 'dan@uni.edu', '2021-09-01 00:00:00', NULL, 'Student Detail 201');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (202, 1, 'Eve', 'Q', 'Davis', '555-0202', 'eve@uni.edu', '2021-09-01 00:00:00', NULL, 'Student Detail 202');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (203, 1, 'Frank', 'R', 'Miller', '555-0203', 'frank@uni.edu', '2020-09-01 00:00:00', '2023-06-01 00:00:00', 'Student Detail 203');
INSERT INTO Assessment_Notes (teacher_id, student_id, notes_id, date_of_notes, text_of_notes, other_details) VALUES (101, 202, 30, '2023-11-20 14:15:00', 'Note D', 'Detail W');
INSERT INTO Assessment_Notes (teacher_id, student_id, notes_id, date_of_notes, text_of_notes, other_details) VALUES (102, 203, 10, '2023-05-15 10:00:00', 'Note C', 'Detail Z');
INSERT INTO Assessment_Notes (teacher_id, student_id, notes_id, date_of_notes, text_of_notes, other_details) VALUES (102, 201, 40, '2023-03-05 09:00:00', 'Note B', 'Detail Y');
INSERT INTO Assessment_Notes (teacher_id, student_id, notes_id, date_of_notes, text_of_notes, other_details) VALUES (103, 201, 20, '2023-01-10 08:30:00', 'Note A', 'Detail X');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT notes_id, student_id, teacher_id, date_of_notes, text_of_notes, other_details FROM assessment_notes ORDER BY notes_id;

/*
Gold Result:
(10, 203, 102, '2023-05-15 10:00:00', 'Note C', 'Detail Z')
(20, 201, 103, '2023-01-10 08:30:00', 'Note A', 'Detail X')
(30, 202, 101, '2023-11-20 14:15:00', 'Note D', 'Detail W')
(40, 201, 102, '2023-03-05 09:00:00', 'Note B', 'Detail Y')
*/

-- Prediction Query
SELECT * FROM Assessment_Notes ORDER BY date_of_notes ASC;

/*
Prediction Result:
(103, 201, 20, '2023-01-10 08:30:00', 'Note A', 'Detail X')
(102, 201, 40, '2023-03-05 09:00:00', 'Note B', 'Detail Y')
(102, 203, 10, '2023-05-15 10:00:00', 'Note C', 'Detail Z')
(101, 202, 30, '2023-11-20 14:15:00', 'Note D', 'Detail W')
*/