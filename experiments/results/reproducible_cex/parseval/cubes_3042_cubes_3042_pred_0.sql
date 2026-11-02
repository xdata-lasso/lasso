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
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483648, 1, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 'stu_713836');

-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'Texas', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483647, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -1981402255, 'Texas', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1610062532, 'Texas', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -734455130, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, NULL, 'add_0b134e', 'add_ea5be5');

-- Inserting into table: student_addresses --
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 2, '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 2, '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 2, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-07-05 02:28:20+00:00', '2025-08-22 00:34:24+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-06-20 11:35:06+00:00', '2021-07-11 07:27:32+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-08-02 13:58:36+00:00', '2021-01-23 18:11:33+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 4, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 0.0015, 'stu_8b8c71');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "monthly_rental" FROM (SELECT * FROM "student_addresses" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "addresses" WHERE ("state_province_county" <> 'Texas')) AS RHS WHERE (LHS.address_id = RHS.address_id))) ORDER BY monthly_rental;

/*
Gold Result:
(None,)
(0.0015,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
*/

-- Prediction Query
SELECT T2.monthly_rental FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id = T2.address_id WHERE T1.state_province_county = 'Texas';

/*
Prediction Result:
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(1.0,)
(None,)
*/