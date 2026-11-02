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
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, -2147483648, 'cus_fee3aa', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'cus_3e707b', 'cus_c0de68', 680.190136, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483648, -2147483648, 'sta_3cf2c4', 'sta_e6aab2', 'sta_7269b1', 'sta_26e2dc', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

-- Inserting into table: vehicles --
INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (-2147483648, 'veh_82e151');

-- Inserting into table: lessons --
INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483648, 1, -2147483648, -2147483648, 'les_fe903b', '2022-12-08 21:38:59+00:00', 'les_d90553', 357.862717);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483647, 1, -2147483648, -2147483648, 'les_fe903b', '2020-10-31 07:51:16+00:00', 'les_d90553', 292.730571);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483646, 1, -2147483648, -2147483648, 'les_fe903b', '2024-01-16 07:29:50+00:00', 'les_d90553', 249.706432);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483645, 1, -2147483648, -2147483648, 'les_fe903b', '2024-06-06 00:28:47+00:00', 'les_d90553', 328.996339);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483644, 1, -2147483648, -2147483648, 'les_fe903b', '2025-06-13 15:31:02+00:00', 'les_d90553', 804.971537);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483643, 1, -2147483648, -2147483648, 'les_fe903b', '2021-02-21 20:09:01+00:00', 'les_d90553', 710.998147);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483642, 1, -2147483648, -2147483648, 'les_fe903b', '2022-01-21 14:23:36+00:00', 'les_d90553', 718.397869);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483641, 1, -2147483648, -2147483648, 'les_fe903b', '2022-07-05 02:28:20+00:00', 'les_d90553', 663.049759);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483640, 1, -2147483648, -2147483648, 'les_fe903b', '2022-01-03 02:42:55+00:00', 'les_d90553', 503.083789);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483639, 1, -2147483648, -2147483648, NULL, '2022-11-06 10:19:41+00:00', 'les_d90553', 855.355181);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483638, 1, -2147483648, -2147483648, NULL, '2022-08-02 13:58:36+00:00', 'les_d90553', 125.12763);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483637, 1, -2147483648, -2147483648, NULL, '2022-01-18 15:57:55+00:00', 'les_d90553', 787.938887);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483636, 1, -2147483648, -2147483648, 'les_fe903b', '2021-12-31 07:20:26+00:00', 'les_d90553', 227.766936);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483635, 1, -2147483648, -2147483648, 'les_fe903b', '2021-01-29 03:06:29+00:00', 'les_d90553', 75.403642);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483634, 1, -2147483648, -2147483648, 'les_fe903b', '2022-12-10 02:38:39+00:00', 'les_d90553', 992.733505);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483633, 1, -2147483648, -2147483648, 'les_fe903b', '2020-09-15 12:11:12+00:00', 'les_d90553', 741.842896);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483632, 1, -2147483648, -2147483648, 'les_fe903b', '2024-10-26 11:04:11+00:00', 'les_d90553', 890.762259);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483631, 1, -2147483648, -2147483648, 'les_fe903b', '2024-03-03 15:52:53+00:00', 'les_d90553', 983.124993);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483630, 1, -2147483648, -2147483648, 'les_fe903b', '2024-12-29 01:35:14+00:00', 'les_d90553', 74.576035);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483629, 1, -2147483648, -2147483648, 'les_fe903b', '2025-03-10 20:24:26+00:00', 'les_d90553', 767.720387);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483628, 1, -2147483648, -2147483648, 'les_fe903b', '2023-12-22 03:17:01+00:00', 'les_d90553', 517.275698);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483627, 1, -2147483648, -2147483648, 'les_fe903b', '2022-09-29 20:25:58+00:00', 'les_d90553', 191.847248);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483626, 1, -2147483648, -2147483648, 'les_fe903b', '2025-09-21 09:36:38+00:00', 'les_d90553', 396.776796);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483625, 1, -2147483648, -2147483648, 'les_fe903b', '2024-01-27 22:01:59+00:00', 'les_d90553', 760.580899);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483624, 1, -2147483648, -2147483648, 'les_fe903b', '2025-01-30 02:54:07+00:00', 'les_d90553', 274.680042);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483623, 1, -2147483648, -2147483648, 'les_fe903b', '2023-04-26 07:28:40+00:00', 'les_d90553', 242.260296);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483622, 1, -2147483648, -2147483648, 'les_fe903b', '2020-02-25 10:33:58+00:00', 'les_d90553', 22.720462);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT * FROM (SELECT "customer_id", "lesson_status_code", COUNT(*) AS "n" FROM "lessons" GROUP BY "customer_id", "lesson_status_code") AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customers" WHERE ("first_name" <> 'Ray')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Lessons AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T2.first_name = 'Ray';

/*
Prediction Result:
(0,)
*/