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
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (1, 'John', 'Doe');
INSERT INTO Orders (order_id, customer_id, date_order_placed) VALUES (1, 1, '2023-01-01 10:00:00');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (1, 1, '2023-01-02 10:00:00');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name) VALUES (1, 1, '2023-01-01 09:00:00', 'Main Account');
-- Group 1: Payment, Details_A -> SUM = 100.50 + 100.50 + 50.00 = 251.00 (Tests SUM(DISTINCT), AVG, MAX, MIN, COUNT)
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 1, 'Payment', '2023-01-03 10:00:00', 100.50, 'Comment1', 'Details_A');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 2, 'Payment', '2023-01-04 10:00:00', 100.50, 'Comment1', 'Details_A');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 3, 'Payment', '2023-01-05 10:00:00', 50.00, 'Comment2', 'Details_A');
-- Group 2: Payment, Details_B -> SUM = 251.00 (Same transaction_type and same sum as Group 1! Tests SELECT DISTINCT in outer query)
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 4, 'Payment', '2023-01-06 10:00:00', 251.00, 'Comment1', 'Details_B');
-- Group 3: Payment, Details_C -> SUM = 10.00 (Same transaction_type, lower sum. Tests secondary ORDER BY sum_transaction_amount_ ASC vs DESC)
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 5, 'Payment', '2023-01-07 10:00:00', 10.00, 'Comment3', 'Details_C');
-- Group 4: Refund, Details_A -> SUM = 500.00 (Same other_transaction_details as Group 1, different transaction_type. Tests GROUP BY columns and primary ORDER BY)
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 1, 6, 'Refund', '2023-01-08 10:00:00', 500.00, 'Comment1', 'Details_A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type, sumtransaction_amount AS sum_transaction_amount_ FROM (SELECT other_transaction_details, transaction_type, SUM(transaction_amount) AS sumtransaction_amount FROM financial_transactions GROUP BY other_transaction_details, transaction_type) ORDER BY transaction_type, sum_transaction_amount_ NULLS LAST;

/*
Gold Result:
('Payment', 10.0)
('Payment', 251.0)
('Payment', 251.0)
('Refund', 500.0)
*/

-- Prediction Query
SELECT transaction_type, SUM(transaction_amount) FROM Financial_transactions GROUP BY transaction_type;

/*
Prediction Result:
('Payment', 512.0)
('Refund', 500.0)
*/