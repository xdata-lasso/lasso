-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(50), "customer_middle_initial" TEXT(1), "customer_last_name" TEXT(50), "gender" TEXT(1), "email_address" TEXT(255), "login_name" TEXT(80), "login_password" TEXT(20), "phone_number" TEXT(255), "town_city" TEXT(50), "state_county_province" TEXT(50), "country" TEXT(50));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_order_placed" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_number" INTEGER PRIMARY KEY, "order_id" INTEGER, "invoice_date" DATETIME, FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_account_opened" DATETIME, "account_name" TEXT(50), "other_account_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Product_Categories" ("production_type_code" TEXT(15) PRIMARY KEY, "product_type_description" TEXT(80), "vat_rating" REAL(19, 4));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "production_type_code" TEXT(15), "parent_product_id" INTEGER, "unit_price" REAL(19, 4), "product_name" TEXT(80), "product_color" TEXT(20), "product_size" TEXT(20), FOREIGN KEY ("production_type_code") REFERENCES "Product_Categories" ("production_type_code"));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "invoice_number" INTEGER, "transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL(19, 4), "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "order_id" INTEGER, "product_id" INTEGER, "product_quantity" TEXT(50), "other_order_item_details" TEXT(255), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Invoice_Line_Items" ("product_id" INTEGER, "invoice_number" INTEGER, "order_item_id" INTEGER, "product_title" TEXT(80), "product_quantity" TEXT(50), "product_price" REAL(19, 4), "derived_product_cost" REAL(19, 4), "derived_vat_payable" REAL(19, 4), "derived_total_cost" REAL(19, 4), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"), FOREIGN KEY ("order_item_id") REFERENCES "Order_Items" ("order_item_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (13, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (12, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (15, NULL, 0, '0');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (14, 13, 0, '0');
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (17, 15, 0);
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (16, 14, 0);
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (19, 12, 0, '0', '0');
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (18, 12, 0, '0', '0');
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('21', '0', 0);
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('20', '0', 0);
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (22, '21', 0, 0, '0', '0', '0');
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (18, 16, 0, '0', 0, 0, '0', '0');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (25, NULL, NULL, '0', '28');
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (24, NULL, NULL, '0', NULL);
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (22, 16, 25, '0', '0', 0, 0, 0, 0);
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (22, 17, 25, '0', '0', 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT order_id, n_distinct AS count_distinct_product_id_ FROM (SELECT order_id, other_order_item_details, COUNT(DISTINCT product_id) AS n_distinct FROM order_items GROUP BY order_id, other_order_item_details) ORDER BY order_id, count_distinct_product_id_ NULLS LAST;

/*
Gold Result:
(None, 0)
(None, 0)
*/

-- Prediction Query
SELECT order_id, COUNT(DISTINCT product_id) FROM Order_items GROUP BY order_id;

/*
Prediction Result:
(None, 0)
*/