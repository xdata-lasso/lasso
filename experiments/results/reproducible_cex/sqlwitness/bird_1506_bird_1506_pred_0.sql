-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, NULL, 'default1', 1, NULL, 1, 0, 0, 0.0), (0, '2023-01-02', NULL, NULL, NULL, 1, 1, NULL, NULL), (2, '2023-01-01', NULL, 0, NULL, 1, 1, NULL, 0.0), (3, NULL, 'CZE', 0, 1, 1, 1, 0, 1.0), (4, NULL, 'default1', 0, 0, 0, NULL, 0, 0.0);
INSERT INTO products (productid, description) VALUES (0, NULL), (1, NULL), (2, 'CZE'), (3, 'CZE'), (4, 'default1'), (5, 'default1'), (6, NULL), (7, 'CZE'), (8, 'CZE');
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, NULL, NULL, 'default2'), (1, 0, 'CZE', 'default2'), (2, 1, NULL, 'default2'), (3, 0, 'default2', NULL), (4, NULL, 'default2', 'CZE'), (5, 1, 'CZE', 'default2'), (6, 1, 'default2', NULL), (7, 0, 'CZE', NULL), (8, NULL, NULL, NULL), (9, 0, 'default1', 'default2'), (10, NULL, 'default2', 'CZE'), (11, 1, 'CZE', 'CZE');
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
*/

-- Prediction Query
SELECT DISTINCT T3.Description FROM "transactions_1k" AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID INNER JOIN products AS T3 ON T1.ProductID = T3.ProductID WHERE T2.Country = 'CZE';

/*
Prediction Result:
(None,)
*/