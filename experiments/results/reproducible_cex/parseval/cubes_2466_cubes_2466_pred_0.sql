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
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483648, 'transact_1', -2147483648, '2024-02-19 01:18:26+00:00', 0.0001, 'tra_41391c', 'tra_ef0dd5');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (-2147483648, 'inv_a898d1');

-- Inserting into table: lots --
INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483648, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (1, -2147483648, 't1__1f3ca0');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (2, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (3, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483646, -2147483648, 't1__7b7ad6');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483643, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483642, -2147483648, 'lot_f0e099');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483641, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483640, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483639, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483638, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483637, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483636, -2147483648, 'lot_c0829f');

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (-2147483635, -2147483648, NULL);

INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (4, -2147483648, NULL);

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('transact_1', 'ref_8ac1c2');

-- Inserting into table: transactions_lots --
INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 2);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 2);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 2);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 1);

INSERT INTO "transactions_lots" ("transaction_id", "lot_id") VALUES (-2147483648, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT lot_details FROM (SELECT * FROM lots AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.transaction_id AS transaction_id, LHS.lot_id AS lot_id, RHS.investor_id AS investor_id, RHS.lot_details AS lot_details FROM transactions_lots AS LHS LEFT JOIN lots AS RHS ON (LHS.lot_id = RHS.lot_id)) AS RHS WHERE (LHS.lot_details = RHS.lot_details))) ORDER BY lot_details;

/*
Gold Result:
(None,)
('lot_f0e099',)
('t1__7b7ad6',)
*/

-- Prediction Query
SELECT lot_details FROM Lots EXCEPT SELECT T1.lot_details FROM Lots AS T1 JOIN transactions_lots AS T2 ON T1.lot_id = T2.lot_id;

/*
Prediction Result:
('lot_f0e099',)
('t1__7b7ad6',)
*/