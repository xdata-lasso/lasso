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
INSERT INTO "ref_detention_type" ("detention_type_code", "detention_type_description") VALUES ('generation', 'Lawyer front they everything week.');
INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (1067, 1068, 'Robert', 'Julie Curry', 'Schultz', 1069, '4535100330', 'thomaswilson@example.org', 'make');
INSERT INTO "teachers" ("teacher_id", "address_id", "first_name", "middle_name", "last_name", "gender", "cell_mobile_number", "email_address", "other_details") VALUES (1077, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary", "other_details") VALUES (1070, 1067, 'generation', '1971-09-08', '1972-10-09', 'Short cold parent security boy.', 'tell');
INSERT INTO "detention" ("detention_id", "teacher_id", "detention_type_code", "datetime_detention_start", "datetime_detention_end", "detention_summary", "other_details") VALUES (1071, 1077, 'generation', '1971-09-08', '1972-10-09', 'Short cold parent security boy.', 'tell');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "datetime_detention_start", "datetime_detention_end" FROM (SELECT * FROM "detention" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "teachers" WHERE ("last_name" <> 'Schultz')) AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY datetime_detention_start;

/*
Gold Result:
('1971-09-08', '1972-10-09')
('1971-09-08', '1972-10-09')
*/

-- Prediction Query
SELECT T1.datetime_detention_start, datetime_detention_end FROM Detention AS T1 JOIN Teachers AS T2 ON T1.teacher_id = T2.teacher_id WHERE T2.last_name = 'Schultz';

/*
Prediction Result:
('1971-09-08', '1972-10-09')
*/