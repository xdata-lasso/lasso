-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, NULL, 0, 1, 0, 0, NULL, 0.0), (0, '2023-01-01', 'CZE', NULL, 0, 0, 1, 0, NULL), (2, '2023-01-01', 'default2', NULL, NULL, NULL, NULL, 0, 1.0), (3, NULL, 'default1', 0, NULL, NULL, 0, 1, 0.0), (4, '2023-01-01', 'default1', 1, NULL, 0, 0, 1, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 1, 'CZE', 'default2'), (1, 1, 'CZE', 'CZE'), (2, NULL, NULL, 'default2'), (3, 0, NULL, 'default2'), (4, 0, NULL, 'default2'), (5, 1, 'default1', 'default2'), (6, 0, 'CZE', 'CZE'), (7, 0, 'default2', 'CZE'), (8, 1, NULL, 'default2'), (9, NULL, 'default1', 'CZE'), (10, 0, NULL, NULL), (11, 1, 'default1', 'default2'), (12, 1, NULL, NULL), (13, 0, 'default1', 'default2'), (14, 0, 'default2', 'CZE'), (15, NULL, 'default2', 'default2'), (16, NULL, 'CZE', NULL), (17, 1, 'default2', NULL), (18, 0, 'default1', 'default1'), (19, 1, NULL, 'CZE'), (20, 1, 'default1', 'default1'), (21, 1, NULL, 'default1'), (22, 1, 'default1', 'default2'), (23, 0, 'default2', 'CZE'), (24, NULL, 'default2', 'default1'), (25, 0, 'default1', 'default1'), (26, 1, NULL, 'CZE'), (27, 0, 'CZE', 'CZE'), (28, NULL, 'CZE', 'default2'), (29, 1, NULL, NULL), (30, 1, 'CZE', 'CZE'), (31, NULL, 'CZE', 'CZE');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(0.5,)
*/

-- Prediction Query
SELECT AVG(transactions_1k.Price * transactions_1k.Amount) AS AverageTotalPrice FROM transactions_1k INNER JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE gasstations.Country = 'CZE';

/*
Prediction Result:
(1.0,)
*/