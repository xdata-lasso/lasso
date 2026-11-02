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
-- 1. Grouping by address_id vs grouping by line_1 (two distinct address_ids sharing the exact same line_1).
-- 2. INNER JOIN vs LEFT JOIN on Addresses (address_id 3 has no Student_Addresses).
-- 3. Addresses referenced in Students.address_id vs Student_Addresses.address_id (student 1 lives at address 3, rents 1 and 2).
-- 4. DISTINCT elimination (address_id 1 has multiple rentals with different values).
-- 5. ORDER BY line_1 vs ORDER BY address_id or AVG(monthly_rental).
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (1, '200 Elm St', 'Metropolis', 10001, 'USA');
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (2, '200 Elm St', 'Gotham', 10002, 'USA');
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (3, '100 Main St', 'Star City', 10003, 'USA');
INSERT INTO "Addresses" ("address_id", "line_1", "city", "zip_postcode", "country") VALUES (4, '050 Oak Ave', 'Central City', 10004, 'USA');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (1, 3, 'John', 'Doe');
INSERT INTO "Students" ("student_id", "address_id", "first_name", "last_name") VALUES (2, 1, 'Jane', 'Smith');
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental") VALUES (1, 1, '2022-01-01', '2022-06-01', 100.0);
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental") VALUES (2, 1, '2022-06-02', '2022-12-31', 200.0);
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental") VALUES (1, 2, '2023-01-01', '2023-06-01', 500.0);
INSERT INTO "Student_Addresses" ("student_id", "address_id", "date_address_from", "date_address_to", "monthly_rental") VALUES (2, 4, '2023-01-01', '2023-06-01', 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT line_1, meanmonthly_rental AS avg_t2_monthly_rental_ FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, LHS.student_id AS student_id, LHS.date_address_from AS date_address_from, LHS.date_address_to AS date_address_to, LHS.monthly_rental AS monthly_rental, LHS.other_details AS other_details, RHS.meanmonthly_rental AS meanmonthly_rental FROM (SELECT LHS.address_id AS address_id, LHS.line_1 AS line_1, LHS.line_2 AS line_2, LHS.line_3 AS line_3, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.other_address_details AS other_address_details, RHS.student_id AS student_id, RHS.date_address_from AS date_address_from, RHS.date_address_to AS date_address_to, RHS.monthly_rental AS monthly_rental, RHS.other_details AS other_details FROM addresses AS LHS INNER JOIN student_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, AVG(monthly_rental) AS meanmonthly_rental FROM student_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY line_1;

/*
Gold Result:
('050 Oak Ave', 1000.0)
('200 Elm St', 150.0)
('200 Elm St', 500.0)
*/

-- Prediction Query
SELECT T1.line_1, AVG(T2.monthly_rental) FROM Addresses AS T1 JOIN Student_Addresses AS T2 ON T1.address_id = T2.address_id GROUP BY T2.address_id;

/*
Prediction Result:
('200 Elm St', 150.0)
('200 Elm St', 500.0)
('050 Oak Ave', 1000.0)
*/