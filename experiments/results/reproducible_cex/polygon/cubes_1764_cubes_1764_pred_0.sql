-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (16, 19, '19', '19');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (21, 19, '19', '19');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (18, '19', '19', '19', '19', '19', '19');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (17, '19', '19', '19', '19', '19', '19');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (20, 19, '19', '19', 19, 19, '19');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (19, 39, NULL, '41', 42, 43, '44');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (21, 19, 26, 27, '28', 29, 30, '31', '32');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (21, 19, 33, 34, '35', 36, 37, NULL, '38');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
(None, 2)
*/