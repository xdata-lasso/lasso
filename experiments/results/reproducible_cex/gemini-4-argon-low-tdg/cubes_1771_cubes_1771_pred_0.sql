-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join, ordering, duplicate customer names (DISTINCT vs ALL), and decoy tables (Customers_Cards, Financial_Transactions).
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'Charlie', 'Brown');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (2, 'Alice', 'Smith');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (3, 'Alice', 'Smith');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (4, 'Alice', 'Adams');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (5, 'Bob', 'Jones');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (6, 'David', 'Wilson');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (1, 1, 'Checking');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (2, 1, 'Savings');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (6, 6, 'Investment');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code") VALUES (10, 2, 'VISA');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code") VALUES (20, 1, 'MC');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_amount") VALUES (1, 20, 100, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM accounts AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_first_name, customer_last_name NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Smith')
('Alice', 'Smith')
('Bob', 'Jones')
*/

-- Prediction Query
SELECT customer_first_name, customer_last_name FROM Customers EXCEPT SELECT T1.customer_first_name, T1.customer_last_name FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
('Alice', 'Adams')
('Alice', 'Smith')
('Bob', 'Jones')
*/