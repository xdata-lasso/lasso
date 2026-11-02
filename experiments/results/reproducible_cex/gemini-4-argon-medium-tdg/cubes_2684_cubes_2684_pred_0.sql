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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Zeta', 'Zero orders');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Charlie', 'One order');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (3, 'Alpha', 'Two orders');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (4, 'Beta', 'Three orders');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (101, 2, 'Shipped', '2023-01-01 10:00:00', 'Order 1 for Charlie');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (102, 3, 'Shipped', '2023-01-02 10:00:00', 'Order 1 for Alpha');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (103, 3, 'Pending', '2023-01-03 10:00:00', 'Order 2 for Alpha');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (104, 4, 'Shipped', '2023-01-04 10:00:00', 'Order 1 for Beta');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (105, 4, 'Cancelled', '2023-01-05 10:00:00', 'Order 2 for Beta');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (106, 4, 'Delivered', '2023-01-06 10:00:00', 'Order 3 for Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT customer_name, COUNT(*) AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.customer_details AS customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN orders AS RHS ON (LHS.customer_id = RHS.customer_id)) GROUP BY customer_name) WHERE (n <= 2) ORDER BY customer_name;

/*
Gold Result:
('Alpha',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.customer_name FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING COUNT(*) <= 2;

/*
Prediction Result:
('Charlie',)
('Alpha',)
*/