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
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (19, '-388', '-388');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (18, '-388', '-388');
INSERT INTO "Invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (26, -388, '-388');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (21, NULL, '-388', -388, '-388');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (20, 18, '-388', -388, '-388');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (22, '-388', '-388');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (23, 22, 20, '-388', '-388');
INSERT INTO "Shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (25, 26, NULL, '27', -388, '29');
INSERT INTO "Shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (24, 26, NULL, '28', -388, '30');
INSERT INTO "Shipment_Items" ("shipment_id", "order_item_id") VALUES (24, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT order_id_other AS order_id FROM (SELECT LHS.shipment_id AS shipment_id, LHS.order_id AS order_id, LHS.invoice_number AS invoice_number, LHS.shipment_tracking_number AS shipment_tracking_number, LHS.shipment_date AS shipment_date, LHS.other_shipment_details AS other_shipment_details, LHS.maxshipment_date AS maxshipment_date, RHS.shipment_id AS shipment_id_other, RHS.order_id AS order_id_other, RHS.invoice_number AS invoice_number_other, RHS.shipment_tracking_number AS shipment_tracking_number_other, RHS.shipment_date AS shipment_date_other, RHS.other_shipment_details AS other_shipment_details_other, RHS.maxshipment_date AS maxshipment_date_other FROM (SELECT shipment_id, order_id, invoice_number, shipment_tracking_number, shipment_date, other_shipment_details, MAX(shipment_date) OVER () AS maxshipment_date FROM shipments) AS LHS CROSS JOIN (SELECT shipment_id, order_id, invoice_number, shipment_tracking_number, shipment_date, other_shipment_details, MAX(shipment_date) OVER () AS maxshipment_date FROM shipments) AS RHS) WHERE (maxshipment_date > maxshipment_date_other OR shipment_date_other >= maxshipment_date_other) ORDER BY order_id;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT order_id FROM shipments WHERE shipment_date = (SELECT MAX(shipment_date) FROM shipments);

/*
Prediction Result:
(None,)
(None,)
*/