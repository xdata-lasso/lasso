-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Charlie', 'Brown', '789 Pine Rd', '555-0103', 'charlie@example.com', 'Standard');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (10, 1, 'Primary Checking', 'No transactions');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (100, 1, 'DEBIT', '4111222233334444', '2023-01-01 00:00:00', '2027-01-01 00:00:00', 'New Card');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(transaction_amount) OVER () AS avg_transaction_amount_, sumtransaction_amount AS sum_transaction_amount_ FROM (SELECT transaction_id, previous_transaction_id, account_id, card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, SUM(transaction_amount) OVER () AS sumtransaction_amount FROM financial_transactions) ORDER BY avg_transaction_amount_, sum_transaction_amount_ NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(transaction_amount), SUM(transaction_amount) FROM Financial_transactions;

/*
Prediction Result:
(None, None)
*/