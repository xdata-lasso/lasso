-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-22', '2012-08-23', 1, 0, 1, NULL, 0, 1.0), (1, NULL, '2012-08-23', 1, 1, 0, 0, NULL, 0.0), (2, '2026-10-27', '2012-08-23', 1, NULL, 0, 1, NULL, 1.0), (3, NULL, 'default1', NULL, 0, 1, NULL, NULL, NULL), (4, '2012-08-24', '21:20:00', NULL, 1, 1, 1, NULL, NULL), (5, '2012-08-22', 'default2', NULL, NULL, 1, 0, NULL, NULL), (6, '2023-01-01', NULL, 1, NULL, 0, NULL, 1, 1.0), (7, '2012-08-24', 'default1', 0, NULL, 1, NULL, 1, 1.0), (8, '2012-08-23', NULL, 1, 1, 1, 0, NULL, 1.0), (9, '2023-01-01', 'default2', 0, 0, NULL, 1, NULL, 0.0), (10, '2012-08-23', 'default1', NULL, 1, 1, 1, NULL, 1.0), (11, '2012-08-24', '2012-08-23', 0, 0, 0, 0, NULL, 1.0), (12, '2023-01-01', '2012-08-23', 1, NULL, 0, 0, NULL, 1.0), (13, '2026-10-27', NULL, 0, NULL, NULL, NULL, NULL, 1.0), (14, '2012-08-23', '21:20:00', 1, NULL, NULL, 1, NULL, 0.0), (15, '2012-08-24', 'default2', NULL, 0, 1, NULL, 0, 1.0), (16, '2012-08-24', 'default1', 0, 1, 0, 1, NULL, 1.0), (17, '2012-08-24', NULL, 0, 1, 1, NULL, 0, 0.0), (18, '2023-01-02', '21:20:00', 0, 1, 1, 1, 1, 0.0), (19, '2012-08-24', '21:20:00', 1, NULL, NULL, 0, 1, NULL), (20, '2023-01-01', '21:20:00', 0, 0, 0, NULL, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 1, 'default1', NULL), (1, 0, 'default2', '2012-08-23'), (2, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ProductID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.ProductID FROM "transactions_1k" AS T1 WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00';

/*
Prediction Result:
(1,)
*/