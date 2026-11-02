-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (0, '2012-08-24', 'default2', 2, 1, 0, 2, 1, 2.0), (1, '2023-01-01', '2012-08-25', 0, NULL, 0, 0, 1, 0.0), (2, '2012-08-25', 'default1', 0, 1, 1, NULL, 0, 2.0), (3, '2012-08-25', 'default2', 0, 2, 0, NULL, 0, 2.0), (4, '2012-08-24', 'default1', 2, NULL, NULL, 2, 2, NULL), (5, '2012-08-24', '2012-08-25', NULL, 0, NULL, NULL, 0, 0.0), (6, '2012-08-25', 'default1', 0, 1, 0, 1, 2, NULL), (7, '2012-08-25', '2012-08-25', 0, 0, 1, NULL, 1, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (0, 1, 'default2', NULL), (1, 1, '2012-08-25', 'default1'), (2, 0, '2012-08-25', '2012-08-25'), (3, NULL, NULL, NULL), (4, NULL, '2012-08-25', '2012-08-25'), (5, 0, '2012-08-25', '2012-08-25'), (6, 1, 'default2', 'default2'), (7, NULL, 'default2', 'default1'), (8, 2, NULL, 'default2'), (9, 0, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.Country FROM gasstations AS T1 INNER JOIN transactions_1k AS T2 ON T1.GasStationID = T2.GasStationID WHERE T2.Date = '2012-08-25' LIMIT 1;

/*
Prediction Result:
('2012-08-25',)
*/