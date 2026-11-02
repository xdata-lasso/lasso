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
-- Tests ORDER BY first_name, customer_id tie-breaking, duplicate projection (SELECT vs SELECT DISTINCT), and NULL handling in sorting/projection.
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '200 Oak St', 'Gotham', '20002', 'NJ', 'USA');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (10, 1, 'Active', '2021-01-01', '1985-05-05', 'Zack', 'Taylor', 1500.0, 'zack@example.com', '555-0010', '555-9010');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (30, 1, 'Active', '2021-01-01', '1985-05-05', 'Aaron', 'Adams', 2500.0, 'aaron30@example.com', '555-0030', '555-9030');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (20, 1, 'Active', '2021-01-01', '1985-05-05', 'Aaron', 'Zimmer', 1800.0, 'aaron20@example.com', '555-0020', '555-9020');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (40, 1, 'Active', '2021-01-01', '1985-05-05', 'Aaron', 'Zimmer', 1800.0, 'aaron40@example.com', '555-0040', '555-9040');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (50, 1, 'Active', '2021-01-01', '1985-05-05', NULL, 'NoFirstOne', 1200.0, 'nofirst1@example.com', '555-0050', '555-9050');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES (5, 1, 'Active', '2021-01-01', '1985-05-05', NULL, 'NoFirstTwo', 2200.0, 'nofirst2@example.com', '555-0005', '555-9005');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM customers WHERE (amount_outstanding >= 1000.0 AND amount_outstanding <= 3000.0) ORDER BY first_name, customers.customer_id NULLS LAST;

/*
Gold Result:
(None, 'NoFirstTwo')
(None, 'NoFirstOne')
('Aaron', 'Zimmer')
('Aaron', 'Adams')
('Aaron', 'Zimmer')
('Zack', 'Taylor')
*/

-- Prediction Query
SELECT first_name, last_name FROM Customers WHERE amount_outstanding BETWEEN 1000 AND 3000;

/*
Prediction Result:
(None, 'NoFirstTwo')
('Zack', 'Taylor')
('Aaron', 'Zimmer')
('Aaron', 'Adams')
('Aaron', 'Zimmer')
(None, 'NoFirstOne')
*/