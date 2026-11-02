-- Schema DDL
CREATE TABLE "Premises" ("premise_id" INTEGER PRIMARY KEY, "premises_type" TEXT(15), "premise_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "product_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "customer_address" TEXT(255), "customer_login" TEXT(80), "customer_password" TEXT(10));

CREATE TABLE "Mailshot_Campaigns" ("mailshot_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "mailshot_name" TEXT(80), "mailshot_start_date" DATETIME, "mailshot_end_date" DATETIME);

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "premise_id" INTEGER, "date_address_from" DATETIME, "address_type_code" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("premise_id") REFERENCES "Premises" ("premise_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(15), "shipping_method_code" TEXT(15), "order_placed_datetime" DATETIME, "order_delivered_datetime" DATETIME, "order_shipping_charges" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Mailshot_Customers" ("mailshot_id" INTEGER, "customer_id" INTEGER, "outcome_code" TEXT(15), "mailshot_customer_date" DATETIME, FOREIGN KEY ("mailshot_id") REFERENCES "Mailshot_Campaigns" ("mailshot_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "item_id" INTEGER, "order_item_status_code" TEXT(15), "item_status_code" TEXT(15), "item_delivered_datetime" DATETIME, "item_order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1056, 'others', 'Megan Sanders', '(693)479-2374x7407', 'alexandermichael@example.net', '474 Yvonne Walk Suite 136
Baileyport, AK 86776', 'individual', 'draw');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1058, 'structure', 'Christopher Lynch', '+1-274-639-5339x421', 'xjohnson@example.net', '6232 Schmidt Groves Apt. 474
Lindamouth, CA 18950', 'somebody', 'face');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1057, 1056, 'Paid', 'FedEx', '1993-09-07', '1994-10-08', 'across');
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status_code", "shipping_method_code", "order_placed_datetime", "order_delivered_datetime", "order_shipping_charges") VALUES (1059, 1058, 'Paid', 'FedEx', '1995-11-09', '1996-01-10', 'trade');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."customer_address" AS "customer_address", "LHS"."customer_login" AS "customer_login", "LHS"."customer_password" AS "customer_password", "RHS"."order_id" AS "order_id", "RHS"."order_status_code" AS "order_status_code", "RHS"."shipping_method_code" AS "shipping_method_code", "RHS"."order_placed_datetime" AS "order_placed_datetime", "RHS"."order_delivered_datetime" AS "order_delivered_datetime", "RHS"."order_shipping_charges" AS "order_shipping_charges" FROM "customers" AS "LHS" INNER JOIN (SELECT * FROM "customer_orders" WHERE ("shipping_method_code" = 'FedEx' AND "order_status_code" = 'Paid')) AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Christopher Lynch',)
('Megan Sanders',)
*/

-- Prediction Query
SELECT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id WHERE shipping_method_code = 'FedEx' AND order_status_code = 'Paid';

/*
Prediction Result:
('Megan Sanders',)
('Christopher Lynch',)
*/