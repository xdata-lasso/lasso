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
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (10, '2023-01-01 09:00:00', 'Paid');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (100, 1, 'Shipped', '2023-01-01 08:00:00', 'Details 1');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (200, 1, 'Pending', '2023-01-02 08:00:00', 'Details 2');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (3452, 1, 'Delivered', '2023-01-03 08:00:00', 'Order ID matches tracking number');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (1, 10, 200, '3452', '2023-01-04 10:00:00', 'Match 1');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (2, 10, 100, '3452', '2023-01-04 11:00:00', 'Match 2 (Tests ORDER BY order_id)');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (3, 10, 100, '3452', '2023-01-04 12:00:00', 'Duplicate order_id (Tests DISTINCT vs ALL)');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (4, 10, 3452, '3451', '2023-01-04 13:00:00', 'Boundary below & Order ID = 3452');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (5, 10, 200, '3453', '2023-01-04 14:00:00', 'Boundary above');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (3452, 10, 200, '9999', '2023-01-04 15:00:00', 'Shipment ID = 3452');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM shipments WHERE (shipment_tracking_number = 3452) ORDER BY order_id, shipments.shipment_id NULLS LAST;

/*
Gold Result:
(100,)
(100,)
(200,)
*/

-- Prediction Query
SELECT order_id FROM shipments WHERE shipment_tracking_number = '3452';

/*
Prediction Result:
(200,)
(100,)
(100,)
*/