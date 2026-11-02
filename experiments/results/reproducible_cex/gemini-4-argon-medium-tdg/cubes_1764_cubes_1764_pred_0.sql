-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic INNER JOIN, GROUP BY (card_type_code, transaction_comment), projection omission of transaction_comment, and two-level ORDER BY (card_type_code ASC, count___ ASC).
INSERT INTO Customers (customer_id, customer_first_name) VALUES (1, 'Alice');
INSERT INTO Accounts (account_id, customer_id) VALUES (10, 1);
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code) VALUES (101, 1, 'VISA');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code) VALUES (102, 1, 'VISA');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code) VALUES (103, 1, 'AMEX');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code) VALUES (104, 1, 'MASTERCARD');
-- VISA with 'Refund' (count = 1), inserted before 'Purchase' (count = 3) to test secondary sort on count___
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 102, 1001, 'Refund');
-- VISA with 'Purchase' across two different cards of the same card_type_code (count = 3)
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 101, 1002, 'Purchase');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 101, 1003, 'Purchase');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 102, 1004, 'Purchase');
-- AMEX with 'Purchase' (count = 2), inserted after VISA to test primary sort on card_type_code
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 103, 1005, 'Purchase');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_comment) VALUES (10, 103, 1006, 'Purchase');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
('AMEX', 2)
('VISA', 1)
('VISA', 3)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
('AMEX', 2)
('VISA', 4)
*/