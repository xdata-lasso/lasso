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
-- Tests basic ordering (out-of-order insertion of notes_id), column order/selection, and distinct values across columns.
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (1, '123 Main St', 'Springfield', 12345, 'USA');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name", "gender") VALUES (10, 1, 'John', 'Doe', 1);
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name", "gender") VALUES (20, 1, 'Jane', 'Smith', 2);
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (100, 1, 'Alice', 'Brown');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (200, 1, 'Bob', 'White');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (10, 200, 30, '2023-05-01 10:00:00', 'Note text C', 'Detail C');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (20, 100, 10, '2023-06-15 09:30:00', 'Note text A', 'Detail A');
INSERT INTO "Assessment_Notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (10, 100, 20, '2023-01-10 14:15:00', 'Note text B', 'Detail B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT notes_id, student_id, teacher_id, date_of_notes, text_of_notes, other_details FROM assessment_notes ORDER BY notes_id;

/*
Gold Result:
(10, 100, 20, '2023-06-15 09:30:00', 'Note text A', 'Detail A')
(20, 100, 10, '2023-01-10 14:15:00', 'Note text B', 'Detail B')
(30, 200, 10, '2023-05-01 10:00:00', 'Note text C', 'Detail C')
*/

-- Prediction Query
SELECT * FROM Assessment_Notes ORDER BY date_of_notes ASC;

/*
Prediction Result:
(10, 100, 20, '2023-01-10 14:15:00', 'Note text B', 'Detail B')
(10, 200, 30, '2023-05-01 10:00:00', 'Note text C', 'Detail C')
(20, 100, 10, '2023-06-15 09:30:00', 'Note text A', 'Detail A')
*/