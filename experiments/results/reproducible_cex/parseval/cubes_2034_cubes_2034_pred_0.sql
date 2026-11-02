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
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (-2147483648, 'add_a42cda', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, -2147483648, 'cus_fee3aa', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'cus_3e707b', 'cus_c0de68', 2000.0, 'cus_e7c176', 'cus_eed95f', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (2, -2147483648, 'cus_fee3aa', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'cus_3e707b', 'cus_c0de68', 2000.0, 'cus_e7c176', 'cus_eed95f', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (3, -2147483648, 'cus_fee3aa', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'cus_3e707b', 'cus_c0de68', 2000.0, 'cus_e7c176', 'cus_eed95f', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (4, -2147483648, 'cus_fee3aa', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'cus_3e707b', 'cus_c0de68', 1999.99, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (5, -2147483648, 'cus_fee3aa', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'cus_3e707b', 'cus_c0de68', NULL, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (6, -2147483648, 'cus_fee3aa', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'cus_3e707b', 'cus_c0de68', 2000.0, 'cus_275a9f', NULL, 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (7, -2147483648, 'cus_fee3aa', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'cus_3e707b', 'cus_c0de68', 2000.0, NULL, 'cus_d5f626', 'cus_4c44f9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT phone_number, email_address FROM customers WHERE (amount_outstanding >= 2000.0) ORDER BY phone_number, customers.customer_id NULLS LAST;

/*
Gold Result:
(None, 'cus_275a9f')
('cus_d5f626', None)
('cus_eed95f', 'cus_e7c176')
('cus_eed95f', 'cus_e7c176')
('cus_eed95f', 'cus_e7c176')
*/

-- Prediction Query
SELECT phone_number, email_address FROM Customers WHERE amount_outstanding > 2000;

/*
Prediction Result:
*/