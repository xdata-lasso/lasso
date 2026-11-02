-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Ties for maximum account count (3 accounts each for customers 30 and 10),
-- inserted in reverse order of customer_id to test ORDER BY customer_id ASC,
-- plus a customer with fewer accounts (customer 20 with 1 account),
-- and a customer in Customers table with 0 accounts (to test unnecessary INNER JOIN / LEFT JOIN mutants).
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (10, 'Alice', 'Smith');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (20, 'Bob', 'Jones');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (30, 'Charlie', 'Brown');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (40, 'David', 'White');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1, 30, 'Checking', 'Active');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (2, 30, 'Savings', NULL);
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (3, 30, NULL, 'Joint');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (4, 10, 'Checking', 'Active');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (5, 10, 'Checking', 'Active');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (6, 10, 'Savings', 'Active');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (7, 20, 'Checking', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, n AS count___ FROM (SELECT LHS.n AS n, RHS.customer_id AS customer_id, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id)) AS LHS CROSS JOIN (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS RHS) WHERE (n <= n_other) ORDER BY customer_id, count___ NULLS LAST;

/*
Gold Result:
(10, 3)
(30, 3)
*/

-- Prediction Query
SELECT customer_id, COUNT(*) FROM Accounts GROUP BY customer_id ORDER BY COUNT(*) DESC, customer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10, 3)
*/