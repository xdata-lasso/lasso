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
INSERT INTO "Investors" ("investor_id", "Investor_details") VALUES (1, 'Investor Alpha'), (2, 'Investor Beta');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'Sale'), ('PUR', 'Purchase');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES
(1, 'SALE', 1, '2023-01-01 10:00:00', 100.0, '10', 'Group_A'),
(2, 'SALE', 1, '2023-01-02 10:00:00', 200.0, '20', 'Group_A'),
(3, 'PUR', 1, '2023-01-03 10:00:00', 900.0, '90', 'Group_A'),
(4, 'SALE', 2, '2023-01-04 10:00:00', 50.0, '5', 'Group_B'),
(5, 'SALE', 1, '2023-01-05 10:00:00', 100.0, '10', 'Group_C'),
(6, 'SALE', 2, '2023-01-06 10:00:00', 200.0, '20', 'Group_C');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (1, 'Sale Detail 1'), (3, 'Sale Detail 3');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (3, 'Pur Detail 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanamount_of_transaction" AS "avg_amount_of_transaction_" FROM (SELECT "other_details", "transaction_type_code", AVG("amount_of_transaction") AS "meanamount_of_transaction" FROM "transactions" GROUP BY "other_details", "transaction_type_code") WHERE ("transaction_type_code" = 'SALE') ORDER BY avg_amount_of_transaction_;

/*
Gold Result:
(50.0,)
(150.0,)
(150.0,)
*/

-- Prediction Query
SELECT AVG(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
(130.0,)
*/