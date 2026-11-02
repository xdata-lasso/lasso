-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, 'lhs_a475bb', 'lhs_a99f49', 'lhs_605613', 'lhs_4e4ecb', 'lhs_8ef2a5');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, 1, 'cus_4d8b21', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'A', 'A', 1.0, 'cus_29d9f9', 'cus_509cf8', 'cus_7b32de');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "country" FROM (SELECT "LHS"."address_id" AS "address_id", "LHS"."line_1_number_building" AS "line_1_number_building", "LHS"."city" AS "city", "LHS"."zip_postcode" AS "zip_postcode", "LHS"."state_province_county" AS "state_province_county", "LHS"."country" AS "country", "RHS"."customer_id" AS "customer_id", "RHS"."customer_address_id" AS "customer_address_id", "RHS"."customer_status_code" AS "customer_status_code", "RHS"."date_became_customer" AS "date_became_customer", "RHS"."date_of_birth" AS "date_of_birth", "RHS"."first_name" AS "first_name", "RHS"."last_name" AS "last_name", "RHS"."amount_outstanding" AS "amount_outstanding", "RHS"."email_address" AS "email_address", "RHS"."phone_number" AS "phone_number", "RHS"."cell_mobile_phone_number" AS "cell_mobile_phone_number" FROM "addresses" AS "LHS" CROSS JOIN (SELECT * FROM "customers" WHERE ("first_name" = 'Carole' OR "last_name" <> 'Bernhard')) AS RHS) ORDER BY country, "country" NULLS LAST;

/*
Gold Result:
('lhs_8ef2a5',)
*/

-- Prediction Query
SELECT T2.country FROM Customers AS T1 JOIN Addresses AS T2 ON T1.customer_address_id = T2.address_id WHERE T1.first_name = 'Carole' AND T1.last_name = 'Bernhard';

/*
Prediction Result:
*/