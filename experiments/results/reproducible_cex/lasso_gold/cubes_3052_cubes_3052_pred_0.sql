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
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1120, 'quality', 'picture', 'against', 'Port Matthewberg', 1121, 'Indiana', 'Switzerland', '335 Kristina Ranch
West Micheleberg, DC 71308');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "line_3", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1125, 'most', 'young', 'possible', 'Lake Kristahaven', 1126, 'Indiana', 'Gabon', '76617 Jones Common
Charleneland, DC 36547');
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1122, 1120, 'Greg', 'Allison Smith', 'Tyler', '395.302.4026', 'xwest@example.net', '1975-08-13', '1976-09-14', 'personal');
INSERT INTO "students" ("student_id", "address_id", "first_name", "middle_name", "last_name", "cell_mobile_number", "email_address", "date_first_rental", "date_left_university", "other_student_details") VALUES (1127, 1125, 'Claudia', 'Michelle James', 'Harper', '778-996-1183x6736', 'gperry@example.com', '1981-03-19', '1982-04-20', 'late');
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (1122, 1120, '1977-10-15', '1978-11-16', 1123.5, 'boy');
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (1122, 1120, '1979-01-17', '1980-02-18', 1124.5, 'live');
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (1127, 1125, '1983-05-21', '1984-06-22', 1128.5, 'form');
INSERT INTO "student_addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental", "other_details") VALUES (1127, 1125, '1985-07-23', '1986-08-01', 1129.5, 'reduce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT line_1, meanmonthly_rental AS avg_t2_monthly_rental_ FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, LHS.student_id AS student_id, LHS.date_address_from AS date_address_from, LHS.date_address_to AS date_address_to, LHS.monthly_rental AS monthly_rental, LHS.other_details AS other_details, RHS.meanmonthly_rental AS meanmonthly_rental FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.student_id AS student_id, RHS.date_address_from AS date_address_from, RHS.date_address_to AS date_address_to, RHS.monthly_rental AS monthly_rental, RHS.other_details AS other_details FROM addresses AS LHS INNER JOIN student_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, AVG(monthly_rental) AS meanmonthly_rental FROM student_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY line_1;

/*
Gold Result:
('most', 1129.0)
('quality', 1124.0)
*/

-- Prediction Query
SELECT T1.line_1, AVG(T2.monthly_rental) FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id = T2.address_id GROUP BY T2.address_id;

/*
Prediction Result:
('quality', 1124.0)
('most', 1129.0)
*/