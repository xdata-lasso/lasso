-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping by (card_id, card_type_code) vs grouping by (card_type_code) alone: 'Debit' has 5 rows (each with n=1 due to PK card_id).
-- 2. Grouping by (customer_id, card_type_code): 'Credit' has 5 rows for the same customer_id (100).
-- 3. Joining with Financial_Transactions: card_id 11 ('Prepaid') has 5 transactions.
-- 4. DISTINCT keyword: multiple rows per card_type_code.
-- 5. ORDER BY card_type_code: inserted out of alphabetical order ('Prepaid', 'Debit', 'Credit').
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (100, 'John', 'Doe');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (101, 'Jane', 'Smith');
INSERT INTO Accounts (account_id, customer_id, account_name) VALUES (1, 100, 'Checking');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (11, 101, 'Prepaid', '1111', '2020-01-01', '2025-01-01', 'Details');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 100, 'Debit', '2221', '2020-01-01', '2025-01-01', NULL);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 101, 'Debit', '2222', '2020-01-01', '2025-01-01', NULL);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 100, 'Debit', '2223', '2020-01-01', '2025-01-01', NULL);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 101, 'Debit', '2224', '2020-01-01', '2025-01-01', NULL);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 100, 'Debit', '2225', '2020-01-01', '2025-01-01', NULL);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (6, 100, 'Credit', '3331', '2020-01-01', '2025-01-01', 'A');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (7, 100, 'Credit', '3332', '2020-01-01', '2025-01-01', 'B');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (8, 100, 'Credit', '3333', '2020-01-01', '2025-01-01', 'C');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (9, 100, 'Credit', '3334', '2020-01-01', '2025-01-01', 'D');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (10, 100, 'Credit', '3335', '2020-01-01', '2025-01-01', 'E');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount) VALUES (1, 11, 1001, NULL, 'Purchase', '2021-01-01', 10.0);
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount) VALUES (1, 11, 1002, 1001, 'Purchase', '2021-01-02', 20.0);
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount) VALUES (1, 11, 1003, 1002, 'Purchase', '2021-01-03', 30.0);
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount) VALUES (1, 11, 1004, 1003, 'Purchase', '2021-01-04', 40.0);
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount) VALUES (1, 11, 1005, 1004, 'Purchase', '2021-01-05', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM (SELECT card_id, card_type_code, COUNT(*) AS n FROM customers_cards GROUP BY card_id, card_type_code) WHERE (n <> 5) ORDER BY card_type_code;

/*
Gold Result:
('Credit',)
('Debit',)
('Prepaid',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Credit',)
('Debit',)
*/