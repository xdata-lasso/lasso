-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (10, 'Alice', 'Smith', '123 Maple St', '555-0101', 'alice@example.com', 'Regular');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (20, 'Bob', 'Jones', '456 Oak Ave', '555-0102', 'bob@example.com', 'VIP');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (30, 'Charlie', 'Brown', '789 Pine Rd', '555-0103', 'charlie@example.com', 'New');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (40, 'Diana', 'Prince', '321 Elm St', '555-0104', 'diana@example.com', 'Preferred');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (100, 10, 'Checking', 'Active');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (200, 20, 'Savings', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 10, 'Visa', '4000111122223333', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Primary');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 40, 'Amex', '300011112222333', '2021-06-01 00:00:00', '2026-06-01 00:00:00', 'Corporate');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 20, 'Debit', '5000111122223333', '2019-03-15 00:00:00', '2024-03-15 00:00:00', 'Daily');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 30, 'Credit', '6000111122223333', '2022-01-01 00:00:00', '2027-01-01 00:00:00', 'Rewards');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 10, 'Visa', '4000999988887777', '2021-01-01 00:00:00', '2026-01-01 00:00:00', 'Secondary');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (6, 20, 'Debit', '5000444455556666', '2020-05-01 00:00:00', '2025-05-01 00:00:00', 'Backup');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (7, 20, 'Debit', '5000777788889999', '2022-08-01 00:00:00', '2027-08-01 00:00:00', 'Travel');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (100, 1, 1001, NULL, 'Purchase', '2023-01-10 12:00:00', 150.50, 'Groceries', 'Approved');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (200, 3, 1002, 1001, 'Withdrawal', '2023-01-11 15:30:00', 60.00, 'ATM', 'Approved');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM customers_cards ORDER BY card_type_code;

/*
Gold Result:
('Amex',)
('Credit',)
('Debit',)
('Visa',)
*/

-- Prediction Query
SELECT DISTINCT card_type_code FROM Customers_Cards;

/*
Prediction Result:
('Visa',)
('Amex',)
('Debit',)
('Credit',)
*/