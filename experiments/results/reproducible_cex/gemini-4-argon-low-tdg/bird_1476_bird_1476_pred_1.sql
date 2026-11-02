-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
-- Cross join / Join condition omission trap and substring position/length boundary checks
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (10, 'SME', 'CZK');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (20, 'KAM', 'EUR');
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (30, 'LAM', 'CZK');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (10, '201211', 50.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (20, '2012', 15.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (30, '020120', 999.0);
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (30, '201299', -10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.Currency = 'CZK', T2.Consumption, 0)) - SUM(IIF(T1.Currency = 'EUR', T2.Consumption, 0)) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2012';

/*
Gold Result:
(25.0,)
*/

-- Prediction Query
SELECT SUM(CASE WHEN c.Currency = 'CZK' THEN y.Consumption ELSE 0 END) - SUM(CASE WHEN c.Currency = 'EUR' THEN y.Consumption ELSE 0 END) AS Difference FROM customers AS c JOIN yearmonth AS y ON c.CustomerID = y.CustomerID WHERE y.Date BETWEEN '201201' AND '201212';

/*
Prediction Result:
(50.0,)
*/