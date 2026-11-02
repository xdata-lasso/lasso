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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Zack', 'VIP Customer');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Alice', 'Regular Customer');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (3, 'Bob', 'Wholesale Customer');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (4, 'Charlie', 'Single Order Customer');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (5, 'David', 'Zero Order Customer');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (101, 1, 'Shipped', '2023-01-10 10:00:00', 'Order 101');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (102, 1, 'Pending', '2023-01-11 11:00:00', 'Order 102');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (103, 1, 'Delivered', '2023-01-12 12:00:00', 'Order 103');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (104, 2, 'Shipped', '2023-02-01 09:00:00', 'Order 104');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (105, 2, 'Cancelled', '2023-02-02 09:30:00', 'Order 105');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (106, 3, 'Shipped', '2023-03-01 08:00:00', 'Order 106');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (107, 3, 'Shipped', '2023-03-02 08:00:00', 'Order 107');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (108, 3, 'Pending', '2023-03-03 08:00:00', 'Order 108');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (109, 3, 'Delivered', '2023-03-04 08:00:00', 'Order 109');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (110, 4, 'Shipped', '2023-04-01 14:00:00', 'Order 110');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, n AS count___ FROM (SELECT customer_name, COUNT(*) AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.customer_details AS customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN orders AS RHS ON (LHS.customer_id = RHS.customer_id)) GROUP BY customer_name) WHERE (n >= 2) ORDER BY customer_name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
('Bob', 4)
('Zack', 3)
*/

-- Prediction Query
SELECT T2.customer_name, COUNT(*) FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zack', 3)
('Alice', 2)
('Bob', 4)
*/