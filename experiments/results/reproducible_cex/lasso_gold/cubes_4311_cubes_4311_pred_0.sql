-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1001, 1004, 'Allison Hill', 'all');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1002, 1004, 'Noah Rhodes', 'better');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1003, 1004, 'Angie Henderson', 'discover');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1005, 1008, 'Lance Hoffman', 'song');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1006, 1008, 'Meredith Barnes', 'sure');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1007, 1008, 'Donald Booth', 'collection');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, n AS count___ FROM (SELECT LHS.n AS n, RHS.customer_id AS customer_id, RHS.n AS n_other FROM (SELECT MAX(n) AS n FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id)) AS LHS CROSS JOIN (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS RHS) WHERE (n <= n_other) ORDER BY customer_id, count___ NULLS LAST;

/*
Gold Result:
(1004, 3)
(1008, 3)
*/

-- Prediction Query
SELECT customer_id, COUNT(*) FROM Accounts GROUP BY customer_id ORDER BY COUNT(*) DESC, customer_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1004, 3)
*/