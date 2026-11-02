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
-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (1, 'pro_27a7c2', 1.0, 'pro_e61074');

INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (-2147483647, 'pro_9923bc', 1.0, 'pro_39348a');

INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (-1, '0', 0.0003, 'pro_0bcc33');

INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (0, '2', 0.0004, 'pro_0bcc33');

INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (-2147483644, 'q_1_2d8074', 0.0005, 'pro_0bcc33');

INSERT INTO "products" ("product_id", "product_name", "product_price", "product_description") VALUES (-2147483643, 'q_1_2d8074', 0.0006, 'pro_0bcc33');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT * FROM (SELECT * FROM products ORDER BY product_name, products.product_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT product_name FROM products ORDER BY product_price DESC, products.product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('pro_9923bc',)
*/