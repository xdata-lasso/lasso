-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', 'default1', 0, 0, 0, 0, NULL, 0.0), (0, '2023-01-02', 'default2', NULL, 1, 0, 1, 1, NULL), (2, '2026-10-27', 'default1', 0, 1, 1, NULL, 1, NULL), (3, '2023-01-02', '2012-08-23', 0, 0, NULL, 0, 1, 0.0), (4, '2012-08-23', '2012-08-23', 0, 1, NULL, 0, NULL, 0.0), (5, '2012-08-22', NULL, 1, NULL, 0, NULL, 1, 1.0), (6, '2023-01-01', '21:20:00', NULL, NULL, 0, 0, NULL, 0.0), (7, '2012-08-24', 'default2', 1, NULL, 0, 1, 0, 1.0), (8, '2012-08-23', '21:20:00', 1, NULL, NULL, 0, 0, 1.0), (9, '2023-01-01', NULL, 1, NULL, 0, 1, 0, NULL), (10, '2012-08-24', '2012-08-23', 0, 1, NULL, NULL, NULL, 1.0), (11, '2012-08-22', 'default2', 1, NULL, NULL, 0, 1, NULL), (12, '2012-08-24', '2012-08-23', 0, 1, 0, 1, 1, 1.0), (13, '2012-08-22', '2012-08-23', 0, 0, 1, 1, 1, 1.0), (14, '2023-01-02', '21:20:00', NULL, 0, 1, 1, NULL, 1.0), (15, '2023-01-02', 'default2', 0, 1, 1, NULL, 1, 1.0), (16, '2023-01-01', NULL, NULL, 1, 1, 0, NULL, 1.0), (17, '2026-10-27', 'default2', 1, NULL, NULL, 0, 0, NULL), (18, '2012-08-22', 'default2', 1, 0, 0, NULL, 1, 0.0), (19, NULL, '2012-08-23', 1, NULL, NULL, 0, 0, 0.0), (20, '2012-08-24', '21:20:00', 1, 1, 1, 0, 0, 0.0), (21, '2012-08-24', '21:20:00', 1, 0, 0, NULL, 1, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, NULL, NULL), (0, 0, '21:20:00', '21:20:00'), (2, 0, '2012-08-23', 'default1'), (3, 0, '21:20:00', '21:20:00'), (4, NULL, NULL, '2012-08-23'), (5, 0, NULL, NULL), (6, 1, 'default1', '21:20:00'), (7, 0, NULL, 'default1'), (8, NULL, NULL, 'default2'), (9, 0, '2012-08-23', '21:20:00'), (10, 1, 'default1', 'default1'), (11, 0, 'default2', NULL), (12, 0, 'default2', '2012-08-23'), (13, 1, 'default2', 'default1'), (14, 0, '21:20:00', '2012-08-23'), (15, NULL, '21:20:00', 'default1'), (16, 0, '2012-08-23', 'default2'), (17, 0, 'default2', '2012-08-23'), (18, NULL, NULL, 'default1'), (19, 0, '21:20:00', 'default1'), (20, 0, '2012-08-23', '21:20:00'), (21, NULL, '2012-08-23', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.ProductID FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00';

/*
Gold Result:
*/

-- Prediction Query
SELECT ProductID FROM transactions_1k WHERE Date = '2012-08-23' AND Time = '21:20:00';

/*
Prediction Result:
(0,)
*/