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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice Smith', 'VIP');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (1, '2023-06-01 10:00:00', 'Paid');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 1, 'Shipped', '2023-05-20 14:30:00', 'First Order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (20, 1, 'Pending', '2023-05-10 09:15:00', 'Second Order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (30, 1, 'Shipped', '2023-05-15 11:00:00', 'Third Order');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (100, 1, 10, '3452', '2023-05-21 08:00:00', 'Track 1');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (101, 1, 10, '3452', '2023-05-22 09:00:00', 'Track 2 Duplicate');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (102, 1, 20, '9999', '2023-05-12 10:00:00', 'Different Track');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_order_placed FROM (SELECT * FROM orders AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM shipments WHERE (shipment_tracking_number = 3452)) AS RHS WHERE (LHS.order_id = RHS.order_id))) ORDER BY date_order_placed;

/*
Gold Result:
('2023-05-20 14:30:00',)
*/

-- Prediction Query
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.shipment_tracking_number = 3452;

/*
Prediction Result:
('2023-05-20 14:30:00',)
('2023-05-20 14:30:00',)
*/