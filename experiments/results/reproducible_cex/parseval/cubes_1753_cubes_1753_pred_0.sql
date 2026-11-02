-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (-2147483648, -55602865, 'acc_cebcf7', 'acc_f54433');

INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (1, -1022641847, 'acc_cebcf7', 'acc_f54433');

-- Inserting into table: customers_cards --
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (-2147483648, -59984348, 'cus_a1d01c', 'cus_6b9283', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1, -1726781632, 'cus_a1d01c', 'cus_6b9283', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'cus_3972f8');

-- Inserting into table: financial_transactions --
INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'fin_ee7bf7', '2024-06-15 00:00:00+00:00', 1.0, 'fin_906990', 'fin_a77e26');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_e75ffa', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_dfb1d8', 'lhs_afeaa7');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'rhs_8f329d', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_9b7d97', 'rhs_bbb41c');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, NULL, '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, NULL, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, NULL, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, NULL, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', NULL, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', NULL, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'fin_c2c88a', NULL, 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'rhs_59c3ea', NULL, 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, NULL, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, NULL, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, NULL, 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', NULL);

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 1, 'fin_c2c88a', '2024-06-15 00:00:00+00:00', 1.0, 'fin_9e91a2', 'fin_5cfbb8');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, 1, 1, 1, 'lhs_a6072e', '2024-06-15 00:00:00+00:00', 1.0, 'lhs_abc36b', 'lhs_dad6fb');

INSERT INTO "financial_transactions" ("account_id", "card_id", "transaction_id", "previous_transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1, 1, 'rhs_59c3ea', '2024-06-15 00:00:00+00:00', 1.0, 'rhs_2e07f2', 'rhs_e81fbe');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type FROM (SELECT transaction_id, previous_transaction_id, card_id AS account_id, card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT transaction_id, previous_transaction_id, account_id, transaction_id AS card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.previous_transaction_id AS previous_transaction_id, LHS.account_id AS account_id, LHS.card_id AS card_id, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, RHS.transaction_id AS transaction_id_other, RHS.previous_transaction_id AS previous_transaction_id_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM financial_transactions AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.transaction_id = RHS.card_id AND LHS.card_id = RHS.account_id)))) ORDER BY transaction_type;

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_c2c88a',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('fin_ee7bf7',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_a6072e',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('lhs_e75ffa',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_59c3ea',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
('rhs_8f329d',)
*/

-- Prediction Query
SELECT transaction_type FROM Financial_transactions GROUP BY transaction_type ORDER BY SUM(transaction_amount) DESC, transaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_a6072e',)
*/