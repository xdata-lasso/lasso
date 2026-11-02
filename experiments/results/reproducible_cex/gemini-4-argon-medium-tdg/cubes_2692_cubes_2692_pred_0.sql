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
-- Tests standard populated state where Order_Items has multiple rows (testing DISTINCT),
-- Orders has multiple rows with NULLs and duplicate foreign keys (testing COUNT(*) vs COUNT(col) vs COUNT(DISTINCT col)),
-- and count of Orders (3) differs from count of Order_Items (2) and actual order_id values (10, 20, 30).
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice', 'Regular');
INSERT INTO Products (product_id, product_name, product_details) VALUES (100, 'Laptop', 'Electronics');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 1, 'Shipped', '2023-01-01 10:00:00', 'First order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (20, 1, NULL, NULL, NULL);
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (30, NULL, 'Pending', '2023-01-02 10:00:00', NULL);
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1000, 100, 10, 'Delivered', 'Item 1');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1001, NULL, 10, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS order_id FROM (SELECT LHS.order_item_id AS order_item_id, LHS.product_id AS product_id, LHS.order_id AS order_id, LHS.order_item_status AS order_item_status, LHS.order_item_details AS order_item_details, RHS.n AS n FROM order_items AS LHS CROSS JOIN (SELECT COUNT(*) AS n FROM orders) AS RHS) ORDER BY order_id;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT T1.order_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id GROUP BY T1.order_id ORDER BY COUNT(*) DESC, T1.order_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/