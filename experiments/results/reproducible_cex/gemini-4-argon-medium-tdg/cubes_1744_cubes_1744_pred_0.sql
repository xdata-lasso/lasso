-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Grouping and counting with NULL values in `other_customer_details` (catches `COUNT(other_customer_details)` vs `COUNT(*)`).
-- 2. Duplicate counts across different groups (catches `SELECT DISTINCT` mutations).
-- 3. Ordering by count vs ordering by the grouped text column (alphabetical order 'A_detail', 'B_detail', 'C_detail' has inverse counts 3, 2, 1).
-- 4. Duplicate values in other columns like `customer_first_name` or `customer_last_name` (catches grouping by wrong columns or `COUNT(DISTINCT col)`).
-- 5. Unreferenced customers and customers with multiple accounts/cards (catches erroneous INNER JOINs with Accounts or Customers_Cards).
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'John', 'Smith', '123 Main St', '555-0101', 'john1@example.com', 'A_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'John', 'Smith', '123 Main St', '555-0101', 'john2@example.com', 'A_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (3, 'Alice', 'Jones', '456 Oak Ave', '555-0102', NULL, 'A_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (4, 'Bob', 'Brown', NULL, '555-0103', 'bob@example.com', 'B_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (5, 'Charlie', 'Davis', '789 Pine Rd', NULL, 'charlie@example.com', 'B_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (6, 'John', 'Smith', '321 Elm St', '555-0104', 'john3@example.com', 'C_detail');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (7, 'Eve', 'White', '654 Maple Dr', '555-0105', 'eve1@example.com', NULL);
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (8, 'Frank', 'Green', '987 Cedar Ln', '555-0106', 'frank@example.com', NULL);
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (101, 1, 'Checking', 'A_detail');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (102, 1, 'Savings', 'B_detail');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (201, 1, 'VISA', '1111222233334444', '2020-01-01', '2025-01-01', 'A_detail');
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