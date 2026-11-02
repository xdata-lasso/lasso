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
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (20, NULL, NULL, NULL, NULL, NULL, '42', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (21, 20, NULL, NULL);
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (23, 21, NULL);
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (26, 20, NULL, NULL, NULL);
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (25, NULL, NULL, NULL, NULL);
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('28', NULL, NULL);
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('27', NULL, NULL);
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (30, '27', NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (29, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (25, 23, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (25, 23, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (32, 21, 29, NULL, NULL);
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (31, NULL, 29, NULL, NULL);
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (29, 23, 32, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, customer_first_name, customer_last_name, n AS count___ FROM (SELECT LHS.customer_id AS customer_id, LHS.n AS n, RHS.customer_first_name AS customer_first_name, RHS.customer_middle_initial AS customer_middle_initial, RHS.customer_last_name AS customer_last_name, RHS.gender AS gender, RHS.email_address AS email_address, RHS.login_name AS login_name, RHS.login_password AS login_password, RHS.phone_number AS phone_number, RHS.town_city AS town_city, RHS.state_county_province AS state_county_province, RHS.country AS country FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_id, customer_first_name NULLS LAST, customer_last_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, None, 1)
(20, None, None, 1)
*/

-- Prediction Query
SELECT T1.customer_id, T2.customer_first_name, T2.customer_last_name, COUNT(*) FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id;

/*
Prediction Result:
(20, None, None, 1)
*/