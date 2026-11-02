-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. GROUP BY card_type_code vs GROUP BY card_id, card_type_code (Credit has 5 rows, Debit has 4 rows, Prepaid has 6 rows)
-- 2. DISTINCT requirement (multiple cards of the same type)
-- 3. ORDER BY card_type_code (inserted out of alphabetical order)
-- 4. JOIN with Customers vs no JOIN (card 12 has a customer_id not present in Customers)
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (1, 'Alice', 'Smith');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name") VALUES (2, 'Bob', 'Jones');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (1, 1, 'Prepaid', '1001');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (2, 1, 'Prepaid', '1002');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (3, 1, 'Prepaid', '1003');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (4, 1, 'Prepaid', '1004');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (5, 1, 'Prepaid', '1005');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (6, 2, 'Prepaid', '1006');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (7, 1, 'Credit', '2001');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (8, 1, 'Credit', '2002');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (9, 2, 'Credit', '2003');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (10, 2, 'Credit', '2004');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (11, 2, 'Credit', '2005');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (12, 99, 'Debit', '3001');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (13, 1, 'Debit', '3002');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (14, 2, 'Debit', '3003');
INSERT INTO "Customers_Cards" ("card_id", "customer_id", "card_type_code", "card_number") VALUES (15, 2, 'Debit', '3004');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM (SELECT card_id, card_type_code, COUNT(*) AS n FROM customers_cards GROUP BY card_id, card_type_code) WHERE (n <> 5) ORDER BY card_type_code;

/*
Gold Result:
('Credit',)
('Debit',)
('Prepaid',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code HAVING COUNT(*) >= 5;

/*
Prediction Result:
('Credit',)
('Prepaid',)
*/