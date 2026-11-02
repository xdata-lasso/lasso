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
-- Tests DISTINCT vs ALL, ORDER BY date_of_birth (ASC vs DESC), NULL handling in date_of_birth, and LIMIT 1 mutations.
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (10, NULL, 'J1', 'Janessa', 'A', 'Sawayn', '1995-10-20 00:00:00', '2018-01-01 00:00:00', '2020-01-01 00:00:00');
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (20, NULL, 'J2', 'Janessa', 'B', 'Sawayn', '1980-01-15 00:00:00', '2010-05-05 00:00:00', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (30, NULL, 'J3', 'Janessa', 'C', 'Sawayn', '1980-01-15 00:00:00', '2012-06-06 00:00:00', NULL);
INSERT INTO "Staff" ("staff_id", "staff_address_id", "nickname", "first_name", "middle_name", "last_name", "date_of_birth", "date_joined_staff", "date_left_staff") VALUES (40, NULL, 'J4', 'Janessa', 'D', 'Sawayn', NULL, '2021-07-07 00:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_birth" FROM "staff" WHERE ("first_name" = 'Janessa' AND "last_name" = 'Sawayn') ORDER BY date_of_birth, staff.staff_id NULLS LAST;

/*
Gold Result:
(None,)
('1980-01-15 00:00:00',)
('1980-01-15 00:00:00',)
('1995-10-20 00:00:00',)
*/

-- Prediction Query
SELECT date_of_birth FROM Staff WHERE first_name = 'Janessa' AND last_name = 'Sawayn';

/*
Prediction Result:
('1995-10-20 00:00:00',)
('1980-01-15 00:00:00',)
('1980-01-15 00:00:00',)
(None,)
*/