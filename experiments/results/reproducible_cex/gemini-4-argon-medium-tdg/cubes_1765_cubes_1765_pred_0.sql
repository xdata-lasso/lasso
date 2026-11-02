-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set vs 0 count when 'Debit' is absent (GROUP BY + WHERE returns 0 rows, whereas COUNT(*) WHERE without GROUP BY returns 1 row with 0).
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (1, 'Alice', 'Brown', '789 Pine St', '555-0300', 'alice@example.com', NULL);
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (201, 1, 'Credit', '1111222233339999', '2021-01-01 00:00:00', '2025-01-01 00:00:00', 'Only Credit');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (202, 1, 'Prepaid', '2222333344440000', '2021-01-01 00:00:00', '2025-01-01 00:00:00', 'Only Prepaid');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (203, 1, NULL, '3333444455551111', '2021-01-01 00:00:00', '2025-01-01 00:00:00', 'Null Card Type');
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