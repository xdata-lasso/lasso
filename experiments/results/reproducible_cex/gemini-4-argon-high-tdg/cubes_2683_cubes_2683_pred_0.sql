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
-- DATASET 2
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'Charlie', 'Active');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 'Diana', 'No orders');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (100, 'laptop', 'Electronics');
INSERT INTO "Products" ("product_id", "product_name", "product_details") VALUES (200, 'food', 'Unordered food');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (10, 1, 'Placed', '2023-02-01 09:00:00', 'Single valid order');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (20, 1, 'Cancelled', '2023-02-02 09:00:00', 'Empty order');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1000, 100, 10, 'OK', 'Only joined item');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "customer_id", "customer_name", "customer_details", "order_id", "order_status", "date_order_placed", "order_details", "product_id", "product_name", "product_details", "order_item_id", "order_item_status", "order_item_details", COUNT(*) OVER () AS "n" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "LHS"."product_id" AS "product_id", "LHS"."product_name" AS "product_name", "LHS"."product_details" AS "product_details", "RHS"."order_item_id" AS "order_item_id", "RHS"."order_item_status" AS "order_item_status", "RHS"."order_item_details" AS "order_item_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "RHS"."product_id" AS "product_id", "RHS"."product_name" AS "product_name", "RHS"."product_details" AS "product_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "RHS"."order_id" AS "order_id", "RHS"."order_status" AS "order_status", "RHS"."date_order_placed" AS "date_order_placed", "RHS"."order_details" AS "order_details" FROM "customers" AS "LHS" INNER JOIN "orders" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id" AND "LHS"."product_id" = "RHS"."product_id"))) WHERE ("product_name" = 'food' OR n <= 1) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Charlie',)
*/

-- Prediction Query
SELECT T1.customer_name FROM customers AS T1 CROSS JOIN orders AS T2 CROSS JOIN order_items AS T3 JOIN products AS T4 ON T1.customer_id = T2.customer_id AND T2.order_id = T3.order_id AND T3.product_id = T4.product_id WHERE T4.product_name = 'food' GROUP BY T1.customer_id HAVING COUNT(*) >= 1;

/*
Prediction Result:
*/