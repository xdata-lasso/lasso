-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 10, 'VISA', '1111', '2020-01-01', '2025-01-01', 'D1');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 1, 'MASTERCARD', '2222', '2020-01-01', '2026-01-01', 'D2');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 1, 'AMEX', '3333', '2020-01-01', '2026-01-01', 'D3');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 1, 'AMEX', '4444', '2020-01-01', '2027-01-01', 'D4');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 1, 'AMEX', '5555', '2020-01-01', '2027-01-01', 'D5');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (6, 1, 'DISCOVER', '6666', '2021-01-01', '2026-01-01', 'D6');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (7, 99, 'JCB', '7777', '2020-01-01', '2026-01-01', 'D7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code FROM (SELECT card_type_code, date_valid_to, COUNT(*) AS n FROM (SELECT customer_id AS card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details, customer_id_other, card_type_code_other, card_number_other, date_valid_to_other, other_card_details_other FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.customer_id AS customer_id_other, RHS.card_type_code AS card_type_code_other, RHS.card_number AS card_number_other, RHS.date_valid_to AS date_valid_to_other, RHS.other_card_details AS other_card_details_other FROM customers_cards AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.card_id AND LHS.date_valid_from = RHS.date_valid_from))) GROUP BY card_type_code, date_valid_to) ORDER BY card_type_code;

/*
Gold Result:
('AMEX',)
('AMEX',)
('MASTERCARD',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY COUNT(*) DESC, card_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('AMEX',)
*/