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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (20, 'Bob Jones', 'Regular');
INSERT INTO Products (product_id, product_name, product_details) VALUES (100, 'Laptop', '15-inch');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (101, 10, 'Shipped', '2023-01-10 10:00:00', 'First order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (102, 10, 'Shipped', '2023-01-11 11:00:00', 'Second order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (103, NULL, NULL, NULL, NULL);
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1001, 100, 102, 'Delivered', 'Item A');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1002, 100, 101, 'Delivered', 'Item B');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1003, 100, 101, 'Pending', 'Item C');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1004, 100, 102, NULL, NULL);
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (501, '2023-01-12 00:00:00', 'Inv 1');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (502, '2023-01-13 00:00:00', 'Inv 2');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (503, '2023-01-14 00:00:00', 'Inv 3');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (504, '2023-01-15 00:00:00', 'Inv 4');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (505, '2023-01-16 00:00:00', 'Inv 5');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (601, 501, 101, 'TRK1', '2023-01-12 12:00:00', 'S1');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (602, 502, 101, 'TRK2', '2023-01-13 12:00:00', 'S2');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (603, 503, 102, 'TRK3', '2023-01-14 12:00:00', 'S3');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (604, 504, 102, 'TRK4', '2023-01-15 12:00:00', 'S4');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (605, 505, 103, 'TRK5', '2023-01-16 12:00:00', 'S5');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (606, 505, 103, 'TRK6', '2023-01-17 12:00:00', 'S6');
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (601, 1001);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (602, 1002);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (603, 1003);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (604, 1004);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (605, 1001);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (606, 1002);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (606, 1003);
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
(101,)
*/