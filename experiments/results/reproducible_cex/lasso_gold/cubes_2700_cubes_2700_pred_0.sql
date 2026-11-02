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
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1001, 'Allison Hill', 'dog');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1004, 'Allison Hill', 'dog');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (10, '1970-01-01', 'chair');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1005, '1970-01-01', 'chair');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1002, 1001, 'since', '1971-02-02', 'blue');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1007, 1001, 'since', '1971-02-02', 'blue');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1003, 10, 1002, 'require', '1972-03-03', 'sit');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1008, 10, NULL, 'require', '1972-03-03', 'sit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_order_placed FROM (SELECT LHS.shipment_id AS shipment_id, LHS.order_id AS order_id, LHS.invoice_number AS invoice_number, LHS.shipment_tracking_number AS shipment_tracking_number, LHS.shipment_date AS shipment_date, LHS.other_shipment_details AS other_shipment_details, RHS.customer_id AS customer_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM (SELECT * FROM shipments WHERE (invoice_number = 10)) AS LHS LEFT JOIN orders AS RHS ON (LHS.order_id = RHS.order_id)) ORDER BY date_order_placed;

/*
Gold Result:
(None,)
('1971-02-02',)
*/

-- Prediction Query
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.invoice_number = 10;

/*
Prediction Result:
('1971-02-02',)
*/