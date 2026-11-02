-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1, -55602865, 'acc_cebcf7', 'acc_f54433');

-- Inserting into table: customers_cards --
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1, 1, 'lhs_a4204e', 'lhs_ab55a9', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_996c46');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (-2147483647, 1, 'lhs_711979', 'lhs_3dfc25', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_3150ab');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (3, 1, 'lhs_a4204e', 'lhs_ab55a9', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_996c46');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (2, -59984348, 'cus_a1d01c', 'cus_6b9283', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'cus_3972f8');

-- Inserting into table: financial_transactions --
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_ced5fc', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2f8b96', 'rhs_56a72d');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 2, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 2, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 2, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 2, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_ced5fc', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2f8b96', 'rhs_56a72d');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_ced5fc', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2f8b96', 'rhs_56a72d');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_ced5fc', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2f8b96', 'rhs_56a72d');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_ced5fc', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2f8b96', 'rhs_56a72d');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', NULL, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, NULL, '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', NULL, 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, NULL, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', NULL);

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, NULL, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'rhs_d358ad', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_bf24c3', 'rhs_94828e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
('cus_a1d01c', 4)
('lhs_a4204e', 5)
('lhs_a4204e', 23)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
('cus_a1d01c', 4)
('lhs_a4204e', 28)
*/