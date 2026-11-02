-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (30, 'Aniyah', 'Feest', '501 Birch Ln', '555-0300', 'middle_email@example.com', 'Third by phone');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (20, 'Aniyah', 'Feest', '502 Birch Ln', '555-0100', 'a_second_by_id@example.com', 'Tied phone higher ID');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (5, 'Aniyah', 'Feest', '503 Birch Ln', '555-0100', 'z_first_by_id@example.com', 'Tied phone lower ID');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (10, 'Aniyah', 'Feest', '504 Birch Ln', NULL, 'null_phone_1@example.com', 'Null phone lower ID');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_address, customer_phone, customer_email, other_customer_details) VALUES (2, 'Aniyah', 'Feest', '505 Birch Ln', NULL, 'null_phone_2@example.com', 'Null phone lowest ID');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_phone", "customer_email" FROM "customers" WHERE ("customer_first_name" = 'Aniyah' AND "customer_last_name" = 'Feest') ORDER BY customer_phone, customers.customer_id NULLS LAST;

/*
Gold Result:
(None, 'null_phone_2@example.com')
(None, 'null_phone_1@example.com')
('555-0100', 'z_first_by_id@example.com')
('555-0100', 'a_second_by_id@example.com')
('555-0300', 'middle_email@example.com')
*/

-- Prediction Query
SELECT customer_phone, customer_email FROM Customers WHERE customer_first_name = 'Aniyah' AND customer_last_name = 'Feest';

/*
Prediction Result:
(None, 'null_phone_2@example.com')
('555-0100', 'z_first_by_id@example.com')
(None, 'null_phone_1@example.com')
('555-0100', 'a_second_by_id@example.com')
('555-0300', 'middle_email@example.com')
*/