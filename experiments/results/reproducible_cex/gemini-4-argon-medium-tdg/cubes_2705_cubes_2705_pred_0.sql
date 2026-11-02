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
-- DATASET 1
-- Tests basic filtering (On Road vs other statuses, customers with no orders) and multiplicity (multiple On Road orders per customer vs JOIN without DISTINCT).
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (1, 'Alice Smith', 'Details_Z');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (2, 'Bob Jones', 'Details_A');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (3, 'Charlie Brown', 'Details_M');
INSERT INTO "Customers" ("customer_id", "customer_name", "customer_details") VALUES (4, 'Diana Prince', 'Details_B');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (101, 1, 'On Road', '2023-01-01 10:00:00', 'Order 101');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (102, 1, 'On Road', '2023-01-02 10:00:00', 'Order 102');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (103, 2, 'Shipped', '2023-01-03 10:00:00', 'Order 103');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (104, 4, 'On Road', '2023-01-04 10:00:00', 'Order 104');
INSERT INTO "Orders" ("order_id", "customer_id", "order_status", "date_order_placed", "order_details") VALUES (105, 4, 'Pending', '2023-01-05 10:00:00', 'Order 105');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_details" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "orders" WHERE ("order_status" = 'On Road')) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_details, "customer_details" NULLS LAST;

/*
Gold Result:
('Details_B',)
('Details_Z',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_details FROM customers AS T1 JOIN orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status = 'On Road';

/*
Prediction Result:
('Details_Z',)
('Details_B',)
*/