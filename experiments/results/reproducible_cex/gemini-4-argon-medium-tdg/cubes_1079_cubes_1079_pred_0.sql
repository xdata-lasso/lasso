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
-- DATASET 2
-- Tests:
-- 1. Handling of NULL account_name in Accounts and ORDER BY NULLS FIRST vs NULLS LAST on account_name.
-- 2. Tie-breaking on account_id when account_name is NULL (Account 10 vs Account 20, with inverse transaction counts).
-- 3. Account vs Customer ID confusion (account_id != customer_id).
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (100, 'Bob');
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (200, 'Charlie');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (10, 200, NULL);
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (20, 100, NULL);
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (30, 100, 'Zeta');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (40, 200, 'Aardvark');
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (10, 1, 10.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (10, 2, 20.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (20, 3, 30.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (30, 4, 40.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (30, 5, 50.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (30, 6, 60.0);
INSERT INTO "Financial_Transactions" ("account_id", "transaction_id", "transaction_amount") VALUES (40, 7, 70.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_name, account_id, n AS count___ FROM (SELECT LHS.account_id AS account_id, LHS.n AS n, RHS.customer_id AS customer_id, RHS.date_account_opened AS date_account_opened, RHS.account_name AS account_name, RHS.other_account_details AS other_account_details FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) AS LHS INNER JOIN accounts AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_name, account_id NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, 10, 2)
(None, 20, 1)
('Aardvark', 40, 1)
('Zeta', 30, 3)
*/

-- Prediction Query
SELECT T2.account_name, T1.account_id, COUNT(*) FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id;

/*
Prediction Result:
(None, 10, 2)
(None, 20, 1)
('Zeta', 30, 3)
('Aardvark', 40, 1)
*/