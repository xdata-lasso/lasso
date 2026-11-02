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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice', 'Regular');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (10, 'Bob', 'VIP');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (9, '2023-01-01 00:00:00', 'Inv 9');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (10, '2023-01-02 00:00:00', 'Inv 10');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (11, '2023-01-03 00:00:00', 'Inv 11');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (1, 1, 'Shipped', '2023-06-15 10:00:00', 'Order 1');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (2, 1, 'Shipped', '2023-01-10 08:30:00', 'Order 2');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (3, 1, 'Shipped', '2023-03-20 14:15:00', 'Order 3');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 10, 'Pending', '2022-12-01 09:00:00', 'Decoy Order 10');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (101, 10, 1, 'TRK101', '2023-07-01 10:00:00', 'First inserted, latest order date');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (102, 10, 2, 'TRK102', '2023-07-03 10:00:00', 'Second inserted, earliest order date');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (103, 10, 3, 'TRK103', '2023-07-02 10:00:00', 'Third inserted, middle order date');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (10, 9, 10, '10', '2023-01-05 10:00:00', 'Decoy shipment_id 10 and order_id 10');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (104, 11, 1, 'TRK104', '2023-07-04 10:00:00', 'Decoy invoice 11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_order_placed FROM (SELECT LHS.shipment_id AS shipment_id, LHS.order_id AS order_id, LHS.invoice_number AS invoice_number, LHS.shipment_tracking_number AS shipment_tracking_number, LHS.shipment_date AS shipment_date, LHS.other_shipment_details AS other_shipment_details, RHS.customer_id AS customer_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM (SELECT * FROM shipments WHERE (invoice_number = 10)) AS LHS LEFT JOIN orders AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY date_order_placed;

/*
Gold Result:
('2023-01-10 08:30:00',)
('2023-03-20 14:15:00',)
('2023-06-15 10:00:00',)
*/

-- Prediction Query
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.invoice_number = 10;

/*
Prediction Result:
('2023-06-15 10:00:00',)
('2023-01-10 08:30:00',)
('2023-03-20 14:15:00',)
*/