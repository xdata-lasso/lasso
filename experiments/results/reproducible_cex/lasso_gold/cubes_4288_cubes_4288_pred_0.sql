-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1013, 1014, 'knowledge', 'almost', '1982-02-13', '1983-03-14', 'all');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1015, 1016, 'knowledge', 'better', '1984-04-15', '1985-05-16', 'discover');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1017, 1018, 'early', 'mouth', '1986-06-17', '1987-07-18', 'play');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1019, 1020, 'agreement', 'option', '1988-08-19', '1989-09-20', 'decide');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1021, 1022, 'agreement', 'sense', '1990-10-21', '1991-11-22', 'rate');
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1023, 1024, 'science', 'offer', '1992-01-23', '1993-02-01', 'kind');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT card_type_code FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, LHS.n AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.n AS n FROM customers_cards AS LHS INNER JOIN (SELECT card_type_code, COUNT(*) AS n FROM customers_cards GROUP BY card_type_code) AS RHS ON (LHS.card_type_code = RHS.card_type_code)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT card_type_code, COUNT(*) AS n FROM customers_cards GROUP BY card_type_code)) AS RHS ON (LHS.n = RHS.n)) ORDER BY card_type_code;

/*
Gold Result:
('agreement',)
('knowledge',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY COUNT(*) DESC, card_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('agreement',)
*/