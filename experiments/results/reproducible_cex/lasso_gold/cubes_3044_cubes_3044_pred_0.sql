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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1109, 'main', 'specific', 'father', 'Shawchester', 1110, 'Hawaii', 'Svalbard & Jan Mayen Islands', '0758 Jennifer Path
West Christopherburgh, KY 59394');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1113, 'fish', 'campaign', 'anyone', 'South Danielle', 1114, 'South Carolina', 'Kuwait', '808 Jennifer Highway Suite 095
New Robert, TN 88085');
INSERT INTO "ref_incident_type" ("incident_type_code", "incident_type_description") VALUES ('western', 'Challenge join watch develop later glass ago.');
INSERT INTO "ref_incident_type" ("incident_type_code", "incident_type_description") VALUES ('bed', 'Window attack moment medical write never hospital.');
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1111, 1109, 'Brian', 'Cynthia Vang', 'Fahey', '(930)951-5220x472', 'bullockandrew@example.org', '1983-02-09', '1984-03-10', 'thing');
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1115, 1113, 'Theodore', 'Veronica King', 'Fahey', '2517531952', 'lisa27@example.net', '1987-06-13', '1988-07-14', 'measure');
INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (1112, 1111, 'western', '1985-04-12', '1986-05-12', 'Consider care respond want already cut social though.', 'fight', 'economy');
INSERT INTO "behavior_incident" ("incident_id", "student_id", "incident_type_code", "date_incident_start", "date_incident_end", "incident_summary", "recommendations", "other_details") VALUES (1116, 1115, 'bed', '1985-04-11', '1990-09-16', 'Nature road month book.', 'four', 'worker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_incident_start", "date_incident_end" FROM (SELECT "LHS"."incident_id" AS "incident_id", "LHS"."incident_type_code" AS "incident_type_code", "LHS"."student_id" AS "student_id", "LHS"."date_incident_start" AS "date_incident_start", "LHS"."date_incident_end" AS "date_incident_end", "LHS"."incident_summary" AS "incident_summary", "LHS"."recommendations" AS "recommendations", "LHS"."other_details" AS "other_details", "RHS"."address_id" AS "address_id", "RHS"."first_name" AS "first_name", "RHS"."middle_name" AS "middle_name", "RHS"."last_name" AS "last_name", "RHS"."cell_mobile_number" AS "cell_mobile_number", "RHS"."email_address" AS "email_address", "RHS"."date_first_rental" AS "date_first_rental", "RHS"."date_left_university" AS "date_left_university", "RHS"."other_student_details" AS "other_student_details" FROM "behavior_incident" AS "LHS" INNER JOIN "students" AS "RHS" ON ("LHS"."student_id" = "RHS"."student_id")) WHERE ("last_name" = 'Fahey') ORDER BY date_incident_start;

/*
Gold Result:
('1985-04-11', '1990-09-16')
('1985-04-12', '1986-05-12')
*/

-- Prediction Query
SELECT T1.date_incident_start, date_incident_end FROM Behavior_Incident AS T1 JOIN Students AS T2 ON T1.student_id = T2.student_id WHERE T2.last_name = 'Fahey';

/*
Prediction Result:
('1985-04-12', '1986-05-12')
('1985-04-11', '1990-09-16')
*/