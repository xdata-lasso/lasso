-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic DISTINCT (duplicates) and ORDER BY (out-of-order insertion, standard values)
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'John', 'Doe');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (10, 1, 'Checking');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (100, 1, 'Debit', '1111222233334444');
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_type", "transaction_amount") VALUES (10, 100, 1, 'WITHDRAWAL', 100.0);
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_type", "transaction_amount") VALUES (10, 100, 2, 'DEPOSIT', 200.0);
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_type", "transaction_amount") VALUES (10, 100, 3, 'WITHDRAWAL', 50.0);
INSERT INTO "Financial_Transactions" ("account_id", "card_id", "transaction_id", "transaction_type", "transaction_amount") VALUES (10, 100, 4, 'TRANSFER', 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_type FROM financial_transactions ORDER BY transaction_type;

/*
Gold Result:
('DEPOSIT',)
('TRANSFER',)
('WITHDRAWAL',)
*/

-- Prediction Query
SELECT DISTINCT transaction_type FROM Financial_Transactions;

/*
Prediction Result:
('WITHDRAWAL',)
('DEPOSIT',)
('TRANSFER',)
*/