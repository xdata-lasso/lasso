-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(20), "product_price" REAL(19, 4), "product_description" TEXT(255));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(10), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "date_became_customer" DATETIME);

CREATE TABLE "Regular_Orders" ("regular_order_id" INTEGER PRIMARY KEY, "distributer_id" INTEGER, FOREIGN KEY ("distributer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Regular_Order_Products" ("regular_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Actual_Orders" ("actual_order_id" INTEGER PRIMARY KEY, "regular_order_id" INTEGER, "order_status_code" TEXT(10), "actual_order_date" DATETIME, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"));

CREATE TABLE "Actual_Order_Products" ("actual_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Customer_Addresses" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "address_type" TEXT(10), "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Delivery_Routes" ("route_id" INTEGER PRIMARY KEY, "route_name" TEXT(50), "other_route_details" TEXT(255));

CREATE TABLE "Delivery_Route_Locations" ("location_code" TEXT(10) PRIMARY KEY, "route_id" INTEGER, "location_address_id" INTEGER, "location_name" TEXT(50), FOREIGN KEY ("route_id") REFERENCES "Delivery_Routes" ("route_id"), FOREIGN KEY ("location_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Trucks" ("truck_id" INTEGER PRIMARY KEY, "truck_licence_number" TEXT(20), "truck_details" TEXT(255));

CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "employee_address_id" INTEGER, "employee_name" TEXT(80), "employee_phone" TEXT(80), FOREIGN KEY ("employee_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Order_Deliveries" ("driver_employee_id" INTEGER, "location_code" TEXT(10), "actual_order_id" INTEGER, "truck_id" INTEGER, "delivery_status_code" TEXT(10), "delivery_date" DATETIME, FOREIGN KEY ("driver_employee_id") REFERENCES "Employees" ("employee_id"), FOREIGN KEY ("location_code") REFERENCES "Delivery_Route_Locations" ("location_code"), FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("truck_id") REFERENCES "Trucks" ("truck_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by customer_name (ASC vs DESC) and secondary ordering by customer_id (ASC vs DESC) when customer_name has duplicates, ensuring columns (phone, email) are distinct for tie-breaking visibility.
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (10, 'Credit', 'Bob', '555-0102', 'bob2@example.com', '2022-01-15 10:00:00');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (20, 'Cash', 'Alice', '555-0100', 'alice1@example.com', '2023-05-20 14:30:00');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (5, 'Debit', 'Alice', '555-0101', 'alice2@example.com', '2021-11-01 08:15:00');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1, 'Check', 'Charlie', '555-0103', 'charlie@example.com', '2020-03-10 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone, customer_email FROM customers ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alice', '555-0101', 'alice2@example.com')
('Alice', '555-0100', 'alice1@example.com')
('Bob', '555-0102', 'bob2@example.com')
('Charlie', '555-0103', 'charlie@example.com')
*/

-- Prediction Query
SELECT customer_name, customer_phone, customer_email FROM Customers ORDER BY date_became_customer, Customers.customer_id NULLS LAST;

/*
Prediction Result:
('Charlie', '555-0103', 'charlie@example.com')
('Alice', '555-0101', 'alice2@example.com')
('Bob', '555-0102', 'bob2@example.com')
('Alice', '555-0100', 'alice1@example.com')
*/