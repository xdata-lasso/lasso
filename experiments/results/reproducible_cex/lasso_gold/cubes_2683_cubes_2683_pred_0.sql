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
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1001, 'Allison Hill', 'all');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1002, 'Noah Rhodes', 'better');
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (1003, 'Angie Henderson', 'discover');
INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (1004, 'food', 'early');
INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (1005, 'food', 'mouth');
INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (1006, 'food', 'play');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1007, 1001, 'agreement', '1970-01-01', 'sense');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1008, 1001, 'option', '1970-01-02', 'rate');
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1009, 1001, 'decide', '1970-01-03', 'science');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1010, 1004, 1007, 'offer', 'list');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1011, 1004, 1007, 'kind', 'perform');
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1012, 1004, 1007, 'discussion', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "customer_id", "customer_name", "customer_details", "order_id", "order_status", "date_order_placed", "order_details", "product_id", "product_name", "product_details", "order_item_id", "order_item_status", "order_item_details", COUNT(*) OVER () AS "n" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "LHS"."product_id" AS "product_id", "LHS"."product_name" AS "product_name", "LHS"."product_details" AS "product_details", "RHS"."order_item_id" AS "order_item_id", "RHS"."order_item_status" AS "order_item_status", "RHS"."order_item_details" AS "order_item_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "LHS"."order_id" AS "order_id", "LHS"."order_status" AS "order_status", "LHS"."date_order_placed" AS "date_order_placed", "LHS"."order_details" AS "order_details", "RHS"."product_id" AS "product_id", "RHS"."product_name" AS "product_name", "RHS"."product_details" AS "product_details" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."customer_name" AS "customer_name", "LHS"."customer_details" AS "customer_details", "RHS"."order_id" AS "order_id", "RHS"."order_status" AS "order_status", "RHS"."date_order_placed" AS "date_order_placed", "RHS"."order_details" AS "order_details" FROM "customers" AS "LHS" INNER JOIN "orders" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" CROSS JOIN "products" AS "RHS") AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id" AND "LHS"."product_id" = "RHS"."product_id"))) WHERE ("product_name" = 'food' OR n <= 1) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
*/

-- Prediction Query
SELECT T1.customer_name FROM customers AS T1 CROSS JOIN orders AS T2 CROSS JOIN order_items AS T3 JOIN products AS T4 ON T1.customer_id = T2.customer_id AND T2.order_id = T3.order_id AND T3.product_id = T4.product_id WHERE T4.product_name = 'food' GROUP BY T1.customer_id HAVING COUNT(*) >= 1;

/*
Prediction Result:
('Allison Hill',)
*/