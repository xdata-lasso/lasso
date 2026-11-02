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
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (1, 1, 'lhs_94a148', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_b0d8c6', 'lhs_2b3ae7', 1.0, 'lhs_e34160', 'lhs_bd10b6', 'lhs_7f1316');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483647, 1, 'lhs_5bf9e3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_049a64', 'lhs_115bc0', 1.0, 'lhs_568151', 'lhs_f6d98e', 'lhs_ef949b');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483646, 1, 'lhs_5bf9e3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_049a64', 'lhs_2b3ae7', 1.0, 'lhs_568151', 'lhs_f6d98e', 'lhs_ef949b');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483645, 1, 'lhs_5bf9e3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_049a64', 'lhs_2b3ae7', 1.0, 'lhs_568151', 'lhs_f6d98e', 'lhs_ef949b');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483644, 1, 'lhs_5bf9e3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_049a64', 'lhs_2b3ae7', 1.0, 'lhs_568151', 'lhs_f6d98e', 'lhs_ef949b');

INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483643, 1, 'lhs_5bf9e3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_049a64', 'lhs_2b3ae7', 1.0, 'lhs_568151', 'lhs_f6d98e', 'lhs_ef949b');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483648, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, 1, 'rhs_06f1d8', 'rhs_b22f0b', 'rhs_1118c1', 'lhs_2b3ae7', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483646, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483645, 1, 'sta_3cf2c4', 'sta_90eb2b', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483644, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483643, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483642, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483641, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483640, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483639, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483638, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483637, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483636, 1, NULL, 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483635, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2025-08-22 00:34:24+00:00', NULL);

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483634, 1, 'sta_3cf2c4', NULL, 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-12-20 09:53:17+00:00', '2020-04-05 14:43:51+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483633, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483632, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', NULL, '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483631, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', NULL, '2021-07-11 07:27:32+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483630, 1, 'sta_3cf2c4', 'sta_51c18c', NULL, 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-08-02 13:58:36+00:00', '2021-01-23 18:11:33+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483629, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2020-03-11 00:23:16+00:00', '2025-02-07 06:53:31+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483628, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-01-18 15:57:55+00:00', '2022-04-12 01:47:28+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483627, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483626, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-12-31 07:20:26+00:00', '2021-12-08 15:32:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483625, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-02-17 05:47:13+00:00', '2021-01-29 03:06:29+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483624, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2024-02-29 12:08:41+00:00', '2022-10-15 07:04:26+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483623, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2022-12-10 02:38:39+00:00', '2024-05-04 23:07:19+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483622, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2021-06-25 00:51:07+00:00', '2020-09-15 12:11:12+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483621, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483620, 1, 'sta_3cf2c4', 'sta_51c18c', 'sta_7269b1', 'sta_26e2dc', '2024-06-15 00:00:00+00:00', '2024-10-26 11:04:11+00:00', '2025-07-08 08:09:50+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT last_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_address_id AS customer_address_id, LHS.customer_status_code AS customer_status_code, LHS.date_became_customer AS date_became_customer, LHS.date_of_birth AS date_of_birth, LHS.first_name AS first_name, LHS.last_name AS last_name, LHS.amount_outstanding AS amount_outstanding, LHS.email_address AS email_address, LHS.phone_number AS phone_number, LHS.cell_mobile_phone_number AS cell_mobile_phone_number, RHS.staff_id AS staff_id, RHS.staff_address_id AS staff_address_id, RHS.nickname AS nickname, RHS.first_name AS first_name_other, RHS.middle_name AS middle_name, RHS.date_of_birth AS date_of_birth_other, RHS.date_joined_staff AS date_joined_staff, RHS.date_left_staff AS date_left_staff FROM customers AS LHS INNER JOIN staff AS RHS ON (LHS.last_name = RHS.last_name)) ORDER BY last_name;

/*
Gold Result:
('lhs_2b3ae7',)
('lhs_2b3ae7',)
('lhs_2b3ae7',)
('lhs_2b3ae7',)
('lhs_2b3ae7',)
*/

-- Prediction Query
SELECT last_name FROM Customers INTERSECT SELECT last_name FROM Staff;

/*
Prediction Result:
('lhs_2b3ae7',)
*/