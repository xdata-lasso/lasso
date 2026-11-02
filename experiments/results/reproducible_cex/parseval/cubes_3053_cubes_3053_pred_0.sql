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
-- Inserting into table: students --
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483648, 1, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (2, 1, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (3, 1, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483645, 3, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483644, 3, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483643, 3, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483642, 1, 't2__94fb20', 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483641, 1, NULL, 'stu_bce5a9', 't2__37a38e', 'stu_46e6b9', 'stu_b0fcc4', '2024-02-11 16:43:27+00:00', '2025-06-13 15:31:02+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483640, 1, 't2__94fb20', 'stu_bce5a9', NULL, 'stu_46e6b9', 'stu_b0fcc4', '2021-01-07 01:22:28+00:00', '2022-04-15 05:01:35+00:00', 'stu_713836');

INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (4, 4, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'stu_713836');

-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'Wisconsin', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483647, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -664303813, 'Wisconsin', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 247012447, 'Wisconsin', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -1980249628, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, NULL, 'add_0b134e', 'add_ea5be5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "first_name", "last_name" FROM (SELECT * FROM "students" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "addresses" WHERE ("state_province_county" <> 'Wisconsin')) AS RHS WHERE (LHS.address_id = RHS.address_id))) ORDER BY first_name;

/*
Gold Result:
(None, 't2__37a38e')
('stu_314a8f', 'stu_84974d')
('t2__94fb20', 't2__37a38e')
('t2__94fb20', 't2__37a38e')
('t2__94fb20', None)
('t2__94fb20', 't2__37a38e')
('t2__94fb20', 't2__37a38e')
*/

-- Prediction Query
SELECT T2.first_name, T2.last_name FROM Addresses AS T1 JOIN Students AS T2 ON T1.address_id = T2.address_id WHERE T1.state_province_county = 'Wisconsin';

/*
Prediction Result:
('t2__94fb20', 't2__37a38e')
('t2__94fb20', 't2__37a38e')
(None, 't2__37a38e')
('t2__94fb20', None)
('t2__94fb20', 't2__37a38e')
('t2__94fb20', 't2__37a38e')
*/