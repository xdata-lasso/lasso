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
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'lhs_b97e79', 1, '2024-06-15 00:00:00+00:00', 1.0, 'lhs_4106ac', 'lhs_740d65');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483647, 'lhs_344e4c', 1, '2024-06-15 00:00:00+00:00', 1.0, 'lhs_b3bf51', 'lhs_8876a0');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'lhs_344e4c', 1, '2022-12-08 21:38:59+00:00', 0.0003, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'ref_ad9020', 1, '2020-04-30 03:21:27+00:00', 0.0004, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'ref_2db366', 1, '2021-06-17 14:22:38+00:00', 0.0005, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'lhs_344e4c', 1, '2024-01-16 07:29:50+00:00', 0.0006, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (6, 'lhs_344e4c', 1, '2025-11-08 19:01:33+00:00', 0.0007, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (7, '@', 1, '2020-09-25 19:25:33+00:00', 0.0008, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (8, 'lhs_b97e79', 1, '2025-06-13 15:31:02+00:00', 0.0009, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (9, 'lhs_b97e79', 1, '2021-02-21 20:09:01+00:00', 0.001, 'tra_41391c', 'tra_ef0dd5');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1, 'inv_a898d1');

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('ref_2db366', 'ref_6bb0ff');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('lhs_b97e79', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('ref_ad9020', 'ref_6532fc');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('lhs_344e4c', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('A', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('@', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('H', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('I', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('B', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('C', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('"', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('D', 'ref_8ac1c2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_description FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.transaction_type_description AS transaction_type_description FROM transactions AS LHS INNER JOIN (SELECT transaction_type_code, transaction_type_description, COUNT(*) OVER () AS n FROM ref_transaction_types) AS RHS ON (LHS.transaction_id = RHS.n AND LHS.transaction_type_code = RHS.transaction_type_code)) ORDER BY transaction_type_description;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.transaction_type_description FROM Ref_Transaction_Types AS T1 JOIN TRANSACTIONS AS T2 ON T1.transaction_type_code = T2.transaction_type_code GROUP BY T1.transaction_type_code ORDER BY COUNT(*) DESC, T1.transaction_type_description NULLS LAST LIMIT 1;

/*
Prediction Result:
('ref_8ac1c2',)
*/