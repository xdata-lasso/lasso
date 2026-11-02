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
-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483648, 1, 'ord_be23fb', '2024-12-15 00:56:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483647, 1, 'ord_be23fb', '2025-11-23 07:28:46+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483646, 1, 'ord_be23fb', '2025-10-14 06:39:08+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483645, 3, 'ord_be23fb', '2025-06-10 18:20:47+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483644, 4, 'ord_be23fb', '2024-02-22 05:22:28+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483643, 3, 'ord_be23fb', '2021-05-28 17:00:04+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483642, 4, 'ord_be23fb', '2024-02-19 01:18:26+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483641, 3, 'ord_be23fb', '2022-06-06 02:35:43+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483640, 4, 'ord_be23fb', '2022-12-08 21:38:59+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483639, 3, 'ord_be23fb', '2023-01-16 20:10:41+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483638, 4, 'ord_be23fb', '2022-03-24 16:30:12+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483637, 3, 'ord_be23fb', '2020-04-30 03:21:27+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (2, 1, 'ord_be23fb', '2020-10-31 07:51:16+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (3, 1, 'ord_be23fb', '2022-06-28 11:34:24+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483634, 1, 'ord_be23fb', '2021-06-17 14:22:38+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483633, 1, 'ord_be23fb', '2024-11-14 12:35:58+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483632, 1, 'ord_be23fb', '2024-09-28 03:06:45+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (4, 6, 'ord_be23fb', '2024-12-15 00:56:33+00:00', 'ord_0a08b4');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 't2__cfa7d7', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (-2147483647, 't2__cfa7d7', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (3, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 't2__cfa7d7', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (4, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (6, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (5, 'cus_8d1b6b', 'cus_04a990');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, n AS count___ FROM (SELECT customer_name, COUNT(*) AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_name AS customer_name, LHS.customer_details AS customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.date_order_placed AS date_order_placed, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN orders AS RHS ON (LHS.customer_id = RHS.customer_id)) GROUP BY customer_name) WHERE (n >= 2) ORDER BY customer_name, count___ NULLS LAST;

/*
Gold Result:
('cus_8d1b6b', 10)
('t2__cfa7d7', 8)
*/

-- Prediction Query
SELECT T2.customer_name, COUNT(*) FROM orders AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T2.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('t2__cfa7d7', 8)
('cus_8d1b6b', 5)
('cus_8d1b6b', 4)
*/