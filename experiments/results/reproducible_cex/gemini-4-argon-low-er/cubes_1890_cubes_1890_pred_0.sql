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
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1, 'Visa', 'Bob', '123', 'z@example.com', '2023-01-01');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (2, 'Visa', 'Alice', '456', 'a@example.com', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_email", "customer_name" FROM "customers" WHERE ("payment_method" = 'Visa') ORDER BY customer_email, customers.customer_id NULLS LAST;

/*
Gold Result:
('a@example.com', 'Alice')
('z@example.com', 'Bob')
*/

-- Prediction Query
SELECT customer_email, customer_name FROM customers WHERE payment_method = 'Visa';

/*
Prediction Result:
('z@example.com', 'Bob')
('a@example.com', 'Alice')
*/