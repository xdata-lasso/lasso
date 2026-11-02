-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', 'default2', 1, 3, 1, NULL, 2, NULL), (2, '2023-01-01', 'default1', 3, 2, 2, 2, 3, 3.0), (3, '2023-01-01', 'default2', 0, NULL, 0, 0, 1, 2.0), (0, NULL, NULL, NULL, 3, 2, NULL, 1, 0.0), (4, '2023-01-01', NULL, 2, 2, 3, 0, 2, 3.0), (5, '2023-01-02', 'default2', NULL, NULL, 1, 2, 1, 3.0), (6, '2023-01-01', NULL, 3, 2, 0, 3, 0, 1.0), (7, '2023-01-02', NULL, 1, 1, 2, NULL, 0, 0.0), (8, '2023-01-01', NULL, 3, NULL, 2, NULL, NULL, 0.0), (9, '2023-01-01', NULL, 2, 0, 1, 3, 2, NULL);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 3, NULL, 'default1'), (2, 0, 'default1', 'default2'), (3, 0, 'default1', NULL), (1, 0, 'default2', 'default1'), (4, 1, 'default1', 'default2'), (5, NULL, 'default2', 'default2'), (6, 2, NULL, 'default1'), (7, 3, 'default2', 'default2'), (8, 2, NULL, NULL), (9, 3, 'default1', NULL), (10, 2, 'default1', 'default1'), (11, 1, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.Country FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.ProductID = 2 ORDER BY T2.Price DESC, T1.gasstationid NULLS LAST, T2.transactionid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/