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
-- Tests basic ordering by date_of_transaction (out-of-order relative to PK), secondary tie-breaker ordering by transaction_id, and ensures DISTINCT / GROUP BY mutants are caught via duplicate (date_of_transaction, share_count) pairs. Also tests missing joins (rows without corresponding Sales, Purchases, or Lots).
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor A');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Purchase');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'BUY', 1, '2023-05-10 10:00:00', 500.0000, '50', 'First inserted, middle date');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'BUY', 1, '2023-01-15 09:30:00', 1000.0000, '200', 'Earliest date, large share count');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'BUY', 1, '2023-05-10 10:00:00', 100.0000, '10', 'Same date as ID 1, higher ID, smaller share_count');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'BUY', 1, '2023-05-10 10:00:00', 500.0000, '50', 'Exact duplicate of ID 1 for projected columns');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_transaction, share_count FROM transactions ORDER BY date_of_transaction, transactions.transaction_id NULLS LAST;

/*
Gold Result:
('2023-01-15 09:30:00', '200')
('2023-05-10 10:00:00', '50')
('2023-05-10 10:00:00', '10')
('2023-05-10 10:00:00', '50')
*/

-- Prediction Query
SELECT date_of_transaction, share_count FROM TRANSACTIONS;

/*
Prediction Result:
('2023-05-10 10:00:00', '50')
('2023-01-15 09:30:00', '200')
('2023-05-10 10:00:00', '10')
('2023-05-10 10:00:00', '50')
*/