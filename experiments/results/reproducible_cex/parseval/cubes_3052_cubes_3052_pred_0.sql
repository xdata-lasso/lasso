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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, 't1__e2147f', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483647, 't1__e2147f', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1610062532, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, 't1__e2147f', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1160656988, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -252690330, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (5, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -59984348, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (6, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1610062532, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (7, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -106629402, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (8, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -1865039888, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (9, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1160656988, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (10, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1115440883, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (11, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1644814318, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (12, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (13, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 247012447, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (14, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', 1160656988, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: student_addresses --
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 0.0001, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 0.0002, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-11-14 12:35:58+00:00', '2024-09-28 03:06:45+00:00', 0.0003, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 0.0004, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 0.0005, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', 0.0006, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-01-21 14:23:36+00:00', '2022-10-06 13:20:05+00:00', 0.0007, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 0.0008, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00', 0.0009, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00', 0.001, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 0.0011, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2020-06-20 11:35:06+00:00', '2021-07-11 07:27:32+00:00', 0.0012, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-08-02 13:58:36+00:00', '2021-01-23 18:11:33+00:00', 0.0013, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00', 0.0014, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 3, '2022-01-18 15:57:55+00:00', '2022-04-12 01:47:28+00:00', 0.0015, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00', 0.0016, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00', 0.0017, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00', 0.0018, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00', 0.0019, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00', 0.002, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00', 0.0021, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 0.0022, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-05-02 19:47:39+00:00', '2023-07-26 05:50:21+00:00', 0.0023, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', 0.0024, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2023-12-22 03:17:01+00:00', '2024-05-26 02:52:16+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-10-24 14:16:53+00:00', '2024-02-23 22:32:48+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-09-21 09:36:38+00:00', '2023-05-17 17:49:21+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2025-10-02 08:51:14+00:00', '2022-10-09 12:52:21+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2024-01-27 22:01:59+00:00', '2021-09-24 11:50:48+00:00', NULL, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 4, '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 2.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 4, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 3.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 5, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00', 0.0036, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 6, '2020-11-05 04:59:51+00:00', '2025-11-08 19:01:33+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 5, '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 8, '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 10, '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 10, '2022-04-13 09:01:25+00:00', '2022-12-20 09:53:17+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 12, '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00', 0.0043, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 0.0044, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 4, '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 13, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 0.0046, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, -2147483647, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 0.0047, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, -2147483647, '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', 1.0, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 14, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00', 0.0049, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 1, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 0.005, 'stu_8b8c71');

INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (-2147483648, 14, '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00', 1.0, 'stu_8b8c71');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT line_1, meanmonthly_rental AS avg_t2_monthly_rental_ FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, LHS.student_id AS student_id, LHS.date_address_from AS date_address_from, LHS.date_address_to AS date_address_to, LHS.monthly_rental AS monthly_rental, LHS.other_details AS other_details, RHS.meanmonthly_rental AS meanmonthly_rental FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.student_id AS student_id, RHS.date_address_from AS date_address_from, RHS.date_address_to AS date_address_to, RHS.monthly_rental AS monthly_rental, RHS.other_details AS other_details FROM addresses AS LHS INNER JOIN student_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, AVG(monthly_rental) AS meanmonthly_rental FROM student_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY line_1;

/*
Gold Result:
('add_263ee2', 0.0010999999999999998)
('add_263ee2', 2.0)
('add_263ee2', 0.5018)
('add_263ee2', 1.0)
('add_263ee2', 0.0043)
('add_263ee2', 0.0046)
('add_263ee2', 0.50245)
('t1__e2147f', 0.50235)
('t1__e2147f', 0.05719444444444444)
*/

-- Prediction Query
SELECT T1.line_1, AVG(T2.monthly_rental) FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id = T2.address_id GROUP BY T2.address_id;

/*
Prediction Result:
('t1__e2147f', 0.50235)
('t1__e2147f', 0.05719444444444444)
('add_263ee2', 0.0010999999999999998)
('add_263ee2', 2.0)
('add_263ee2', 0.5018)
('add_263ee2', 1.0)
('add_263ee2', 1.0)
('add_263ee2', 1.0)
('add_263ee2', 0.0043)
('add_263ee2', 0.0046)
('add_263ee2', 0.50245)
*/