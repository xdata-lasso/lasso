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
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'Sale Transaction');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR', 'Purchase Transaction');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (101, 'SALE', 1, '2023-01-10 10:00:00', 2999.99, '10', 'Under limit');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (102, 'SALE', 1, '2023-01-11 10:00:00', 3000.0, '20', 'Exact limit');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (103, 'SALE', 1, '2023-01-12 10:00:00', 3000.01, '30', 'Over limit');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (104, 'SALE', 1, '2023-01-13 10:00:00', NULL, '40', 'Null amount');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (105, 'PUR', 1, '2023-01-14 10:00:00', 1500.0, '50', 'Not a sale');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (101, 'Sale Under Limit');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (102, 'Sale Exact Limit');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (103, 'Sale Over Limit');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (104, 'Sale Null Amount');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (105, 'Purchase Under Limit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sales_details, date_of_transaction FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, sales_details, transaction_id AS sales_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.sales_details AS sales_details FROM transactions AS LHS INNER JOIN sales AS RHS ON (LHS.transaction_id = RHS.sales_transaction_id))) WHERE (amount_of_transaction <= 3000.0) ORDER BY sales_details, date_of_transaction NULLS LAST;

/*
Gold Result:
('Sale Exact Limit', '2023-01-11 10:00:00')
('Sale Under Limit', '2023-01-10 10:00:00')
*/

-- Prediction Query
SELECT T1.sales_details, T2.date_of_transaction FROM SALES AS T1 JOIN TRANSACTIONS AS T2 ON T1.sales_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction < 3000;

/*
Prediction Result:
('Sale Under Limit', '2023-01-10 10:00:00')
*/