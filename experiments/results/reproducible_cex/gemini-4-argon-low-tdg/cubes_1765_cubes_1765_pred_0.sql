-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set when 'Debit' cards do not exist.
-- Distinguishes GROUP BY + WHERE (returns 0 rows) from simple COUNT(*) WHERE (returns 1 row with 0).
-- Also includes 'Debit' in other columns/tables to catch column reference errors.
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'Debit', 'User');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (10, 1, 'Debit');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "other_card_details") VALUES (201, 1, 'Credit', '9999', 'Debit');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "other_card_details") VALUES (202, 1, 'Prepaid', '8888', 'Debit');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_type", "transaction_amount") VALUES (10, 201, 2001, 'Debit', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "card_type_code", COUNT(*) AS "n" FROM "customers_cards" GROUP BY "card_type_code") WHERE ("card_type_code" = 'Debit') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Customers_cards WHERE card_type_code = 'Debit';

/*
Prediction Result:
(0,)
*/