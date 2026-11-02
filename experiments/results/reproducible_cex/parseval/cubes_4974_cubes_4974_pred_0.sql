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
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'ref_88c64a', 1, '2024-06-15 00:00:00+00:00', 1.0, 'rhs_c80f06', 'rhs_c69b16');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483647, 'ref_92372f', 1, '2024-06-15 00:00:00+00:00', 1.0, 'rhs_798d54', 'rhs_2da0bb');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'C', 1, '2025-02-21 23:30:13+00:00', 0.0003, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'ref_88c64a', 1, '2022-02-14 19:27:39+00:00', 0.0004, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'ref_88c64a', 1, '2024-06-06 00:28:47+00:00', 0.0005, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'C', 1, '2020-07-23 07:32:15+00:00', 0.0006, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (6, 'Q', 1, '2022-04-15 05:01:35+00:00', 0.0007, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (7, 'C', 1, '2023-10-02 15:43:02+00:00', 0.0008, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (8, 'B', 1, '2022-10-06 13:20:05+00:00', 0.0009, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (9, 'B', 1, '2022-07-05 02:28:20+00:00', 0.001, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (10, 'b', 1, '2022-12-20 09:53:17+00:00', 0.0011, 'tra_41391c', 'tra_ef0dd5');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1, 'inv_a898d1');

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('ref_88c64a', 'ref_11b833');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('ref_92372f', 'ref_47268d');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('C', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('Q', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('A', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('@', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('B', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('H', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('D', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('#', 'ref_8ac1c2');

INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('b', 'ref_8ac1c2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_description FROM (SELECT LHS.transaction_type_code AS transaction_type_code, LHS.transaction_type_description AS transaction_type_description, LHS.n AS n, RHS.investor_id AS investor_id, RHS.date_of_transaction AS date_of_transaction, RHS.amount_of_transaction AS amount_of_transaction, RHS.share_count AS share_count, RHS.other_details AS other_details FROM (SELECT transaction_type_code, transaction_type_description, MAX(n) OVER () AS n FROM (SELECT transaction_type_code, transaction_type_description, COUNT(*) OVER () AS n FROM ref_transaction_types)) AS LHS INNER JOIN transactions AS RHS ON (LHS.n = RHS.transaction_id AND LHS.transaction_type_code = RHS.transaction_type_code)) ORDER BY transaction_type_description;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.transaction_type_description FROM Ref_Transaction_Types AS T1 JOIN TRANSACTIONS AS T2 ON T1.transaction_type_code = T2.transaction_type_code GROUP BY T1.transaction_type_code ORDER BY COUNT(*) DESC, T1.transaction_type_description NULLS LAST LIMIT 1;

/*
Prediction Result:
('ref_11b833',)
*/