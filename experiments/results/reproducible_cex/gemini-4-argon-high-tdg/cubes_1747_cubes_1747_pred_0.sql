-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (10, 'Alice', 'Smith', '100 Main St', '555-0100', 'alice@example.com', 'VIP');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (99, 'Bob', 'Jones', '200 Oak Ave', '555-0199', 'bob@example.com', 'Standard');
INSERT INTO Accounts (account_id, customer_id, account_name, other_account_details) VALUES (100, 10, 'Checking', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (10, 99, 'RHS_BASE', '1111222233334444', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Base card');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (20, 10, 'VISA', '4000111122223331', '2020-01-01 00:00:00', '2023-06-01 00:00:00', 'Visa 1');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (21, 10, 'VISA', '4000111122223332', '2020-01-01 00:00:00', '2023-06-01 00:00:00', 'Visa 2 duplicate group');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (22, 10, 'VISA', '4000111122223333', '2020-01-01 00:00:00', '2024-06-01 00:00:00', 'Visa 3 distinct valid_to');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (23, 10, 'AMEX', '3700111122223334', '2020-01-01 00:00:00', '2025-12-31 00:00:00', 'Amex 1');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (24, 10, 'DISCOVER', '6011111122223335', '2021-05-05 00:00:00', '2025-01-01 00:00:00', 'Mismatched date_valid_from');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (25, 88, 'DINERS', '3000111122223336', '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Mismatched customer_id');
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, previous_transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (100, 20, 1001, NULL, 'PURCHASE', '2021-01-15 12:00:00', 50.25, 'Grocery', 'Completed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code FROM (SELECT card_type_code, date_valid_to, COUNT(*) AS n FROM (SELECT customer_id AS card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details, customer_id_other, card_type_code_other, card_number_other, date_valid_to_other, other_card_details_other FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.customer_id AS customer_id_other, RHS.card_type_code AS card_type_code_other, RHS.card_number AS card_number_other, RHS.date_valid_to AS date_valid_to_other, RHS.other_card_details AS other_card_details_other FROM customers_cards AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.card_id AND LHS.date_valid_from = RHS.date_valid_from))) GROUP BY card_type_code, date_valid_to) ORDER BY card_type_code;

/*
Gold Result:
('AMEX',)
('VISA',)
('VISA',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY COUNT(*) DESC, card_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('VISA',)
*/