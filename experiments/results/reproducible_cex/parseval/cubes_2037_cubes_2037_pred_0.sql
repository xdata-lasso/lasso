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
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483648, -2147483648, 'cus_da3269', '2024-12-15 00:56:33+00:00', '2025-11-23 07:28:46+00:00', 'cus_3e707b', 'cus_c0de68', 680.190136, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483647, -2147483648, 'cus_da3269', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'cus_3e707b', 'cus_c0de68', 285.529132, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483646, -2147483648, 'cus_da3269', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'cus_3e707b', 'cus_c0de68', 97.952323, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483645, -2147483648, 'cus_820c29', '2024-11-14 12:35:58+00:00', '2024-09-28 03:06:45+00:00', 'cus_3e707b', 'cus_c0de68', 206.939346, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483644, -2147483648, 'cus_820c29', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'cus_3e707b', 'cus_c0de68', 935.695299, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483643, -2147483648, 'cus_820c29', '2024-06-06 00:28:47+00:00', '2022-10-19 03:44:42+00:00', 'cus_3e707b', 'cus_c0de68', 86.520366, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483642, -2147483648, 'cus_da3269', '2024-02-11 16:43:27+00:00', '2025-06-13 15:31:02+00:00', 'cus_3e707b', 'cus_c0de68', 804.971537, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483641, -2147483648, 'cus_da3269', '2022-04-15 05:01:35+00:00', '2021-02-21 20:09:01+00:00', 'cus_3e707b', 'cus_c0de68', 710.998147, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483640, -2147483648, 'cus_da3269', '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 'cus_3e707b', 'cus_c0de68', 797.015047, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483639, -2147483648, 'cus_820c29', '2022-10-06 13:20:05+00:00', '2023-05-25 17:04:36+00:00', 'cus_3e707b', 'cus_c0de68', 841.297061, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483638, -2147483648, 'cus_820c29', '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00', 'cus_3e707b', 'cus_c0de68', 711.020062, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483637, -2147483648, 'cus_820c29', '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 'cus_3e707b', 'cus_c0de68', 503.083789, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483636, -2147483648, 'cus_da3269', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00', 'cus_3e707b', 'cus_c0de68', 855.355181, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483635, -2147483648, 'cus_da3269', '2022-07-30 13:34:14+00:00', '2022-08-02 13:58:36+00:00', 'cus_3e707b', 'cus_c0de68', 125.12763, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483634, -2147483648, 'cus_da3269', '2025-02-07 06:53:31+00:00', '2021-10-06 00:40:57+00:00', 'cus_3e707b', 'cus_c0de68', 240.969194, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483633, -2147483648, 'cus_820c29', '2021-08-20 16:50:24+00:00', '2025-09-01 05:13:03+00:00', 'cus_3e707b', 'cus_c0de68', 607.794538, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483632, -2147483648, 'cus_820c29', '2021-12-08 15:32:00+00:00', '2025-04-09 18:22:58+00:00', 'cus_3e707b', 'cus_c0de68', 971.82669, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483631, -2147483648, 'cus_820c29', '2021-01-29 03:06:29+00:00', '2020-08-22 06:30:10+00:00', 'cus_3e707b', 'cus_c0de68', 489.397796, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483630, -2147483648, NULL, '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00', 'cus_3e707b', 'cus_c0de68', 162.04354, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483629, -2147483648, NULL, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 'cus_3e707b', 'cus_c0de68', 587.783596, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483628, -2147483648, NULL, '2025-05-02 19:47:39+00:00', '2023-07-26 05:50:21+00:00', 'cus_3e707b', 'cus_c0de68', 801.414196, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483627, -2147483648, NULL, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', 'cus_3e707b', 'cus_c0de68', 983.124993, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483626, -2147483648, NULL, '2025-08-21 21:00:40+00:00', '2024-01-02 11:27:20+00:00', 'cus_3e707b', 'cus_c0de68', 587.103196, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483625, -2147483648, NULL, '2021-02-04 01:21:18+00:00', '2025-03-10 20:24:26+00:00', 'cus_3e707b', 'cus_c0de68', 767.720387, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483624, -2147483648, 'cus_da3269', '2025-04-19 21:11:20+00:00', '2020-08-15 08:54:31+00:00', 'cus_3e707b', 'cus_c0de68', 467.07027, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483623, -2147483648, 'cus_da3269', '2021-02-10 21:10:52+00:00', '2022-09-29 20:25:58+00:00', 'cus_3e707b', 'cus_c0de68', 191.847248, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483622, -2147483648, 'cus_da3269', '2023-11-07 12:14:47+00:00', '2025-09-21 09:36:38+00:00', 'cus_3e707b', 'cus_c0de68', 396.776796, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483621, -2147483648, 'cus_820c29', '2021-11-30 23:39:10+00:00', '2024-01-27 22:01:59+00:00', 'cus_3e707b', 'cus_c0de68', 760.580899, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483620, -2147483648, 'cus_820c29', '2025-10-19 18:29:54+00:00', '2022-02-18 18:38:40+00:00', 'cus_3e707b', 'cus_c0de68', 597.420508, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483619, -2147483648, 'cus_820c29', '2025-10-15 06:50:58+00:00', '2020-09-11 22:32:24+00:00', 'cus_3e707b', 'cus_c0de68', 586.906897, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483618, -2147483648, 'cus_da3269', '2022-01-22 16:14:13+00:00', '2024-02-28 04:46:49+00:00', 'cus_3e707b', 'cus_c0de68', 938.694822, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483617, -2147483648, 'cus_da3269', '2020-02-25 10:33:58+00:00', '2020-03-11 14:09:37+00:00', 'cus_3e707b', 'cus_c0de68', 797.364011, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483616, -2147483648, 'cus_da3269', '2023-07-13 23:57:06+00:00', '2025-09-22 03:26:15+00:00', 'cus_3e707b', 'cus_c0de68', 442.009805, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483615, -2147483648, 'cus_820c29', '2022-10-06 23:43:31+00:00', '2022-07-13 23:48:43+00:00', 'cus_3e707b', 'cus_c0de68', 186.190286, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483614, -2147483648, 'cus_820c29', '2020-01-22 05:30:29+00:00', '2023-08-20 20:02:04+00:00', 'cus_3e707b', 'cus_c0de68', 982.938576, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483613, -2147483648, 'cus_820c29', '2023-03-22 03:47:49+00:00', '2024-10-18 05:00:47+00:00', 'cus_3e707b', 'cus_c0de68', 377.535852, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483612, -2147483648, 'cus_da3269', '2025-06-28 05:56:56+00:00', '2021-12-20 12:18:45+00:00', 'cus_3e707b', 'cus_c0de68', 882.985782, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483611, -2147483648, 'cus_da3269', '2024-09-13 14:36:04+00:00', '2020-12-13 17:48:30+00:00', 'cus_3e707b', 'cus_c0de68', 187.343342, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483610, -2147483648, 'cus_da3269', '2021-05-27 14:39:41+00:00', '2021-07-01 18:29:24+00:00', 'cus_3e707b', 'cus_c0de68', 74.250383, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483609, -2147483648, 'cus_820c29', '2023-08-25 07:55:29+00:00', '2024-02-08 07:13:40+00:00', 'cus_3e707b', 'cus_c0de68', 144.777217, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483608, -2147483648, 'cus_820c29', '2023-01-02 05:47:29+00:00', '2025-03-16 12:14:02+00:00', 'cus_3e707b', 'cus_c0de68', 15.406045, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483607, -2147483648, 'cus_820c29', '2025-11-10 22:24:59+00:00', '2020-06-29 05:47:52+00:00', 'cus_3e707b', 'cus_c0de68', 845.831524, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483606, -2147483648, 'cus_da3269', '2022-05-13 17:57:39+00:00', '2022-03-25 08:00:08+00:00', 'cus_3e707b', 'cus_c0de68', 433.533777, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483605, -2147483648, 'cus_da3269', '2022-01-29 19:28:25+00:00', '2023-03-13 16:07:34+00:00', 'cus_3e707b', 'cus_c0de68', 326.912005, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483604, -2147483648, 'cus_da3269', '2024-09-04 21:17:21+00:00', '2024-09-26 13:13:01+00:00', 'cus_3e707b', 'cus_c0de68', 272.376524, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483603, -2147483648, 'cus_820c29', '2022-06-17 21:46:26+00:00', '2021-07-14 21:04:24+00:00', 'cus_3e707b', 'cus_c0de68', 419.361606, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483602, -2147483648, 'cus_820c29', '2023-04-11 01:23:11+00:00', '2025-02-03 05:21:58+00:00', 'cus_3e707b', 'cus_c0de68', 893.990071, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483601, -2147483648, 'cus_820c29', '2022-03-22 13:45:21+00:00', '2021-03-04 06:15:13+00:00', 'cus_3e707b', 'cus_c0de68', 447.109657, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483600, -2147483648, 'cus_da3269', '2020-10-15 10:13:01+00:00', '2024-09-10 08:04:52+00:00', 'cus_3e707b', 'cus_c0de68', 335.624913, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483599, -2147483648, 'cus_da3269', '2024-02-28 14:45:41+00:00', '2024-08-09 01:13:45+00:00', 'cus_3e707b', 'cus_c0de68', 625.233756, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483598, -2147483648, 'cus_da3269', '2023-06-28 05:47:44+00:00', '2025-11-28 13:30:18+00:00', 'cus_3e707b', 'cus_c0de68', 88.474525, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483597, -2147483648, 'cus_820c29', '2020-08-21 23:51:43+00:00', '2020-10-30 07:33:08+00:00', 'cus_3e707b', 'cus_c0de68', 712.084197, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483596, -2147483648, 'cus_820c29', '2023-09-10 09:37:01+00:00', '2022-11-21 09:24:31+00:00', 'cus_3e707b', 'cus_c0de68', 390.34832, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483595, -2147483648, 'cus_820c29', '2023-02-15 11:45:56+00:00', '2024-12-23 02:48:29+00:00', 'cus_3e707b', 'cus_c0de68', 835.894437, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483594, -2147483648, 'cus_da3269', '2021-01-22 00:53:52+00:00', '2023-01-02 20:56:29+00:00', 'cus_3e707b', 'cus_c0de68', 22.63964, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483593, -2147483648, 'cus_da3269', '2021-07-30 02:29:08+00:00', '2022-01-26 11:13:48+00:00', 'cus_3e707b', 'cus_c0de68', 705.754562, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483592, -2147483648, 'cus_da3269', '2023-09-26 13:08:37+00:00', '2020-12-04 21:49:29+00:00', 'cus_3e707b', 'cus_c0de68', 795.815869, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483591, -2147483648, 'cus_820c29', '2020-07-01 12:41:54+00:00', '2022-03-02 18:03:57+00:00', 'cus_3e707b', 'cus_c0de68', 345.35543, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483590, -2147483648, 'cus_820c29', '2020-04-10 05:04:30+00:00', '2025-05-09 05:17:21+00:00', 'cus_3e707b', 'cus_c0de68', 366.889199, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483589, -2147483648, 'cus_820c29', '2025-05-27 16:57:17+00:00', '2020-12-18 09:02:22+00:00', 'cus_3e707b', 'cus_c0de68', 210.05299, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483588, -2147483648, 'cus_da3269', '2022-04-18 00:53:20+00:00', '2021-04-06 16:11:52+00:00', 'cus_3e707b', 'cus_c0de68', 304.188492, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483587, -2147483648, 'cus_da3269', '2020-06-29 02:04:50+00:00', '2023-05-14 17:39:51+00:00', 'cus_3e707b', 'cus_c0de68', 521.610309, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483586, -2147483648, 'cus_da3269', '2021-04-23 15:57:00+00:00', '2020-10-20 06:14:04+00:00', 'cus_3e707b', 'cus_c0de68', 261.415754, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483585, -2147483648, 'cus_820c29', '2023-11-01 15:52:25+00:00', '2020-10-05 05:32:26+00:00', 'cus_3e707b', 'cus_c0de68', 456.127515, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483584, -2147483648, 'cus_820c29', '2025-08-02 02:30:29+00:00', '2025-05-19 00:55:13+00:00', 'cus_3e707b', 'cus_c0de68', 619.547972, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483583, -2147483648, 'cus_820c29', '2023-06-17 22:27:46+00:00', '2024-11-28 11:20:05+00:00', 'cus_3e707b', 'cus_c0de68', 108.525871, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483582, -2147483648, 'cus_da3269', '2020-04-02 07:45:47+00:00', '2024-09-26 23:38:30+00:00', 'cus_3e707b', 'cus_c0de68', 540.154414, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483581, -2147483648, 'cus_da3269', '2021-05-16 14:38:12+00:00', '2023-12-12 02:47:46+00:00', 'cus_3e707b', 'cus_c0de68', 395.957566, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483580, -2147483648, 'cus_da3269', '2021-03-04 22:18:05+00:00', '2021-07-02 01:45:48+00:00', 'cus_3e707b', 'cus_c0de68', 728.712934, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483579, -2147483648, 'cus_820c29', '2021-06-12 16:42:05+00:00', '2025-03-26 10:17:14+00:00', 'cus_3e707b', 'cus_c0de68', 648.551674, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483578, -2147483648, 'cus_820c29', '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 'cus_3e707b', 'cus_c0de68', 508.771546, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483577, -2147483648, 'cus_820c29', '2023-07-25 15:03:55+00:00', '2020-10-15 18:29:15+00:00', 'cus_3e707b', 'cus_c0de68', 532.326819, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_status_code_other AS customer_status_code FROM (SELECT LHS.customer_status_code AS customer_status_code, LHS.n AS n, RHS.customer_status_code AS customer_status_code_other, RHS.n AS n_other FROM (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS LHS CROSS JOIN (SELECT customer_status_code, COUNT(*) AS n FROM customers GROUP BY customer_status_code) AS RHS) WHERE (n > n_other) ORDER BY customer_status_code;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT customer_status_code FROM Customers GROUP BY customer_status_code ORDER BY COUNT(*) ASC, customer_status_code NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/