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
-- 1. Multiple transactions for an EUR customer on the target date (tests SUM vs COUNT(DISTINCT) in numerator: 2/3 = 66.6667% vs 1/2 = 50% or 1/3 = 33.3333%).
-- 2. Unnecessary joins with gasstations, products, or yearmonth (foreign keys in transactions_1k point to non-existent gasstations/products, and yearmonth is empty).
-- 3. Case sensitivity and substring matching on Currency ('eur', 'EURO' vs 'EUR').
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (2, 'LAM', 'eur');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (3, 'KAM', 'EURO');
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (1, '2012-08-25', '08:00:00', 1, 201, 99, 99, 5, 50.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (2, '2012-08-25', '09:00:00', 1, 201, 99, 99, 10, 100.0);
INSERT INTO "transactions_1k" (TransactionID, Date, Time, CustomerID, CardID, GasStationID, ProductID, Amount, Price) VALUES (3, '2012-08-25', '10:00:00', 2, 202, 99, 99, 15, 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T2.Currency = 'EUR', 1, 0)) AS REAL) * 100 / COUNT(T1.CustomerID) FROM transactions_1k AS T1 INNER JOIN customers AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Date = '2012-08-25';

/*
Gold Result:
(66.66666666666667,)
*/

-- Prediction Query
SELECT CAST(COUNT(DISTINCT t1.customerid) AS REAL) * 100 / (SELECT COUNT(DISTINCT customerid) FROM transactions_1k WHERE date = '2012-08-25') AS percentage FROM transactions_1k AS t1 INNER JOIN customers AS t2 ON t1.customerid = t2.customerid WHERE t1.date = '2012-08-25' AND t2.currency = 'EUR';

/*
Prediction Result:
(50.0,)
*/