-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'KAM', 'CZK');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (10, 1, 'CZE', 'Value for money');
INSERT INTO gasstations (GasStationID, ChainID, Country, Segment) VALUES (20, 2, 'SVK', 'Premium');
INSERT INTO products (ProductID, Description) VALUES (10, 'Prod_10_Top1_And_Neg');
INSERT INTO products (ProductID, Description) VALUES (20, 'Prod_20_Tie400_Tx30');
INSERT INTO products (ProductID, Description) VALUES (30, 'Prod_30_Tie200_Tx25_Cut');
INSERT INTO products (ProductID, Description) VALUES (40, 'Prod_40_Tie400_Tx20');
INSERT INTO products (ProductID, Description) VALUES (50, 'Prod_50_Amt100_Cut');
INSERT INTO products (ProductID, Description) VALUES (60, 'Prod_60_Tie200_Tx15_In');
INSERT INTO products (ProductID, Description) VALUES (70, 'Prod_70_Amt300');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (50, '2023-01-05', '10:00:00', 20, 30, 40, 10, 500, 10.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (30, '2023-01-03', '12:00:00', 10, 50, 70, 20, 400, 5.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (20, '2023-01-02', '08:00:00', 30, 10, 20, 40, 400, 20.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (10, '2023-01-01', '09:00:00', 40, 20, 10, 70, 300, 100.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (25, '2023-01-04', '14:00:00', 50, 40, 60, 30, 200, 200.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (15, '2023-01-06', '16:00:00', 70, 60, 50, 60, 200, 1.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (5, '2023-01-07', '18:00:00', 60, 70, 30, 50, 100, 500.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2023-01-08', '20:00:00', 10, 10, 10, 10, -50, 1000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Description FROM transactions_1k AS T1 INNER JOIN products AS T2 ON T1.ProductID = T2.ProductID ORDER BY T1.Amount DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST LIMIT 5;

/*
Gold Result:
('Prod_10_Top1_And_Neg',)
('Prod_40_Tie400_Tx20',)
('Prod_20_Tie400_Tx30',)
('Prod_70_Amt300',)
('Prod_60_Tie200_Tx15_In',)
*/

-- Prediction Query
SELECT p.Description FROM products AS p JOIN transactions_1k AS t ON p.ProductID = t.ProductID GROUP BY p.ProductID ORDER BY CAST(SUM(t.Amount) AS REAL) DESC, p.Description NULLS LAST LIMIT 5;

/*
Prediction Result:
('Prod_10_Top1_And_Neg',)
('Prod_20_Tie400_Tx30',)
('Prod_40_Tie400_Tx20',)
('Prod_70_Amt300',)
('Prod_30_Tie200_Tx25_Cut',)
*/