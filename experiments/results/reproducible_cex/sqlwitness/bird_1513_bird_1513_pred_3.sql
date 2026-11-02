-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2023-01-02', NULL, 1, 2, NULL, 2, 2, 1.0), (0, '2012-08-24', '2012-08-25', NULL, 1, 2, 2, NULL, 1.0), (1, NULL, '2012-08-25', 2, 2, 2, 2, 0, 0.0), (3, '2012-08-25', 'default2', 1, 1, 1, 0, 1, 2.0), (4, NULL, 'default1', 0, 0, 1, 0, 2, 2.0), (5, NULL, '2012-08-25', 0, 2, NULL, 1, 0, NULL), (6, '2012-08-25', 'default1', 0, NULL, 2, 0, 2, 2.0), (7, '2023-01-02', NULL, 2, 1, 1, 1, 0, 2.0), (8, '2023-01-02', '2012-08-25', 0, 1, 0, 1, NULL, 1.0), (9, '2012-08-24', '2012-08-25', NULL, NULL, 2, NULL, 0, 1.0), (10, '2023-01-01', 'default2', 1, 2, 1, 1, 2, 1.0), (11, '2012-08-25', 'default1', 0, 0, 2, NULL, NULL, 0.0), (12, NULL, '2012-08-25', 1, 0, 2, 0, 2, NULL), (13, '2012-08-25', 'default2', 0, 2, 0, 2, 0, 1.0), (14, NULL, 'default2', 1, 2, 2, 2, 0, 1.0), (15, '2012-08-25', 'default2', 2, NULL, 2, 1, NULL, 2.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 2, '2012-08-25', '2012-08-25'), (2, 2, 'default1', 'default1'), (1, NULL, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT g.Country FROM transactions_1k AS t JOIN gasstations AS g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-25' ORDER BY t.Time, t.transactionid NULLS LAST, g.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/