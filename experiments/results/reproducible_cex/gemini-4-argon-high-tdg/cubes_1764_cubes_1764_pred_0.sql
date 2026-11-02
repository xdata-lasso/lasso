-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '100 Main St', '555-0101', 'alice@example.com', 'Regular');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Bob', 'Jones', '200 Oak Ave', '555-0102', 'bob@example.com', 'VIP');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (10, 1, 'Alice Checking', 'Active');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (20, 2, 'Bob Savings', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (101, 1, 'Visa', '4000111122223333', '2022-01-01 00:00:00', '2026-01-01 00:00:00', 'Personal');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (102, 1, 'Debit', '5000111122223333', '2022-01-01 00:00:00', '2026-01-01 00:00:00', 'Checking Card');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (103, 1, 'Credit', '6000111122223333', '2022-01-01 00:00:00', '2026-01-01 00:00:00', 'Rewards');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (104, 2, 'Credit', '6000999988887777', '2022-06-01 00:00:00', '2026-06-01 00:00:00', 'Business');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (105, 2, 'Prepaid', '7000111122223333', '2023-01-01 00:00:00', '2025-01-01 00:00:00', 'Unused Card');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 103, 1001, NULL, 'PURCHASE', '2023-03-01 10:00:00', 50.00, 'Purchase', 'Store A');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 103, 1002, 1001, 'PURCHASE', '2023-03-02 11:00:00', 75.00, 'Purchase', 'Store B');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 104, 1003, 1002, 'PURCHASE', '2023-03-03 12:00:00', 120.00, 'Purchase', 'Store C');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 103, 1004, 1003, 'REFUND', '2023-03-04 13:00:00', 25.00, 'Refund', 'Store A');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 104, 1005, 1004, 'REWARD', '2023-03-05 14:00:00', 10.00, 'Bonus', 'Promo');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 101, 1006, 1005, 'PAYMENT', '2023-03-06 15:00:00', 200.00, 'Bill Pay', 'Utility');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 102, 1007, 1006, 'WITHDRAWAL', '2023-03-07 16:00:00', 40.00, 'ATM', 'Cash');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 102, 1008, 1007, 'WITHDRAWAL', '2023-03-08 17:00:00', 60.00, 'ATM', 'Cash');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
('Credit', 1)
('Credit', 1)
('Credit', 3)
('Debit', 2)
('Visa', 1)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
('Credit', 5)
('Debit', 2)
('Visa', 1)
*/