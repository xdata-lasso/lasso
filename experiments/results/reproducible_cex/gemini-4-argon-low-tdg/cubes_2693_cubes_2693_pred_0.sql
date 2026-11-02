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
-- Tests basic ordering (insertion order differs from ascending order_id), joins with Order_Items/Shipments (1-to-many vs 0-to-many), and anti-ordering by other columns (customer_id, date_order_placed, order_status).
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice', 'Details A');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Bob', 'Details B');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (3, 'Charlie', 'Details C');
INSERT INTO Products (product_id, product_name, product_details) VALUES (10, 'Laptop', 'Tech');
INSERT INTO Products (product_id, product_name, product_details) VALUES (20, 'Mouse', 'Accessory');
INSERT INTO Invoices (invoice_number, invoice_date, invoice_details) VALUES (100, '2023-01-10 10:00:00', 'Paid');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (30, 1, 'Pending', '2023-01-01 08:00:00', 'First placed, highest ID');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 3, 'Shipped', '2023-01-03 09:00:00', 'Last placed, lowest ID');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (20, 2, 'Cancelled', '2023-01-02 08:30:00', 'Middle ID');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (1, 10, 10, 'Delivered', 'Item 1 for Order 10');
INSERT INTO Order_Items (order_item_id, product_id, order_id, order_item_status, order_item_details) VALUES (2, 20, 10, 'Delivered', 'Item 2 for Order 10');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (500, 100, 10, 'TRK123', '2023-01-04 12:00:00', 'First shipment');
INSERT INTO Shipments (shipment_id, invoice_number, order_id, shipment_tracking_number, shipment_date, other_shipment_details) VALUES (501, 100, 10, 'TRK124', '2023-01-05 12:00:00', 'Second shipment');
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (500, 1);
INSERT INTO Shipment_Items (shipment_id, order_item_id) VALUES (501, 2);
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
(30,)
(20,)
(10,)
*/