-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. Duplicate customers in transactions on the same day: tests COUNT(T1.CustomerID) vs COUNT(DISTINCT T1.CustomerID), and SUM over transactions vs SUM over distinct customers.
-- Reference: 3 'EUR' transactions + 1 'CZK' transaction = 4 total transactions (75.0%).
-- If DISTINCT is used on CustomerID: 1 'EUR' customer + 1 'CZK' customer = 2 customers (50.0% or 150.0%).
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (20, 'KAM', 'CZK');
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '08:00:00', 10, 201, 1, 1, 10, 25.5);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '09:00:00', 10, 201, 1, 2, 20, 50.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '10:00:00', 10, 202, 2, 1, 15, 30.0);
INSERT INTO transactions_1k (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (4, '2012-08-25', '11:00:00', 20, 203, 1, 1, 40, 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(75.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN customers.Currency = 'EUR' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(DISTINCT transactions_1k.CustomerID) AS EUR_Percentage FROM transactions_1k INNER JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-25';

/*
Prediction Result:
(150.0,)
*/