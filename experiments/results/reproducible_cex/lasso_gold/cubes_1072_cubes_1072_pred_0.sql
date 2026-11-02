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
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1025, 'Kimberly', 'drop', 'Underwood', 'support', 'richard13@example.net', 'Emily Rios', 'individual', '+1-772-542-3884x9696', 'New Trevor', 'Wisconsin', 'Australia');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1026, 1025, '1983-03-14', 'Brittany Moore', 'building');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1027, 1025, '1983-03-15', 'Linda Cruz', 'rest');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1028, 1025, '1983-03-16', 'Julie King', 'value');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1029, 1025, '1983-03-17', 'Terri Frazier', 'not');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1033, 1025, '1987-07-18', 'social');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1034, 1033, '1988-08-19');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1035, 1033, '1988-08-20');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1036, 1033, '1988-08-21');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1037, 1033, '1988-08-22');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1026, 1034, 1041, 'example', '1992-01-23', 1045.5, 'Fall citizen about reveal.', 'effect');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1026, 1034, 1048.0, 'specific', '1992-01-24', 1058.5, 'Will seven medical blood personal.', 'unit');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1026, 1034, 1055.0, 'put', '1992-01-25', 1071.5, 'Participant check several much single morning a.', 'our');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1026, 1034, 1062.0, 'grow', '1992-01-26', 1084.5, 'Major born guy world southern dream.', 'your');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1026, 1034, 1049, 'example', '1992-01-23', 1045.5, 'Fall citizen about reveal.', 'effect');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, account_name FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.date_account_opened AS date_account_opened, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.n AS n FROM accounts AS LHS INNER JOIN (SELECT * FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) WHERE (n = 4)) AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_id, account_name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.account_id, T2.account_name FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id HAVING COUNT(*) >= 4;

/*
Prediction Result:
(1026, 'Brittany Moore')
*/