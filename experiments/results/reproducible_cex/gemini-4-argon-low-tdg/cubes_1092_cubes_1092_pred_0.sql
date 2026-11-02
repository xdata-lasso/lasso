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
-- 1. Customers with 0 accounts (catches LEFT JOIN from Customers vs querying Accounts).
-- 2. Customers with multiple accounts (catches missing GROUP BY or COUNT(DISTINCT customer_id)).
-- 3. Accounts with NULL customer_id (catches COUNT(customer_id) vs COUNT(*), INNER JOIN Customers vs no join, and NULLS LAST in ORDER BY).
-- 4. Accounts with NULL non-PK attributes (catches COUNT(account_name), COUNT(date_account_opened), etc.).
-- 5. Tie-breaking in ORDER BY (same count___, different customer_id including NULL).
-- 6. Inversely correlated customer_id and count___ (catches ORDER BY customer_id, count___ vs ORDER BY count___, customer_id).
-- 7. Confounder rows in Orders and Financial_Transactions (catches querying wrong table or ungrouped joins).
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'Alice', 'Smith');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (2, 'Bob', 'Jones');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (3, 'Charlie', 'Brown');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (4, 'Diana', 'Prince');
-- Customer 3 has 1 account (with NULL non-key columns)
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (101, 3, NULL, NULL, NULL);
-- Customer 2 has 1 account (ties with Customer 3 on count=1, tests secondary sort on customer_id)
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (102, 2, '2023-01-01', 'Checking', 'Details');
-- NULL customer_id has 1 account (ties with Customer 2 and 3 on count=1, tests NULLS LAST and COUNT(*) vs COUNT(customer_id))
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (103, NULL, '2023-01-02', 'Anonymous', 'Details');
-- Customer 1 has 3 accounts (higher count with lower customer_id=1 to test primary sort on count___ vs customer_id)
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (104, 1, '2023-01-03', 'Savings', 'Details');
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (105, 1, '2023-01-04', 'Savings', 'Details');
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (106, 1, NULL, NULL, NULL);
-- Confounders in Orders (Customer 4 has orders but 0 accounts; Customer 2 has 2 orders vs 1 account)
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed") VALUES (201, 4, '2023-02-01');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed") VALUES (202, 2, '2023-02-02');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed") VALUES (203, 2, '2023-02-03');
-- Confounders in Invoices & Financial_Transactions (Account 102 has multiple transactions)
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (301, 202, '2023-02-05');
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_amount") VALUES (102, 301, 401, 50.0);
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_amount") VALUES (102, 301, 402, 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, customer_id FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) ORDER BY count___, customer_id NULLS LAST;

/*
Gold Result:
(1, 2)
(1, 3)
(1, None)
(3, 1)
*/

-- Prediction Query
SELECT COUNT(*), customer_id FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(1, None)
(3, 1)
(1, 2)
(1, 3)
*/