-- Schema DDL
CREATE TABLE "Investors" ("investor_id" INTEGER PRIMARY KEY, "Investor_details" TEXT(255));

CREATE TABLE "Lots" ("lot_id" INTEGER PRIMARY KEY, "investor_id" INTEGER, "lot_details" TEXT(255), FOREIGN KEY ("investor_id") REFERENCES "Investors" ("investor_id"));

CREATE TABLE "Ref_Transaction_Types" ("transaction_type_code" TEXT(10) PRIMARY KEY, "transaction_type_description" TEXT(80));

CREATE TABLE "Transactions" ("transaction_id" INTEGER PRIMARY KEY, "transaction_type_code" TEXT(10), "investor_id" INTEGER, "date_of_transaction" DATETIME, "amount_of_transaction" REAL(19, 4), "share_count" TEXT(40), "other_details" TEXT(255), FOREIGN KEY ("transaction_type_code") REFERENCES "Ref_Transaction_Types" ("transaction_type_code"), FOREIGN KEY ("investor_id") REFERENCES "Investors" ("investor_id"));

CREATE TABLE "Sales" ("sales_transaction_id" INTEGER PRIMARY KEY, "sales_details" TEXT(255), FOREIGN KEY ("sales_transaction_id") REFERENCES "Transactions" ("transaction_id"));

CREATE TABLE "Purchases" ("purchase_transaction_id" INTEGER, "purchase_details" TEXT(255), FOREIGN KEY ("purchase_transaction_id") REFERENCES "Transactions" ("transaction_id"));

CREATE TABLE "Transactions_Lots" ("transaction_id" INTEGER, "lot_id" INTEGER, FOREIGN KEY ("transaction_id") REFERENCES "Transactions" ("transaction_id"), FOREIGN KEY ("lot_id") REFERENCES "Lots" ("lot_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'tra_909e64', -2147483648, '2024-06-15 00:00:00+00:00', 1.0, 'tra_b8b7c8', 'tra_60cc7d');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483647, 'tra_2aebaa', 1, '2024-06-15 00:00:00+00:00', 1.0, 'tra_16d0d0', 'tra_a0fabc');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'tra_2aebaa', -2147483648, '2022-04-15 05:01:35+00:00', 0.0003, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'lhs_abb3ac', -2147483648, '2023-10-02 15:43:02+00:00', 0.0004, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'tra_2aebaa', -2147483648, '2022-10-06 13:20:05+00:00', 0.0005, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'tra_2aebaa', -2147483648, '2022-07-05 02:28:20+00:00', 0.0006, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483642, 'lhs_7f545b', 1, '2022-12-20 09:53:17+00:00', 0.0007, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483641, 'lhs_7f545b', -2147483648, '2020-03-08 22:40:47+00:00', 0.0008, 'tra_41391c', 'tra_ef0dd5');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (-2147483648, 'inv_a898d1');

INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1, 'inv_a898d1');

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('tra_909e64', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('lhs_abb3ac', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('rhs_ff90f6', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('tra_2aebaa', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('lhs_7f545b', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('rhs_80e857', 'ref_8ac1c2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code FROM (SELECT investor_id, transaction_type_code, MAX(n) AS maxn FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other, COUNT(*) OVER () AS n FROM (SELECT investor_id AS transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other FROM (SELECT transaction_id, transaction_id AS investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.transaction_type_code AS transaction_type_code_other, RHS.date_of_transaction AS date_of_transaction_other, RHS.amount_of_transaction AS amount_of_transaction_other, RHS.share_count AS share_count_other, RHS.other_details AS other_details_other FROM transactions AS LHS INNER JOIN transactions AS RHS ON (LHS.transaction_id = RHS.investor_id AND LHS.investor_id = RHS.transaction_id))))) GROUP BY investor_id, transaction_type_code) ORDER BY transaction_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) DESC, transaction_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('tra_2aebaa',)
*/