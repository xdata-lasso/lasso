-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate card_type_code 'Credit' and 'Debit').
-- 2. Missing ORDER BY or DESC instead of ASC (inserted in reverse alphabetical order: 'Visa', 'MasterCard', 'Debit', 'Credit').
-- 3. Unnecessary INNER JOIN with Customers (card 2 has customer_id 999 which is not in Customers; card 3 has NULL customer_id).
-- 4. Unnecessary INNER JOIN with Financial_Transactions (only card 1 has a transaction).
-- 5. Querying wrong table/column (e.g., Financial_Transactions.transaction_type 'Purchase' or Customers_Cards.other_card_details).
-- 6. Unnecessary WHERE filtering on date validity (card 4 has expired/inverted dates).
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (1, 'Alice', 'Smith');
INSERT INTO Accounts (account_id, customer_id, account_name) VALUES (10, 1, 'Checking');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 1, 'Visa', '4000111122223333', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 999, 'MasterCard', '5000111122223333', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Orphan Customer');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, NULL, 'Debit', '6000111122223333', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Null Customer');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 1, 'Credit', '7000111122223333', '2022-01-01 00:00:00', '2019-01-01 00:00:00', 'Expired');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 1, 'Credit', '7000999988887777', '2021-01-01 00:00:00', '2026-01-01 00:00:00', 'Duplicate Type 1');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (6, 1, 'Debit', '6000999988887777', '2021-01-01 00:00:00', '2026-01-01 00:00:00', 'Duplicate Type 2');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 1, 100, NULL, 'Purchase', '2023-05-01 12:00:00', 150.50, 'Groceries', 'Completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM customers_cards ORDER BY card_type_code;

/*
Gold Result:
('Credit',)
('Debit',)
('MasterCard',)
('Visa',)
*/

-- Prediction Query
SELECT DISTINCT card_type_code FROM Customers_Cards;

/*
Prediction Result:
('Visa',)
('MasterCard',)
('Debit',)
('Credit',)
*/