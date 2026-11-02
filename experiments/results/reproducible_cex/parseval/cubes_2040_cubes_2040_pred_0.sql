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
INSERT INTO "customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (-2147483648, 1, 'cus_fee3aa', '2022-02-14 19:27:39+00:00', '2020-11-05 04:59:51+00:00', 'cus_3e707b', 'cus_c0de68', 688.4027, 'cus_275a9f', 'cus_d5f626', 'cus_4c44f9');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, 1, 'lhs_af899a', 'lhs_27bfa1', 'lhs_c42fb1', 'lhs_b381c6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483647, 1, 'lhs_60ddaa', 'lhs_786e36', 'lhs_64e91f', 'lhs_b64a29', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483646, 1, 'sta_3cf2c4', 'q_0_285d4a', 'sta_7269b1', 'sta_26e2dc', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', '2022-12-08 21:38:59+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483645, 1, 'sta_3cf2c4', 'q_0_285d4a', 'sta_7269b1', 'sta_26e2dc', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (2, 1, 'sta_3cf2c4', 'sta_e6aab2', 'sta_7269b1', 'sta_26e2dc', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', '2024-09-28 03:06:45+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (3, 1, 'sta_3cf2c4', 'sta_e6aab2', 'sta_7269b1', 'sta_26e2dc', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', '2020-04-30 23:22:06+00:00');

-- Inserting into table: vehicles --
INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (-2147483648, 'veh_82e151');

-- Inserting into table: lessons --
INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (4, -2147483648, 2, -2147483648, 'les_1c5d2b', '2024-06-06 00:28:47+00:00', 'les_d90553', 328.996339);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (5, -2147483648, 3, -2147483648, 'les_1c5d2b', '2025-06-13 15:31:02+00:00', 'les_d90553', 804.971537);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM (SELECT * FROM staff AS LHS WHERE NOT EXISTS(SELECT 1 FROM lessons AS RHS WHERE (LHS.staff_id = RHS.staff_id))) ORDER BY first_name;

/*
Gold Result:
('lhs_27bfa1',)
('lhs_786e36',)
('q_0_285d4a',)
('q_0_285d4a',)
*/

-- Prediction Query
SELECT first_name FROM Staff EXCEPT SELECT T2.first_name FROM Lessons AS T1 JOIN Staff AS T2 ON T1.staff_id = T2.staff_id;

/*
Prediction Result:
('lhs_27bfa1',)
('lhs_786e36',)
('q_0_285d4a',)
*/