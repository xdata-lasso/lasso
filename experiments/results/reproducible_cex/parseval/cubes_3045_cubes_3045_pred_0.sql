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
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (-2147483648, -2147483648, 'stu_314a8f', 'stu_bce5a9', 'stu_84974d', 'stu_46e6b9', 'stu_b0fcc4', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'stu_713836');

-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483648, 'add_263ee2', 'add_2e28f5', 'add_9bd5fa', 'add_ae09f0', -664303813, 'add_7d1289', 'add_0b134e', 'add_ea5be5');

-- Inserting into table: teachers --
INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (1, -55602865, 'tea_ca9e5b', 'tea_e5b9ca', 'Schuster', -59984348, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (-2147483647, 1610062532, 'tea_ca9e5b', 'tea_e5b9ca', 'Schuster', -106629402, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (2, -1633151678, 'tea_ca9e5b', 'tea_e5b9ca', 'Schuster', -252690330, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (3, 1115440883, 'tea_ca9e5b', 'tea_e5b9ca', 'tea_4bc33d', 1644814318, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (4, -55602865, 'tea_ca9e5b', 'tea_e5b9ca', NULL, -59984348, 'tea_837324', 'tea_8f8a1d', 'tea_7f3b93');

-- Inserting into table: assessment_notes --
INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, -1726781632, '2021-06-17 14:22:38+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 809183447, '2024-06-06 00:28:47+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, -1865039888, '2025-06-13 15:31:02+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (3, -2147483648, -1349201381, '2020-12-19 01:52:21+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (3, -2147483648, 1526238907, '2021-07-11 07:27:32+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (3, -2147483648, -841692980, '2021-07-20 10:41:36+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, -1257178728, '2022-04-12 01:47:28+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 907682809, '2021-12-08 15:32:00+00:00', 't1__8cd610', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, -1576219117, '2020-08-22 06:30:10+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, -1209887326, '2024-05-04 23:07:19+00:00', 't1__8cd610', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 1151980946, '2020-09-15 12:11:12+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 1419861592, '2025-08-21 21:00:40+00:00', 't1__8cd610', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 374105386, '2020-05-12 00:10:04+00:00', 't1__b863e1', 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (1, -2147483648, 1149850321, '2020-05-18 19:45:10+00:00', NULL, 'ass_fff079');

INSERT INTO "assessment_notes" ("teacher_id", "student_id", "notes_id", "date_of_notes", "text_of_notes", "other_details") VALUES (4, -2147483648, 1258409369, '2020-04-30 03:21:27+00:00', 'ass_094e1d', 'ass_fff079');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "text_of_notes" FROM (SELECT * FROM "assessment_notes" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "teachers" WHERE ("last_name" <> 'Schuster')) AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY text_of_notes;

/*
Gold Result:
(None,)
('ass_094e1d',)
('t1__8cd610',)
('t1__8cd610',)
('t1__8cd610',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
*/

-- Prediction Query
SELECT T1.text_of_notes FROM Assessment_Notes AS T1 JOIN Teachers AS T2 ON T1.teacher_id = T2.teacher_id WHERE T2.last_name = 'Schuster';

/*
Prediction Result:
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__b863e1',)
('t1__8cd610',)
('t1__b863e1',)
('t1__8cd610',)
('t1__b863e1',)
('t1__8cd610',)
('t1__b863e1',)
(None,)
*/