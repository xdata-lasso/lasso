-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SQLite type affinity (TEXT column compared with REAL literal 4560596484842.0), filtering out non-matching rows, and basic ORDER BY date_valid_from.
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 101, 'VISA', '4560596484842.0', '2022-05-01', '2025-05-01', 'Exact string match');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 102, 'MC', '4560596484842', '2020-01-01', '2023-01-01', 'Integer string without .0');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 103, 'AMEX', '9999999999999.0', '2021-01-01', '2024-01-01', 'Different card number');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 104, 'VISA', '4560596484842.0', '2019-06-15', '2022-06-15', 'Earlier valid_from match');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_valid_from, date_valid_to FROM customers_cards WHERE (card_number = 4560596484842.0) ORDER BY date_valid_from, customers_cards.card_id NULLS LAST;

/*
Gold Result:
('2019-06-15', '2022-06-15')
('2022-05-01', '2025-05-01')
*/

-- Prediction Query
SELECT date_valid_from, date_valid_to FROM Customers_cards WHERE card_number = '4560596484842';

/*
Prediction Result:
('2020-01-01', '2023-01-01')
*/