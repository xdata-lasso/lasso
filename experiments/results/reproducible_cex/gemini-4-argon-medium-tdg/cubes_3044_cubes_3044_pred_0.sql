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
-- Tests basic INNER JOIN, WHERE clause filtering ('Fahey' vs other names, first/middle vs last name, case sensitivity), and ORDER BY date_incident_start (ASC vs DESC vs insertion order vs end date order).
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (1, '123 Main St', 'Springfield', 12345, 'USA');
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('NOISE', 'Noise Complaint');
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('DAMAGE', 'Property Damage');
-- Student 1: Matches last_name = 'Fahey'
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (1, 1, 'John', 'Paul', 'Fahey', '2020-09-01 00:00:00', '2024-06-01 00:00:00');
-- Student 2: Does NOT match last_name, but has 'Fahey' as first_name and middle_name (tests column confusion)
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (2, 1, 'Fahey', 'Fahey', 'Smith', '2020-09-01 00:00:00', '2024-06-01 00:00:00');
-- Student 3: Lowercase 'fahey' (tests case sensitivity / LIKE vs =)
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (3, 1, 'Alice', 'M', 'fahey', '2020-09-01 00:00:00', '2024-06-01 00:00:00');
-- Student 4: Matches last_name = 'Fahey', but has NO incidents (tests INNER JOIN vs RIGHT/FULL JOIN)
INSERT INTO "Students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "date_first_rental", "date_left_university") VALUES (4, 1, 'Bob', 'R', 'Fahey', '2021-09-01 00:00:00', '2025-06-01 00:00:00');
-- Incidents for Student 1 ('Fahey'), inserted out of chronological order, and where start_date order opposes end_date order and incident_id order
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (1, 1, 'NOISE', '2023-05-10 10:00:00', '2023-05-10 12:00:00', 'Loud music');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (2, 1, 'DAMAGE', '2023-01-15 08:00:00', '2023-06-20 09:00:00', 'Broken window');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (3, 1, 'NOISE', '2023-03-01 14:00:00', '2023-05-15 15:00:00', 'Party');
-- Incidents for non-matching students
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (4, 2, 'NOISE', '2022-01-01 00:00:00', '2022-01-02 00:00:00', 'Other student');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (5, 3, 'NOISE', '2022-02-01 00:00:00', '2022-02-02 00:00:00', 'Lowercase student');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_incident_start", "date_incident_end" FROM (SELECT "LHS"."incident_id" AS "incident_id", "LHS"."incident_type_code" AS "incident_type_code", "LHS"."student_id" AS "student_id", "LHS"."date_incident_start" AS "date_incident_start", "LHS"."date_incident_end" AS "date_incident_end", "LHS"."incident_summary" AS "incident_summary", "LHS"."recommendations" AS "recommendations", "LHS"."other_details" AS "other_details", "RHS"."address_id" AS "address_id", "RHS"."first_name" AS "first_name", "RHS"."middle_name" AS "middle_name", "RHS"."last_name" AS "last_name", "RHS"."cell_mobile_number" AS "cell_mobile_number", "RHS"."email_address" AS "email_address", "RHS"."date_first_rental" AS "date_first_rental", "RHS"."date_left_university" AS "date_left_university", "RHS"."other_student_details" AS "other_student_details" FROM "behavior_incident" AS "LHS" INNER JOIN "students" AS "RHS" ON ("LHS"."student_id" = "RHS"."student_id")) WHERE ("last_name" = 'Fahey') ORDER BY date_incident_start;

/*
Gold Result:
('2023-01-15 08:00:00', '2023-06-20 09:00:00')
('2023-03-01 14:00:00', '2023-05-15 15:00:00')
('2023-05-10 10:00:00', '2023-05-10 12:00:00')
*/

-- Prediction Query
SELECT T1.date_incident_start, date_incident_end FROM Behavior_Incident AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.last_name = 'Fahey';

/*
Prediction Result:
('2023-05-10 10:00:00', '2023-05-10 12:00:00')
('2023-01-15 08:00:00', '2023-06-20 09:00:00')
('2023-03-01 14:00:00', '2023-05-15 15:00:00')
*/