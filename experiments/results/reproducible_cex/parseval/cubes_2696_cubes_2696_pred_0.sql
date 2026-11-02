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
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1, -2147483648, 'ord_cb856b', '2024-06-15 00:00:00+00:00', 'ord_9f7a15');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483647, 1, 'ord_31ef05', '2024-06-15 00:00:00+00:00', 'ord_8f8948');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (2, 1, 'ord_be23fb', '2022-02-14 19:27:39+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (3, -2147483648, 'ord_be23fb', '2025-11-08 19:01:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (4, 1, 'ord_be23fb', '2024-06-06 00:28:47+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (5, 1, 'ord_be23fb', '2020-09-25 19:25:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (6, -2147483648, 'ord_be23fb', '2024-02-11 16:43:27+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (7, -2147483648, 'ord_be23fb', '2022-04-15 05:01:35+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (8, -2147483648, 'ord_be23fb', '2020-01-15 18:18:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (9, 1, 'ord_be23fb', '2023-03-21 21:13:18+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (10, -2147483648, 'ord_be23fb', '2022-10-06 13:20:05+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (11, 1, 'ord_be23fb', '2020-12-10 17:36:20+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (12, 1, 'ord_be23fb', '2025-08-22 00:34:24+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (13, 1, 'ord_be23fb', '2022-12-20 09:53:17+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (14, -2147483648, 'ord_be23fb', '2020-03-08 22:40:47+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (15, -2147483648, 'ord_be23fb', '2024-04-12 00:38:47+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (16, -2147483648, 'ord_be23fb', '2022-09-23 20:24:07+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (17, -2147483648, 'ord_be23fb', '2022-11-06 10:19:41+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (18, -2147483648, 'ord_be23fb', '2021-07-11 07:27:32+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (19, 1, 'ord_be23fb', '2022-08-02 13:58:36+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (20, -2147483648, 'ord_be23fb', '2021-07-20 10:41:36+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (21, -2147483648, 'ord_be23fb', '2025-02-07 06:53:31+00:00', 'ord_0a08b4');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (-2147483648, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'cus_8d1b6b', 'cus_04a990');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id AS order_id FROM (SELECT order_id, order_id AS customer_id, order_status, date_order_placed, order_details, order_status_other, date_order_placed_other, order_details_other FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.date_order_placed AS date_order_placed, LHS.order_details AS order_details, RHS.order_status AS order_status_other, RHS.date_order_placed AS date_order_placed_other, RHS.order_details AS order_details_other FROM orders AS LHS INNER JOIN orders AS RHS ON (LHS.order_id = RHS.customer_id AND LHS.customer_id = RHS.order_id))) ORDER BY order_id;

/*
Gold Result:
*/

-- Prediction Query
SELECT order_id FROM orders ORDER BY date_order_placed DESC, orders.order_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(3,)
*/