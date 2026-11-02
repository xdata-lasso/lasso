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
-- DATASET 1
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor 1');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (2, 'Investor 2');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (10, 'Investor 10');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (20, 'Investor 20');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (99, 'Investor 99');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Buy Shares');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SELL', 'Sell Shares');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('DIV', 'Dividend');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('FEE', 'Fee');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('TAX', 'Tax');
-- RHS target row (transaction_id = 10)
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (10, 'BUY', 1, '2023-01-01 10:00:00', 100.0000, '500', 'Target RHS');
-- LHS matching row 1 (investor_id = 10 matches RHS.transaction_id = 10, share_count = '500' matches)
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (20, 'SELL', 10, '2023-01-02 10:00:00', 200.0000, '500', 'Match 1');
-- LHS matching row 2 (tests GROUP BY deduplication on 'SELL')
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (21, 'SELL', 10, '2023-01-03 10:00:00', 300.0000, '500', 'Match 2');
-- Partial match: investor_id matches RHS.transaction_id (10), but share_count differs
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (30, 'DIV', 10, '2023-01-04 10:00:00', 400.0000, '999', 'Diff share_count');
-- Partial match: share_count matches ('500'), but investor_id (99) has no corresponding transaction_id
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (40, 'FEE', 99, '2023-01-05 10:00:00', 500.0000, '500', 'Diff id');
-- Self-match on ID (transaction_id = 2 = investor_id), share_count = '100'
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'TAX', 2, '2023-01-06 10:00:00', 50.0000, '100', 'Self match');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code FROM (SELECT transaction_type_code, COUNT(*) AS n FROM (SELECT investor_id AS transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, investor_id_other, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, other_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.investor_id AS investor_id_other, RHS.transaction_type_code AS transaction_type_code_other, RHS.date_of_transaction AS date_of_transaction_other, RHS.amount_of_transaction AS amount_of_transaction_other, RHS.other_details AS other_details_other FROM transactions AS LHS INNER JOIN transactions AS RHS ON (LHS.investor_id = RHS.transaction_id AND LHS.share_count = RHS.share_count))) GROUP BY transaction_type_code) ORDER BY transaction_type_code;

/*
Gold Result:
('SELL',)
('TAX',)
*/

-- Prediction Query
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) DESC, transaction_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('SELL',)
*/