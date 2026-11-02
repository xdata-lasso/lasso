-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (1, 'Alice', 'Smith', '123 Main St', '555-0101', 'alice@example.com', 'Regular');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Bob', 'Jones', '456 Oak Ave', '555-0102', 'bob@example.com', 'VIP');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (1, 1, 'Visa', '4000111122223331', '2020-01-01', '2025-01-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (2, 1, 'Visa', '4000111122223332', '2020-02-01', '2025-02-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (3, 2, 'Visa', '4000111122223333', '2020-03-01', '2025-03-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (4, 2, 'Visa', '4000111122223334', '2020-04-01', '2025-04-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (5, 1, 'Visa', '4000111122223335', '2020-05-01', '2025-05-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (6, 1, 'Amex', '3000111122223331', '2021-01-01', '2026-01-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (7, 2, 'Amex', '3000111122223332', '2021-02-01', '2026-02-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (8, 1, 'Debit', '5000111122223331', '2019-01-01', '2024-01-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (9, 1, 'Debit', '5000111122223332', '2019-02-01', '2024-02-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (10, 2, 'Debit', '5000111122223333', '2019-03-01', '2024-03-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (11, 2, 'Debit', '5000111122223334', '2019-04-01', '2024-04-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (12, 1, 'Debit', '5000111122223335', '2019-05-01', '2024-05-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (13, 2, 'Debit', '5000111122223336', '2019-06-01', '2024-06-01', 'Active');
INSERT INTO Customers_Cards (card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details) VALUES (14, 1, 'MasterCard', '6000111122223331', '2022-01-01', '2027-01-01', 'Active');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM (SELECT card_id, card_type_code, COUNT(*) AS n FROM customers_cards GROUP BY card_id, card_type_code) WHERE (n <> 5) ORDER BY card_type_code;

/*
Gold Result:
('Amex',)
('Debit',)
('MasterCard',)
('Visa',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Debit',)
('Visa',)
*/