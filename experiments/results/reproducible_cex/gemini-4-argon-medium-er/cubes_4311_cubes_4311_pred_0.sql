-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (1, 10, 'Acc1', 'Details1');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (2, 20, 'Acc2', 'Details2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, n AS count___ FROM (SELECT LHS.n AS n, RHS.customer_id AS customer_id, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id)) AS LHS CROSS JOIN (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS RHS) WHERE (n <= n_other) ORDER BY customer_id, count___ NULLS LAST;

/*
Gold Result:
(10, 1)
(20, 1)
*/

-- Prediction Query
SELECT customer_id, COUNT(*) FROM Accounts GROUP BY customer_id ORDER BY COUNT(*) DESC, customer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10, 1)
*/