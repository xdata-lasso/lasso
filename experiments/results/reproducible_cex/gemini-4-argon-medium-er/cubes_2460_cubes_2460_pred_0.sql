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
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Buy Shares');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (999, 'BUY', 1, '2023-01-01', 100.0, '10', 'None');
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
('Buy Shares',)
*/