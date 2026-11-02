-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '100 Main St', '555-0101', 'alice1@example.com', 'A_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Alice', 'Jones', '200 Main St', '555-0102', 'alice2@example.com', 'A_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (3, 'Bob', 'Smith', '100 Main St', '555-0103', 'bob1@example.com', 'A_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (4, 'Charlie', 'Brown', '300 Oak Ave', '555-0104', 'charlie@example.com', 'B_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (5, 'David', 'Wilson', '400 Pine Rd', '555-0105', 'david@example.com', 'C_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (6, 'Eva', 'Wilson', '400 Pine Rd', '555-0106', 'eva@example.com', 'C_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (7, 'Frank', 'Miller', '500 Elm St', '555-0107', 'frank@example.com', 'D_Tier');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (8, 'Grace', 'Davis', '600 Birch Ln', '555-0108', 'grace@example.com', 'D_Tier');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (101, 1, 'Checking', 'Active');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (102, 1, 'Savings', 'Active');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (103, 4, 'Checking', 'Closed');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (201, 1, 'Debit', '4000111122223333', '2020-01-01', '2025-01-01', 'Standard');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (202, 2, 'Credit', '5000111122223333', '2021-01-01', '2026-01-01', 'Gold');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (101, 201, 301, NULL, 'Purchase', '2023-05-10', 50.25, 'Grocery', 'Completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT other_customer_details, COUNT(*) AS n FROM customers GROUP BY other_customer_details) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Customers;

/*
Prediction Result:
(8,)
*/