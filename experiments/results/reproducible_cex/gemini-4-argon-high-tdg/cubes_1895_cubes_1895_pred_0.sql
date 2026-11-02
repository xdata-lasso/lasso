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
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (1, '100 Main St', 'Los Angeles', '90001', 'California', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (2, '200 Oak Ave', 'San Diego', '92101', 'California', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (3, '300 Pine Rd', 'San Jose', '95101', 'California', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (4, '400 Elm St', 'Sacramento', '94203', 'California', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (5, '500 Lone Star Blvd', 'Austin', '73301', 'Texas', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (6, '600 Desert Way', 'Reno', '89501', 'Nevada', 'USA');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (1, 'Card', 'Alice Smith', '555-0101', 'alice@example.com', '2020-01-10 08:00:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (2, 'Cash', 'Bob Jones', '555-0102', 'bob@example.com', '2020-02-15 09:30:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (3, 'Check', 'Carol White', '555-0103', 'carol@example.com', '2020-03-20 10:45:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (4, 'Card', 'Dan Brown', '555-0104', 'dan@example.com', '2020-04-25 11:15:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (5, 1, '2021-01-01 00:00:00', 'Billing', '2022-01-01 00:00:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (5, 1, '2022-01-02 00:00:00', 'Shipping', NULL);
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 1, '2021-03-01 00:00:00', 'Home', '2021-12-31 00:00:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 2, '2021-04-01 00:00:00', 'Office', '2022-04-01 00:00:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 3, '2021-05-01 00:00:00', 'Billing', NULL);
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (2, 2, '2021-06-01 00:00:00', 'Shipping', '2022-06-01 00:00:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (3, 3, '2021-07-01 00:00:00', 'Home', NULL);
INSERT INTO Employees (employee_id, employee_address_id, employee_name, employee_phone) VALUES (1, 6, 'Evan Driver', '555-0900');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (1, 'West Route', 'Highway 101');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('LOC1', 1, 4, 'Sacramento Depot');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state_province_county, n AS count___ FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.customer_id AS customer_id, LHS.date_from AS date_from, LHS.address_type AS address_type, LHS.date_to AS date_to, RHS.n AS n FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.address_type AS address_type, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, COUNT(*) AS n FROM customer_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY state_province_county, count___ NULLS LAST;

/*
Gold Result:
('California', 1)
('California', 3)
('Texas', 2)
*/

-- Prediction Query
SELECT t2.state_province_county, COUNT(*) FROM customer_addresses AS t1 JOIN addresses AS t2 ON t1.address_id = t2.address_id GROUP BY t2.state_province_county;

/*
Prediction Result:
('California', 5)
('Texas', 2)
*/