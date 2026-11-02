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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1028, 'wait', 'Sandra Kelley', '(677)943-4873', 'reevesjimmy@example.com', '23623 Robert Isle
Perryborough, MP 55570', 'improve', 'west');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "customer_address", "customer_login", "customer_password") VALUES (1038, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "mailshot_campaigns" ("mailshot_id", "product_category", "mailshot_name", "mailshot_start_date", "mailshot_end_date") VALUES (1029, 'speech', 'gateskathy@example.com', '1979-06-16', '1980-07-17');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1029, 1028, 'No Response', '1981-08-18');
INSERT INTO "mailshot_customers" ("mailshot_id", "customer_id", "outcome_code", "mailshot_customer_date") VALUES (1029, 1038, 'No Response', '1981-08-18');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name", "customer_phone" FROM (SELECT "LHS"."mailshot_id" AS "mailshot_id", "LHS"."customer_id" AS "customer_id", "LHS"."outcome_code" AS "outcome_code", "LHS"."mailshot_customer_date" AS "mailshot_customer_date", "RHS"."payment_method" AS "payment_method", "RHS"."customer_name" AS "customer_name", "RHS"."customer_phone" AS "customer_phone", "RHS"."customer_email" AS "customer_email", "RHS"."customer_address" AS "customer_address", "RHS"."customer_login" AS "customer_login", "RHS"."customer_password" AS "customer_password" FROM "mailshot_customers" AS "LHS" INNER JOIN "customers" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) WHERE ("outcome_code" = 'No Response') ORDER BY customer_name, "customer_name" NULLS LAST, "customer_phone" NULLS LAST;

/*
Gold Result:
(None, None)
('Sandra Kelley', '(677)943-4873')
*/

-- Prediction Query
SELECT T1.customer_name, T1.customer_phone FROM customers AS T1 JOIN mailshot_customers AS T2 ON T1.customer_id = T2.customer_id WHERE T2.outcome_code = 'No Response';

/*
Prediction Result:
('Sandra Kelley', '(677)943-4873')
(None, None)
*/