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
INSERT INTO Investors (investor_id, Investor_details) VALUES (10, 'Investor Alpha');
INSERT INTO Investors (investor_id, Investor_details) VALUES (20, 'Investor Beta');
INSERT INTO Investors (investor_id, Investor_details) VALUES (30, 'Investor Gamma');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (1, 30, 'Zeta Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (2, 20, 'Alpha Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (3, 10, 'Beta Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (4, 10, 'Alpha Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (5, 20, 'Zeta Lot');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('BUY', 'Purchase Transaction');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SELL', 'Sales Transaction');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (101, 'BUY', 30, '2023-01-15 10:00:00', 1500.50, '100', 'Initial Buy');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (102, 'SELL', 20, '2023-02-20 14:30:00', 2500.00, '50', 'Partial Sell');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (101, 'Purchased via Broker A');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (102, 'Sold via Broker B');
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (101, 1);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (102, 1);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (101, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT lot_details FROM lots ORDER BY lot_details;

/*
Gold Result:
('Alpha Lot',)
('Beta Lot',)
('Zeta Lot',)
*/

-- Prediction Query
SELECT DISTINCT lot_details FROM LOTS;

/*
Prediction Result:
('Zeta Lot',)
('Alpha Lot',)
('Beta Lot',)
*/