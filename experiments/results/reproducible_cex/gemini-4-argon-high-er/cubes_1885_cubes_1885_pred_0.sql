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
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (1, '123 Main St', 'Los Angeles', '90001', 'California', 'USA');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (1, 'Card', 'Bob', '222-2222', 'bob@example.com', '2020-01-01');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (2, 'Cash', 'Alice', '111-1111', 'alice@example.com', '2020-01-02');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 1, '2020-01-01', 'Home', '2021-01-01');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 2, '2020-01-02', 'Home', '2021-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name", "customer_phone" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."address_id" AS "address_id", "LHS"."date_from" AS "date_from", "LHS"."address_type" AS "address_type", "LHS"."date_to" AS "date_to", "RHS"."address_details" AS "address_details", "RHS"."city" AS "city", "RHS"."zip_postcode" AS "zip_postcode", "RHS"."state_province_county" AS "state_province_county", "RHS"."country" AS "country" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."date_became_customer" AS "date_became_customer", "RHS"."address_id" AS "address_id", "RHS"."date_from" AS "date_from", "RHS"."address_type" AS "address_type", "RHS"."date_to" AS "date_to" FROM "customers" AS "LHS" INNER JOIN "customer_addresses" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN (SELECT * FROM "addresses" WHERE ("state_province_county" = 'California')) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY customer_name, "customer_name" NULLS LAST, "customer_phone" NULLS LAST;

/*
Gold Result:
('Alice', '111-1111')
('Bob', '222-2222')
*/

-- Prediction Query
SELECT t1.customer_name, t1.customer_phone FROM customers AS t1 JOIN customer_addresses AS t2 ON t1.customer_id = t2.customer_id JOIN addresses AS t3 ON t2.address_id = t3.address_id WHERE t3.state_province_county = 'California';

/*
Prediction Result:
('Bob', '222-2222')
('Alice', '111-1111')
*/