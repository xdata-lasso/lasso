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
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Purchase');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SELL', 'Sale');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'BUY', 1, '2023-01-01 10:00:00', 100.0, '10', 'D1');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'BUY', 1, '2023-01-02 10:00:00', 200.0, '20', 'D1');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'BUY', 1, '2023-01-03 10:00:00', 50.0, '5', 'D2');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'SELL', 1, '2023-01-04 10:00:00', 300.0, '30', 'D1');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'SELL', 1, '2023-01-05 10:00:00', 300.0, '30', 'D2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT other_details, transaction_type_code, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY other_details, transaction_type_code) ORDER BY transaction_type_code, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
('BUY', 50.0)
('BUY', 150.0)
('SELL', 300.0)
('SELL', 300.0)
*/

-- Prediction Query
SELECT transaction_type_code, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY transaction_type_code;

/*
Prediction Result:
('BUY', 116.66666666666667)
('SELL', 300.0)
*/