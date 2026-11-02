-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, NULL, NULL, 2, NULL, 2, 0, 3.0), (2, '2023-01-02', 'default2', 0, 3, NULL, 1, 0, 0.0), (1, NULL, NULL, 1, 3, 3, 2, 0, 1.0), (3, '2023-01-01', 'default1', 3, 1, 0, 0, 3, 2.0), (4, '2023-01-01', NULL, 1, 1, NULL, 0, 2, 3.0), (5, '2023-01-01', NULL, 1, 2, 3, 1, 2, NULL), (6, '2023-01-01', NULL, 2, 1, NULL, 3, 2, 3.0), (7, '2023-01-02', 'default1', 0, NULL, 0, 3, 1, 2.0), (8, NULL, 'default1', 3, NULL, 2, 1, 1, 3.0), (9, '2023-01-02', NULL, 1, 0, 3, 2, 2, 2.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (3, 1, 'default2', 'default1'), (2, NULL, NULL, 'default2'), (0, 0, 'default2', 'default1'), (1, 3, 'default2', NULL), (4, 3, NULL, 'default1'), (5, 1, 'default2', 'default2'), (6, 1, 'default2', NULL), (7, 3, 'default1', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT DISTINCT gs.country FROM gasstations AS gs INNER JOIN transactions_1k AS t ON gs.gasstationid = t.gasstationid WHERE t.productid = 2 AND t.price = (SELECT MAX(price) FROM transactions_1k WHERE productid = 2);

/*
Prediction Result:
*/