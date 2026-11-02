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
-- 1. Products with identical names (GROUP BY product_id, product_name vs GROUP BY product_name)
-- 2. Secondary sorting on count___ when product_name ties
-- 3. Multiple order_items for the same (order_id, product_id) vs across different orders (COUNT(*) vs COUNT(DISTINCT order_id))
-- 4. Products and Orders with 0 order_items (INNER JOIN vs LEFT JOIN)
-- 5. Unshipped items (refutes mutants joining Shipments or Shipment_Items)
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'Alice', 'Regular');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 'Bob', 'VIP');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (10, 1, 'Shipped', '2023-01-01 10:00:00', 'First Order');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (20, 2, 'Pending', '2023-01-02 11:00:00', 'Second Order');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (30, 1, 'Cancelled', '2023-01-03 12:00:00', 'Empty Order');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (100, 'Widget', 'Blue Widget');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (200, 'Widget', 'Red Widget');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (300, 'Gadget', 'Green Gadget');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (400, 'Unused', 'Never Ordered');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1001, 100, 10, 'Delivered', 'Batch 1');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1002, 100, 10, 'Delivered', 'Batch 2');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1003, 100, 20, 'Pending', 'Batch 3');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1004, 200, 10, 'Delivered', 'Single');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1005, 300, 20, 'Pending', 'G1');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1006, 300, 20, 'Pending', 'G2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, n AS count___ FROM (SELECT product_id, product_name, COUNT(*) AS n FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.order_item_id AS order_item_id, RHS.order_item_status AS order_item_status, RHS.order_item_details AS order_item_details FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.product_name AS product_name, RHS.product_details AS product_details FROM orders AS LHS CROSS JOIN products AS RHS) AS LHS INNER JOIN order_items AS RHS ON (LHS.order_id = RHS.order_id AND LHS.product_id = RHS.product_id)) GROUP BY product_id, product_name) ORDER BY product_name, count___ NULLS LAST;

/*
Gold Result:
('Gadget', 2)
('Widget', 1)
('Widget', 3)
*/

-- Prediction Query
SELECT T3.product_name, COUNT(*) FROM orders AS T1 CROSS JOIN order_items AS T2 JOIN products AS T3 ON T1.order_id = T2.order_id AND T2.product_id = T3.product_id GROUP BY T3.product_id;

/*
Prediction Result:
('Widget', 3)
('Widget', 1)
('Gadget', 2)
*/