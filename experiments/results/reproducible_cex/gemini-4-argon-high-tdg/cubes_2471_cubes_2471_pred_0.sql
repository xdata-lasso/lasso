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
INSERT INTO Investors (investor_id, Investor_details) VALUES (1, 'Alice Smith');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('PUR', 'Purchase');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SAL', 'Sale');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'PUR', 1, '2023-01-01 10:00:00', 60.0, '10', 'Min amount row with PUR');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'SAL', 1, '2023-01-02 10:00:00', 100.0, '20', 'Sale row 1');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'SAL', 1, '2023-01-03 10:00:00', 120.0, '30', 'Sale row 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "minamount_of_transaction" AS "min_amount_of_transaction_" FROM (SELECT "transaction_id", "investor_id", "transaction_type_code", "date_of_transaction", "amount_of_transaction", "share_count", "other_details", MIN("amount_of_transaction") OVER () AS "minamount_of_transaction" FROM "transactions") WHERE ("transaction_type_code" <> 'PUR' OR minamount_of_transaction <= 50.0) ORDER BY min_amount_of_transaction_;

/*
Gold Result:
(60.0,)
*/

-- Prediction Query
SELECT MIN(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'PUR' AND share_count > 50;

/*
Prediction Result:
(None,)
*/