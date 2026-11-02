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
-- Tests DISTINCT vs ALL (duplicate date_became_customer values), ORDER BY direction (ASC vs DESC), and NULL handling in date_became_customer.
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '200 Oak Ave', 'Gotham', '20002', 'NJ', 'USA');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (10, 1, 'Active', '2023-06-01 00:00:00', '1980-01-01 00:00:00', 'Carole', 'Bernhard', 10.0, 'c1@example.com', '111', '222');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (20, 1, 'Active', '2021-01-15 00:00:00', '1982-02-02 00:00:00', 'Carole', 'Bernhard', 20.0, 'c2@example.com', '333', '444');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (30, 1, 'Active', '2021-01-15 00:00:00', '1984-03-03 00:00:00', 'Carole', 'Bernhard', 30.0, 'c3@example.com', '555', '666');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (40, 1, 'Active', NULL, '1986-04-04 00:00:00', 'Carole', 'Bernhard', 40.0, 'c4@example.com', '777', '888');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_became_customer" FROM "customers" WHERE ("first_name" = 'Carole' AND "last_name" = 'Bernhard') ORDER BY date_became_customer, customers.customer_id NULLS LAST;

/*
Gold Result:
(None,)
('2021-01-15 00:00:00',)
('2021-01-15 00:00:00',)
('2023-06-01 00:00:00',)
*/

-- Prediction Query
SELECT date_became_customer FROM Customers WHERE first_name = 'Carole' AND last_name = 'Bernhard';

/*
Prediction Result:
('2023-06-01 00:00:00',)
('2021-01-15 00:00:00',)
('2021-01-15 00:00:00',)
(None,)
*/