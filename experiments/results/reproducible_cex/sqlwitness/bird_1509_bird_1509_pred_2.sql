-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2011-12-31', 'default1', 1, 1, 0, NULL, 0, 1.0), (1, '2012-10-27', 'default2', NULL, 1, 0, 1, NULL, 1.0), (2, '2012-01-01', NULL, NULL, NULL, 1, 1, 1, 1.0), (3, '2012-01-02', '2012-01-01', 1, 0, NULL, NULL, 0, 0.0), (4, '2011-12-31', '2012-01-01', NULL, 1, NULL, 0, 0, 0.0), (5, '2011-12-31', NULL, 0, 0, 1, 0, 0, NULL), (6, '2023-01-02', NULL, NULL, NULL, NULL, 0, 0, 1.0), (7, '2023-01-01', '2012-01-01', 0, NULL, NULL, NULL, 1, 0.0), (8, '2023-01-02', '2012', NULL, 1, NULL, NULL, NULL, NULL), (9, '2012-01-02', '2012', 1, 1, 0, NULL, 1, 1.0), (10, '2012-01-02', NULL, NULL, NULL, 1, NULL, 1, NULL), (11, '2023-01-02', 'CZE', NULL, 1, 1, 0, 0, 1.0), (12, '2012-10-27', 'default1', 1, NULL, 0, NULL, NULL, 1.0), (13, '2023-01-01', 'default1', 0, 1, 1, 0, 1, 0.0), (14, '2023-01-02', '%Y', NULL, 1, NULL, 1, NULL, 1.0), (15, NULL, 'default1', 0, NULL, 1, 0, 1, 1.0), (16, '2012-01-02', 'default2', 0, 0, 1, NULL, NULL, 1.0), (17, NULL, NULL, 1, 1, 0, 0, 1, NULL), (18, '2012-10-27', '%Y', NULL, NULL, 0, 1, NULL, 0.0), (19, '2012-01-01', '2012', 0, NULL, 0, 0, 0, 1.0), (20, '2012-01-01', 'default2', NULL, 0, NULL, NULL, 0, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, 'CZE', NULL), (0, 1, '%Y', 'default1'), (2, NULL, NULL, NULL), (3, NULL, 'default1', NULL), (4, 1, 'CZE', '%Y'), (5, 1, NULL, NULL), (6, 1, '2012-01-01', NULL), (7, 1, 'default1', 'default1'), (8, NULL, 'CZE', 'default1'), (9, NULL, 'default2', '2012-01-01'), (10, NULL, '2012-01-01', '2012'), (11, NULL, '%Y', '2012-01-01'), (12, 1, 'default1', '%Y'), (13, 0, 'CZE', 'CZE'), (14, 1, '2012', 'default1'), (15, 1, 'CZE', 'default1'), (16, NULL, '%Y', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(T1.GasStationID) FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Country = 'CZE' AND T2.Date > '2012-01-01';

/*
Prediction Result:
(4,)
*/