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
-- Tests basic counting, duplicate (product_id, order_id) pairs in Order_Items (COUNT(*) vs COUNT(DISTINCT order_id)),
-- products never ordered (INNER JOIN vs LEFT JOIN), and ORDER BY count___ ASC, product_id ASC tie-breaking.
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice', 'Details A');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Bob', 'Details B');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 1, 'Pending', '2023-01-01 10:00:00', 'Order 10');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (20, 2, 'Shipped', '2023-01-02 11:00:00', 'Order 20');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (30, 1, 'Cancelled', '2023-01-03 12:00:00', 'Empty Order');
INSERT INTO Products (product_id, product_name, product_details) VALUES (100, 'Widget', 'Standard Widget');
INSERT INTO Products (product_id, product_name, product_details) VALUES (200, 'Gadget', 'Advanced Gadget');
INSERT INTO Products (product_id, product_name, product_details) VALUES (300, 'Doohickey', 'Unused Product');
INSERT INTO Products (product_id, product_name, product_details) VALUES (400, 'Thingamajig', 'Single Item Product');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1, 100, 10, 'Delivered', 'Item 1');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (2, 100, 10, 'Delivered', 'Item 2 - Same Order and Product');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (3, 100, 20, 'Pending', 'Item 3 - Different Order');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (4, 200, 10, 'Shipped', 'Item 4');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (5, 400, 20, 'Shipped', 'Item 5 - Tie on count with product 200');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, product_id FROM (SELECT product_id, COUNT(*) AS n FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, LHS.product_id AS product_id, LHS.product_name AS product_name, LHS.product_details AS product_details, RHS.order_item_id AS order_item_id, RHS.order_item_status AS order_item_status, RHS.order_item_details AS order_item_details FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.product_name AS product_name, RHS.product_details AS product_details FROM orders AS LHS CROSS JOIN products AS RHS) AS LHS INNER JOIN order_items AS RHS ON (LHS.order_id = RHS.order_id AND LHS.product_id = RHS.product_id)) GROUP BY product_id) ORDER BY count___, product_id NULLS LAST;

/*
Gold Result:
(1, 200)
(1, 400)
(3, 100)
*/

-- Prediction Query
SELECT COUNT(*), T3.product_id FROM orders AS T1 CROSS JOIN order_items AS T2 JOIN products AS T3 ON T1.order_id = T2.order_id AND T2.product_id = T3.product_id GROUP BY T3.product_id;

/*
Prediction Result:
(3, 100)
(1, 200)
(1, 400)
*/