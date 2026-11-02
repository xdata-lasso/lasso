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
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor One');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (2, 'Investor Two');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (3, 'Investor Three');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (4, 'Investor Four');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (5, 'Investor Five');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Purchase');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SELL', 'Sale');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('DIV', 'Dividend');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'SELL', 2, '2023-01-01 10:00:00', 100.0000, '10', 'Swap pair A1');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'BUY', 1, '2023-01-02 10:00:00', 200.0000, '20', 'Swap pair A2');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'BUY', 3, '2023-01-03 10:00:00', 300.0000, '30', 'Self match with same type as ID 2');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'DIV', 5, '2023-01-04 10:00:00', 400.0000, '40', 'One way match only');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'SELL', 1, '2023-01-05 10:00:00', 500.0000, '50', 'No reciprocal back to 4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code FROM (SELECT investor_id, transaction_type_code, MAX(n) AS maxn FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other, COUNT(*) OVER () AS n FROM (SELECT investor_id AS transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other FROM (SELECT transaction_id, transaction_id AS investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, share_count_other, other_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.transaction_type_code AS transaction_type_code_other, RHS.date_of_transaction AS date_of_transaction_other, RHS.amount_of_transaction AS amount_of_transaction_other, RHS.share_count AS share_count_other, RHS.other_details AS other_details_other FROM transactions AS LHS INNER JOIN transactions AS RHS ON (LHS.transaction_id = RHS.investor_id AND LHS.investor_id = RHS.transaction_id))))) GROUP BY investor_id, transaction_type_code) ORDER BY transaction_type_code;

/*
Gold Result:
('BUY',)
('BUY',)
('SELL',)
*/

-- Prediction Query
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) DESC, transaction_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('BUY',)
*/