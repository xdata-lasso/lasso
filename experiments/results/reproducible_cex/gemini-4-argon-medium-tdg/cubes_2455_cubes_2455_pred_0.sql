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
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'Sale');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR', 'Purchase');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('Sale', 'Lowercase Sale');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALES', 'Plural Sales');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (10, 'SALE', 1, '2023-05-10 14:30:00', 500.00, '50', 'First sale, later date');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (20, 'SALE', 1, '2023-01-15 09:00:00', 200.00, '20', 'Second sale, earlier date');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (30, 'SALE', 2, '2023-01-15 09:00:00', 300.00, '30', 'Duplicate date to test DISTINCT and tie-breaker');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (40, 'PUR', 1, '2023-02-20 10:00:00', 100.00, '10', 'Purchase transaction');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (50, 'Sale', 2, '2023-03-01 11:00:00', 150.00, '15', 'Case sensitivity check');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (60, 'SALES', 2, '2023-04-01 12:00:00', 250.00, '25', 'LIKE wildcard check');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (70, NULL, 1, '2023-06-01 15:00:00', 50.00, '5', 'Null transaction type code');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (10, 'Recorded in Sales');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (20, 'Recorded in Sales');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (40, 'Recorded in Purchases');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_transaction" FROM "transactions" WHERE ("transaction_type_code" = 'SALE') ORDER BY date_of_transaction, transactions.transaction_id NULLS LAST;

/*
Gold Result:
('2023-01-15 09:00:00',)
('2023-01-15 09:00:00',)
('2023-05-10 14:30:00',)
*/

-- Prediction Query
SELECT date_of_transaction FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
('2023-05-10 14:30:00',)
('2023-01-15 09:00:00',)
('2023-01-15 09:00:00',)
*/