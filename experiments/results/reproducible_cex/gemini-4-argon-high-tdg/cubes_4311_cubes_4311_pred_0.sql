-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (30, 'Zack', 'Taylor', '30 West St', '555-0030', 'zack@example.com', NULL);
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (10, 'Aaron', 'Baker', '10 East St', '555-0010', 'aaron@example.com', NULL);
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (20, 'Mary', 'Clark', '20 North St', '555-0020', 'mary@example.com', NULL);
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (1, 30, 'Acct A', 'First');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (2, 30, 'Acct B', 'Second');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (3, 10, 'Acct C', 'Third');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (4, 10, 'Acct D', 'Fourth');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (5, 20, 'Acct E', 'Fifth');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, n AS count___ FROM (SELECT LHS.n AS n, RHS.customer_id AS customer_id, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id)) AS LHS CROSS JOIN (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS RHS) WHERE (n <= n_other) ORDER BY customer_id, count___ NULLS LAST;

/*
Gold Result:
(10, 2)
(30, 2)
*/

-- Prediction Query
SELECT customer_id, COUNT(*) FROM Accounts GROUP BY customer_id ORDER BY COUNT(*) DESC, customer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10, 2)
*/