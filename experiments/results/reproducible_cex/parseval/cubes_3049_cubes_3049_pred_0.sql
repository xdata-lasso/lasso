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
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1, -2147483648, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'stu_713836');

-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483648, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -664303813, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: teachers --
INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (1, -55602865, 'tea_ca9e5b', 'tea_e5b9ca', 'tea_4bc33d', -59984348, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

-- Inserting into table: assessment_notes --
INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, NULL, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', NULL);

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, NULL, 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 'ass_5ac0a2');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, -1980249628, '2022-02-14 19:27:39+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 89267185, '2020-09-25 19:25:33+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1160656988, '2022-04-15 05:01:35+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1268590800, '2023-03-21 21:13:18+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1644814318, '2020-12-10 17:36:20+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 906324270, '2020-04-05 14:43:51+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 13244799, '2022-09-23 20:24:07+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1526238907, '2021-07-11 07:27:32+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, -1610064545, '2020-03-11 00:23:16+00:00', 'ass_094e1d', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, 1, 1236688122, '2021-08-20 16:50:24+00:00', 'ass_094e1d', 'ass_fff079');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT notes_id, student_id, teacher_id, date_of_notes, text_of_notes, other_details FROM assessment_notes ORDER BY notes_id;

/*
Gold Result:
(None, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(-1980249628, 1, 1, '2022-02-14 19:27:39+00:00', 'ass_094e1d', 'ass_fff079')
(-1610064545, 1, 1, '2020-03-11 00:23:16+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', None)
(1, 1, 1, None, 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', None, 'ass_5ac0a2')
(13244799, 1, 1, '2022-09-23 20:24:07+00:00', 'ass_094e1d', 'ass_fff079')
(89267185, 1, 1, '2020-09-25 19:25:33+00:00', 'ass_094e1d', 'ass_fff079')
(906324270, 1, 1, '2020-04-05 14:43:51+00:00', 'ass_094e1d', 'ass_fff079')
(1160656988, 1, 1, '2022-04-15 05:01:35+00:00', 'ass_094e1d', 'ass_fff079')
(1236688122, 1, 1, '2021-08-20 16:50:24+00:00', 'ass_094e1d', 'ass_fff079')
(1268590800, 1, 1, '2023-03-21 21:13:18+00:00', 'ass_094e1d', 'ass_fff079')
(1526238907, 1, 1, '2021-07-11 07:27:32+00:00', 'ass_094e1d', 'ass_fff079')
(1644814318, 1, 1, '2020-12-10 17:36:20+00:00', 'ass_094e1d', 'ass_fff079')
*/

-- Prediction Query
SELECT * FROM Assessment_Notes ORDER BY date_of_notes ASC;

/*
Prediction Result:
(1, 1, 1, None, 'ass_133d94', 'ass_5ac0a2')
(1, 1, -1610064545, '2020-03-11 00:23:16+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 906324270, '2020-04-05 14:43:51+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 89267185, '2020-09-25 19:25:33+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1644814318, '2020-12-10 17:36:20+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1526238907, '2021-07-11 07:27:32+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1236688122, '2021-08-20 16:50:24+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, -1980249628, '2022-02-14 19:27:39+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1160656988, '2022-04-15 05:01:35+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 13244799, '2022-09-23 20:24:07+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1268590800, '2023-03-21 21:13:18+00:00', 'ass_094e1d', 'ass_fff079')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, None, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', None)
(1, 1, 1, '2024-06-15 00:00:00+00:00', 'ass_133d94', 'ass_5ac0a2')
(1, 1, 1, '2024-06-15 00:00:00+00:00', None, 'ass_5ac0a2')
*/