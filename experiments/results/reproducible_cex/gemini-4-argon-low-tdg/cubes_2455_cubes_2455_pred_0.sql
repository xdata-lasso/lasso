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
-- Tests basic filtering (exact match vs LIKE/case-sensitivity), duplicate dates (DISTINCT/GROUP BY mutants), and NULL foreign keys (INNER JOIN Investors mutants).
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'Sale');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR', 'Purchase');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('sale', 'Lowercase Sale');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALES', 'Plural Sales');
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor One');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1, 'SALE', 1, '2023-05-10 10:00:00', 100.0, '10', 'Valid Sale 1');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (2, 'SALE', NULL, '2023-01-15 08:30:00', 200.0, '20', 'Valid Sale with NULL investor');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (3, 'SALE', 1, '2023-05-10 10:00:00', 150.0, '15', 'Duplicate date Sale');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (4, 'PUR', 1, '2023-02-20 09:00:00', 300.0, '30', 'Purchase');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (5, 'sale', 1, '2023-03-10 11:00:00', 400.0, '40', 'Lowercase sale');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (6, 'SALES', 1, '2023-04-01 12:00:00', 500.0, '50', 'Plural sales');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (7, NULL, 1, '2023-01-01 00:00:00', 600.0, '60', 'NULL type code');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_transaction" FROM "transactions" WHERE ("transaction_type_code" = 'SALE') ORDER BY date_of_transaction, transactions.transaction_id NULLS LAST;

/*
Gold Result:
('2023-01-15 08:30:00',)
('2023-05-10 10:00:00',)
('2023-05-10 10:00:00',)
*/

-- Prediction Query
SELECT date_of_transaction FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
('2023-05-10 10:00:00',)
('2023-01-15 08:30:00',)
('2023-05-10 10:00:00',)
*/