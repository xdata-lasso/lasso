-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '202 Oak Ave', 'Gotham', '20002', 'NJ', 'USA');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, 1, 'Active', '2020-01-01 00:00:00', '1980-01-01 00:00:00', 'Carole', 'Bernhard', 150.00, 'carole@example.com', '555-0201', '555-0202');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (2, 1, 'Active', '2020-01-01 00:00:00', '1980-01-01 00:00:00', 'Alice', 'Wonder', 50.00, 'alice@example.com', '555-0203', '555-0204');
INSERT INTO "Customer_Payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (2, '2023-02-01 12:00:00', 'CC', 75.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "sumamount_payment" AS "sum_t1_amount_payment_" FROM (SELECT "first_name", "last_name", SUM("amount_payment") AS "sumamount_payment" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_address_id" AS "customer_address_id", "LHS"."customer_status_code" AS "customer_status_code", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."date_of_birth" AS "date_of_birth", "LHS"."first_name" AS "first_name", "LHS"."last_name" AS "last_name", "LHS"."amount_outstanding" AS "amount_outstanding", "LHS"."email_address" AS "email_address", "LHS"."phone_number" AS "phone_number", "LHS"."cell_mobile_phone_number" AS "cell_mobile_phone_number", "RHS"."datetime_payment" AS "datetime_payment", "RHS"."payment_method_code" AS "payment_method_code", "RHS"."amount_payment" AS "amount_payment" FROM "customers" AS "LHS" INNER JOIN "customer_payments" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) GROUP BY "first_name", "last_name") WHERE ("first_name" = 'Carole' AND "last_name" = 'Bernhard') ORDER BY sum_t1_amount_payment_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(T1.amount_payment) FROM Customer_Payments AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'Carole' AND T2.last_name = 'Bernhard';

/*
Prediction Result:
(None,)
*/