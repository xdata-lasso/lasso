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
-- Core logic: Tests ordering (inserted out of chronological order), duplicate date preservation (SELECT vs SELECT DISTINCT), inner join matching, and filtering on first_name = 'Fanny' vs other names or 'Fanny' in other name columns.
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (1, '123 Main St', 'Springfield', 12345, 'USA');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name") VALUES (1, 1, 'John', 'Doe');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (1, 1, 'Fanny', 'Mae', 'Smith', '2020-01-01 00:00:00', '2024-01-01 00:00:00');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (2, 1, 'Fanny', 'Lou', 'Jones', '2021-01-01 00:00:00', '2025-01-01 00:00:00');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (3, 1, 'Fanny', 'Ann', 'NoNotes', '2019-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (4, 1, 'Alice', 'Fanny', 'Fanny', '2020-05-05 00:00:00', '2024-05-05 00:00:00');
INSERT INTO "Assessment_Notes" ("notes_id", "teacher_id", "student_id", "date_of_notes", "text_of_notes") VALUES (101, 1, 1, '2023-05-15 10:00:00', 'Second note chronologically');
INSERT INTO "Assessment_Notes" ("notes_id", "teacher_id", "student_id", "date_of_notes", "text_of_notes") VALUES (102, 1, 1, '2023-01-10 09:00:00', 'First note chronologically');
INSERT INTO "Assessment_Notes" ("notes_id", "teacher_id", "student_id", "date_of_notes", "text_of_notes") VALUES (103, 1, 2, '2023-01-10 09:00:00', 'Duplicate date note from another Fanny');
INSERT INTO "Assessment_Notes" ("notes_id", "teacher_id", "student_id", "date_of_notes", "text_of_notes") VALUES (104, 1, 4, '2022-01-01 08:00:00', 'Note for non-Fanny first_name');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_notes" FROM (SELECT "LHS"."student_id" AS "student_id", "LHS"."address_id" AS "address_id", "LHS"."first_name" AS "first_name", "LHS"."middle_name" AS "middle_name", "LHS"."last_name" AS "last_name", "LHS"."cell_mobile_number" AS "cell_mobile_number", "LHS"."email_address" AS "email_address", "LHS"."date_first_rental" AS "date_first_rental", "LHS"."date_left_university" AS "date_left_university", "LHS"."other_student_details" AS "other_student_details", "RHS"."notes_id" AS "notes_id", "RHS"."teacher_id" AS "teacher_id", "RHS"."date_of_notes" AS "date_of_notes", "RHS"."text_of_notes" AS "text_of_notes", "RHS"."other_details" AS "other_details" FROM (SELECT * FROM "students" WHERE ("first_name" = 'Fanny')) AS LHS INNER JOIN assessment_notes AS RHS ON (LHS.student_id = RHS.student_id)) ORDER BY date_of_notes;

/*
Gold Result:
('2023-01-10 09:00:00',)
('2023-01-10 09:00:00',)
('2023-05-15 10:00:00',)
*/

-- Prediction Query
SELECT T1.date_of_notes FROM Assessment_Notes AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.first_name = 'Fanny';

/*
Prediction Result:
('2023-05-15 10:00:00',)
('2023-01-10 09:00:00',)
('2023-01-10 09:00:00',)
*/