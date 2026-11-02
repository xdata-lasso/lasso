-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '123 Main St', '555-0101', 'alice@example.com', 'VIP');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Bob', 'Jones', '456 Oak Ave', '555-0102', 'bob@example.com', 'Regular');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (338, 'Charlie', 'Brown', '789 Pine Rd', '555-0338', 'charlie@example.com', '338');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (1, 1, '338', 'M_Detail');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (2, 1, '338', 'Z_Detail');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (3, 2, '338', NULL);
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (4, NULL, '338', 'A_Detail');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (5, 2, '338', 'A_Detail');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (6, 338, '337', 'Boundary_Low');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (7, 338, '339', 'Boundary_High');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (8, 1, NULL, 'Null_Account_Name');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (338, 1, '999', '338');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (10, 1, 'VISA', '4000111122223333', '2020-01-01', '2025-01-01', 'Primary');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 100, NULL, 'PAYMENT', '2023-05-01', 150.0, 'First', 'None');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 101, 100, 'PAYMENT', '2023-05-02', 200.0, 'Second', 'None');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (338, 10, 102, NULL, 'REFUND', '2023-05-03', 338.0, '338', '338');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_account_details FROM accounts WHERE (account_name = 338) ORDER BY other_account_details, accounts.account_id NULLS LAST;

/*
Gold Result:
(None,)
('A_Detail',)
('A_Detail',)
('M_Detail',)
('Z_Detail',)
*/

-- Prediction Query
SELECT other_account_details FROM Accounts WHERE account_name = '338';

/*
Prediction Result:
('M_Detail',)
('Z_Detail',)
(None,)
('A_Detail',)
('A_Detail',)
*/