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
INSERT INTO Ref_Address_Types (address_type_code, address_type_description) VALUES ('HOME', 'Home Address');
INSERT INTO Ref_Address_Types (address_type_code, address_type_description) VALUES ('TERM', 'Term Address');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('WEEKEND', 'Weekend Detention');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('LUNCH', 'Lunchtime Detention');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('AFTER', 'After School Detention');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('MORNING', 'Morning Detention');
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('SUSP', 'In-School Suspension');
INSERT INTO Ref_Incident_Type (incident_type_code, incident_type_description) VALUES ('NOISE', 'Class Disruption');
INSERT INTO Ref_Incident_Type (incident_type_code, incident_type_description) VALUES ('TARDY', 'Late Arrival');
INSERT INTO Addresses (address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Main St', NULL, NULL, 'Springfield', 12345, 'IL', 'USA', NULL);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (1, 1, 'Alice', 'M', 'Smith', 1, '555-0101', 'asmith@school.edu', NULL);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender, cell_mobile_number, email_address, other_details) VALUES (2, 1, 'Bob', 'J', 'Jones', 0, '555-0102', 'bjones@school.edu', NULL);
INSERT INTO Students (student_id, address_id, first_name, middle_name, last_name, cell_mobile_number, email_address, date_first_rental, date_left_university, other_student_details) VALUES (1, 1, 'Charlie', 'D', 'Brown', '555-0201', 'cbrown@school.edu', '2022-09-01 00:00:00', NULL, NULL);
INSERT INTO Behavior_Incident (incident_id, student_id, incident_type_code, date_incident_start, date_incident_end, incident_summary, recommendations, other_details) VALUES (1, 1, 'NOISE', '2023-03-01 09:00:00', '2023-03-01 09:30:00', 'Talking loudly', 'Detention', NULL);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (1, 1, 'WEEKEND', '2023-03-04 09:00:00', '2023-03-04 12:00:00', 'Saturday session 1', NULL);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (2, 2, 'LUNCH', '2023-03-05 12:00:00', '2023-03-05 12:45:00', 'Lunch session', NULL);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (3, 1, 'AFTER', '2023-03-06 15:30:00', '2023-03-06 16:30:00', 'After school 1', NULL);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (4, 2, 'WEEKEND', '2023-03-11 09:00:00', '2023-03-11 12:00:00', 'Saturday session 2', NULL);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary, other_details) VALUES (5, 1, 'AFTER', '2023-03-13 15:30:00', '2023-03-13 16:30:00', 'After school 2', NULL);
INSERT INTO Students_in_Detention (student_id, detention_id, incident_id) VALUES (1, 1, 1);
INSERT INTO Students_in_Detention (student_id, detention_id, incident_id) VALUES (1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT detention_type_code FROM detention ORDER BY detention_type_code;

/*
Gold Result:
('AFTER',)
('LUNCH',)
('WEEKEND',)
*/

-- Prediction Query
SELECT DISTINCT detention_type_code FROM Detention;

/*
Prediction Result:
('WEEKEND',)
('LUNCH',)
('AFTER',)
*/