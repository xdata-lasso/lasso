-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Bob', '2022-01-01', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'Alice', '2022-01-02', 'None');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1, 1, 'Delivered', '2023-01-02', 'Order 1');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (2, 2, 'Delivered', '2023-01-01', 'Order 2');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (3, NULL, 'Delivered', '2023-01-03', 'Order 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name", "order_date" FROM (SELECT "LHS"."order_id" AS "order_id", "LHS"."customer_id" AS "customer_id", "LHS"."order_status" AS "order_status", "LHS"."order_date" AS "order_date", "LHS"."order_details" AS "order_details", "RHS"."payment_method" AS "payment_method", "RHS"."customer_name" AS "customer_name", "RHS"."date_became_customer" AS "date_became_customer", "RHS"."other_customer_details" AS "other_customer_details" FROM (SELECT * FROM "customer_orders" WHERE ("order_status" = 'Delivered')) AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_name, "customer_name" NULLS LAST, "order_date" NULLS LAST;

/*
Gold Result:
(None, '2023-01-03')
('Alice', '2023-01-01')
('Bob', '2023-01-02')
*/

-- Prediction Query
SELECT t1.customer_name, t2.order_date FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id WHERE order_status = 'Delivered';

/*
Prediction Result:
('Bob', '2023-01-02')
('Alice', '2023-01-01')
*/