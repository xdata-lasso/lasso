-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1016, 1017, 'James Howard', 'guy');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1023, 1024, 'Benjamin Stanley', 'spring');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1018, 1019, 'PM', 'everything', '1976-07-07', '1977-08-08', 'surface');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1025, 1026, 'figure', 'base', '1979-10-10', '1980-11-11', 'top');
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1016, 1018, 1020, 1021, 'determine', '1978-09-09', 1022.5, 'Herself law street class.', 'hear');
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1023, 1025, 1021, 1022, 'animal', '1981-01-12', 1023.5, 'Movie win her need stop peace technology.', 'participant');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_type FROM financial_transactions ORDER BY transaction_type;

/*
Gold Result:
('animal',)
('determine',)
*/

-- Prediction Query
SELECT DISTINCT transaction_type FROM Financial_Transactions;

/*
Prediction Result:
('determine',)
('animal',)
*/