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
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (19, '34', NULL);
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (18, '34', '42');
INSERT INTO "Invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (21, 34, '34');
INSERT INTO "Invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (20, 34, '34');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (23, 19, NULL, NULL, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (22, 18, '39', 40, '41');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (25, '34', '34');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (24, '34', '34');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (27, 25, 22, '34', '34');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (26, 24, 22, '34', '34');
INSERT INTO "Shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (29, NULL, NULL, '34', 34, '34');
INSERT INTO "Shipment_Items" ("shipment_id", "order_item_id") VALUES (29, 26);
INSERT INTO "Shipment_Items" ("shipment_id", "order_item_id") VALUES (NULL, 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, n AS count___ FROM (SELECT customer_name, COUNT(*) AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.customer_details AS customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN orders AS RHS ON (LHS.customer_id = RHS.customer_id)) GROUP BY customer_name) WHERE (n >= 2) ORDER BY customer_name, count___ NULLS LAST;

/*
Gold Result:
('34', 2)
*/

-- Prediction Query
SELECT T2.customer_name, COUNT(*) FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/