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
-- DATASET 1
-- Tests:
-- 1. INNER JOIN vs LEFT/RIGHT JOIN (Account 3 has 0 transactions; should be excluded).
-- 2. GROUP BY account_id vs GROUP BY account_name (Accounts 1 and 2 share 'SharedName').
-- 3. ORDER BY account_name, account_id tie-breaking (Account 2 has ID 2, Account 1 has ID 1, both 'SharedName', inverted counts).
-- 4. COUNT(*) vs COUNT(column) vs COUNT(DISTINCT column) (Account 1 has NULLs and duplicate values across transaction columns).
-- 5. Unassociated NULL account_id in Financial_Transactions (should be excluded by INNER JOIN).
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (1, 'Alice');
INSERT INTO "Orders" ("order_id", "customer_id") VALUES (1, 1);
INSERT INTO "Invoices" ("invoice_number", "order_id") VALUES (1, 1);
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (1, 1, 'SharedName');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (2, 1, 'SharedName');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (3, 1, 'NoTxAccount');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (4, 1, 'AlphaAccount');
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (1, 1, 10, 'Pay', 50.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (1, 1, 10, 'Pay', 50.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (1, NULL, NULL, NULL, NULL);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (2, 1, 20, 'Refund', 100.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (4, 1, 30, 'Pay', 25.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (4, 1, 31, 'Pay', 75.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_amount") VALUES (NULL, 1, 40, 'Pay', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_name, account_id, n AS count___ FROM (SELECT LHS.account_id AS account_id, LHS.n AS n, RHS.customer_id AS customer_id, RHS.date_account_opened AS date_account_opened, RHS.account_name AS account_name, RHS.other_account_details AS other_account_details FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) AS LHS INNER JOIN accounts AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_name, account_id NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('AlphaAccount', 4, 2)
('SharedName', 1, 3)
('SharedName', 2, 1)
*/

-- Prediction Query
SELECT T2.account_name, T1.account_id, COUNT(*) FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id;

/*
Prediction Result:
('SharedName', 1, 3)
('SharedName', 2, 1)
('AlphaAccount', 4, 2)
*/