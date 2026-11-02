-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_phone) VALUES (1, 'Alice', 'Smith', '111-222-3333');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_phone) VALUES (2, 'Bob', 'Jones', '444-555-6666');
INSERT INTO Customers_Cards (card_id, customer_id, card_number) VALUES (1, 1, '4560596484842');
INSERT INTO Customers_Cards (card_id, customer_id, card_number) VALUES (2, 2, '4560596484842.0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name, customer_phone FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_first_name AS customer_first_name, LHS.customer_last_name AS customer_last_name, LHS.customer_address AS customer_address, LHS.customer_phone AS customer_phone, LHS.customer_email AS customer_email, LHS.other_customer_details AS other_customer_details, RHS.card_id AS card_id, RHS.card_type_code AS card_type_code, RHS.card_number AS card_number, RHS.date_valid_from AS date_valid_from, RHS.date_valid_to AS date_valid_to, RHS.other_card_details AS other_card_details FROM customers AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (card_number = 4560596484842.0) ORDER BY customer_first_name, customer_last_name NULLS LAST, customer_phone NULLS LAST;

/*
Gold Result:
('Bob', 'Jones', '444-555-6666')
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name, T2.customer_phone FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.card_number = '4560596484842';

/*
Prediction Result:
('Alice', 'Smith', '111-222-3333')
*/