-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '101 Main St', '555-0101', 'alice@example.com', 'Regular');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Bob', 'Jones', '202 Oak Ave', '555-0102', 'bob@example.com', 'VIP');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (10, 1, 'Alice Checking', 'Active');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (20, 2, 'Bob Savings', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (100, 1, 'VISA', '4000111122223333', '2021-01-01 00:00:00', '2026-01-01 00:00:00', 'Primary');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (200, 2, 'MASTERCARD', '5000111122223333', '2021-06-01 00:00:00', '2026-06-01 00:00:00', 'Secondary');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 100, 1, NULL, 'Withdrawal', '2023-01-02 10:00:00', 50.0, 'ATM Withdrawal', 'Cleared');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 100, 2, 1, 'Deposit', '2023-01-03 10:00:00', 500.0, 'Payroll Deposit', 'Cleared');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 100, 3, 2, 'Transfer', '2023-01-01 10:00:00', 200.0, 'Wire Transfer', 'Cleared');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 200, 4, NULL, 'Withdrawal', '2023-01-04 10:00:00', 75.0, 'Branch Withdrawal', 'Cleared');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 200, 5, 4, 'Deposit', '2023-01-05 10:00:00', 300.0, 'Check Deposit', 'Cleared');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_type FROM financial_transactions ORDER BY transaction_type;

/*
Gold Result:
('Deposit',)
('Transfer',)
('Withdrawal',)
*/

-- Prediction Query
SELECT DISTINCT transaction_type FROM Financial_Transactions;

/*
Prediction Result:
('Withdrawal',)
('Deposit',)
('Transfer',)
*/