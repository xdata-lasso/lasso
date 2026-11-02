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
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'lhs_24705b', 1, '2024-06-15 00:00:00+00:00', 3000.0, 'lhs_fda95e', 'lhs_001af4');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'lhs_24705b', 1, '2024-06-15 00:00:00+00:00', 3000.0, 'lhs_fda95e', 'lhs_001af4');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'lhs_24705b', 1, '2022-06-06 02:35:43+00:00', 0.0003, 'tra_41391c', 'tra_ef0dd5');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1, 'inv_a898d1');

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('lhs_24705b', 'ref_8ac1c2');

-- Inserting into table: sales --
INSERT INTO "sales" ("sales_transaction_id", "sales_details") VALUES (1, 'rhs_78e7a7');

INSERT INTO "sales" ("sales_transaction_id", "sales_details") VALUES (2, 'rhs_78e7a7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sales_details, date_of_transaction FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, sales_details, transaction_id AS sales_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.sales_details AS sales_details FROM transactions AS LHS INNER JOIN sales AS RHS ON (LHS.transaction_id = RHS.sales_transaction_id))) WHERE (amount_of_transaction <= 3000.0) ORDER BY sales_details, date_of_transaction NULLS LAST;

/*
Gold Result:
('rhs_78e7a7', '2022-06-06 02:35:43+00:00')
('rhs_78e7a7', '2024-06-15 00:00:00+00:00')
*/

-- Prediction Query
SELECT T1.sales_details, T2.date_of_transaction FROM SALES AS T1 JOIN TRANSACTIONS AS T2 ON T1.sales_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction < 3000;

/*
Prediction Result:
('rhs_78e7a7', '2022-06-06 02:35:43+00:00')
*/