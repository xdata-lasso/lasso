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
-- DATASET 2
INSERT INTO Investors (investor_id, Investor_details) VALUES (10, 'Investor X');
INSERT INTO Investors (investor_id, Investor_details) VALUES (20, 'Investor Y');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('T1', 'Type 1');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (1, 'T1', 10, '2023-05-01 12:00:00', 50000.0, '500', 'Z_Other');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (2, 'T1', 20, '2023-04-01 12:00:00', 20000.0, '200', 'A_Other');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (3, 'T1', 10, '2023-06-01 12:00:00', 30000.0, '300', 'M_Other');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (1, 'Charlie');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (2, 'Bravo');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (3, 'Alpha');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (1, 'Alpha');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT purchase_details FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, purchase_details, transaction_id AS purchase_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.purchase_details AS purchase_details FROM transactions AS LHS INNER JOIN purchases AS RHS ON (LHS.transaction_id = RHS.purchase_transaction_id))) WHERE (amount_of_transaction > 10000.0) ORDER BY purchase_details;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.purchase_details FROM PURCHASES AS T1 JOIN TRANSACTIONS AS T2 ON T1.purchase_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction > 10000;

/*
Prediction Result:
('Charlie',)
('Bravo',)
('Alpha',)
('Alpha',)
*/