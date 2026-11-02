-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_address_id" INTEGER, "nickname" TEXT(80), "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "date_of_birth" DATETIME, "date_joined_staff" DATETIME, "date_left_staff" DATETIME, FOREIGN KEY ("staff_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Vehicles" ("vehicle_id" INTEGER PRIMARY KEY, "vehicle_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_address_id" INTEGER, "customer_status_code" TEXT(15), "date_became_customer" DATETIME, "date_of_birth" DATETIME, "first_name" TEXT(80), "last_name" TEXT(80), "amount_outstanding" REAL, "email_address" TEXT(250), "phone_number" TEXT(255), "cell_mobile_phone_number" TEXT(255), FOREIGN KEY ("customer_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Payments" ("customer_id" INTEGER, "datetime_payment" DATETIME, "payment_method_code" TEXT(10), "amount_payment" REAL, PRIMARY KEY ("customer_id", "datetime_payment"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Lessons" ("lesson_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "staff_id" INTEGER, "vehicle_id" INTEGER, "lesson_status_code" TEXT(15), "lesson_date" DATETIME, "lesson_time" TEXT(10), "price" REAL, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("vehicle_id") REFERENCES "Vehicles" ("vehicle_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic OR vs AND logic, column selection (cell_mobile_phone_number vs phone_number), and filtering out non-matching rows.
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (1, '101 Main St', 'Seattle', '98101', 'WA', 'USA');
INSERT INTO "Customers" ("customer_id", "customer_address_id", "customer_status_code", "date_became_customer", "date_of_birth", "first_name", "last_name", "amount_outstanding", "email_address", "phone_number", "cell_mobile_phone_number") VALUES
(1, 1, 'Active', '2021-01-01', '1990-05-15', 'Marina', 'Smith', 10.50, 'marina.smith@example.com', '111-111-1111', '999-111-1111'),
(2, 1, 'Pending', '2021-02-01', '1985-08-20', 'John', 'Kohler', 0.00, 'john.kohler@example.com', '222-222-2222', '999-222-2222'),
(3, 1, 'Closed', '2021-03-01', '1992-11-30', 'Marina', 'Kohler', 50.00, 'marina.kohler@example.com', '333-333-3333', '999-333-3333'),
(4, 1, 'Active', '2021-04-01', '1980-01-10', 'Alice', 'Brown', 0.00, 'alice.brown@example.com', '444-444-4444', '999-444-4444');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_status_code", "cell_mobile_phone_number", "email_address" FROM "customers" WHERE ("first_name" = 'Marina' OR "last_name" = 'Kohler') ORDER BY customer_status_code, customers.customer_id NULLS LAST;

/*
Gold Result:
('Active', '999-111-1111', 'marina.smith@example.com')
('Closed', '999-333-3333', 'marina.kohler@example.com')
('Pending', '999-222-2222', 'john.kohler@example.com')
*/

-- Prediction Query
SELECT customer_status_code, cell_mobile_phone_number, email_address FROM Customers WHERE first_name = 'Marina' OR last_name = 'Kohler';

/*
Prediction Result:
('Active', '999-111-1111', 'marina.smith@example.com')
('Pending', '999-222-2222', 'john.kohler@example.com')
('Closed', '999-333-3333', 'marina.kohler@example.com')
*/