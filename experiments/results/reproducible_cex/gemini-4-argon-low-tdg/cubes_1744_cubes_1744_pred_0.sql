-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(*) vs COUNT(other_customer_details) via NULL group (size 2).
-- 2. COUNT(*) vs COUNT(other_columns) via NULLs in first_name, last_name, etc.
-- 3. SELECT DISTINCT mutants via duplicate count sizes (two groups of size 1: 'Vip' and 'Basic').
-- 4. ORDER BY count___ ASC vs DESC vs ORDER BY other_customer_details ('Alpha' has count 4, 'Zeta' has count 1).
-- 5. Unintended INNER JOIN / LEFT JOIN mutants with Accounts and Customers_Cards (some customers have 0 accounts/cards, some have multiple).
-- 6. Querying wrong table/column (e.g. Accounts.other_account_details or Customers_Cards.other_card_details).
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (1, 'Alice', 'Smith', '123 Maple St', '555-0101', 'alice@example.com', 'Alpha');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (2, NULL, 'Smith', '123 Maple St', '555-0102', 'bob@example.com', 'Alpha');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (3, 'Alice', NULL, NULL, NULL, NULL, 'Alpha');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (4, 'David', 'Jones', '456 Oak St', '555-0104', 'david@example.com', 'Alpha');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (5, 'Eve', 'Brown', '789 Pine St', '555-0105', 'eve@example.com', NULL);
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (6, 'Frank', 'White', '321 Elm St', '555-0106', 'frank@example.com', NULL);
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (7, 'Grace', 'Green', '654 Birch St', '555-0107', 'grace@example.com', 'Zeta');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (8, 'Heidi', 'Black', '987 Cedar St', '555-0108', 'heidi@example.com', 'Beta');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (101, 1, 'Checking', 'AccDetail1');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (102, 1, 'Savings', 'AccDetail1');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (103, 7, 'Checking', 'AccDetail2');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (201, 1, 'VISA', '1111', '2020-01-01', '2025-01-01', 'CardDetail1');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (202, 1, 'MC', '2222', '2020-01-01', '2025-01-01', 'CardDetail2');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (101, 201, 301, NULL, 'PURCHASE', '2022-05-01', 100.50, 'Grocery', 'TxDetail1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT other_customer_details, COUNT(*) AS n FROM customers GROUP BY other_customer_details) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(2,)
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Customers;

/*
Prediction Result:
(8,)
*/