-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Products" ("product_id", "product_details") VALUES (201, 'Monitor');
INSERT INTO "Products" ("product_id", "product_details") VALUES (202, 'Cable');
INSERT INTO "Products" ("product_id", "product_details") VALUES (203, 'Stand');
INSERT INTO "Products" ("product_id", "product_details") VALUES (204, 'Adapter');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (10, 'Cash', 'Rodrick Heaney', '2021-05-01 00:00:00', 'First Rodrick');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (20, 'Wire', 'Rodrick Heaney', '2021-06-01 00:00:00', 'Second Rodrick');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (2001, 10, 'Shipped', '2021-07-01 00:00:00', 'Order A');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (2002, 20, 'Shipped', '2021-07-02 00:00:00', 'Order B');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (2001, 201, '1');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (2001, 202, '1');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (2001, 203, '1');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (2002, 201, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count_distinct_t3_product_id_" FROM (SELECT "customer_id", "customer_name", COUNT(DISTINCT "product_id") AS "n_distinct" FROM (SELECT "LHS"."order_id" AS "order_id", "LHS"."customer_id" AS "customer_id", "LHS"."order_status" AS "order_status", "LHS"."order_date" AS "order_date", "LHS"."order_details" AS "order_details", "LHS"."product_id" AS "product_id", "LHS"."order_quantity" AS "order_quantity", "RHS"."payment_method" AS "payment_method", "RHS"."customer_name" AS "customer_name", "RHS"."date_became_customer" AS "date_became_customer", "RHS"."other_customer_details" AS "other_customer_details" FROM (SELECT "LHS"."order_id" AS "order_id", "LHS"."customer_id" AS "customer_id", "LHS"."order_status" AS "order_status", "LHS"."order_date" AS "order_date", "LHS"."order_details" AS "order_details", "RHS"."product_id" AS "product_id", "RHS"."order_quantity" AS "order_quantity" FROM "customer_orders" AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id")) AS "LHS" INNER JOIN (SELECT * FROM "customers" WHERE ("customer_name" = 'Rodrick Heaney')) AS RHS ON (LHS.customer_id = RHS.customer_id)) GROUP BY customer_id, customer_name) ORDER BY count_distinct_t3_product_id_;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t3.product_id) FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id JOIN order_items AS t3 ON t2.order_id = t3.order_id WHERE t1.customer_name = 'Rodrick Heaney';

/*
Prediction Result:
(3,)
*/