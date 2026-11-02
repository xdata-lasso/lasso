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
-- Tests:
-- 1. INNER JOIN without DISTINCT vs EXISTS (Customer 1 has multiple 'Packing' orders).
-- 2. Duplicate customer_name across different customers (Customer 1 and 2 both named 'Alice', testing SELECT DISTINCT customer_name mutants).
-- 3. Mixed order statuses for a single customer (Customer 3 has both 'Packing' and 'Shipped').
-- 4. Customer with only non-'Packing' orders (Customer 4).
-- 5. Customer with no orders at all (Customer 5, tests LEFT JOIN mutants).
-- 6. Sorting order (Zoe vs Alice) and NULL handling in customer_name.
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'Alice', 'Details 1');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 'Alice', 'Details 2');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (3, 'Zoe', 'Details 3');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (4, 'Bob', 'Details 4');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (5, 'Charlie', 'Details 5');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (6, NULL, 'Details 6');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (101, 1, 'Packing', '2023-01-01 10:00:00', 'Order 101');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (102, 1, 'Packing', '2023-01-02 10:00:00', 'Order 102');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (103, 2, 'Packing', '2023-01-03 10:00:00', 'Order 103');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (104, 3, 'Shipped', '2023-01-04 10:00:00', 'Order 104');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (105, 3, 'Packing', '2023-01-05 10:00:00', 'Order 105');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (106, 4, 'Shipped', '2023-01-06 10:00:00', 'Order 106');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (107, 4, NULL, '2023-01-07 10:00:00', 'Order 107');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (108, 6, 'Packing', '2023-01-08 10:00:00', 'Order 108');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (109, NULL, 'Packing', '2023-01-09 10:00:00', 'Order 109');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "orders" WHERE ("order_status" = 'Packing')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = 'Packing';

/*
Prediction Result:
('Alice',)
('Zoe',)
(None,)
*/