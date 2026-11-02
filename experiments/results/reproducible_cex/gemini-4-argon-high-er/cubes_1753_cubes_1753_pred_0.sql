-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Accounts (account_id) VALUES (1);
INSERT INTO Customers_Cards (card_id) VALUES (1);
INSERT INTO Financial_Transactions (account_id, card_id, transaction_id, transaction_type, transaction_amount) VALUES (1, 1, 2, 'PURCHASE', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type FROM (SELECT transaction_id, previous_transaction_id, card_id AS account_id, card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT transaction_id, previous_transaction_id, account_id, transaction_id AS card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.previous_transaction_id AS previous_transaction_id, LHS.account_id AS account_id, LHS.card_id AS card_id, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, RHS.transaction_id AS transaction_id_other, RHS.previous_transaction_id AS previous_transaction_id_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM financial_transactions AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.transaction_id = RHS.card_id AND LHS.card_id = RHS.account_id)))) ORDER BY transaction_type;

/*
Gold Result:
*/

-- Prediction Query
SELECT transaction_type FROM Financial_transactions GROUP BY transaction_type ORDER BY SUM(transaction_amount) DESC, transaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('PURCHASE',)
*/