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
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (1, 'Alice', 'VIP');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (2, 'Bob', 'Regular');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (3, 'Charlie', 'New');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (4, 'Diana', 'Regular');
INSERT INTO Customers (customer_id, customer_name, customer_details) VALUES (10, 'Eve', 'VIP');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (1, 1, 'Shipped', '2023-01-01 10:00:00', 'Self loop order');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (2, 10, 'Pending', '2023-01-05 12:00:00', 'Cycle A to B');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (10, 2, 'Delivered', '2023-01-02 08:30:00', 'Cycle B to A');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (3, 2, 'Cancelled', '2023-01-03 09:00:00', 'One way link');
INSERT INTO Orders (order_id, customer_id, order_status, date_order_placed, order_details) VALUES (99, 4, 'Pending', '2023-01-04 11:00:00', 'Unmatched order_id not in Customers');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id AS order_id FROM (SELECT order_id, order_id AS customer_id, order_status, date_order_placed, order_details, order_status_other, date_order_placed_other, order_details_other FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.order_status AS order_status_other, RHS.date_order_placed AS date_order_placed_other, RHS.order_details AS order_details_other FROM orders AS LHS INNER JOIN orders AS RHS ON (LHS.order_id = RHS.customer_id AND LHS.customer_id = RHS.order_id))) ORDER BY order_id;

/*
Gold Result:
(1,)
(2,)
(10,)
*/

-- Prediction Query
SELECT order_id FROM orders ORDER BY date_order_placed DESC, orders.order_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/