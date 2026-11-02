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
-- Tests basic ordering (out-of-order insertion vs chronological order), duplicate dates (kills DISTINCT/GROUP BY mutants), and inverse correlation with notes_id (kills ORDER BY notes_id mutants).
INSERT INTO "Addresses" ("address_id", "line_1", "city", "country") VALUES (1, '123 Main St', 'Springfield', 'USA');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name") VALUES (1, 1, 'John', 'Doe');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (1, 1, 'Alice', 'Smith');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2023-05-10 14:30:00', 'Z_note', 'detail_C');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 2, '2021-01-15 09:00:00', 'M_note', 'detail_A');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 3, '2022-11-20 11:15:00', 'A_note', 'detail_B');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 4, '2021-01-15 09:00:00', 'B_note', 'detail_D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_notes FROM assessment_notes ORDER BY date_of_notes;

/*
Gold Result:
('2021-01-15 09:00:00',)
('2021-01-15 09:00:00',)
('2022-11-20 11:15:00',)
('2023-05-10 14:30:00',)
*/

-- Prediction Query
SELECT date_of_notes FROM Assessment_Notes;

/*
Prediction Result:
('2023-05-10 14:30:00',)
('2021-01-15 09:00:00',)
('2022-11-20 11:15:00',)
('2021-01-15 09:00:00',)
*/