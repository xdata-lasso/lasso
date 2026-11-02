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
-- Tests basic ordering (out-of-order insertion vs alphabetical), duplicate investor_details (to catch DISTINCT or GROUP BY mutants), and unreferenced investors vs investors with multiple lots/transactions (to catch erroneous JOINs).
INSERT INTO Investors (investor_id, Investor_details) VALUES (1, 'Zeta Corp');
INSERT INTO Investors (investor_id, Investor_details) VALUES (2, 'Alpha Inc');
INSERT INTO Investors (investor_id, Investor_details) VALUES (3, 'Beta LLC');
INSERT INTO Investors (investor_id, Investor_details) VALUES (4, 'Alpha Inc');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (10, 2, 'Lot A1');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (11, 2, 'Lot A2');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('BUY', 'Purchase');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (100, 'BUY', 2, '2023-01-01 10:00:00', 500.00, '10', 'None');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (101, 'BUY', 2, '2023-01-02 10:00:00', 1000.00, '20', 'None');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (100, 'First Buy');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (101, 'Erroneous Sale');
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (100, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor_details FROM investors ORDER BY investor_details, investors.investor_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zeta Corp',)
*/

-- Prediction Query
SELECT Investor_details FROM INVESTORS;

/*
Prediction Result:
('Zeta Corp',)
('Alpha Inc',)
('Beta LLC',)
('Alpha Inc',)
*/