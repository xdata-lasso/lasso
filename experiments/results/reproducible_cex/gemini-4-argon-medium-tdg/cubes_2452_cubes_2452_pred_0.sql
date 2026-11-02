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
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor Alpha');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (2, 'Investor Beta');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (10, 1, 'Lot 10');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (20, 2, 'Lot 20');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (30, 1, 'Lot 30 - No Transactions');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Purchase');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SELL', 'Sale');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (101, 'BUY', 1, '2023-01-01 10:00:00', 100.5, '10', 'First buy');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (102, 'BUY', 1, '2023-01-02 10:00:00', 100.5, '10', 'Duplicate amount for AVG DISTINCT check');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (103, 'SELL', 1, '2023-01-03 10:00:00', 300.0, '30', 'Third tx for Lot 10');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (104, 'BUY', 2, '2023-01-04 10:00:00', 50.25, '5', 'Single tx for Lot 20');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (105, 'SELL', 2, '2023-01-05 10:00:00', 999.99, '100', 'Unlinked transaction');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (103, 'Sale details');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (101, 'Purchase details');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (101, 10);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (102, 10);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (103, 10);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (104, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lot_id, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT lot_id, AVG(amount_of_transaction) AS meanamount_of_transaction FROM (SELECT LHS.transaction_id AS transaction_id, LHS.lot_id AS lot_id, RHS.investor_id AS investor_id, RHS.transaction_type_code AS transaction_type_code, RHS.date_of_transaction AS date_of_transaction, RHS.amount_of_transaction AS amount_of_transaction, RHS.share_count AS share_count, RHS.other_details AS other_details FROM transactions_lots AS LHS INNER JOIN transactions AS RHS ON (LHS.transaction_id = RHS.transaction_id)) GROUP BY lot_id) ORDER BY lot_id, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
(10, 167.0)
(20, 50.25)
*/

-- Prediction Query
SELECT T2.lot_id, AVG(amount_of_transaction) FROM TRANSACTIONS AS T1 JOIN Transactions_Lots AS T2 ON T1.transaction_id = T2.transaction_id GROUP BY T2.lot_id ORDER BY AVG(amount_of_transaction), T2.lot_id NULLS LAST;

/*
Prediction Result:
(20, 50.25)
(10, 167.0)
*/