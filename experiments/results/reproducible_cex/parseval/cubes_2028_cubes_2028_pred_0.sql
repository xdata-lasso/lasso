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
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, 'add_a42cda', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, 1, 'lhs_25cd35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_bae4cf', 'lhs_4af988', 1.0, 'lhs_27e00b', 'lhs_e65825', 'lhs_5dba13');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483647, 1, 'lhs_733f5a', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_cc71a4', 'lhs_901602', 1.0, 'lhs_8e8ee1', 'lhs_d9b85d', 'lhs_c49a33');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (2, 1, 'lhs_25cd35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_bae4cf', 'lhs_4af988', 1.0, 'lhs_27e00b', 'lhs_e65825', 'lhs_5dba13');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (3, 1, 'cus_fee3aa', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'cus_3e707b', 'cus_c0de68', 285.529132, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483644, 1, 'cus_fee3aa', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'Carole', 'Bernhard', 292.730571, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (4, 1, 'cus_fee3aa', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'cus_3e707b', 'cus_c0de68', 874.871895, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483642, 1, 'cus_fee3aa', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'Carole', 'Bernhard', 520.784135, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (5, 1, 'cus_fee3aa', '2020-07-23 07:32:15+00:00', '2024-02-11 16:43:27+00:00', 'cus_3e707b', 'cus_c0de68', 779.409124, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483640, 1, 'cus_fee3aa', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'Carole', 'Bernhard', 710.998147, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (6, 1, 'cus_fee3aa', '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 'cus_3e707b', 'cus_c0de68', 797.015047, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483638, 1, 'cus_fee3aa', '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00', 'Carole', 'Bernhard', 294.861575, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (7, 1, 'cus_fee3aa', '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00', 'cus_3e707b', 'cus_c0de68', 994.117864, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483636, 1, 'cus_fee3aa', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00', 'Carole', 'Bernhard', 855.355181, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (8, 1, 'cus_fee3aa', '2022-07-30 13:34:14+00:00', '2022-08-02 13:58:36+00:00', 'cus_3e707b', 'cus_c0de68', 125.12763, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

-- Inserting into table: customer_payments --
INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (1, '2024-06-15 00:00:00+00:00', 'rhs_475efa', 1.0);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (3, '2024-06-15 00:00:00+00:00', 'rhs_475efa', 1.0);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (4, '2024-01-16 07:29:50+00:00', 'cus_d68ea6', 249.706432);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (5, '2025-06-13 15:31:02+00:00', 'cus_d68ea6', 804.971537);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (6, '2022-01-21 14:23:36+00:00', 'cus_d68ea6', 718.397869);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (7, '2022-01-03 02:42:55+00:00', 'cus_d68ea6', 503.083789);

INSERT INTO "customer_payments" ("customer_id", "datetime_payment", "payment_method_code", "amount_payment") VALUES (8, '2020-03-11 00:23:16+00:00', 'cus_d68ea6', 998.421621);
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