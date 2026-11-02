-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (2, '2012-08-25', NULL, 1, 2, 0, NULL, 1, 0.0), (0, '2023-01-01', NULL, NULL, 2, 1, NULL, 1, 0.0), (1, NULL, '2012-08-25', NULL, 1, 2, 1, 2, 0.0), (3, '2012-08-25', 'default1', 2, NULL, 1, 0, NULL, NULL), (4, '2012-08-26', 'default1', 0, 2, 1, 0, NULL, 2.0), (5, '2023-01-02', '2012-08-25', 1, 0, 1, 2, NULL, 1.0), (6, '2012-08-24', 'default1', 2, 1, NULL, 1, NULL, NULL), (7, '2012-08-24', 'default1', 0, NULL, 0, NULL, 2, 0.0), (8, '2012-08-24', '2012-08-25', 1, 2, 0, 1, 0, 1.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (1, 1, 'default2', NULL), (0, 0, '2012-08-25', '2012-08-25'), (2, NULL, 'default1', 'default1'), (3, 2, NULL, NULL), (4, 0, 'default1', '2012-08-25'), (5, 1, NULL, 'default1'), (6, NULL, NULL, NULL), (7, NULL, '2012-08-25', NULL), (8, 0, '2012-08-25', '2012-08-25'), (9, 2, NULL, 'default1'), (10, 2, 'default2', 'default2'), (11, 1, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT g.Country FROM gasstations AS g JOIN (SELECT GasStationID FROM transactions_1k WHERE Date = '2012-08-25' ORDER BY Time ASC, transactions_1k.transactionid NULLS LAST LIMIT 1) AS t ON g.GasStationID = t.GasStationID;

/*
Prediction Result:
('2012-08-25',)
*/