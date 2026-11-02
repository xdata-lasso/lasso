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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (10, 'Alice Smith', 'VIP');
INSERT INTO Products (product_id, product_name, product_details) VALUES (20, 'Laptop', 'Electronics');
INSERT INTO Products (product_id, product_name, product_details) VALUES (21, 'Mouse', 'Accessories');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (100, 10, 'Placed', '2023-01-10 10:00:00', 'First Order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (101, 10, 'Shipped', '2023-01-11 11:00:00', 'Second Order');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1, 20, 100, 'Shipped', 'Alpha');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (2, 20, 100, 'Shipped', 'Alpha');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (3, 20, 101, 'Pending', 'Alpha');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (4, 21, 100, 'Shipped', 'Beta');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (5, 20, 100, 'Shipped', 'Gamma');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (6, 20, 101, 'Pending', 'Gamma');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxn AS order_id FROM (SELECT order_item_details, MAX(n) AS maxn FROM (SELECT order_item_details, COUNT(*) AS n FROM (SELECT * FROM order_items AS LHS WHERE EXISTS(SELECT 1 FROM orders AS RHS WHERE (LHS.order_id = RHS.order_id))) GROUP BY order_item_details) GROUP BY order_item_details) ORDER BY order_id;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT T1.order_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id GROUP BY T1.order_id ORDER BY COUNT(*) DESC, T1.order_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(100,)
*/