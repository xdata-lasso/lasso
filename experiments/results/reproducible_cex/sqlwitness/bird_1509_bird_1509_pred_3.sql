-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'CZE', NULL, 1, NULL, 0, NULL, 1.0), (1, '2011-12-31', 'CZE', 1, 1, NULL, 0, NULL, NULL), (2, '2023-01-02', '2012', NULL, 0, 0, 1, 1, NULL), (3, '2012-01-01', 'default1', 1, 1, 0, NULL, 1, NULL), (4, '2023-01-01', 'default1', NULL, 0, NULL, NULL, 0, NULL), (5, '2012-01-02', '2012', NULL, NULL, 1, 1, NULL, NULL), (6, '2012-01-01', 'CZE', NULL, NULL, 1, 1, NULL, 0.0), (7, NULL, 'default2', 1, 1, NULL, NULL, 1, 1.0), (8, '2012-01-02', '2012', 1, 1, NULL, 1, NULL, 1.0), (9, '2023-01-02', '2012-01-01', NULL, 0, 0, NULL, 0, 0.0), (10, '2012-10-27', 'default2', 1, 1, 1, NULL, 1, 0.0), (11, '2023-01-01', 'default1', 0, 0, 1, 1, 1, NULL), (12, '2023-01-01', 'default2', NULL, 1, 1, 1, NULL, 1.0), (13, '2023-01-01', NULL, 0, 1, 1, 0, NULL, 0.0), (14, '2012-01-01', 'CZE', 1, 0, NULL, 0, 1, 1.0), (15, '2023-01-02', '2012-01-01', NULL, NULL, 0, 1, 0, 1.0), (16, '2011-12-31', '2012-01-01', NULL, 1, 1, 1, NULL, NULL), (17, '2012-01-01', NULL, 1, 1, 1, NULL, 1, 1.0), (18, '2012-01-02', '%Y', NULL, 0, 0, 1, 1, 0.0), (19, '2012-10-27', NULL, 0, NULL, 0, NULL, 1, 0.0), (20, '2012-10-27', 'default1', NULL, NULL, NULL, 0, 1, 0.0), (21, '2011-12-31', 'default2', 0, NULL, 1, 1, 1, 0.0), (22, '2023-01-01', NULL, 0, 0, 0, 0, 0, 1.0), (23, '2012-01-01', 'default1', 0, NULL, 1, NULL, 0, NULL), (24, NULL, 'default1', 1, 1, 1, 1, 1, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, NULL, '%Y', '2012'), (0, 0, 'CZE', 'default1'), (2, NULL, 'default2', 'default2'), (3, 1, '2012-01-01', 'CZE'), (4, NULL, 'default1', '2012'), (5, 1, '2012', 'CZE'), (6, 0, NULL, '2012'), (7, NULL, NULL, 'default1'), (8, NULL, NULL, NULL), (9, 0, 'CZE', '%Y'), (10, 0, 'default1', '2012'), (11, 0, 'default1', '2012'), (12, NULL, 'CZE', NULL), (13, 1, '%Y', NULL), (14, 0, NULL, NULL), (15, 0, '2012', '2012-01-01'), (16, NULL, 'default2', 'default1'), (17, NULL, 'CZE', 'default2'), (18, NULL, '2012-01-01', 'CZE'), (19, 0, '2012-01-01', '%Y'), (20, NULL, NULL, '%Y'), (21, 0, '%Y', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(7,)
*/

-- Prediction Query
SELECT COUNT(*) FROM transactions_1k AS t JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE' AND t.Date > '2012-01-01';

/*
Prediction Result:
(6,)
*/