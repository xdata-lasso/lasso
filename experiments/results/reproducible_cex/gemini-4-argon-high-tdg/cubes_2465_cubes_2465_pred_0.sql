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
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('SALE', 'Sale of shares');
INSERT INTO Ref_Transaction_Types (transaction_type_code, transaction_type_description) VALUES ('PUR', 'Purchase of shares');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (101, 'SALE', 1, '2023-03-15 10:00:00', 3000.0, '150', 'Exact boundary');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (102, 'SALE', 1, '2023-03-10 09:00:00', 2999.9999, '149', 'Just below boundary');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (103, 'SALE', 2, '2023-03-20 11:00:00', 3000.0001, '151', 'Just above boundary');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (104, 'SALE', 2, '2023-01-05 08:30:00', 0.0, '0', 'Zero amount');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (105, 'SALE', 1, '2023-02-01 12:00:00', -100.5, '5', 'Negative adjustment');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (106, 'SALE', 2, '2023-04-01 15:00:00', NULL, '50', 'Null amount');
INSERT INTO Transactions (transaction_id, transaction_type_code, investor_id, date_of_transaction, amount_of_transaction, share_count, other_details) VALUES (107, 'PUR', 1, '2023-03-12 14:00:00', 1500.0, '75', 'Purchase not in sales');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (101, 'Boundary Sale 3000');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (102, 'Below Boundary Sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (103, 'Above Boundary Sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (104, 'Zero Amount Sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (105, 'Negative Amount Sale');
INSERT INTO Sales (sales_transaction_id, sales_details) VALUES (106, 'Null Amount Sale');
INSERT INTO Purchases (purchase_transaction_id, purchase_details) VALUES (107, 'Low Amount Purchase');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sales_details, date_of_transaction FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, sales_details, transaction_id AS sales_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.sales_details AS sales_details FROM transactions AS LHS INNER JOIN sales AS RHS ON (LHS.transaction_id = RHS.sales_transaction_id))) WHERE (amount_of_transaction <= 3000.0) ORDER BY sales_details, date_of_transaction NULLS LAST;

/*
Gold Result:
('Below Boundary Sale', '2023-03-10 09:00:00')
('Boundary Sale 3000', '2023-03-15 10:00:00')
('Negative Amount Sale', '2023-02-01 12:00:00')
('Zero Amount Sale', '2023-01-05 08:30:00')
*/

-- Prediction Query
SELECT T1.sales_details, T2.date_of_transaction FROM SALES AS T1 JOIN TRANSACTIONS AS T2 ON T1.sales_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction < 3000;

/*
Prediction Result:
('Below Boundary Sale', '2023-03-10 09:00:00')
('Zero Amount Sale', '2023-01-05 08:30:00')
('Negative Amount Sale', '2023-02-01 12:00:00')
*/