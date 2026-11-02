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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Bob', 'VIP');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (3, 'Charlie', 'New');
INSERT INTO Products (product_id, product_name, product_details) VALUES (100, 'Laptop', 'Electronics');
INSERT INTO Products (product_id, product_name, product_details) VALUES (200, 'Mouse', 'Accessories');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (801, '2023-01-10 10:00:00', 'Paid');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (802, '2023-02-15 12:00:00', 'Pending');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (30, 2, 'Pending', '2023-02-01 09:00:00', 'Order B');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 3, 'Shipped', '2023-03-01 09:00:00', 'Order C');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (20, 1, 'Cancelled', '2023-01-01 09:00:00', 'Order A');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (501, 100, 10, 'Delivered', 'Item 1');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (502, 200, 10, 'Delivered', 'Item 2');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (503, 100, 20, 'Cancelled', 'Item 3');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (901, 801, 10, 'TRK1001', '2023-03-02 14:00:00', 'First part');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (902, 802, 10, 'TRK1002', '2023-03-03 15:00:00', 'Second part');
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (901, 501);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (902, 502);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id FROM orders ORDER BY order_id;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT DISTINCT order_id FROM orders ORDER BY date_order_placed, order_id NULLS LAST;

/*
Prediction Result:
(20,)
(30,)
(10,)
*/