-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_phone") VALUES (1, 'B', 'Smith', '111-1111');
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_phone") VALUES (2, 'A', 'Jones', '222-2222');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (1, 1, '162');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (2, 2, '162');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name, customer_phone FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.customer_first_name AS customer_first_name, RHS.customer_last_name AS customer_last_name, RHS.customer_address AS customer_address, RHS.customer_phone AS customer_phone, RHS.customer_email AS customer_email, RHS.other_customer_details AS other_customer_details FROM accounts AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (account_name = 162) ORDER BY customer_first_name, customer_last_name NULLS LAST, customer_phone NULLS LAST;

/*
Gold Result:
('A', 'Jones', '222-2222')
('B', 'Smith', '111-1111')
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name, T2.customer_phone FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.account_name = '162';

/*
Prediction Result:
('B', 'Smith', '111-1111')
('A', 'Jones', '222-2222')
*/