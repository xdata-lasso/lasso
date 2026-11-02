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
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483648, -2147483648, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'stu_713836');

-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483648, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -55602865, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: ref_incident_type --
INSERT INTO "ref_incident_type" ("incident_type_code", "incident_type_description") VALUES ('incident_1', 'ref_1e333f');

-- Inserting into table: behavior_incident --
INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483648, -2147483648, 'incident_1', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483647, -2147483648, 'incident_1', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483646, -2147483648, 'incident_1', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483645, -2147483648, 'incident_1', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483644, -2147483648, 'incident_1', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483643, -2147483648, 'incident_1', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483642, -2147483648, 'incident_1', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483641, -2147483648, 'incident_1', '2020-12-10 17:36:20+00:00', '2022-07-05 02:28:20+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483640, -2147483648, 'incident_1', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483639, -2147483648, 'incident_1', '2022-09-23 20:24:07+00:00', '2020-12-19 01:52:21+00:00', 'beh_6ef01f', 'beh_cd2162', NULL);

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483638, -2147483648, 'incident_1', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00', 'beh_6ef01f', 'beh_cd2162', NULL);

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483637, -2147483648, 'incident_1', '2021-07-20 10:41:36+00:00', '2020-03-11 00:23:16+00:00', 'beh_6ef01f', 'beh_cd2162', NULL);

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483636, -2147483648, 'incident_1', '2022-04-12 01:47:28+00:00', '2021-08-20 16:50:24+00:00', 'beh_6ef01f', 'beh_cd2162', NULL);

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483635, -2147483648, 'incident_1', '2021-12-08 15:32:00+00:00', '2025-04-09 18:22:58+00:00', 'beh_6ef01f', 'beh_cd2162', NULL);

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483634, -2147483648, 'incident_1', '2021-01-29 03:06:29+00:00', '2020-08-22 06:30:10+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483633, -2147483648, 'incident_1', '2021-11-09 05:42:50+00:00', '2022-12-10 02:38:39+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483632, -2147483648, 'incident_1', '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483631, -2147483648, 'incident_1', '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483630, -2147483648, 'incident_1', '2024-03-03 15:52:53+00:00', '2020-04-28 17:03:46+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');

INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (-2147483629, -2147483648, 'incident_1', '2020-05-12 00:10:04+00:00', '2021-02-04 01:21:18+00:00', 'beh_6ef01f', 'beh_cd2162', 'beh_37fc6b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_incident_type_code_ FROM (SELECT other_details, COUNT(DISTINCT incident_type_code) AS n_distinct FROM behavior_incident GROUP BY other_details) ORDER BY count_distinct_incident_type_code_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT incident_type_code) FROM Behavior_Incident;

/*
Prediction Result:
(1,)
*/