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
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '100 Main St', NULL, NULL, 'Springfield', 12345, 'IL', 'USA', 'None');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('DT1', 'After School');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('DT2', 'Lunch Break');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('DT3', 'Weekend');
INSERT INTO Ref_Incident_Type (incident_type_code, incident_type_description) VALUES ('IT1', 'Noise');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (10, 1, 'Alice', 'M', 'Smith', 1, '555-0100', 'alice@school.edu', 'Math');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (20, 1, 'Bob', 'J', 'Jones', 0, '555-0200', 'bob@school.edu', 'History');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (30, 1, 'Carol', 'A', 'White', 1, '555-0300', 'carol@school.edu', 'Science');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (101, 1, 'John', 'D', 'Doe', '555-1001', 'john@student.edu', '2022-09-01 00:00:00', NULL, 'Freshman');
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (102, 1, 'Jane', 'E', 'Roe', '555-1002', 'jane@student.edu', '2022-09-01 00:00:00', NULL, 'Sophomore');
INSERT INTO Behavior_Incident (incident_id, student_id, incident_type_code, date_incident_start, date_incident_end, incident_summary, recommendations, other_details) VALUES (501, 101, 'IT1', '2023-03-01 09:00:00', '2023-03-01 09:30:00', 'Disrupted class lecture', 'Give warning', 'First offense');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (1, 20, 'DT2', '2023-05-02 15:00:00', '2023-05-02 16:00:00', 'Zebra writing lines', 'Room 102');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (2, 30, 'DT1', '2023-05-03 15:00:00', '2023-05-01 16:00:00', 'Apple cleaning desks', 'Room 103');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (3, 10, 'DT3', '2023-05-01 15:00:00', '2023-05-03 16:00:00', 'Mango silent study', 'Room 101');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (4, 10, 'DT1', '2023-05-04 15:00:00', '2023-05-04 16:00:00', 'Apple cleaning desks', 'Room 104');
INSERT INTO Students_in_Detention (student_id, detention_id, incident_id) VALUES (101, 1, 501);
INSERT INTO Students_in_Detention (student_id, detention_id, incident_id) VALUES (102, 1, 501);
INSERT INTO Students_in_Detention (student_id, detention_id, incident_id) VALUES (101, 2, 501);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT detention_summary FROM detention ORDER BY detention_summary;

/*
Gold Result:
('Apple cleaning desks',)
('Apple cleaning desks',)
('Mango silent study',)
('Zebra writing lines',)
*/

-- Prediction Query
SELECT detention_summary FROM Detention;

/*
Prediction Result:
('Zebra writing lines',)
('Apple cleaning desks',)
('Mango silent study',)
('Apple cleaning desks',)
*/