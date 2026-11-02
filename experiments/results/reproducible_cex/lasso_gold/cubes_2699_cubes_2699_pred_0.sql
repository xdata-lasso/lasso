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
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1676, 'Mr. Donald Fischer', 'answer');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1677, 'Jeffrey Campbell', 'discussion');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1678, 'Katelyn Estrada', 'indicate');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1693, 'Katelyn Estrada', 'indicate');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1679, '1984-09-08', 'place');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1680, '1984-09-09', 'around');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1681, '1984-09-10', 'account');
INSERT INTO "invoices" ("invoice_number", "invoice_date", "invoice_details") VALUES (1694, '1984-09-10', 'account');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1682, 1676, 'democratic', '1987-01-11', 'development');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1683, 1676, 'fish', '1987-01-12', 'speak');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1684, 1676, 'young', '1987-01-13', 'certain');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1692, 1676, 'young', '1987-01-13', 'certain');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1685, 1679, 1682, 'south', '1990-04-14', 'generation');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1686, 1679, 1682, 'especially', '1990-04-15', 'call');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1687, 1679, 1682, 'figure', '1990-04-16', 'modern');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1688, 1679, 1682, 'skin', '1993-07-17', 'carry');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1689, 1679, 1682, 'law', '1993-07-18', 'husband');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1690, 1679, 1682, 'continue', '1993-07-19', 'no');
INSERT INTO "shipments" ("shipment_id", "invoice_number", "order_id", "shipment_tracking_number", "shipment_date", "other_shipment_details") VALUES (1691, 1679, 1682, 'continue', '1993-07-19', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT order_id_other AS order_id FROM (SELECT LHS.shipment_id AS shipment_id, LHS.order_id AS order_id, LHS.invoice_number AS invoice_number, LHS.shipment_tracking_number AS shipment_tracking_number, LHS.shipment_date AS shipment_date, LHS.other_shipment_details AS other_shipment_details, LHS.maxshipment_date AS maxshipment_date, RHS.shipment_id AS shipment_id_other, RHS.order_id AS order_id_other, RHS.invoice_number AS invoice_number_other, RHS.shipment_tracking_number AS shipment_tracking_number_other, RHS.shipment_date AS shipment_date_other, RHS.other_shipment_details AS other_shipment_details_other, RHS.maxshipment_date AS maxshipment_date_other FROM (SELECT shipment_id, order_id, invoice_number, shipment_tracking_number, shipment_date, other_shipment_details, MAX(shipment_date) OVER () AS maxshipment_date FROM shipments) AS LHS CROSS JOIN (SELECT shipment_id, order_id, invoice_number, shipment_tracking_number, shipment_date, other_shipment_details, MAX(shipment_date) OVER () AS maxshipment_date FROM shipments) AS RHS) WHERE (maxshipment_date > maxshipment_date_other OR shipment_date_other >= maxshipment_date_other) ORDER BY order_id;

/*
Gold Result:
(1682,)
*/

-- Prediction Query
SELECT order_id FROM shipments WHERE shipment_date = (SELECT MAX(shipment_date) FROM shipments);

/*
Prediction Result:
(1682,)
(1682,)
*/