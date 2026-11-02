-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', NULL, NULL, NULL, NULL, 1, 1, NULL), (0, '2012-01-02', '%Y', 1, 0, NULL, NULL, 1, 0.0), (2, '2023-01-01', 'default1', NULL, 1, 1, 1, 0, 1.0), (3, '2023-01-02', 'default2', 1, 0, 1, NULL, NULL, NULL), (4, '2023-01-02', NULL, 0, 1, NULL, NULL, 1, 0.0), (5, '2023-01-02', '2012-01-01', 0, 0, 0, NULL, NULL, 0.0), (6, '2012-01-01', '%Y', 1, 0, 1, 1, NULL, 1.0), (7, NULL, '%Y', 0, NULL, 0, 0, 0, NULL), (8, '2012-10-27', NULL, 0, 0, 1, NULL, 1, NULL), (9, '2011-12-31', '2012', 0, 0, 0, 1, 1, 1.0), (10, '2012-01-02', NULL, 0, NULL, 0, NULL, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 0, 'CZE', 'CZE'), (0, NULL, '2012-01-01', '2012'), (2, 1, 'default2', '%Y'), (3, 1, '2012', 'CZE'), (4, 1, 'CZE', NULL), (5, NULL, '2012-01-01', 'default1'), (6, 0, '%Y', 'CZE'), (7, 1, 'CZE', '%Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND T1.Date > '2012-01-01';

/*
Prediction Result:
(3,)
*/