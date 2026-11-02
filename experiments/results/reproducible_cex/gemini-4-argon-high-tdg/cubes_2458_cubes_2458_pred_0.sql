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
INSERT INTO Investors (investor_id, Investor_details) VALUES (3, 'Investor Three');
INSERT INTO Investors (investor_id, Investor_details) VALUES (4, 'Investor Four');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('PUR', 'Purchase');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SAL', 'Sale');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'PUR', 2, '2023-01-04 10:00:00', 50000.0, '500', 'Other C');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'PUR', 3, '2023-01-03 10:00:00', 40000.0, '400', 'Other A');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'PUR', 4, '2023-01-02 10:00:00', 30000.0, '300', 'Other D');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (4, 'PUR', 1, '2023-01-01 10:00:00', 10000.01, '100', 'Other B');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (5, 'PUR', 1, '2023-01-05 10:00:00', 10000.0, '100', 'Boundary Exact');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (6, 'PUR', 2, '2023-01-06 10:00:00', 9999.99, '99', 'Boundary Below');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (7, 'SAL', 3, '2023-01-07 10:00:00', 75000.0, '750', 'High Value Sale');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (8, 'PUR', 4, '2023-01-08 10:00:00', 85000.0, '850', 'Unlinked Transaction');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (1, 'Gamma Purchase');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (2, 'Alpha Purchase');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (3, 'Delta Purchase');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (4, 'Beta Purchase');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (5, 'Exact Ten Thousand');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (6, 'Just Under Ten Thousand');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (7, 'Large Sale Details');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT purchase_details FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, purchase_details, transaction_id AS purchase_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.purchase_details AS purchase_details FROM transactions AS LHS INNER JOIN purchases AS RHS ON (LHS.transaction_id = RHS.purchase_transaction_id))) WHERE (amount_of_transaction > 10000.0) ORDER BY purchase_details;

/*
Gold Result:
('Alpha Purchase',)
('Beta Purchase',)
('Delta Purchase',)
('Gamma Purchase',)
*/

-- Prediction Query
SELECT T1.purchase_details FROM PURCHASES AS T1 JOIN TRANSACTIONS AS T2 ON T1.purchase_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction > 10000;

/*
Prediction Result:
('Gamma Purchase',)
('Alpha Purchase',)
('Delta Purchase',)
('Beta Purchase',)
*/