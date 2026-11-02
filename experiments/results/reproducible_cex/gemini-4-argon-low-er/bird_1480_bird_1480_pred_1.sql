-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (CustomerID, Segment, Currency) VALUES (1, 'SME', 'USD');
INSERT INTO yearmonth (CustomerID, Date, Consumption) VALUES (1, '201301', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUBSTRING(T2.Date, 5, 2) FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE SUBSTRING(T2.Date, 1, 4) = '2013' AND T1.Segment = 'SME' GROUP BY SUBSTRING(T2.Date, 5, 2) ORDER BY SUM(T2.Consumption) DESC, SUBSTRING(T2.Date, 5, 2) NULLS LAST LIMIT 1;

/*
Gold Result:
('01',)
*/

-- Prediction Query
SELECT T2.Date AS PeakMonth FROM customers AS T1 INNER JOIN yearmonth AS T2 ON T1.CustomerID = T2.CustomerID WHERE T1.Segment = 'SME' AND T2.Date BETWEEN '201301' AND '201312' GROUP BY T2.Date ORDER BY SUM(T2.Consumption) DESC, PeakMonth NULLS LAST LIMIT 1;

/*
Prediction Result:
('201301',)
*/