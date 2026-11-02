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
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, -2147483648, 'sta_3cf2c4', 'sta_e6aab2', 'sta_7269b1', 'sta_26e2dc', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00');

-- Inserting into table: vehicles --
INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (1, 'veh_2835fd');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (-2147483647, 'veh_9b8ba7');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (2, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (3, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (4, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (5, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (6, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (7, 'veh_82e151');

INSERT INTO "vehicles" ("vehicle_id", "vehicle_details") VALUES (8, 'veh_82e151');

-- Inserting into table: lessons --
INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (1, 1, 1, 1, 'lhs_250934', '2024-06-15 00:00:00+00:00', 'lhs_1c164c', 1.0);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (-2147483647, 1, 1, 1, 'lhs_e42f66', '2024-06-15 00:00:00+00:00', 'lhs_b23f8d', 1.0);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (2, 1, 1, -2147483647, 'les_1c5d2b', '2021-06-17 14:22:38+00:00', 'les_d90553', 572.766956);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (3, 1, 1, 3, 'les_1c5d2b', '2022-02-14 19:27:39+00:00', 'les_d90553', 935.695299);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (4, 1, 1, 1, 'les_1c5d2b', '2020-07-23 07:32:15+00:00', 'les_d90553', 483.665643);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (5, 1, 1, -2147483647, 'les_1c5d2b', '2020-01-15 18:18:33+00:00', 'les_d90553', 795.366812);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (6, 1, 1, 5, 'les_1c5d2b', '2022-10-06 13:20:05+00:00', 'les_d90553', 882.963176);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (7, 1, 1, 4, 'les_1c5d2b', '2022-12-20 09:53:17+00:00', 'les_d90553', 944.247544);

INSERT INTO "lessons" ("lesson_id", "customer_id", "staff_id", "vehicle_id", "lesson_status_code", "lesson_date", "lesson_time", "price") VALUES (8, 1, 1, 8, 'les_1c5d2b', '2021-07-31 11:04:01+00:00', 'les_d90553', 320.851235);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT vehicle_id, vehicle_details FROM (SELECT LHS.lesson_id AS lesson_id, LHS.customer_id AS customer_id, LHS.lesson_status_code AS lesson_status_code, LHS.staff_id AS staff_id, LHS.vehicle_id AS vehicle_id, LHS.lesson_date AS lesson_date, LHS.lesson_time AS lesson_time, LHS.price AS price, RHS.vehicle_details AS vehicle_details FROM lessons AS LHS INNER JOIN (SELECT vehicle_id, vehicle_details, COUNT(*) OVER () AS n FROM vehicles) AS RHS ON (LHS.vehicle_id = RHS.vehicle_id AND LHS.lesson_id = RHS.n)) ORDER BY vehicle_id, vehicle_details NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.vehicle_id, T1.vehicle_details FROM Vehicles AS T1 JOIN Lessons AS T2 ON T1.vehicle_id = T2.vehicle_id GROUP BY T1.vehicle_id ORDER BY COUNT(*) DESC, T1.vehicle_id NULLS LAST, T1.vehicle_details NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, 'veh_2835fd')
*/