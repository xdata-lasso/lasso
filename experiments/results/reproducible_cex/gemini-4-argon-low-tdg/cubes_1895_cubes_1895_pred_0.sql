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
-- Tests:
-- 1. Grouping by address_id vs grouping by state_province_county (State 'CA' has two addresses with counts 1 and 2, rather than a combined state count of 3).
-- 2. Outer SELECT DISTINCT vs SELECT ALL (Address 102 has 2 rows in Customer_Addresses, which produces duplicate (CA, 2) rows before DISTINCT).
-- 3. Addresses with 0 Customer_Addresses (Address 104 in 'FL' should be excluded by INNER JOIN, refuting LEFT JOIN mutants).
-- 4. COUNT(*) vs COUNT(DISTINCT customer_id) (Address 103 in 'NY' is linked to the same customer 2 times, so COUNT(*) is 2 while COUNT(DISTINCT customer_id) is 1).
-- 5. Ordering by state_province_county and count___ (CA has counts 1 and 2).
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (1, 'Card', 'Alice', '111-1111', 'alice@example.com', '2020-01-01');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (2, 'Cash', 'Bob', '222-2222', 'bob@example.com', '2020-01-02');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (101, '101 Main St', 'Los Angeles', '90001', 'CA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (102, '102Market St', 'San Francisco', '94101', 'CA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (103, '103 Broadway', 'New York', '10001', 'NY', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (104, '104 Ocean Dr', 'Miami', '33101', 'FL', 'USA');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (101, 1, '2021-01-01', 'Home', '2022-01-01');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (102, 1, '2021-02-01', 'Work', '2022-02-01');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (102, 2, '2021-03-01', 'Home', '2022-03-01');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (103, 1, '2019-01-01', 'Billing', '2020-01-01');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (103, 1, '2020-01-02', 'Billing', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state_province_county, n AS count___ FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.customer_id AS customer_id, LHS.date_from AS date_from, LHS.address_type AS address_type, LHS.date_to AS date_to, RHS.n AS n FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.address_type AS address_type, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, COUNT(*) AS n FROM customer_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY state_province_county, count___ NULLS LAST;

/*
Gold Result:
('CA', 1)
('CA', 2)
('NY', 2)
*/

-- Prediction Query
SELECT t2.state_province_county, COUNT(*) FROM customer_addresses AS t1 JOIN addresses AS t2 ON t1.address_id = t2.address_id GROUP BY t2.state_province_county;

/*
Prediction Result:
('CA', 3)
('NY', 2)
*/