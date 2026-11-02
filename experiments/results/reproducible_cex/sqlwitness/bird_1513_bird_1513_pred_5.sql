-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2023-01-02', 'default2', NULL, NULL, 2, 1, 0, 0.0), (2, NULL, '2012-08-25', 2, 2, 0, 2, 2, 1.0), (1, '2012-08-26', NULL, NULL, 1, 1, 0, 2, 1.0), (3, '2012-08-26', 'default2', 0, 0, 1, NULL, 1, 2.0), (4, '2012-08-24', 'default1', NULL, 0, 1, NULL, 1, 0.0), (5, '2012-08-24', '2012-08-25', NULL, 1, NULL, 0, NULL, 1.0), (6, '2023-01-01', '2012-08-25', 2, 1, NULL, 2, 0, 1.0), (7, '2023-01-02', 'default1', NULL, 1, 2, 2, NULL, 1.0), (8, '2023-01-01', 'default1', 1, 2, NULL, 2, 2, 0.0), (9, '2012-08-26', '2012-08-25', 1, NULL, 2, 1, 1, NULL), (10, '2012-08-25', NULL, NULL, 0, 0, 1, 1, 1.0), (11, '2012-08-25', 'default1', NULL, NULL, 1, 0, 0, 1.0), (12, '2012-08-25', 'default1', NULL, 0, 2, 1, 0, 2.0), (13, '2023-01-02', NULL, 1, 2, 0, NULL, 2, 1.0), (14, '2023-01-02', '2012-08-25', 1, 0, NULL, 0, NULL, 2.0), (15, NULL, 'default1', 1, 2, NULL, NULL, 2, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (2, 1, NULL, '2012-08-25'), (0, 0, 'default2', 'default1'), (1, 0, NULL, NULL), (3, NULL, '2012-08-25', 'default2'), (4, 0, 'default2', 'default1'), (5, NULL, 'default2', '2012-08-25'), (6, 1, NULL, NULL), (7, NULL, 'default1', 'default2'), (8, NULL, NULL, '2012-08-25'), (9, 0, 'default1', '2012-08-25'), (10, 0, 'default2', 'default2'), (11, 2, 'default2', 'default2'), (12, 0, NULL, NULL), (13, 0, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT gasstations.Country FROM transactions_1k INNER JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE transactions_1k.Date = '2012-08-25' ORDER BY transactions_1k.CustomerID ASC, transactions_1k.transactionid NULLS LAST, gasstations.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/