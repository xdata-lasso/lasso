-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-01-02', 'default1', 1, 1, NULL, NULL, 1, 1.0), (1, '2023-01-01', 'CZE', 0, 0, 0, 1, NULL, NULL), (2, '2011-12-31', 'default2', 1, 1, NULL, NULL, NULL, 0.0), (3, '2023-01-01', NULL, 1, 1, NULL, NULL, 1, NULL), (4, '2012-01-01', NULL, 0, 1, NULL, 0, NULL, NULL), (5, '2012-01-01', '2012', 1, 1, 0, 1, NULL, NULL), (6, '2011-12-31', 'default1', 1, 0, 0, NULL, NULL, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'CZE', NULL), (1, NULL, '%Y', 'CZE'), (2, 0, 'default1', '%Y'), (3, 0, 'default2', 'default2'), (4, 0, 'default1', '%Y'), (5, NULL, '%Y', '2012-01-01'), (6, 1, 'default2', 'default1'), (7, NULL, '%Y', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.TransactionID) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE' AND STRFTIME('%Y', T1.Date) >= '2012';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(T.TransactionID) AS TransactionCount FROM transactions_1k AS T INNER JOIN gasstations AS G ON T.GasStationID = G.GasStationID WHERE G.Country = 'CZE' AND T.Date > '2012-01-01';

/*
Prediction Result:
(1,)
*/