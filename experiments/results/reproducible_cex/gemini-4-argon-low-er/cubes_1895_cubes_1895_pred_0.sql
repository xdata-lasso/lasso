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
INSERT INTO Addresses (address_id, state_province_county) VALUES (1, 'CA');
INSERT INTO Addresses (address_id, state_province_county) VALUES (2, 'CA');
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Alice');
INSERT INTO Customer_Addresses (address_id, customer_id) VALUES (1, 1);
INSERT INTO Customer_Addresses (address_id, customer_id) VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state_province_county, n AS count___ FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.customer_id AS customer_id, LHS.date_from AS date_from, LHS.address_type AS address_type, LHS.date_to AS date_to, RHS.n AS n FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.address_type AS address_type, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, COUNT(*) AS n FROM customer_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY state_province_county, count___ NULLS LAST;

/*
Gold Result:
('CA', 1)
*/

-- Prediction Query
SELECT t2.state_province_county, COUNT(*) FROM customer_addresses AS t1 JOIN addresses AS t2 ON t1.address_id = t2.address_id GROUP BY t2.state_province_county;

/*
Prediction Result:
('CA', 2)
*/