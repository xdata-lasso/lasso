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
-- Focus: ORDER BY first_name and tie-breaking with customer_id.
-- Tests if secondary sort (customer_id ASC) is properly applied when first_name is identical, and diverges from last_name or amount_outstanding sorting.
INSERT INTO "Customers" ("customer_id", "first_name", "last_name", "amount_outstanding") VALUES (30, 'Zoe', 'Adams', 2500.0);
INSERT INTO "Customers" ("customer_id", "first_name", "last_name", "amount_outstanding") VALUES (10, 'Zoe', 'Zimmerman', 1500.0);
INSERT INTO "Customers" ("customer_id", "first_name", "last_name", "amount_outstanding") VALUES (20, 'Zoe', 'Baker', 2000.0);
INSERT INTO "Customers" ("customer_id", "first_name", "last_name", "amount_outstanding") VALUES (5, 'Aaron', 'Smith', 1200.0);
INSERT INTO "Customers" ("customer_id", "first_name", "last_name", "amount_outstanding") VALUES (15, 'Aaron', 'Adams', 2800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM customers WHERE (amount_outstanding >= 1000.0 AND amount_outstanding <= 3000.0) ORDER BY first_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Aaron', 'Smith')
('Aaron', 'Adams')
('Zoe', 'Zimmerman')
('Zoe', 'Baker')
('Zoe', 'Adams')
*/

-- Prediction Query
SELECT first_name, last_name FROM Customers WHERE amount_outstanding BETWEEN 1000 AND 3000;

/*
Prediction Result:
('Aaron', 'Smith')
('Zoe', 'Zimmerman')
('Aaron', 'Adams')
('Zoe', 'Baker')
('Zoe', 'Adams')
*/