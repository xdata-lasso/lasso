-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-02', 'default2', 1, NULL, NULL, 0, 0, NULL), (0, '2023-01-01', 'default1', 0, NULL, 0, 0, 0, 0.0), (2, '2023-01-01', 'default1', NULL, NULL, 1, NULL, NULL, 1.0), (3, '2023-01-01', 'default1', 0, NULL, 1, NULL, 1, 1.0), (4, '2023-01-02', NULL, 0, 1, 0, 1, NULL, 1.0), (5, '2023-01-02', 'default2', 0, NULL, 0, NULL, 1, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 0, 'CZE', 'CZE'), (1, 1, 'default2', NULL), (2, NULL, 'default2', 'default1'), (3, 1, 'default1', 'default1'), (4, 0, NULL, 'default2'), (5, 0, 'CZE', NULL), (6, 0, 'default1', 'default1'), (7, 0, NULL, 'default2'), (8, NULL, 'CZE', 'default1'), (9, 1, 'default1', 'default2'), (10, NULL, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T1.Price) FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Country = 'CZE';

/*
Gold Result:
(0.3333333333333333,)
*/

-- Prediction Query
SELECT AVG(CAST(t.Amount AS REAL) * CAST(t.Price AS REAL)) AS average_total_price FROM transactions_1k AS t JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE';

/*
Prediction Result:
(0.0,)
*/