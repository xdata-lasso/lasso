-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '123 Maple St', '555-0101', 'alice@example.com', 'VIP');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 1, 'Credit', '4560596484842.0', '2023-06-01 00:00:00', '2024-06-01 00:00:00', 'Primary');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 1, 'Debit', '4560596484842.0', '2020-01-01 00:00:00', '2025-12-31 00:00:00', 'Secondary');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 1, 'Credit', '4560596484842.0', '2020-01-01 00:00:00', '2022-12-31 00:00:00', 'Backup');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 1, 'Credit', '4560596484841.0', '2019-01-01 00:00:00', '2021-01-01 00:00:00', 'Lower bound');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 1, 'Debit', '4560596484843.0', '2021-01-01 00:00:00', '2023-01-01 00:00:00', 'Upper bound');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_valid_from, date_valid_to FROM customers_cards WHERE (card_number = 4560596484842.0) ORDER BY date_valid_from, customers_cards.card_id NULLS LAST;

/*
Gold Result:
('2020-01-01 00:00:00', '2025-12-31 00:00:00')
('2020-01-01 00:00:00', '2022-12-31 00:00:00')
('2023-06-01 00:00:00', '2024-06-01 00:00:00')
*/

-- Prediction Query
SELECT date_valid_from, date_valid_to FROM Customers_cards WHERE card_number = '4560596484842';

/*
Prediction Result:
*/