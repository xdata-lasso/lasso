-- Schema DDL
CREATE TABLE customers (CustomerID INTEGER UNIQUE NOT NULL PRIMARY KEY, Segment TEXT NULL, Currency TEXT NULL);

CREATE TABLE gasstations (GasStationID INTEGER UNIQUE NOT NULL PRIMARY KEY, ChainID INTEGER NULL, Country TEXT NULL, Segment TEXT NULL);

CREATE TABLE products (ProductID INTEGER UNIQUE NOT NULL PRIMARY KEY, Description TEXT NULL);

CREATE TABLE "transactions_1k" (TransactionID INTEGER PRIMARY KEY AUTOINCREMENT, Date DATE, Time TEXT, CustomerID INTEGER, CardID INTEGER, GasStationID INTEGER, ProductID INTEGER, Amount INTEGER, Price REAL);

CREATE TABLE "yearmonth" (CustomerID INTEGER NOT NULL REFERENCES customers ON update CASCADE ON delete CASCADE REFERENCES customers, Date TEXT NOT NULL, Consumption REAL, PRIMARY KEY (Date, CustomerID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions_1k (transactionid, date, time, customerid, cardid, gasstationid, productid, amount, price) VALUES (1, '2023-01-01', NULL, NULL, 2, 1, 1, 2, 0.0), (0, '2012-08-25', NULL, 2, NULL, 2, NULL, 0, 1.0), (2, '2012-08-25', 'default1', NULL, 2, 0, NULL, 1, 2.0), (3, '2023-01-01', '2012-08-25', 2, 1, 1, 1, 1, 2.0), (4, '2023-01-01', '2012-08-25', 1, NULL, 0, 0, 0, 2.0), (5, '2012-08-25', NULL, 1, NULL, NULL, 1, 0, 2.0), (6, '2023-01-01', 'default2', 0, 2, 0, NULL, 0, 2.0), (7, NULL, 'default1', 2, 0, 1, 1, NULL, 2.0), (8, '2012-08-26', NULL, 0, NULL, NULL, NULL, 0, 0.0);
INSERT INTO gasstations (gasstationid, chainid, country, segment) VALUES (2, NULL, NULL, 'default2'), (1, 1, NULL, 'default1'), (0, NULL, '2012-08-25', NULL), (3, 1, '2012-08-25', '2012-08-25'), (4, NULL, 'default1', 'default2'), (5, NULL, NULL, 'default2'), (6, 1, 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Country FROM transactions_1k AS T1 INNER JOIN gasstations AS T2 ON T1.GasStationID = T2.GasStationID WHERE T1.Date = '2012-08-25' ORDER BY T1.Time DESC, T1.transactionid NULLS LAST, T2.gasstationid NULLS LAST LIMIT 1;

/*
Gold Result:
('2012-08-25',)
*/

-- Prediction Query
SELECT gasstations.country FROM transactions_1k INNER JOIN gasstations ON transactions_1k.gasstationid = gasstations.gasstationid WHERE transactions_1k.date = '2012-08-25' ORDER BY transactions_1k.transactionid ASC, gasstations.gasstationid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/