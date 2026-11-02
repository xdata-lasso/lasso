-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1016, 1017, 'James Howard', 'guy');
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1023, 1024, 'Brian Ramirez', 'prove');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1018, 1019, 'PM', 'everything', '1976-07-07', '1977-08-08', 'surface');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1025, 1026, 'PM', 'they', '1979-10-10', '1980-11-11', 'his');
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1016, 1018, 1020, 1021, 'animal', '1978-09-09', 1022.5, 'Movie win her need stop peace technology.', 'participant');
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1023, 1025, 1027, 1028, 'commercial', '1981-01-12', 1029.5, 'Relate animal direction eye bag.', 'hospital');
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1023, 1025, 1028, 1028, 'commercial', '1981-01-12', 1029.5, 'Relate animal direction eye bag.', 'hospital');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
('PM', 1)
('PM', 2)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
('PM', 3)
*/