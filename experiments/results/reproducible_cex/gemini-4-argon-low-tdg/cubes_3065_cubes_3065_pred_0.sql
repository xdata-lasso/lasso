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
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('NOISE', 'Noise Violation');
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('THEFT', 'Theft');
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('noise', 'Lowercase Noise');
INSERT INTO "Addresses" ("address_id", "line_1", "city", "country") VALUES (1, '123 Main St', 'Springfield', 'USA');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (1, 1, 'John', 'Doe');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (2, 1, 'Jane', 'Smith');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (1, 1, 'NOISE', '2023-05-10 10:00:00', '2023-05-10 12:00:00', 'Loud music');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (2, 2, 'NOISE', '2023-01-15 08:00:00', '2023-06-20 18:00:00', 'Shouting');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (3, 1, 'THEFT', '2023-02-01 09:00:00', '2023-02-01 10:00:00', 'NOISE');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (4, 2, 'noise', '2023-03-01 09:00:00', '2023-03-01 10:00:00', 'Quiet noise');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_incident_start", "date_incident_end" FROM "behavior_incident" WHERE ("incident_type_code" = 'NOISE') ORDER BY date_incident_start;

/*
Gold Result:
('2023-01-15 08:00:00', '2023-06-20 18:00:00')
('2023-05-10 10:00:00', '2023-05-10 12:00:00')
*/

-- Prediction Query
SELECT date_incident_start, date_incident_end FROM Behavior_Incident WHERE incident_type_code = 'NOISE';

/*
Prediction Result:
('2023-05-10 10:00:00', '2023-05-10 12:00:00')
('2023-01-15 08:00:00', '2023-06-20 18:00:00')
*/