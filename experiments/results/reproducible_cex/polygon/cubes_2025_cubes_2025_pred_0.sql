-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (12, 'Cancelled1', 'Cancelled1', 'Cancelled1', 'Cancelled1', 'Cancelled1');
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (11, 'Cancelled1', 'Cancelled1', 'Cancelled1', 'Cancelled1', 'Cancelled1');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (13, 11, 'Cancelled1', 'Cancelled1', 'Cancelled1', 'Cancelled1', 1, 1, 1);
INSERT INTO "Vehicles" ("vehicle_id", "vehicle_details") VALUES (16, 'Cancelled1');
INSERT INTO "Vehicles" ("vehicle_id", "vehicle_details") VALUES (15, 'Cancelled1');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (17, NULL, 'Cancelled1', 1, 1, 'Cancelled1', 'Cancelled1', 1, 'Cancelled1', 'Cancelled1', 'Cancelled1');
INSERT INTO "Customer_Payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (17, 20, 'Cancelled1', 1);
INSERT INTO "Customer_Payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (17, 19, 'Cancelled1', 1);
INSERT INTO "Lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (22, NULL, NULL, NULL, 'Cancelled26', 1, 'Cancelled1', 1);
INSERT INTO "Lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (21, NULL, NULL, NULL, 'Cancelled', 29, 'Cancelled30', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "lesson_status_code", COUNT(*) AS "n" FROM "lessons" GROUP BY "lesson_status_code") WHERE ("lesson_status_code" = 'Cancelled') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Lessons WHERE lesson_status_code = 'Cancelled';

/*
Prediction Result:
(1,)
*/