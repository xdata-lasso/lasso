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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '123 Main St', 'Springfield', '12345', 'IL', 'USA');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (1, 1, 'Active', '2020-01-01', '1990-01-01', 'Marina', 'Smith', 0.0, 'marina.smith@example.com', '111-1111', '999-1111');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (2, 1, 'Pending', '2020-02-01', '1991-02-01', 'John', 'Kohler', 50.0, 'john.kohler@example.com', '111-2222', '999-2222');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (3, 1, 'Closed', '2020-03-01', '1992-03-01', 'Marina', 'Kohler', 0.0, 'marina.kohler@example.com', '111-3333', '999-3333');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (4, 1, 'Active', '2020-04-01', '1993-04-01', 'Kohler', 'Marina', 10.0, 'swapped@example.com', '111-4444', '999-4444');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (5, 1, 'Active', '2020-05-01', '1994-05-01', 'marina', 'kohler', 15.0, 'lowercase@example.com', '111-5555', '999-5555');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (6, 1, 'Active', '2020-06-01', '1995-06-01', 'Marinaa', 'Kohlerr', 20.0, 'substring@example.com', '111-6666', '999-6666');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (7, 1, 'Active', '2020-07-01', '1996-07-01', 'Marina', NULL, 0.0, 'marina.null@example.com', '111-7777', '999-7777');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (8, 1, 'Active', '2020-08-01', '1997-08-01', NULL, 'Kohler', 0.0, 'null.kohler@example.com', '111-8888', '999-8888');
INSERT INTO Customers (customer_id, customer_address_id, customer_status_code, date_became_customer, date_of_birth, first_name, last_name, amount_outstanding, email_address, phone_number, cell_mobile_phone_number) VALUES (9, 1, 'Active', '2020-09-01', '1998-09-01', NULL, NULL, 0.0, 'null.null@example.com', '111-9999', '999-9999');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_status_code", "cell_mobile_phone_number", "email_address" FROM "customers" WHERE ("first_name" = 'Marina' OR "last_name" = 'Kohler') ORDER BY customer_status_code, customers.customer_id NULLS LAST;

/*
Gold Result:
('Active', '999-1111', 'marina.smith@example.com')
('Active', '999-7777', 'marina.null@example.com')
('Active', '999-8888', 'null.kohler@example.com')
('Closed', '999-3333', 'marina.kohler@example.com')
('Pending', '999-2222', 'john.kohler@example.com')
*/

-- Prediction Query
SELECT customer_status_code, cell_mobile_phone_number, email_address FROM Customers WHERE first_name = 'Marina' OR last_name = 'Kohler';

/*
Prediction Result:
('Active', '999-1111', 'marina.smith@example.com')
('Pending', '999-2222', 'john.kohler@example.com')
('Closed', '999-3333', 'marina.kohler@example.com')
('Active', '999-7777', 'marina.null@example.com')
('Active', '999-8888', 'null.kohler@example.com')
*/