-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (101, 'John', 'Doe', '123 Main St', '111-2222', 'john1@example.com', 'Customer with two 162 accounts');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (102, 'John', 'Doe', '456 Oak St', '111-2222', 'john2@example.com', 'Duplicate name and phone customer');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (103, 'Jane', 'Doe', '789 Pine St', '333-4444', 'jane@example.com', 'Customer with one 162 and one 999 account');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (501, 101, '162', 'First 162 account for 101');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (502, 101, '162', 'Second 162 account for 101');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (503, 102, '162', '162 account for 102');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (504, 103, '162', '162 account for 103');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (505, 103, '999', 'Non-matching account for 103');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name, customer_phone FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.customer_first_name AS customer_first_name, RHS.customer_last_name AS customer_last_name, RHS.customer_address AS customer_address, RHS.customer_phone AS customer_phone, RHS.customer_email AS customer_email, RHS.other_customer_details AS other_customer_details FROM accounts AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (account_name = 162) ORDER BY customer_first_name, customer_last_name NULLS LAST, customer_phone NULLS LAST;

/*
Gold Result:
('Jane', 'Doe', '333-4444')
('John', 'Doe', '111-2222')
('John', 'Doe', '111-2222')
('John', 'Doe', '111-2222')
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name, T2.customer_phone FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.account_name = '162';

/*
Prediction Result:
('John', 'Doe', '111-2222')
('John', 'Doe', '111-2222')
('John', 'Doe', '111-2222')
('Jane', 'Doe', '333-4444')
*/