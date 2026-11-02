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
-- DATASET 4
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor One');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('BUY', 'Purchase');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (1, 1, NULL);
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (2, 1, 'Valid_Lot');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (3, 1, 'Transacted_Lot');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (300, 'BUY', 1, '2023-03-01 10:00:00', 250.00, '25', 'Details');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (300, 1);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (300, 3);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (300, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT lot_details FROM (SELECT * FROM lots AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT LHS.transaction_id AS transaction_id, LHS.lot_id AS lot_id, RHS.investor_id AS investor_id, RHS.lot_details AS lot_details FROM transactions_lots AS LHS LEFT JOIN lots AS RHS ON (LHS.lot_id = RHS.lot_id)) AS RHS WHERE (LHS.lot_details = RHS.lot_details))) ORDER BY lot_details;

/*
Gold Result:
(None,)
('Valid_Lot',)
*/

-- Prediction Query
SELECT lot_details FROM Lots EXCEPT SELECT T1.lot_details FROM Lots AS T1 JOIN transactions_lots AS T2 ON T1.lot_id = T2.lot_id;

/*
Prediction Result:
('Valid_Lot',)
*/