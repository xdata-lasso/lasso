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
INSERT INTO Investors (investor_id, Investor_details) VALUES (1, 'Alpha Holdings');
INSERT INTO Investors (investor_id, Investor_details) VALUES (2, 'Beta Ventures');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('BUY', 'Purchase of shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SELL', 'Sale of shares');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'SELL', 1, '2023-05-20', 5000.0000, '10', 'Late date with smallest ID');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'BUY', 2, '2023-02-01', 2000.0000, '200', 'Tie date first ID');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'BUY', 1, '2023-01-10', 9000.0000, '500', 'Earliest date with middle ID');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (4, 'SELL', 2, '2023-03-15', 1500.0000, '50', 'Duplicate date and share_count A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (5, 'BUY', 1, '2023-03-15', 1600.0000, '50', 'Duplicate date and share_count B');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (6, 'SELL', 1, '2023-02-01', 500.0000, '50', 'Tie date second ID');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (7, 'BUY', 2, '2023-02-01', 10000.0000, '1000', 'Tie date third ID');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_of_transaction, share_count FROM transactions ORDER BY date_of_transaction, transactions.transaction_id NULLS LAST;

/*
Gold Result:
('2023-01-10', '500')
('2023-02-01', '200')
('2023-02-01', '50')
('2023-02-01', '1000')
('2023-03-15', '50')
('2023-03-15', '50')
('2023-05-20', '10')
*/

-- Prediction Query
SELECT date_of_transaction, share_count FROM TRANSACTIONS;

/*
Prediction Result:
('2023-05-20', '10')
('2023-02-01', '200')
('2023-01-10', '500')
('2023-03-15', '50')
('2023-03-15', '50')
('2023-02-01', '50')
('2023-02-01', '1000')
*/