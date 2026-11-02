-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, NULL, 'default2', NULL, 2, 0, 1, NULL, NULL), (3, '2023-01-02', 'default2', 2, 2, 1, 3, 1, NULL), (1, NULL, 'default1', 0, NULL, 2, 1, 0, 0.0), (2, NULL, 'default2', 2, 3, 0, 2, 1, 3.0), (4, NULL, 'default1', 3, 1, 1, 2, 0, 2.0), (5, '2023-01-02', 'default2', NULL, 0, NULL, NULL, 0, NULL), (6, '2023-01-02', 'default1', 3, 3, 3, NULL, 2, 1.0);
INSERT INTO products (productid, description) VALUES (1, 'default2'), (0, 'default2');
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 3, 'default1', 'default1'), (0, 1, 'default1', 'default2'), (3, NULL, NULL, 'default1'), (2, 1, 'default2', 'default2'), (4, 3, NULL, NULL), (5, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T3.Country FROM transactions_1k AS T1 JOIN products AS T2 ON T1.ProductID = T2.ProductID JOIN gasstations AS T3 ON T1.GasStationID = T3.GasStationID WHERE T2.ProductID = 2 ORDER BY T1.Price DESC, T1.transactionid NULLS LAST, T2.productid NULLS LAST, T3.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
*/