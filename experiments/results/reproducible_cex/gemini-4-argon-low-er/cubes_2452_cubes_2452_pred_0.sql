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
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor 1');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Buy');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (1, 1, 'Lot 1');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (2, 1, 'Lot 2');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'BUY', 1, '2023-01-01', 100.0, '10', 'None');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'BUY', 1, '2023-01-02', 50.0, '5', 'None');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (1, 1);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lot_id, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT lot_id, AVG(amount_of_transaction) AS meanamount_of_transaction FROM (SELECT LHS.transaction_id AS transaction_id, LHS.lot_id AS lot_id, RHS.investor_id AS investor_id, RHS.transaction_type_code AS transaction_type_code, RHS.date_of_transaction AS date_of_transaction, RHS.amount_of_transaction AS amount_of_transaction, RHS.share_count AS share_count, RHS.other_details AS other_details FROM transactions_lots AS LHS INNER JOIN transactions AS RHS ON (LHS.transaction_id = RHS.transaction_id)) GROUP BY lot_id) ORDER BY lot_id, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
(1, 100.0)
(2, 50.0)
*/

-- Prediction Query
SELECT T2.lot_id, AVG(amount_of_transaction) FROM TRANSACTIONS AS T1 JOIN Transactions_Lots AS T2 ON T1.transaction_id = T2.transaction_id GROUP BY T2.lot_id ORDER BY AVG(amount_of_transaction), T2.lot_id NULLS LAST;

/*
Prediction Result:
(2, 50.0)
(1, 100.0)
*/