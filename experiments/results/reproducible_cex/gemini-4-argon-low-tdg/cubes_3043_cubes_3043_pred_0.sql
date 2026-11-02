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
-- Tests:
-- 1. Missing DISTINCT (duplicate detention_type_code 'AFTER' and 'LUNCH')
-- 2. Missing or incorrect ORDER BY (detention_id order is Z, A, M; frequency order differs from alphabetical)
-- 3. Querying Ref_Detention_Type instead of Detention ('UNUSED' exists in Ref_Detention_Type but not in Detention)
-- 4. Unnecessary INNER JOIN with Teachers (detention_id 2 has NULL teacher_id)
-- 5. Unnecessary INNER JOIN with Students_in_Detention (detention_id 2 and 4 have no students assigned)
-- 6. Selecting wrong column (e.g., detention_type_description or incident_type_code)
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '123 Main St', 'Springfield', 12345, 'IL', 'USA');
INSERT INTO "Teachers" ("teacher_id", "address_id", "first_name", "last_name", "gender") VALUES (1, 1, 'John', 'Doe', 1);
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (1, 1, 'Alice', 'Smith');
INSERT INTO "Ref_Detention_Type" ("detention_type_code", "detention_type_description") VALUES ('AFTER', 'After School');
INSERT INTO "Ref_Detention_Type" ("detention_type_code", "detention_type_description") VALUES ('LUNCH', 'Lunchtime');
INSERT INTO "Ref_Detention_Type" ("detention_type_code", "detention_type_description") VALUES ('SAT', 'Saturday');
INSERT INTO "Ref_Detention_Type" ("detention_type_code", "detention_type_description") VALUES ('UNUSED', 'Unused Type');
INSERT INTO "Ref_Incident_Type" ("incident_type_code", "incident_type_description") VALUES ('NOISE', 'Excessive Noise');
INSERT INTO "Behavior_Incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary") VALUES (1, 1, 'NOISE', '2023-01-01 09:00:00', '2023-01-01 09:30:00', 'Loud talking');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (1, 1, 'SAT', '2023-01-07 09:00:00', '2023-01-07 12:00:00', 'Saturday detention');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (2, NULL, 'AFTER', '2023-01-02 15:00:00', '2023-01-02 16:00:00', 'After school 1');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (3, 1, 'AFTER', '2023-01-03 15:00:00', '2023-01-03 16:00:00', 'After school 2');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (4, 1, 'LUNCH', '2023-01-04 12:00:00', '2023-01-04 12:30:00', 'Lunch detention 1');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (5, 1, 'LUNCH', '2023-01-05 12:00:00', '2023-01-05 12:30:00', 'Lunch detention 2');
INSERT INTO "Detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary") VALUES (6, 1, 'LUNCH', '2023-01-06 12:00:00', '2023-01-06 12:30:00', 'Lunch detention 3');
INSERT INTO "Students_in_Detention" ("student_id", "detention_id", "incident_id") VALUES (1, 1, 1);
INSERT INTO "Students_in_Detention" ("student_id", "detention_id", "incident_id") VALUES (1, 3, 1);
INSERT INTO "Students_in_Detention" ("student_id", "detention_id", "incident_id") VALUES (1, 5, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT detention_type_code FROM detention ORDER BY detention_type_code;

/*
Gold Result:
('AFTER',)
('LUNCH',)
('SAT',)
*/

-- Prediction Query
SELECT DISTINCT detention_type_code FROM Detention;

/*
Prediction Result:
('SAT',)
('AFTER',)
('LUNCH',)
*/