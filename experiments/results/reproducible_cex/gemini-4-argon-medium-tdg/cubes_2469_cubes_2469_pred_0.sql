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
INSERT INTO Investors (investor_id, Investor_details) VALUES (1, 'Investor One');
INSERT INTO Investors (investor_id, Investor_details) VALUES (2, 'Investor Two');
INSERT INTO Investors (investor_id, Investor_details) VALUES (3, 'Investor Three No Transactions');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('BUY', 'Buy Shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SELL', 'Sell Shares');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (101, 'BUY', 1, '2023-01-01 10:00:00', 100.0, '10', 'Detail_A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (102, 'SELL', 1, '2023-01-02 10:00:00', 200.0, '20', 'Detail_A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (103, 'BUY', 1, '2023-01-03 10:00:00', 50.0, '5', 'Detail_B');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (104, 'BUY', 2, '2023-01-04 10:00:00', 300.0, '30', 'Detail_A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (105, 'SELL', 2, '2023-01-05 10:00:00', 300.0, '30', 'Detail_C');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (102, 'Sale 102');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (101, 'Purchase 101');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor_id, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT investor_id, other_details, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY investor_id, other_details) ORDER BY investor_id, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
(1, 50.0)
(1, 150.0)
(2, 300.0)
(2, 300.0)
*/

-- Prediction Query
SELECT investor_id, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY investor_id;

/*
Prediction Result:
(1, 116.66666666666667)
(2, 300.0)
*/