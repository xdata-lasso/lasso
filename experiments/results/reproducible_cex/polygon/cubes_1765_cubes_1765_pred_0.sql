-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (10, 1, 'Debit1', 'Debit1');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (9, 1, 'Debit1', 'Debit1');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (12, 'Debit1', 'Debit1', 'Debit1', 'Debit1', 'Debit1', 'Debit1');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (11, 'Debit1', 'Debit1', 'Debit1', 'Debit1', 'Debit1', 'Debit1');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (14, 1, 'Debit15', 'Debit1', 1, 1, 'Debit1');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (13, 18, 'Debit', 'Debit19', 20, 21, 'Debit22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "card_type_code", COUNT(*) AS "n" FROM "customers_cards" GROUP BY "card_type_code") WHERE ("card_type_code" = 'Debit') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Customers_cards WHERE card_type_code = 'Debit';

/*
Prediction Result:
(1,)
*/