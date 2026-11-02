-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (account_name = '338' vs others), ORDER BY other_account_details ASC, and duplicate preservation (SELECT vs SELECT DISTINCT).
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (1, 101, '338', 'Zebra');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (2, 102, '338', 'Alpha');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (3, 103, '338', 'Alpha');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (4, 104, '339', 'Beta');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (5, 105, '337', 'Gamma');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (6, 338, '100', 'Delta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT other_account_details FROM accounts WHERE (account_name = 338) ORDER BY other_account_details, accounts.account_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT other_account_details FROM Accounts WHERE account_name = '338';

/*
Prediction Result:
('Zebra',)
('Alpha',)
('Alpha',)
*/