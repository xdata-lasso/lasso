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
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1, 1, 'ord_be23fb', '2021-05-28 17:00:04+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483647, 2, 'ord_be23fb', '2023-01-16 20:10:41+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (4, 3, 'ord_be23fb', '2024-12-15 00:56:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (5, 6, 'ord_be23fb', '2024-12-15 00:56:33+00:00', 'ord_0a08b4');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 't1__edd822', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 't1__edd822', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (-2147483647, 't1__edd822', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (3, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (7, 'cus_8d1b6b', 'cus_04a990');

INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (6, 'cus_8d1b6b', 'cus_04a990');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (1, 'food', 'pro_391809');

INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (-2147483647, 'food', 'pro_391809');

INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (2, 'food', 'pro_391809');

INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (3, 'pro_bf129f', 'pro_391809');

INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (4, NULL, 'pro_391809');

INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (5, 'food', 'pro_391809');

-- Inserting into table: order_items --
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483648, 1, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483647, 1, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483646, 1, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483645, 3, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483644, 3, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483643, 3, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483642, 3, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483641, 3, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (2, 1, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (3, 1, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483638, 1, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483637, 1, -2147483647, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483636, 1, 1, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (4, 4, 4, 'ord_2491aa', 'ord_762e9a');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (5, 5, 5, 'ord_2491aa', 'ord_762e9a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "customer_id", "customer_name", "customer_details", "order_id", "order_status", "date_order_placed", "order_details", "product_id", "product_name", "product_details", "order_item_id", "order_item_status", "order_item_details", COUNT(*) OVER () AS "n" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "LHS"."product_id" AS "product_id", "LHS"."product_name" AS "product_name", "LHS"."product_details" AS "product_details", "RHS"."order_item_id" AS "order_item_id", "RHS"."order_item_status" AS "order_item_status", "RHS"."order_item_details" AS "order_item_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "RHS"."product_id" AS "product_id", "RHS"."product_name" AS "product_name", "RHS"."product_details" AS "product_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "RHS"."order_id" AS "order_id", "RHS"."order_status" AS "order_status", "RHS"."date_order_placed" AS "date_order_placed", "RHS"."order_details" AS "order_details" FROM "customers" AS "LHS" INNER JOIN "orders" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id" AND "LHS"."product_id" = "RHS"."product_id"))) WHERE ("product_name" = 'food' OR n <= 1) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('cus_8d1b6b',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
('t1__edd822',)
*/

-- Prediction Query
SELECT T1.customer_name FROM customers AS T1 CROSS JOIN orders AS T2 CROSS JOIN order_items AS T3 JOIN products AS T4 ON T1.customer_id = T2.customer_id AND T2.order_id = T3.order_id AND T3.product_id = T4.product_id WHERE T4.product_name = 'food' GROUP BY T1.customer_id HAVING COUNT(*) >= 1;

/*
Prediction Result:
('t1__edd822',)
('t1__edd822',)
('cus_8d1b6b',)
*/