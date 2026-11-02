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
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT), ordering direction (ASC vs DESC), and NULL handling in date_became_customer.
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (10, NULL, 'Active', '2022-01-10', '1985-02-02', 'Carole', 'Bernhard', 10.0, 'c1@example.com', '111', '222');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (5, NULL, 'Inactive', '2020-08-15', '1995-03-03', 'Carole', 'Bernhard', 20.0, 'c2@example.com', '333', '444');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (8, NULL, 'Active', '2020-08-15', '1992-04-04', 'Carole', 'Bernhard', 30.0, 'c3@example.com', '555', '666');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (12, NULL, 'Pending', NULL, '1999-05-05', 'Carole', 'Bernhard', 0.0, 'c4@example.com', '777', '888');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_became_customer" FROM "customers" WHERE ("first_name" = 'Carole' AND "last_name" = 'Bernhard') ORDER BY date_became_customer, customers.customer_id NULLS LAST;

/*
Gold Result:
(None,)
('2020-08-15',)
('2020-08-15',)
('2022-01-10',)
*/

-- Prediction Query
SELECT date_became_customer FROM Customers WHERE first_name = 'Carole' AND last_name = 'Bernhard';

/*
Prediction Result:
('2020-08-15',)
('2020-08-15',)
('2022-01-10',)
(None,)
*/