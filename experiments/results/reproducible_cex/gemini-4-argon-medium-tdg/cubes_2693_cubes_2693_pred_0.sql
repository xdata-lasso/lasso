-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(80), "customer_details" TEXT(255));

CREATE TABLE "Invoices" ("invoice_number" INTEGER PRIMARY KEY, "invoice_date" DATETIME, "invoice_details" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(10), "date_order_placed" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(80), "product_details" TEXT(255));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "product_id" INTEGER, "order_id" INTEGER, "order_item_status" TEXT(10), "order_item_details" TEXT(255), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Shipments" ("shipment_id" INTEGER PRIMARY KEY, "invoice_number" INTEGER, "order_id" INTEGER, "shipment_tracking_number" TEXT(80), "shipment_date" DATETIME, "other_shipment_details" TEXT(255), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Shipment_Items" ("shipment_id" INTEGER, "order_item_id" INTEGER, FOREIGN KEY ("shipment_id") REFERENCES "Shipments" ("shipment_id"), FOREIGN KEY ("order_item_id") REFERENCES "Order_Items" ("order_item_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion, negative, zero, positive IDs), NULLs in non-key columns, and sorting conflicts between order_id, customer_id, and date_order_placed.
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (10, 'Alice', 'Regular');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (20, 'Bob', 'VIP');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (30, 'Charlie', NULL);
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (50, 10, 'Shipped', '2023-05-01 10:00:00', 'Detail Z');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (-10, 30, 'Pending', '2023-06-15 12:00:00', NULL);
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (0, NULL, NULL, NULL, NULL);
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (5, 20, 'Cancelled', '2023-01-01 08:30:00', 'Detail A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM orders ORDER BY order_id;

/*
Gold Result:
(-10,)
(0,)
(5,)
(50,)
*/

-- Prediction Query
SELECT DISTINCT order_id FROM orders ORDER BY date_order_placed, order_id NULLS LAST;

/*
Prediction Result:
(0,)
(5,)
(50,)
(-10,)
*/