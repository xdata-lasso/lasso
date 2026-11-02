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
INSERT INTO Investors (investor_id, Investor_details) VALUES (2, 'Bob Jones');
INSERT INTO Investors (investor_id, Investor_details) VALUES (3, 'Carol White');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (101, 1, 'Tech Growth Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (102, 2, 'Value Index Lot');
INSERT INTO Lots (lot_id, investor_id, lot_details) VALUES (103, 3, 'Dividend Fund Lot');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SALE', 'Sale of Shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('PUR', 'Purchase of Shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('DIV', 'Dividend Reinvestment');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'SALE', 3, '2023-08-15 10:00:00', 100.00, '10', 'Batch A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'PUR', 1, '2023-01-10 08:00:00', 50.00, '5', 'Batch B');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'SALE', 1, '2023-02-20 12:00:00', 500.00, '50', 'Batch C');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (4, 'SALE', 2, '2023-02-20 12:00:00', 300.00, '30', 'Batch D');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (5, 'SALE', 2, '2023-05-01 09:30:00', 200.00, '20', 'Batch E');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (6, 'DIV', 3, '2023-03-01 15:00:00', 150.00, '15', 'Batch F');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (1, 'Full liquidation');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (3, 'Partial sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (4, 'Rebalance sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (5, 'Tax harvesting');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (2, 'Initial buy');
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (1, 103);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (2, 101);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (3, 101);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (4, 102);
INSERT INTO Transactions_Lots (transaction_id, lot_id) VALUES (5, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_of_transaction" FROM "transactions" WHERE ("transaction_type_code" = 'SALE') ORDER BY date_of_transaction, transactions.transaction_id NULLS LAST;

/*
Gold Result:
('2023-02-20 12:00:00',)
('2023-02-20 12:00:00',)
('2023-05-01 09:30:00',)
('2023-08-15 10:00:00',)
*/

-- Prediction Query
SELECT date_of_transaction FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
('2023-08-15 10:00:00',)
('2023-02-20 12:00:00',)
('2023-02-20 12:00:00',)
('2023-05-01 09:30:00',)
*/