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
INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, 'lhs_76359f', 'lhs_e60977', 'lhs_3e3adc', 'lhs_bbc37e', 'lhs_ccda1c');

INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (-2147483647, 'lhs_da140f', 'lhs_71deb0', 'lhs_c827a1', 'lhs_ba3f45', 'lhs_9cc0c2');

INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (2, 'lhs_76359f', 'lhs_e60977', 'lhs_3e3adc', 'lhs_bbc37e', 'lhs_ccda1c');

INSERT INTO "addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (3, 'add_a42cda', 'add_ae09f0', 'add_92aefd', 'add_7d1289', 'add_0b134e');

-- Inserting into table: staff --
INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (1, 1, 'rhs_e29c58', 'AA', 'rhs_8b7c41', 'Sawayn', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483647, 1, 'rhs_734a6e', 'Janessa', 'rhs_7e2fdf', 'AA__?GO', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483646, 1, 'rhs_734a6e', 'CA', 'rhs_7e2fdf', 'Sawayn', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483645, 1, 'rhs_734a6e', 'AA_', 'rhs_7e2fdf', 'Sawayn', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483644, 1, 'rhs_734a6e', 'Janessa', 'rhs_7e2fdf', 'AA_G_O?', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483643, 1, 'rhs_734a6e', 'Janessa', 'rhs_7e2fdf', 'AA''/???', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (-2147483642, 1, 'rhs_734a6e', 'AA', 'rhs_7e2fdf', 'Sawayn', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_postcode" FROM (SELECT "address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country", "staff_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff", "address_id" AS "staff_address_id" FROM (SELECT "LHS"."address_id" AS "address_id", "LHS"."line_1_number_building" AS "line_1_number_building", "LHS"."city" AS "city", "LHS"."zip_postcode" AS "zip_postcode", "LHS"."state_province_county" AS "state_province_county", "LHS"."country" AS "country", "RHS"."staff_id" AS "staff_id", "RHS"."nickname" AS "nickname", "RHS"."first_name" AS "first_name", "RHS"."middle_name" AS "middle_name", "RHS"."last_name" AS "last_name", "RHS"."date_of_birth" AS "date_of_birth", "RHS"."date_joined_staff" AS "date_joined_staff", "RHS"."date_left_staff" AS "date_left_staff" FROM "addresses" AS "LHS" INNER JOIN "staff" AS "RHS" ON ("LHS"."address_id" = "RHS"."staff_address_id"))) WHERE ("first_name" = 'Janessa' OR "last_name" = 'Sawayn') ORDER BY zip_postcode, "zip_postcode" NULLS LAST;

/*
Gold Result:
('lhs_3e3adc',)
('lhs_3e3adc',)
('lhs_3e3adc',)
('lhs_3e3adc',)
('lhs_3e3adc',)
('lhs_3e3adc',)
('lhs_3e3adc',)
*/

-- Prediction Query
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Staff AS T2 ON T1.address_id = T2.staff_address_id WHERE T2.first_name = 'Janessa' AND T2.last_name = 'Sawayn';

/*
Prediction Result:
*/