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
INSERT INTO Investors (investor_id, Investor_details) VALUES (101, 'Alice Smith');
INSERT INTO Investors (investor_id, Investor_details) VALUES (102, 'Bob Jones');
INSERT INTO Investors (investor_id, Investor_details) VALUES (103, 'Charlie Day');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (10, 103, 'Lot C');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (20, 102, 'Lot A');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (5, 103, 'Lot A');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (30, 101, 'Lot B');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (40, 101, 'Lot B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lot_details, investor_id FROM lots ORDER BY lot_details, lots.lot_id NULLS LAST;

/*
Gold Result:
('Lot A', 103)
('Lot A', 102)
('Lot B', 101)
('Lot B', 101)
('Lot C', 103)
*/

-- Prediction Query
SELECT lot_details, investor_id FROM LOTS;

/*
Prediction Result:
('Lot A', 103)
('Lot C', 103)
('Lot A', 102)
('Lot B', 101)
('Lot B', 101)
*/