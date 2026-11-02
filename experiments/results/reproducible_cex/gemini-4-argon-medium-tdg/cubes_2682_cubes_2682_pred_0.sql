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
-- Tests basic filtering, duplicate elimination of the semi-join (EXISTS vs JOIN without DISTINCT), and duplicate customer names across different customer IDs (SELECT vs SELECT DISTINCT).
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'Alice', 'Details 1');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 'Alice', 'Details 2');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (3, 'Bob', 'Details 3');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (4, 'Charlie', 'Details 4');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (5, 'David', 'Details 5');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (101, 1, 'Packing', '2023-01-01 10:00:00', 'Order 1');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (102, 1, 'Packing', '2023-01-02 10:00:00', 'Order 2');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (103, 2, 'Packing', '2023-01-03 10:00:00', 'Order 3');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (104, 3, 'Shipped', '2023-01-04 10:00:00', 'Order 4');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (105, 5, 'Packing', '2023-01-05 10:00:00', 'Order 5');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (106, 5, 'Delivered', '2023-01-06 10:00:00', 'Order 6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "orders" WHERE ("order_status" = 'Packing')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('David',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = 'Packing';

/*
Prediction Result:
('Alice',)
('David',)
*/