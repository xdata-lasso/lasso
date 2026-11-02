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
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1035, 'Sharon James', 'long');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1043, 'Kimberly Sanchez', 'maintain');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1036, '1994-03-02', 'prove');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1044, '1971-09-08', 'hundred');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1040, NULL, NULL);
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1037, 1035, 'they', '1995-04-03', 'his');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1045, 1043, 'expect', '1972-10-09', 'wish');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1038, 1036, 1037, '3452', '1996-05-04', 'commercial');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1042, 1040, 1037, '3452', '1970-08-07', 'politics');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1046, 1044, 1045, '3452', '1973-11-10', 'push');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_order_placed FROM (SELECT * FROM orders AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM shipments WHERE (shipment_tracking_number = 3452)) AS RHS WHERE (LHS.order_id = RHS.order_id))) ORDER BY date_order_placed;

/*
Gold Result:
('1972-10-09',)
('1995-04-03',)
*/

-- Prediction Query
SELECT T1.date_order_placed FROM orders AS T1 JOIN shipments AS T2 ON T1.order_id = T2.order_id WHERE T2.shipment_tracking_number = 3452;

/*
Prediction Result:
('1995-04-03',)
('1995-04-03',)
('1972-10-09',)
*/