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
INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (1, -2147483648, 'ord_be23fb', '2024-12-15 00:56:33+00:00', 'ord_0a08b4');

INSERT INTO "orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (-2147483648, -2147483648, 'ord_be23fb', '2021-05-28 17:00:04+00:00', 'ord_0a08b4');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_name", "customer_details") VALUES (-2147483648, 'cus_8d1b6b', 'cus_04a990');

-- Inserting into table: products --
INSERT INTO "products" ("product_id", "product_name", "product_details") VALUES (1, 'pro_bf129f', 'pro_391809');

-- Inserting into table: order_items --
INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (1, 1, 1, 'lhs_1a2e89', 'lhs_dbf6e9');

INSERT INTO "order_items" ("order_item_id", "product_id", "order_id", "order_item_status", "order_item_details") VALUES (-2147483648, 1, 1, 'lhs_abaa98', 'lhs_ef097f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT maxn AS order_id FROM (SELECT order_item_details, MAX(n) AS maxn FROM (SELECT order_item_details, COUNT(*) AS n FROM (SELECT * FROM order_items AS LHS WHERE EXISTS(SELECT 1 FROM orders AS RHS WHERE (LHS.order_id = RHS.order_id))) GROUP BY order_item_details) GROUP BY order_item_details) ORDER BY order_id;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.order_id FROM orders AS T1 JOIN order_items AS T2 ON T1.order_id = T2.order_id GROUP BY T1.order_id ORDER BY COUNT(*) DESC, T1.order_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/