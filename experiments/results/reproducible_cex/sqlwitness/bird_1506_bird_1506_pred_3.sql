-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'CZE', 0, 0, NULL, 1, 0, 0.0), (0, '2023-01-02', 'CZE', 0, 1, NULL, NULL, NULL, 1.0), (2, NULL, NULL, 1, 1, 1, 0, 0, NULL), (3, '2023-01-02', NULL, NULL, 0, 1, 1, 1, NULL), (4, '2023-01-01', 'CZE', NULL, 0, 1, 1, NULL, 1.0), (5, NULL, 'default1', 1, NULL, NULL, NULL, 1, 1.0), (6, NULL, NULL, NULL, 1, NULL, 1, 1, 1.0), (7, NULL, 'CZE', 0, NULL, 1, 0, NULL, 1.0), (8, '2023-01-01', NULL, 1, 1, NULL, NULL, 0, 1.0), (9, '2023-01-01', 'CZE', 0, NULL, 0, NULL, 0, 0.0), (10, '2023-01-01', 'default2', 0, 0, 0, NULL, NULL, 1.0), (11, '2023-01-02', 'default1', 1, 1, 1, 1, NULL, NULL), (12, '2023-01-01', 'default2', 1, 0, 1, 1, NULL, NULL), (13, NULL, 'default1', 0, 1, 0, NULL, 0, 1.0), (14, '2023-01-02', NULL, 0, 1, 0, 0, NULL, 0.0), (15, '2023-01-01', 'CZE', 0, 1, 1, NULL, 1, 0.0), (16, '2023-01-02', 'default2', 1, 0, 0, 1, 0, 1.0), (17, NULL, NULL, NULL, 0, 1, 0, NULL, 0.0), (18, '2023-01-01', 'CZE', 0, NULL, 0, 1, 1, NULL), (19, '2023-01-02', 'default2', 0, 1, 1, 0, 1, NULL), (20, '2023-01-02', 'CZE', NULL, 1, 1, 1, 0, 0.0), (21, '2023-01-02', 'default2', 1, 0, 1, NULL, NULL, 1.0), (22, '2023-01-01', 'default2', 1, 1, 1, NULL, 1, 0.0), (23, '2023-01-02', 'CZE', 0, 1, 0, 1, NULL, 0.0);
INSERT INTO products (productid, description) VALUES (1, NULL), (0, NULL), (2, 'default1'), (3, 'default1'), (4, 'default2'), (5, NULL), (6, NULL), (7, NULL), (8, 'CZE'), (9, 'default2'), (10, 'default2'), (11, 'default1'), (12, 'CZE'), (13, 'CZE'), (14, 'default2'), (15, 'CZE'), (16, 'default1');
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, 'default2', NULL), (1, 1, 'CZE', 'CZE'), (2, 0, 'CZE', 'default2'), (3, 0, 'default1', NULL), (4, 1, NULL, NULL), (5, 1, 'default1', NULL), (6, 1, 'default2', 'default1'), (7, 1, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Description FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Gold Result:
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T2.ProductID = T3.ProductID WHERE T1.Country = 'CZE';

/*
Prediction Result:
(None,)
*/