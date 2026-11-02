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
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SELL', 'Sale of shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('BUY', 'Purchase of shares');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'SELL', 1, '2023-01-10 10:00:00', 100.0, '10', 'D1');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'SELL', 2, '2023-01-11 10:00:00', 200.0, '20', 'D1');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'SELL', 1, '2023-01-12 10:00:00', 40.0, '5', 'D2');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (4, 'BUY', 1, '2023-01-13 10:00:00', 50.0, '5', 'D1');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (5, 'BUY', 1, '2023-01-14 10:00:00', 10.0, '2', 'D2');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (6, 'BUY', 2, '2023-01-15 10:00:00', 10.0, '2', 'D2');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (7, 'BUY', 2, '2023-01-16 10:00:00', 25.0, '5', 'D2');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (8, 'BUY', 1, '2023-01-17 10:00:00', 20.0, '4', 'D3');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (9, 'BUY', 2, '2023-01-18 10:00:00', 40.0, '8', 'D3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT other_details, transaction_type_code, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY other_details, transaction_type_code) ORDER BY transaction_type_code, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
('BUY', 15.0)
('BUY', 30.0)
('BUY', 50.0)
('SELL', 40.0)
('SELL', 150.0)
*/

-- Prediction Query
SELECT transaction_type_code, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY transaction_type_code;

/*
Prediction Result:
('BUY', 25.833333333333332)
('SELL', 113.33333333333333)
*/